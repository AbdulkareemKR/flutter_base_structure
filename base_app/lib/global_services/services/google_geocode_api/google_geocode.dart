import 'package:garage_client/global_services/services/google_geocode_api/result.dart';

class GoogleGeocodeResult {
  List<Result>? results;

  GoogleGeocodeResult({
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'results': results?.map((result) => result.toMap()).toList(),
    };
  }

  factory GoogleGeocodeResult.fromMap(Map<String, dynamic> map) {
    return GoogleGeocodeResult(
      results:
          map['results'] != null ? List.from((map['results'])).map((result) => Result.fromMap(result)).toList() : null,
    );
  }
}
