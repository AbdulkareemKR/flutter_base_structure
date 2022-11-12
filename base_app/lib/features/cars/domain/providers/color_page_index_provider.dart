import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorPageIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
