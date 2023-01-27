import 'dart:math';

String generateRandomString(int len) {
  const letters = 'abcdefghijklmnopqrstuvwxyz';
  final upperLetters = letters.toUpperCase();
  const numbers = '1234567890';
  final allChar = letters + upperLetters + numbers;
  String randString = '';
  for (int i = 0; i < len; i++) {
    final randomNumber = Random().nextInt(allChar.length - 1);
    randString += allChar[randomNumber];
  }
  return randString;
}

String generateRandomPassword(int len) {
  const letters = 'abcdefghijklmnopqrstuvwxyz';
  final upperLetters = letters.toUpperCase();
  const numbers = '1234567890';
  const chars = '#\$_+-';
  final allChar = letters + upperLetters + numbers + chars;
  String randString = '';
  for (int i = 0; i < len; i++) {
    final randomNumber = Random().nextInt(allChar.length - 1);
    randString += allChar[randomNumber];
  }
  return randString;
}
