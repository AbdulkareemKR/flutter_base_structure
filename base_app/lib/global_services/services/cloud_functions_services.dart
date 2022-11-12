import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:garage_client/global_services/models/cloud_function_response.dart';

class CloudFunctionsServices {
  static Future<CloudFunctionsResponse?> call(
      {required String functionName, Map<String, dynamic> arguments = const {}}) async {
    try {
      log('Calling $functionName');

      final callable = FirebaseFunctions.instance.httpsCallable(functionName);
      final data = (await callable(arguments)).data;

      final result = CloudFunctionsResponse.fromJson(data);

      log(result.toString());

      return result;
    } catch (e) {
      log('$e');
      ;
      return null;
    }
  }
}
