package dao;

import bean.Key;
import db.JDBIConnector;
import org.jdbi.v3.core.Handle;
import util.KeyGenerator;

import java.security.PrivateKey;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class KeyDAO {
    private KeyGenerator keyGenerator;
    private Key key;
    private String privateKey;
    private String publicKey;

    public KeyDAO(Key key, KeyGenerator keyGenerator) {
        this.key = key;
        this.keyGenerator = keyGenerator;
    }

    public static Key getKeysByUserId(int userId) {
        try (Handle handle = JDBIConnector.me().open()) {
            return handle.createQuery("SELECT * FROM public_key WHERE userId = :userId AND expireDate IS NULL")
                    .bind("userId", userId)
                    .mapToBean(Key.class)
                    .findOne()
                    .orElse(null);
        }
    }

    public static Key getKeyById(int id) {
        try (Handle handle = JDBIConnector.me().open()) {
            return handle.createQuery("SELECT * FROM public_key WHERE id = :id")
                    .bind("id", id)
                    .mapToBean(Key.class)
                    .findOne()
                    .orElse(null);
        }
    }


    public static List<Key> getKeysListByUserId(int userId) {
        try (Handle handle = JDBIConnector.me().open()) {
            return handle.createQuery("SELECT * FROM public_key WHERE userId = :userId")
                    .bind("userId", userId)
                    .mapToBean(Key.class)
                    .collect(Collectors.toList());
        }
    }

    public static List<Key> getKeyList() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM public_key")
                        .mapToBean(Key.class)
                        .collect(Collectors.toList())
        );
    }

    public void createKey(int userId, int keyLength) {
        keyGenerator.setKeySize(keyLength);
        keyGenerator.generateKeyPair(); // Tạo cặp khóa mới

        publicKey = keyGenerator.getPublicKeyBase64Encoded();
        privateKey = keyGenerator.getPrivateKeyBase64Encoded();

        setPrivateKey(privateKey);
        key.setPublicKey(publicKey);

        // Cập nhật đối tượng key với thông tin mới
        key.setPublicKey(publicKey);
        key.setUserId(userId);
        saveKey(publicKey, userId);
    }

    public static void saveKey(String publicKey, int userId) {
        Date createDate = new Date();
        Date expireDate = new Date(); // Ngày hết hạn sẽ là ngày hiện tại cho các khóa cũ

        try (Handle handle = JDBIConnector.me().open()) {
            // Kiểm tra xem có public_key nào của userId với expireDate là null
            List<Integer> existingPublicKeyIds = handle.createQuery(
                            "SELECT id FROM public_key WHERE userId = :userId AND expireDate IS NULL")
                    .bind("userId", userId)
                    .mapTo(Integer.class)
                    .list();

            if (!existingPublicKeyIds.isEmpty()) {
                // Cập nhật expireDate cho các khóa cũ
                handle.createUpdate(
                                "UPDATE public_key SET expireDate = :expireDate WHERE userId = :userId AND expireDate IS NULL")
                        .bind("expireDate", expireDate)
                        .bind("userId", userId)
                        .execute();
            }

            // Thêm key mới với expireDate là null
            handle.createUpdate(
                            "INSERT INTO public_key (publicKey, createDate, expireDate, userId) VALUES (:publicKey, :createDate, NULL, :userId)")
                    .bind("publicKey", publicKey)
                    .bind("createDate", createDate)
                    .bind("userId", userId)
                    .execute();

        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi nếu có
            throw new RuntimeException("Có lỗi xảy ra khi lưu key: " + e.getMessage());
        }
    }

    public static void reportPrivateKeyLeak(int userId) {
        Date currentDate = new Date(); // Thời gian hiện tại

        try (Handle handle = JDBIConnector.me().open()) {
            // Kiểm tra xem có public_key nào có expireDate = null không
            Optional<Integer> existingPublicKeyId = handle.createQuery("SELECT id FROM public_key WHERE userId = :userId AND expireDate IS NULL LIMIT 1")
                    .bind("userId", userId)
                    .mapTo(Integer.class)
                    .findFirst(); // Trả về Optional<Integer>

            if (existingPublicKeyId.isPresent()) {
                // Nếu có, cập nhật expireDate thành thời gian hiện tại
                handle.createUpdate("UPDATE public_key SET expireDate = :expireDate WHERE userId = :userId AND expireDate IS NULL")
                        .bind("expireDate", currentDate) // Cập nhật thời gian hiện tại
                        .bind("userId", userId)
                        .execute();
            } else {
                // Nếu không có key với expireDate là null, thông báo hoặc ghi log
                System.out.println("Không tìm thấy public key nào có expireDate là null.");
            }
        }
    }

    public KeyGenerator getKeyGenerator() {
        return keyGenerator;
    }

    public void setKeyGenerator(KeyGenerator keyGenerator) {
        this.keyGenerator = keyGenerator;
    }

    public Key getKey() {
        return key;
    }

    public void setKey(Key key) {
        this.key = key;
    }

    public String getPrivateKey() {
        return privateKey;
    }

    public void setPrivateKey(String privateKey) {
        this.privateKey = privateKey;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public static void main(String[] args) {
        KeyDAO keyDAO = new KeyDAO(new Key(), new KeyGenerator());
//        List<Key> keys = getKeysListByUserId(24);
//        for (Key key : keys) {
//            System.out.println(key.getPublicKey());
//        }
        keyDAO.createKey(24, 4096);
    }
}
