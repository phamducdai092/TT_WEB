package util;

import java.security.*;
import java.util.Base64;

public class KeyGenerator {
    private KeyPair keyPair;
    private int keySize = 2048;
    private PrivateKey privateKey;
    private PublicKey publicKey;

    public KeyGenerator() {
    }

    public void generateKeyPair() {
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("DSA");
            keyPairGenerator.initialize(keySize);
            this.keyPair = keyPairGenerator.generateKeyPair();
            this.privateKey = keyPair.getPrivate();
            this.publicKey = keyPair.getPublic();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Có lỗi xảy ra khi tạo key: " + e.getMessage(), e);
        }
    }

    public String getPrivateKeyBase64Encoded() {
        return Base64.getEncoder().encodeToString(privateKey.getEncoded());
    }

    public String getPublicKeyBase64Encoded() {
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }

    public void setKeyPair(KeyPair keyPair) {
        this.keyPair = keyPair;
    }

    public void setKeySize(int keySize) {
        this.keySize = keySize;
    }

    public int getKeySize() {
        return keySize;
    }

    public void setPrivateKey(PrivateKey privateKey) {
        this.privateKey = privateKey;
    }

    public void setPublicKey(PublicKey publicKey) {
        this.publicKey = publicKey;
    }
}
