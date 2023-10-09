import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:utilities/utilities.dart';

class EncryptionDecryption {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptAES(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    return [encrypted, iv.base64, key.base64];
  }

  static decryptAES(Encrypted text, String iv, String key) {
    final newKey = encrypt.Key.fromBase64(key);
    final newIv = encrypt.IV.fromBase64(iv);
    final newEncrypter = encrypt.Encrypter(encrypt.AES(newKey));
    return newEncrypter.decrypt(text, iv: newIv);
  }
}
