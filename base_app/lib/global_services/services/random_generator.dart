import 'dart:math';

String generateRandomString(int len) {
  final letters = 'abcdefghijklmnopqrstuvwxyz';
  final upperLetters = letters.toUpperCase();
  final numbers = '1234567890';
  final allChar = letters + upperLetters + numbers;
  String randString = '';
  for (int i = 0; i < len; i++) {
    final randomNumber = Random().nextInt(allChar.length - 1);
    randString += allChar[randomNumber];
  }
  return randString;
}
