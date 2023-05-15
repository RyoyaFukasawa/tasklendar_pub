import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/components/calendar/calendar_page.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:tasklendar/app/data/models/todo_model.dart';
import 'package:tasklendar/app/modules/todo/controllers/todo_controller.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/app/utils/calendar_utils.dart';
import 'package:tasklendar/app/utils/validation.dart';
import 'package:tasklendar/generated/locales.g.dart';

class TodoForm extends GetView<TodoController> {
  TodoForm({
    super.key,
    this.todo,
    required DataStore dataStore,
    required AppController appController,
    required CalendarComponentController calendarComponentController,
  })  : _appController = appController,
        _calendarComponentController = calendarComponentController,
        _dataStore = dataStore,
        isPined = todo?.isPinned.obs ?? false.obs {
    calendarComponentController
        .setSelectedDateValue(dataStore.currentDate.value);
  }

  // Model //
  final TodoModel? todo;

  // Store //
  final DataStore _dataStore;

  // Controller //
  final AppController _appController;
  final PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  final CalendarComponentController _calendarComponentController;

  // Rx //
  final RxInt year = DateTime.now().year.obs;
  final RxBool isPined;
  final Rx<String> _error = ''.obs;

  // Other //
  final _formKey = GlobalKey<FormState>();

  // Getters //
  DateTime get _selectedDate => _calendarComponentController.selectedDate.value;

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final todoController = TextEditingController(text: todo?.title ?? '');

    return Container(
      alignment: Alignment.topCenter,
      height: Get.height * 0.8,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gap(25),
                Row(
                  children: [
                    Obx(
                      () => IconButton(
                        onPressed: () {
                          isPined.value = !isPined.value;
                        },
                        icon: Icon(
                          FontAwesomeIcons.thumbtack,
                          color: isPined.value == true
                              ? AppColors.pin
                              : AppTheme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        style: AppTypography.todo(
                          lineThrough: false,
                          fontWeight: true,
                        ),
                        cursorColor: AppTheme.colorScheme.onPrimary,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorStyle: AppTypography.formError,
                        ),
                        controller: todoController,
                        validator: (value) {
                          _error.value = Validators.validateTask(value) ?? '';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  final error = controller.error.value.isEmpty
                      ? _error.value
                      : controller.error.value;

                  return error.isNotEmpty
                      ? Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            error,
                            style: AppTypography.formError,
                          ),
                        )
                      : Container();
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Container(
                        alignment: Alignment.center,
                        child: Container(
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
                            value: year.value,
                            onChanged: (value) {
                              year.value = value as int;
                              _calendarComponentController
                                  .createCalendarListForYear(year.value);
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
                        ),
                      );
                    }),
                    TextButton(
                      onPressed: () {
                        year.value = DateTime.now().year;
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
                    // rebuild
                    final selectedDate = _selectedDate;
                    final todoList = _dataStore.todoList;
                    _calendarComponentController
                        .createCalendarListForYear(year.value);
                    return PageView.builder(
                      itemCount: _dataStore.calendarList[year.value]?.length,
                      controller: _pageController,
                      itemBuilder: (BuildContext context, int index) {
                        final targetKey = _dataStore
                            .calendarList[year.value]!.keys
                            .firstWhere((key) => key == index + 1);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              CalendarUtils.months[targetKey]!,
                              style: AppTypography.h5,
                            ),
                            const Gap(10),
                            Flexible(
                              fit: FlexFit.loose,
                              child: CalendarPage(
                                weeks: _dataStore
                                    .calendarList[year.value]![targetKey],
                                calledFrom: 'todo',
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
                      // controller.error.value = '';
                      _formKey.currentState!.validate();
                      if (_error.value.isEmpty) {
                        if (todo != null) {
                          controller.updateTodo(
                            id: todo!.id,
                            title: todoController.text,
                            date: _selectedDate,
                            isPined: isPined.value,
                          );
                        } else {
                          final todo = todoController.text;
                          controller.addTodo(
                            date: _selectedDate,
                            title: todo,
                            isPined: isPined.value,
                          );
                        }
                        Get.back();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
