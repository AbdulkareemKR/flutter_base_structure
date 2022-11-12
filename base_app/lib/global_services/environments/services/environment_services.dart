import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:garage_client/global_services/environments/enums/environment_type.dart';
import 'package:garage_client/global_services/services/enum_services.dart';

/// Service handles all operations of loading environment variables
class EnvironmentService {
  /// Loads environment variables from the `.env` directory
  static Future<Map<String, dynamic>> getEnvironmentVariables() async {
    try {
      final EnvironmentType environmentType = enumFromString(
          EnvironmentType.values, const String.fromEnvironment('ENVIRONMENT_TYPE', defaultValue: 'development'));

      await dotenv.load(fileName: "assets/.env/${environmentType.name}.env");

      log("🔑 Environment variables loaded in [${dotenv.env['type']}] environment with [${dotenv.env.keys.length}] values ✅");

      return dotenv.env;
    } catch (e) {
      log('Error loading environment: $e');
    }
    return {};
  }
}
