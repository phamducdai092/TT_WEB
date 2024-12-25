package util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.*;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class DigitalSignature {
    private KeyPair keyPair;
    private int keySize = 2048;
    private PrivateKey privateKey;
    private PublicKey publicKey;

    public DigitalSignature() {
    }
    public void setPublicKey(PublicKey publicKey) {
        this.publicKey = publicKey;
    }
    public void loadPublicKey(String base64PublicKey) {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(base64PublicKey);
            KeyFactory keyFactory = KeyFactory.getInstance("DSA");
            PublicKey publicKey = keyFactory.generatePublic(new X509EncodedKeySpec(decodedKey));
            this.setPublicKey(publicKey);
            this.keyPair = new KeyPair(publicKey, this.keyPair != null ? this.keyPair.getPrivate() : null);
        } catch (Exception e) {
            throw new RuntimeException("Public key không hợp lệ: " + e.getMessage(), e);
        }
    }
    public boolean verifyFile(String src, String signatureBase64) throws Exception {
        Signature signature = Signature.getInstance("SHA256withDSA");
        signature.initVerify(this.publicKey);

        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(src))) {
            byte[] buff = new byte[1024];
            int read;
            while ((read = bis.read(buff)) != -1) {
                signature.update(buff, 0, read);
            }
        }

        byte[] signatureBytes = base64ToBytes(signatureBase64);
        return signature.verify(signatureBytes);
    }
    public byte[] base64ToBytes(String base64String) {
        return Base64.getDecoder().decode(base64String);
    }
}
