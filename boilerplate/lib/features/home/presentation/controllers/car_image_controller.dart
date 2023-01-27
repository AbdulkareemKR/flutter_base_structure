import 'package:garage_client/models/car.dart';
import 'package:garage_client/models/cloud_image/cloud_image.dart';
import 'package:garage_client/services/firestore_services.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final carImageProvider = FutureProvider.autoDispose.family<CloudImage?, String>((ref, carId) async {
  final carImageUrl = await CarImageController.getCarImageUrl(carId);
  return Future.value(carImageUrl);
});

class CarImageController {
  static Future<CloudImage?> getCarImageUrl(String carId) async {
    try {
      final car = Car.fromMap((await FirestoreServices.carsCollection.doc(carId).get()).data()!);
      final image = car.image;

      return image;
    } catch (e) {
      GLogger.error('$e');
      return null;
    }
  }
}
