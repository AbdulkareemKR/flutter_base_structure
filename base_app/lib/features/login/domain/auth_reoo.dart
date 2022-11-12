import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/services/auth_services.dart';

final authRepo = Provider<FirebaseAuthServices>(
  (ref) => FirebaseAuthServices(),
);
