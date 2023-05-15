import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/components/calendar/calendar_page.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:tasklendar/app/modules/routine/controllers/routine_controller.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/app/utils/calendar_utils.dart';
import 'package:tasklendar/app/utils/routine_utils.dart';
import 'package:tasklendar/app/utils/validation.dart';
import 'package:tasklendar/generated/locales.g.dart';

class RoutineForm extends GetView<RoutineController> {
  RoutineForm({
    super.key,
    required DataStore dataStore,
    required AppController appController,
    required CalendarComponentController calendarComponentController,
  })  : _dataStore = dataStore,
        _appController = appController,
        _calendarComponentController = calendarComponentController,
        _pageController = PageController(
          initialPage: dataStore.currentDate.value.month - 1,
        );

  // Store //
  final DataStore _dataStore;

  // Controller //
  final CalendarComponentController _calendarComponentController;
  final AppController _appController;
  final PageController _pageController;
  final TextEditingController textController = TextEditingController();

  // Rx //
  final RxInt _year = DateTime.now().year.obs;
  final RxString _error = ''.obs;

  // Other //
  final _key = GlobalKey();

  // Getters //
  RxMap<int, Map<int, List<List<dynamic>>>> get _calendarList =>
      _dataStore.calendarList;
  Rx<DateTime> get _currentDate => _dataStore.currentDate;
  List get _period => RoutineUtils.period;
  List get dateTypes => RoutineUtils.dateType;
  Map get dayOfWeeks => RoutineUtils.dayOfWeek;
  // List get days => RoutineUtils.days;
  String get _selectedDateType => controller.selectedDateType.value;
  String get _selectedPeriod => controller.selectedPeriod.value;

  @override
  Widget build(BuildContext context) {
    final _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final formKey = GlobalKey<FormState>();

    return Container(
      height: Get.height * 0.8,
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: _keyboardHeight,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 20,
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    FontAwesomeIcons.xmark,
                    color: AppTheme.colorScheme.onPrimary,
                  ),
                ),
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colorScheme.onPrimary,
                  fontFamily: 'EbiharaNoKuseji',
                ),
                cursorColor: AppTheme.colorScheme.onPrimary,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                controller: textController,
                validator: (value) {
                  _error.value = Validators.validateRoutine(value) ?? '';
                  return null;
                },
              ),
              Obx(() {
                return _error.isNotEmpty
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _error.value,
                          style: AppTypography.formError,
                        ),
                      )
                    : Container();
              }),
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _period.length,
                  itemBuilder: (_, index) {
                    return Obx(
                      () => TextButton(
                        onPressed: () {
                          controller.selectedPeriod.value = _period[index];
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            controller.selectedPeriod.value == _period[index]
                                ? AppTheme.colorScheme.secondary
                                : AppTheme.colorScheme.primary,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        child: Text(
                          _period[index],
                          style: TextStyle(
                            fontSize: 17,
                            color: controller.selectedPeriod.value ==
                                    _period[index]
                                ? AppTheme.colorScheme.primary
                                : AppTheme.colorScheme.onPrimary,
                            fontFamily: AppTypography.getPreferredFont(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(() {
                return Wrap(
                  children: [
                    if (_selectedPeriod == LocaleKeys.period_weekly.tr ||
                        _selectedPeriod == LocaleKeys.period_biweekly.tr)
                      // Weekly or Biweekly only
                      for (final dayOfWeek in dayOfWeeks.entries)
                        SizedBox(
                          width: Get.width * 0.22,
                          child: CheckboxListTile(
                            title: Transform.translate(
                              offset: const Offset(-16, 0),
                              child: Text(
                                dayOfWeek.key,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: controller
                                      .getDayOfWeekColor(dayOfWeek.value),
                                  fontFamily: AppTypography.getPreferredFont(),
                                ),
                              ),
                            ),
                            value:
                                controller.selectedDayOfWeeks[dayOfWeek.value]!,
                            onChanged: (bool? value) {
                              controller.selectedDayOfWeeks[dayOfWeek.value] =
                                  value!;
                            },
                            activeColor:
                                controller.getDayOfWeekColor(dayOfWeek.value),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                  ],
                );
              }),
              Obx(() {
                // Monthly only
                if (_selectedPeriod == LocaleKeys.period_monthly.tr) {
                  return SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.selectedDays.length,
                      itemBuilder: (_, index) {
                        return SizedBox(
                          width: Get.width * 0.2,
                          child: CheckboxListTile(
                            title: Transform.translate(
                              offset: const Offset(-10, 0),
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  color: AppTheme.colorScheme.onPrimary,
                                  fontFamily: AppTypography.getPreferredFont(),
                                ),
                              ),
                            ),
                            value: controller.selectedDays[index + 1],
                            onChanged: (bool? value) {
                              controller.selectedDays[index + 1] = value!;
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              Obx(() {
                return Row(
                  children: [
                    for (String dateType in dateTypes)
                      Expanded(
                        child: RadioListTile(
                          title: Text(
                            dateType,
                            style: TextStyle(
                              fontSize: 17,
                              color: controller.getDateTypeColor(dateType),
                              fontFamily: AppTypography.getPreferredFont(),
                            ),
                          ),
                          value: dateType,
                          groupValue: controller.selectedDateType.value,
                          onChanged: (value) {
                            controller.selectedDateType.value = value!;
                          },
                          activeColor:
                              dateType == LocaleKeys.date_type_start_date.tr
                                  ? AppColors.orange
                                  : AppColors.blue,
                        ),
                      ),
                  ],
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Container(
                      alignment: Alignment.center,
                      child: DropdownButton(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        elevation: 1,
                        dropdownColor: AppTheme.colorScheme.primary,
                        underline: Container(
                          color: AppTheme.colorScheme.primary,
                        ),
                        icon: Icon(
                          FontAwesomeIcons.caretDown,
                          color: AppTheme.colorScheme.onPrimary,
                          size: 15,
                        ),
                        value: _year.value,
                        onChanged: (value) {
                          _year.value = value as int;
                          _calendarComponentController
                              .createCalendarListForYear(_year.value);
                        },
                        items: _calendarComponentController.yearList
                            .map((year) => DropdownMenuItem(
                                  value: year,
                                  child: Text(
                                    year.toString(),
                                    style: AppTypography.h5,
                                  ),
                                ))
                            .toList(),
                      ),
                    );
                  }),
                  Spacer(),
                  Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: controller.isInfinite.value
                                  ? AppColors.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _selectedDateType ==
                                  LocaleKeys.date_type_start_date.tr
                              ? null
                              : () {
                                  controller.isInfinite.value =
                                      !controller.isInfinite.value;
                                },
                          child: Text(
                            'infinity',
                            style: AppTypography.h5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _year.value = DateTime.now().year;
                      _calendarComponentController
                          .setSelectedDateValue(DateTime.now());
                      _appController.goToPage(
                        _pageController,
                        DateTime.now().month - 1,
                      );
                    },
                    child: Text(
                      'tody',
                      style: AppTypography.h5,
                    ),
                  ),
                ],
              ),
              Container(
                height: Get.height * 0.3,
                child: Obx(() {
                  // final selectedDate = DataStore.to.selectedDate.value;
                  final todoList = _dataStore.todoList;
                  _calendarComponentController
                      .createCalendarListForYear(_year.value);
                  return PageView.builder(
                    itemCount: _calendarList[_year.value]?.length,
                    controller: _pageController,
                    itemBuilder: (BuildContext context, int index) {
                      final targetKey = _calendarList[_currentDate.value.year]!
                          .keys
                          .firstWhere((key) => key == index + 1);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            CalendarUtils.months[targetKey]!,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: AppTypography.getPreferredFont(),
                              color: AppTheme.colorScheme.onPrimary,
                            ),
                          ),
                          const Gap(10),
                          Flexible(
                            fit: FlexFit.loose,
                            child: CalendarPage(
                              weeks: _calendarList[_year.value]![targetKey],
                              calledFrom: 'routine',
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: CustomElevatedButton(
                  text: LocaleKeys.save.tr,
                  onPressed: () {
                    formKey.currentState!.validate();
                    if (_error.value.isEmpty) {
                      controller.addRoutine(
                        title: textController.text,
                        period: controller.selectedPeriod.value,
                        dayOfWeek: controller.getTrueSelectedDayOfWeeks(),
                        startDate: controller.startDate.value,
                        endDate: controller.endDate.value,
                        // isInfinite:
                      );
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
