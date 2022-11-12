import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:garage_core/environments/enums/environment_type.dart';
import 'package:garage_core/services/enum_services.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';

/// Service handles all operations of loading environment variables
class EnvironmentService {
  /// Loads environment variables from the `.env` directory
  static Future<Map<String, dynamic>> getEnvironmentVariables() async {
    try {
      final EnvironmentType environmentType = enumFromString(
          EnvironmentType.values, const String.fromEnvironment('ENVIRONMENT_TYPE', defaultValue: 'development'));

      await dotenv.load(fileName: "assets/.env/${environmentType.name}.env");

      GLogger.info(
          "🔑 Environment variables loaded in [${dotenv.env['type']}] environment with [${dotenv.env.keys.length}] values ✅");

      return dotenv.env;
    } catch (e) {
      GLogger.error('Error loading environment: $e');
    }
    return {};
  }
}
