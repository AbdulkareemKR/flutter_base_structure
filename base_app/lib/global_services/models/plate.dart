import 'dart:convert';

class Plate {
  String letters;
  String numbers;
  String countryId;
  static final translatableLetters = {
    'ا': 'A',
    'ب': 'B',
    'ح': 'J',
    'د': 'D',
    'ر': 'R',
    'س': 'S',
    'ص': 'X',
    'ط': 'T',
    'ع': 'E',
    'ق': 'G',
    'ك': 'K',
    'ل': 'L',
    'م': 'Z',
    'ن': 'N',
    'ه': 'H',
    'و': 'U',
    'ى': 'V',
  };
  final _translatableNumbers = {
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
    '10': '١٠',
  };
  Plate({
    required this.letters,
    required this.numbers,
    required this.countryId,
  });

  Plate copyWith({
    String? letters,
    String? numbers,
    String? countryId,
  }) {
    return Plate(
      letters: letters ?? this.letters,
      numbers: numbers ?? this.numbers,
      countryId: countryId ?? this.countryId,
    );
  }

  /// translate english letters in a plate to arabic based on KSA regulations
  ///
  /// return a string containing arabic letters after being translated using [letters] with the help of map [translatableLetters] reversed
  String englishLettersToArabic() {
    String arabicLetters = '';
    final reversedTranslatable = translatableLetters.map((k, v) => MapEntry(v, k));

    letters.split('').forEach((ch) {
      arabicLetters = reversedTranslatable[ch.toUpperCase()]! + arabicLetters;
    });
    return arabicLetters;
  }

  /// translate arabic letters in a plate to english based on KSA regulations
  ///
  /// accept a String containing arabic letters
  /// return  english letters after being translated using map [translatableLetters]
  static String arabicLettersToEgnlish(String arabicLetters) {
    String englishLetters = '';
    arabicLetters.split('').forEach((ch) {
      englishLetters += (translatableLetters[ch] ?? ch);
    });
    return englishLetters;
  }

  /// translate english numbers in a plate to arabic based on KSA regulations
  ///
  /// return arabic numbers after being translated using [numbers] with the help of [_translatableNumbers] map
  String englishNumbersToArabic() {
    String arabicNumbers = '';
    numbers.toString().split('').forEach((ch) {
      arabicNumbers += _translatableNumbers[ch]!;
    });
    return arabicNumbers;
  }

  /// translate arabic numbers in a plate to english based on KSA regulations
  ///
  /// accept an [int] containing arabic numbers
  /// return  english numbers after being translated using map [_translatableNumbers]
  String arabicNumbersToEgnlish(int arabicNumbers) {
    String englishNumbers = '';
    final reversedTranslatable = _translatableNumbers.map((k, v) => MapEntry(v, k));
    arabicNumbers.toString().split('').forEach((ch) {
      englishNumbers += reversedTranslatable[ch]!;
    });
    return englishNumbers;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'letters': letters,
      'numbers': numbers,
      'countryId': countryId,
    };
  }

  factory Plate.fromMap(Map<String, dynamic> map) {
    return Plate(
      letters: map['letters'].toString(),
      numbers: map['numbers'].toString(),
      countryId: map['countryId'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Plate.fromJson(String source) => Plate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Plate(letters: $letters, numbers: $numbers, countryId: $countryId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Plate && other.letters == letters && other.numbers == numbers && other.countryId == countryId;
  }

  @override
  int get hashCode => letters.hashCode ^ numbers.hashCode ^ countryId.hashCode;

  String getPlate(String langCode) {
    if (langCode == 'ar') {
      final lettersArabic = englishLettersToArabic();

      return '${lettersArabic.split('').join(' ')}    $numbers';
    } else {
      return '${letters.split('').join(' ')}    $numbers';
    }
  }
}
