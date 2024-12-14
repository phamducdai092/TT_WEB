package service;

import bean.Key;
import dao.KeyDAO;
import util.KeyGenerator;

import java.security.PrivateKey;
import java.util.List;

public class KeyService {
    public static KeyService instance;
    private final KeyDAO keyDao;

    public KeyService(Key key, KeyGenerator keyGenerator) {
        keyDao = new KeyDAO(key, keyGenerator);
    }

    public static KeyService getInstance() {
        if (instance == null) {
            Key key = new Key();
            KeyGenerator keyGenerator = new KeyGenerator();
            instance = new KeyService(key, keyGenerator);
        }
        return instance;
    }

    public Key getKeyByUserId(int id) {
        return KeyDAO.getKeysByUserId(id);
    }

    public Key getKeyById(int id) {
        return KeyDAO.getKeyById(id);
    }

    public List<Key> getKeyListByUserId(int id) {
        return KeyDAO.getKeysListByUserId(id);
    }

    public void createKey(int userId, int keyLength) {
        keyDao.createKey(userId, keyLength);
    }

    public void saveKey(String publicKey, int userId) {
        KeyDAO.saveKey(publicKey, userId);
    }

    public Key getKey() {
        return keyDao.getKey();
    }

    public String getPrivateKey() {
        return keyDao.getPrivateKey();
    }

    public void reportLeakedPrivateKey(int userId) {
        KeyDAO.reportPrivateKeyLeak(userId);
    }

    public static void main(String[] args) {
//        KeyService keyService = KeyService.getInstance();
//
//        // Tạo khóa mới
//        keyService.createKey(1, 2048);
//        System.out.println("Public Key: " + keyService.getKey().getPublicKey());
//        System.out.println("Private Key: " + keyService.getPrivateKey());
//
//        // Tạo khóa mới lần nữa
//        keyService.createKey(1, 2048);
//        System.out.println("New Public Key: " + keyService.getKey().getPublicKey());
//        System.out.println("New Private Key: " + keyService.getPrivateKey().getEncoded());
    }
}
