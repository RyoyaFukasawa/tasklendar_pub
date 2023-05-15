import 'package:get/get.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/store/data_store.dart';

import '../controllers/calendar_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarController>(
      () => CalendarController(
        dataStore: Get.find<DataStore>(),
      ),
    );
    Get.put(
      CalendarComponentController(
        dataStore: Get.find<DataStore>(),
      ),
    );
  }
}
