import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_client/models/timeslot.dart';
import 'package:garage_client/models/timeslot_repeat.dart';
import 'package:garage_client/services/firestore_services.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:intl/intl.dart';

Future<List<Timeslot>> getAvailableTimeslots(String serviceId) async {
  // TODO : implement the function to get the availabe timeslots from the serviceID
  //
  /// It should be a [FireStore] query that get all timeslots with:
  /// [serviceId] == the passed serviceId
  /// [isValid] == true
  /// [isReserved] == false
  ///
  final timeslotsDocs = await FirestoreServices.timeslotsCollection
      .where('serviceId', arrayContains: serviceId)
      .where('dateTo', isGreaterThan: Timestamp.now())
      .where('isReserved', isEqualTo: false)
      .where('isValid', isEqualTo: true)
      .get();

  /// FIXME: this is a temporary solution to get the timeslots,
  /// should be deleted after the app is fully migrated to the new timeslots model.
  final timeslotWithOneServiceDocs = await FirestoreServices.timeslotsCollection
      .where('serviceId', isEqualTo: serviceId)
      .where('dateTo', isGreaterThan: Timestamp.now())
      .where('isReserved', isEqualTo: false)
      .where('isValid', isEqualTo: true)
      .get();

  if (timeslotsDocs.docs.isNotEmpty || timeslotWithOneServiceDocs.docs.isNotEmpty) {
    final totalTimeslots = timeslotsDocs.docs + timeslotWithOneServiceDocs.docs;
    final timeslotsList = totalTimeslots.map((timeslot) => Timeslot.fromMap(timeslot.data())).toList();
    return timeslotsList;
  } else {
    return [];
  }
}

Map<String, List<Timeslot>> groupTimeslotsByDay(Iterable<dynamic> timeslots, String localCode) {
  final Map<String, List<Timeslot>> timeslotsMap = {};
  for (final timeslot in timeslots) {
    final day =
        "${DateFormat('EEEE', localCode).format(timeslot.dateFrom.toDate())} ${DateFormat('Md', localCode).format(timeslot.dateFrom.toDate())}";
    if (timeslotsMap.containsKey(day)) {
      timeslotsMap[day]!.add(timeslot);
    } else {
      timeslotsMap[day] = [timeslot];
    }
  }

  return timeslotsMap;
}

String getDurationAsString(Timestamp from, Timestamp to, String localCode) {
  // This map used to map the duration number to readable text
  // TODO : use translatable
  final durationsMap = {
    'ar_SA': ['صفر', "ساعة واحدة", "ساعتان", 'ساعات'],
    'en': ['zero', 'one hour', 'two hours', 'hours']
  };

  // Getting the difference

  final durationNumber = to.toDate().difference(from.toDate()).inHours;
  final String durationText;
  switch (durationNumber) {
    case 0:
    case 1:
    case 2:
      durationText = durationsMap[localCode]?[durationNumber] ?? '';
      break;
    default:
      durationText = durationNumber.toString() + (durationsMap[localCode]?.last ?? '');
  }

  return durationText;
}

Stream<List<Timeslot>> getTimeslotsStream(String serviceProviderId, {DateTime? date, bool? isReserved}) {
  try {
    final DateTime fromDate;
    if (date != null) {
      fromDate = DateTime(date.year, date.month, date.day);
    } else {
      fromDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }

    final toDate = fromDate.add(const Duration(days: 1));

    final timeslotStream = FirestoreServices.timeslotsCollection
        .where('serviceProviderId', isEqualTo: serviceProviderId)
        .where('dateFrom', isGreaterThanOrEqualTo: Timestamp.fromDate(fromDate))
        .where('dateFrom', isLessThan: Timestamp.fromDate(toDate))
        .where('isValid', isEqualTo: true)
        .where("isReserved", isEqualTo: isReserved)
        .snapshots()
        .map((list) => list.docs.map((doc) => Timeslot.fromMap(doc.data())).toList());

    return timeslotStream;
  } catch (e) {
    e.logException();
    return const Stream.empty();
  }
}

Stream<List<TimeslotRepeat>> getTimeslotsRepeatStream(String serviceProviderId) {
  try {
    final timeslotRepeatStream = FirestoreServices.timeslotRepeatCollection
        .where('serviceProviderId', isEqualTo: serviceProviderId)
        .snapshots()
        .map((list) => list.docs.map((doc) => TimeslotRepeat.fromMap(doc.data())).toList());

    return timeslotRepeatStream;
  } catch (e) {
    e.logException();
    return const Stream.empty();
  }
}

Future<bool> addTimeslot(Timeslot timeslot) async {
  try {
    final docRef = FirestoreServices.timeslotsCollection.doc();
    final timeslotToSave = timeslot.copyWith(id: docRef.id);
    await docRef.set(timeslotToSave.toMap());
    return true;
  } catch (e) {
    e.logException();
    return false;
  }
}
