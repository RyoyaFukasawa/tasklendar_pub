// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/default_design/default_button.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/notifier/global_vars/custom_modal_bottom_sheet/modal_bottom_sheet_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/select_dates/select_dates_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/calendar/calendar_notifier.dart';
import 'package:tasklendar/presentation/state/custom_modal_bottom_sheet/modal_bottom_sheet_state.dart';
import 'package:tasklendar/presentation/state/select_dates/select_dates_state.dart';

class SelectDatePage extends HookConsumerWidget {
  const SelectDatePage({
    required Key key,
    required DateTime? startDate,
    required DateTime? endDate,
  })  : _key = key,
        _startDate = startDate,
        _endDate = endDate,
        super(key: key);

  final Key _key;
  final DateTime? _startDate;
  final DateTime? _endDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int startWeekDay = DateTime.sunday;
    final theme = AppTheme.colorScheme;
    final CalendarPageNotifier calendarPageNotifier =
        ref.read(calendarPageNotifierProvider.notifier);
    final SelectDatesNotifier selectDatesNotifier =
        ref.read(selectDatesNotifierProvider.notifier);
    final SelectDatesState state = ref.watch(selectDatesNotifierProvider);
    final ModalBottomSheetNotifier modalBottomSheetNotifier =
        ref.read(modalBottomSheetNotifierProvider.notifier);

    final currentMonth = useState(now);

    final screenWidth = Screen.width;

    final PageController controller = usePageController(
      initialPage: 9999,
    );

    final toggleSwitch = useState(false);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          selectDatesNotifier.updateState(
            state.copyWith(
              startDate: _startDate,
              endDate: _endDate,
            ),
          );
        });
        return null;
      },
      const [],
    );

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          selectDatesNotifier.autoCalculateDuration();
          if (state.endDate != null && toggleSwitch.value == false) {
            toggleSwitch.value = true;
          }
        });
        return null;
      },
      [state.endDate],
    );

    final tickerProvider = useSingleTickerProvider();

    final shakingAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: tickerProvider,
    );

    final rightAnimation = Tween<double>(begin: 0.0, end: -2.0).animate(
      CurvedAnimation(
        parent: shakingAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    void startShakeAnimation() {
      HapticFeedback.mediumImpact();
      shakingAnimationController.forward().whenComplete(() => {
            shakingAnimationController.reverse().whenComplete(() => {
                  shakingAnimationController.forward().whenComplete(() => {
                        shakingAnimationController.reverse(),
                      }),
                }),
          });
    }

    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Gap(10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultButton(
                builder: (isHover, opacity) => Row(
                  children: [
                    Text(
                      currentMonth.value.monthFormat(),
                      style: AppTypography.h4.copyWith(
                        color: theme.onBackground.withOpacity(
                          isHover ? opacity : 1,
                        ),
                      ),
                    ),
                    const Gap(5),
                    BaseIcon(
                      Symbols.arrow_drop_down,
                      color: theme.onBackground.withOpacity(
                        isHover ? opacity : 1,
                      ),
                      size: 25,
                    ),
                  ],
                ),
                onPressed: () {
                  int newPage = controller.initialPage;
                  const selectMonthKey = Key('select_month');
                  showCustomModalBottomSheet(
                    key: selectMonthKey,
                    title: 'Select Month',
                    context: context,
                    enableSaveButton: true,
                    initialSaveButtonState: true,
                    onSaveButtonPressed: (context, ref) {
                      context.pop(true);
                    },
                    child: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        height: 250,
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle:
                                  AppTypography.h4.copyWith(
                                fontWeight: FontWeight.w400,
                                color: theme.onBackground,
                              ),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.monthYear,
                            onDateTimeChanged: (DateTime value) async {
                              newPage = (controller.initialPage +
                                  (value.year - now.year) * 12 +
                                  (value.month - now.month));
                            },
                            initialDateTime: currentMonth.value,
                            maximumDate: DateTime(2024, 12),
                            minimumDate: DateTime(2020, 1),
                            minimumYear: 2020,
                            maximumYear: 2024,
                          ),
                        ),
                      );
                    },
                  ).then((value) async {
                    if (value != null && value) {
                      controller.animateToPage(
                        newPage,
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeIn,
                      );
                    }
                  });
                },
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Range',
                    style: AppTypography.body.copyWith(
                      color: theme.onBackground,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: toggleSwitch.value,
                      activeColor: theme.primary,
                      onChanged: (value) {
                        toggleSwitch.value = value;
                        if (value == false) {
                          // selectedEndDate.value = null;
                          selectDatesNotifier.updateState(
                            state.copyWith(
                              endDate: null,
                            ),
                          );
                        }
                        final ModalBottomSheetState? modalState =
                            modalBottomSheetNotifier.getState(
                          _key,
                        );
                        if (modalState != null) {
                          modalBottomSheetNotifier.updateState(
                            _key,
                            modalState.copyWith(
                              isSave: !value,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Gap(10),
              DefaultButton(
                builder: (isHover, opacity) => BaseIcon(
                  Symbols.today_rounded,
                  color: theme.onBackground.withOpacity(
                    isHover ? opacity : 1,
                  ),
                  size: 25,
                ),
                onPressed: () {
                  controller.animateToPage(
                    9999,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ],
          ),
          AnimatedBuilder(
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(rightAnimation.value, 0),
                child: child,
              );
            },
            animation: shakingAnimationController,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Range must be less than 7 days',
                style: AppTypography.body.copyWith(
                  color: theme.secondary,
                ),
              ),
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 7; i++)
                Expanded(
                  child: Center(
                    child: Text(
                      calendarPageNotifier.getWeekdayName(
                        (startWeekDay % 7) + i,
                        context,
                      ),
                      style: AppTypography.body.copyWith(
                        color: now.weekday % 7 == (startWeekDay % 7) + i
                            ? theme.primary
                            : theme.onBackground,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Gap(10),
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              onPageChanged: (int index) {
                final DateTime newCurrentMonth = DateTime(
                  now.year,
                  now.month - (controller.initialPage - index),
                );
                currentMonth.value = newCurrentMonth;
              },
              itemBuilder: (BuildContext context, int index) {
                final DateTime currentMonth = DateTime(
                  now.year,
                  now.month - (controller.initialPage - index),
                );
                return Builder(
                  builder: (context) {
                    DateTime firstDayOfMonth = currentMonth.firstDayOfMonth();
                    int firstWeekday = firstDayOfMonth.weekday;
                    return SizedBox(
                      width: screenWidth,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: (screenWidth / 7) / (250 / 6),
                        ),
                        itemCount: 42,
                        itemBuilder: (context, index) {
                          int dayNumber =
                              index - firstWeekday + startWeekDay % 7 + 1;

                          int year = currentMonth.year;
                          int month = currentMonth.month;

                          DateTime date = DateTime(year, month, dayNumber);

                          return DefaultButton(
                            onPressed: () {
                              print('startDate ${state.startDate}');
                              print('endDate ${state.endDate}');
                              if (toggleSwitch.value == true) {
                                if (state.startDate == null) {
                                  selectDatesNotifier.updateState(
                                    state.copyWith(
                                      startDate: date,
                                    ),
                                  );
                                  return;
                                }
                                if (date.isBefore(state.startDate!) &&
                                    state.endDate == null) {
                                  selectDatesNotifier.updateState(
                                    state.copyWith(
                                      startDate: date,
                                    ),
                                  );
                                  return;
                                }
                                if (state.endDate == null) {
                                  if (date.isSameDay(state.startDate!)) {
                                    return;
                                  }
                                  selectDatesNotifier.updateState(
                                    state.copyWith(
                                      endDate: date,
                                    ),
                                  );
                                  final int duration =
                                      selectDatesNotifier.calculateDuration(
                                    startDate: state.startDate!,
                                    endDate: date,
                                  );
                                  if (duration > 7) {
                                    startShakeAnimation();
                                    final modalState =
                                        modalBottomSheetNotifier.getState(
                                      _key,
                                    );
                                    if (modalState != null) {
                                      modalBottomSheetNotifier.updateState(
                                        _key,
                                        modalState.copyWith(
                                          isSave: false,
                                        ),
                                      );
                                    }
                                    return;
                                  }
                                  final modalState =
                                      modalBottomSheetNotifier.getState(
                                    _key,
                                  );
                                  if (modalState != null) {
                                    modalBottomSheetNotifier.updateState(
                                      _key,
                                      modalState.copyWith(
                                        isSave: true,
                                      ),
                                    );
                                  }
                                  return;
                                }
                                if (state.endDate != null) {
                                  selectDatesNotifier.updateState(
                                    state.copyWith(
                                      startDate: date,
                                      endDate: null,
                                    ),
                                  );
                                  final modalState =
                                      modalBottomSheetNotifier.getState(
                                    _key,
                                  );
                                  if (modalState != null) {
                                    modalBottomSheetNotifier.updateState(
                                      _key,
                                      modalState.copyWith(
                                        isSave: false,
                                      ),
                                    );
                                  }
                                  return;
                                }
                              }
                              if (toggleSwitch.value == false) {
                                if (state.startDate != null &&
                                    date.isSameDay(state.startDate!)) {
                                  selectDatesNotifier.updateState(
                                    state.copyWith(
                                      startDate: null,
                                    ),
                                  );
                                  return;
                                } else {
                                  selectDatesNotifier.updateState(
                                    state.copyWith(
                                      startDate: date,
                                    ),
                                  );
                                }
                                final modalState =
                                    modalBottomSheetNotifier.getState(
                                  _key,
                                );
                                if (modalState != null) {
                                  modalBottomSheetNotifier.updateState(
                                    _key,
                                    modalState.copyWith(
                                      isSave: true,
                                    ),
                                  );
                                }
                              }
                            },
                            builder: (isHover, opacity) {
                              return Container(
                                color: state.startDate != null &&
                                        date.isAfter(state.startDate!) &&
                                        state.endDate != null &&
                                        date.isBefore(state.endDate!)
                                    ? AppTheme.colorScheme.primary
                                        .withOpacity(AppOpacity.disabled)
                                    : Colors.transparent,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  child: CustomPaint(
                                    painter: toggleSwitch.value &&
                                            state.endDate != null
                                        ? state.startDate != null &&
                                                date.isSameDay(state.startDate!)
                                            ? RightHalfRectanglePainter()
                                            : date.isSameDay(state.endDate!)
                                                ? LeftHalfRectanglePainter()
                                                : null
                                        : null,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 1,
                                        bottom: 1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _backGroundColor(
                                          selectedStartDate: state.startDate,
                                          date: date,
                                          currentMonth: currentMonth.month,
                                          selectedEndDate: state.endDate,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          date.day.toString(),
                                          style: AppTypography.h5.copyWith(
                                            color: _dateTextColor(
                                              selectedStartDate:
                                                  state.startDate,
                                              date: date,
                                              currentMonth: currentMonth.month,
                                              selectedEndDate: state.endDate,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _backGroundColor({
    required DateTime? selectedStartDate,
    required DateTime date,
    required int currentMonth,
    required DateTime? selectedEndDate,
  }) {
    if (selectedStartDate != null && selectedStartDate.isSameDay(date)) {
      return AppTheme.colorScheme.primary;
    } else if (selectedEndDate?.isSameDay(date) ?? false) {
      return AppTheme.colorScheme.primary;
    } else if (date.month == currentMonth) {
      return transparent;
    } else {
      return transparent;
    }
  }

  Color _dateTextColor({
    required DateTime? selectedStartDate,
    required DateTime date,
    required int currentMonth,
    required DateTime? selectedEndDate,
  }) {
    if (selectedStartDate != null && selectedStartDate.isSameDay(date)) {
      return AppTheme.colorScheme.onPrimary;
    } else if (selectedEndDate?.isSameDay(date) ?? false) {
      return AppTheme.colorScheme.onPrimary;
    } else if (date.truncateTime() == now.truncateTime()) {
      return AppTheme.colorScheme.primary;
    } else if (date.month == currentMonth) {
      return AppTheme.colorScheme.onBackground;
    } else {
      return AppTheme.colorScheme.onBackground.withOpacity(AppOpacity.disabled);
    }
  }
}

class RightHalfRectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.orange.withOpacity(
        AppOpacity.disabled,
      )
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height)
      ..close(); // パスを閉じる

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LeftHalfRectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.orange.withOpacity(
        AppOpacity.disabled,
      )
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height)
      ..close(); // パスを閉じる

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
