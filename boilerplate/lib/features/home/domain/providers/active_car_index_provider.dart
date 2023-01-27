import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeCarIndexProvider = StateProvider<int>((ref) {
  return 0;
});
