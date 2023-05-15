import 'package:get/get.dart';
import 'package:tasklendar/app/store/data_store.dart';

class CalendarController extends GetxController {
  CalendarController({
    required DataStore dataStore,
  })  : _dataStore = dataStore,
        currentYear = dataStore.currentDate.value.year.obs;

  // Store //
  final DataStore _dataStore;

  // Rx //
  final RxInt currentYear;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
