import 'package:garage_client/environments/services/services.dart';

import '../models/environment_model.dart';

/// Service handles all operations of loading environment variables
class Environment {
  static late EnvironmentModel _instance;

  static EnvironmentModel get instance {
    try {
      return _instance;
    } catch (e) {
      throw Exception(
          "(Environment) Can't get instance because the environment is not initialized yet. Consider calling [Environment.load()] first");
    }
  }

  /// Loads environment variables from the `.env` directory
  static load() async {
    _instance = EnvironmentModel.fromMap(await EnvironmentService.getEnvironmentVariables());
  }
}
