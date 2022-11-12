import 'package:flutter_riverpod/flutter_riverpod.dart';

final errorProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});
