import 'package:dart_encryption/dart_encryption.dart' as dart_encryption;

void main(List<String> arguments) {
  Map<String, dynamic> json = {
    'email': 'zukronalviandy@gmail.com',
    'password': 'asdf1234'
  };
  // change to your key
  String strKey = 'HayoooApaHayooo~';

  final encrypt = dart_encryption.encrypt(json, strKey);
  final decrypt = dart_encryption.decrypt(encrypt, strKey);

  print(decrypt);
}
