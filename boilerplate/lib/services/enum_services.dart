import 'package:garage_client/utils/logger/g_logger.dart';

T enumFromString<T>(Iterable<T> values, String? value) {
  return values.firstWhere((type) {
    return type.toString().split(".").last.toLowerCase().replaceAll('-', '').replaceAll('_', '') ==
        value?.toLowerCase().replaceAll('-', '').replaceAll('_', '');
  });
}

@Deprecated("Use [enum.name] instead")
String? enumToString<T>(T? enumValue) {
  if (enumValue == null) return null;
  return enumValue.toString().split(".")[1].replaceAll("_", " ");
}

List<String> enumToList<T>(Iterable<T>? values) {
  if (values == null) return [];
  List<String> list = [];
  for (final element in values) {
    final stringElement = enumToString(element);
    if (stringElement != null) {
      list.add(stringElement);
    }
  }

  return list;
}

List<T> enumFromList<T>(Iterable<T> values, List<dynamic>? enumList) {
  if (enumList == null) return [];
  final newList = enumList.whereType<String>();
  final List<T> enums = [];
  for (final item in newList) {
    final singleElement = enumFromString(values, item);
    if (singleElement != null) {
      enums.add(singleElement);
    }
  }
  return enums;
}

String getEnumReadable<T>(T enumValue, String localCode) {
  // This will return the string of the enum in lowercase i.e PaymentMethod.applePay => "paymentmethod.apppay"
  final enumAsString = enumValue.toString().toLowerCase();
  // We are using lower case because it is easier to map

  // We should have the readable value on the localization json file
  // For example we should have something like:
  /// ``
  /// `` { ...
  /// ``   "paymentmethod" : {
  ///                 "applepay" :  "أبل باي"  ,
  /// ... }
  /// so then we can get its readable value from the localization
  ///
  /// I will use this local map for testing
  final enumLocalization = {
    'paymentmethod': {'applepay': 'Apple Pay', 'mada': 'مدى', 'visa': 'فيزا'},
    'currency': {'sar': "رس"},
    'orderstatus': {
      'completed': "مكتمل",
      'beinghandled': "قيد التجهيز",
      'intheway': "في الطريق",
      'accepted': "مقبول",
      'underprocessing': "قيد المعالجة",
      'canceled': "ملغي",
    },
    'paymentmethod': {'applepay': 'Apple Pay', 'mada': 'مدى', 'visa': 'فيزا', 'giftcard': "بطاقة هدية"},
    'transactiontype': {'withdrawal': 'سحب', 'deposit': 'تغذية المحفظة', 'refund': 'استعادة اموال'},
    'currency': {'sar': "رس"}
  };
  try {
    final enumType = enumAsString.split('.').first;
    final enumValue = enumAsString.split('.').last;

    final enumReadable = enumLocalization[enumType]![enumValue]!;
    return enumReadable;
  } catch (e) {
    e.logException();
    throw Exception('The enum value was not found');
  }
}
