import 'package:cloud_functions/cloud_functions.dart';
import 'package:garage_core/models/cloud_function_response.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';

class CloudFunctionsServices {
  static Future<CloudFunctionsResponse?> call(
      {required String functionName, Map<String, dynamic> arguments = const {}}) async {
    try {
      GLogger.debug('Calling $functionName');

      final callable = FirebaseFunctions.instance.httpsCallable(functionName);
      final data = (await callable(arguments)).data;

      final result = CloudFunctionsResponse.fromJson(data);

      GLogger.debug(result.toString());

      return result;
    } catch (e) {
      e.logException();
      return null;
    }
  }
}
