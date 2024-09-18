import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

String encrypt(Map<String, dynamic> json, String strKey) {
  String text = jsonEncode(json);
  IV iv = IV.fromLength(16);
  Key key = Key.fromUtf8(strKey);

  Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  Encrypted encrypted = encrypter.encrypt(text, iv: iv);

  List<int> cipher = iv.bytes + encrypted.bytes;
  return base64Encode(cipher);
}

Map<String, dynamic> decrypt(String decryptBase64, String strKey) {
  Uint8List decodedData = base64Decode(decryptBase64);

  // extract iv and ciphertext
  int ivSize = 16;
  Uint8List cipher = decodedData.sublist(ivSize);
  IV iv = IV(decodedData.sublist(0, ivSize));
  Encrypted encrypted = Encrypted(cipher);

  // encryption key
  Key key = Key.fromUtf8(strKey);

  Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  String decrypted = encrypter.decrypt(encrypted, iv: iv);

  return jsonDecode(decrypted);
}
