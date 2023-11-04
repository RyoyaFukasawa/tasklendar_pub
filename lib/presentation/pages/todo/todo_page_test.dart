// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:gap/gap.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:material_symbols_icons/symbols.dart';
// import 'package:tasklendar/config/styles/app_themes.dart';
// import 'package:tasklendar/core/extension/date_time_extension.dart';
// import 'package:tasklendar/core/utils/screen.dart';
// import 'package:tasklendar/presentation/components/button/base_button.dart';
// import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';

// class TodoPage extends HookConsumerWidget {
//   TodoPage({
//     super.key,
//     required DateTime initialDate,
//   }) : _initialDate = initialDate;

//   final DateTime _initialDate;
//   // TodoPage({
//   //   required DateTime initialDate,
//   //   required DataStore dataStore,
//   //   required TodoFormController todoFormController,
//   //   required AppController appController,
//   //   Key? key,
//   // })  : _initialDate = initialDate,
//   //       _dataStore = dataStore,
//   //       _appController = appController,
//   //       _selectedDate = initialDate.obs,
//   //       super(key: key) {
//   //   todoFormController.setSelectedDateValue(initialDate);
//   //   _pageController = PageController(
//   //     initialPage: _initialPage,
//   //   );
//   // }

//   // Store //
//   // final DataStore _dataStore;

//   // // Controllers //
//   // final AppController _appController;

//   // final DateTime _initialDate;
//   // final now = DateTime.now();
//   // final Rx<List> dateList = Rx<List>([]);
//   final int _initialPage = 5000;
//   // late final PageController _pageController;
//   // final Rx<DateTime> _currentDate = Rx<DateTime>(DateTime.now());
//   // final Rx<DateTime> _selectedDate;
//   // final RxInt todayIndex = RxInt(0);
//   // final RxInt currentIndex = RxInt(0);

//   // // Getter //
//   // List<TodoModel> get _allTodos => _dataStore.allTodos.value;
//   // // Map<DateTime, RxList<TodoModel>> get _todosByDate =>
//   // //     _dataStore.todosByDate.value;

//   // Timer? _longPressTimer;
//   // final Rx<double> _longPressProgress = 0.0.obs;

//   // void _startLongPressTimer(LongPressStartDetails details, String forward) {
//   //   _longPressTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
//   //     _longPressProgress.value += 0.1; // 適宜調整
//   //     if (_longPressProgress.value >= 1.0) {
//   //       _longPressTimer?.cancel();
//   //       _longPressTimer = null;
//   //       _longPressProgress.value = 0.0;
//   //       if (forward == 'forward') {
//   //         movePage(currentIndex.value + 1);
//   //       } else {
//   //         movePage(currentIndex.value - 1);
//   //       }
//   //       _startLongPressTimer(details, forward);
//   //     }
//   //   });
//   // }

//   // void movePage(int page) {
//   //   _pageController.animateToPage(
//   //     page,
//   //     duration: Duration(milliseconds: 500),
//   //     curve: Curves.ease,
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier = ref.read(todoPageNotifierProvider.notifier);
//     final theme = AppTheme.colorScheme;

//     return ReorderableListView.builder(
//       itemCount: state.todos.length,
//       onReorder: (int oldIndex, int newIndex) {},
//       proxyDecorator: (Widget child, int index, _) {
//         return Material(
//           shadowColor: Theme.of(context)
//               .colorScheme
//               .onBackground
//               .withOpacity(AppOpacity.barrier),
//           borderRadius: BorderRadius.circular(10),
//           elevation: 4,
//           child: child,
//         );
//       },
//       itemBuilder: (BuildContext context, int index) {
//         final TodoEntity? todo = state.todos[index];
//         if (todo == null) {
//           return const SizedBox(
//             key: Key(''),
//           );
//         }
//         final Key key = Key(todo.id);
//         return Container(
//           key: key,
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: AppColors.darkWhite,
//                   width: 0.3,
//                 ),
//               ),
//             ),
//             child: TodoTile(
//               todo: todo,
//               key: key,
//               endActionPane: ActionPane(
//                 extentRatio: 0.2,
//                 motion: const ScrollMotion(),
//                 dismissible: DismissiblePane(
//                   onDismissed: () {
//                     notifier.removeTodo(todo);
//                   },
//                 ),
//                 children: [
//                   DeleteSlidableAction(
//                     onPressed: (BuildContext buildContext) {
//                       notifier.removeTodo(todo);
//                     },
//                   ),
//                 ],
//               ),
//               startActionPane: ActionPane(
//                 extentRatio: 0.4,
//                 motion: const ScrollMotion(),
//                 dismissible: DismissiblePane(
//                   onDismissed: () {},
//                 ),
//                 children: [
//                   SlidableAction(
//                     onPressed: (BuildContext buildContext) {},
//                     backgroundColor: theme.primary,
//                     foregroundColor: theme.onPrimary,
//                     icon: Symbols.push_pin_rounded,
//                   ),
//                   EditSlidableAction(
//                     onPressed: (BuildContext buildContext) {
//                       showCustomModalBottomSheet(
//                         key: const Key('addTodoPage'),
//                         context: context,
//                         child: (_) => AddTodoPage(
//                           groupId: todo.groupId,
//                           todo: todo,
//                         ),
//                         isBottomNavigationBar: false,
//                         isScrollControlled: true,
//                         useTopBar: false,
//                         horizontalPadding: 0,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );

//     // return Stack(
//     //   children: [
//     //     Container(
//     //       height: screenHeight,
//     //       width: double.infinity,
//     //       child: Column(
//     //         children: [
//     //           Expanded(
//     //             child: PageView.builder(
//     //               controller: _pageController,
//     //               onPageChanged: (int i) {
//     //                 HapticFeedback.lightImpact();
//     //                 final DateTime newDate =
//     //                     _initialDate.add(Duration(days: i - _initialPage));
//     //                 _selectedDate.value = newDate;
//     //               },
//     //               itemBuilder: (BuildContext context, int index) {
//     //                 _currentDate.value =
//     //                     _initialDate.add(Duration(days: index - _initialPage));
//     //                 final scrollController = ScrollController();
//     //                 final DateTime date = _currentDate.value;
//     //                 final bool isToday = date.isSameDay(now);
//     //                 final bool isBeforeToday =
//     //                     date.isBefore(now.truncateTime());

//     //                 final todayDiff = now
//     //                     .difference(date.truncateTime())
//     //                     .inDays;
//     //                 todayIndex.value = index + todayDiff;
//     //                 currentIndex.value = index;

//     //                 return Obx(
//     //                   () {
//     //                     // final List<TodoModel> todos =
//     //                     //     _dataStore.todosByDate[date] ?? [];
//     //                     final List<TodoModel> todos = [];
//     //                     return Column(
//     //                       children: [
//     //                         Container(
//     //                           alignment: Alignment.topLeft,
//     //                           padding: EdgeInsets.only(
//     //                             top: 10,
//     //                             left: 20,
//     //                             right: 20,
//     //                             bottom: 10,
//     //                           ),
//     //                           child: Row(
//     //                             crossAxisAlignment: CrossAxisAlignment.end,
//     //                             children: [
//     //                               if (isToday)
//     //                                 Text(
//     //                                   LocaleKeys.today.tr,
//     //                                   style: AppTypography.h1,
//     //                                 ),
//     //                               if (isToday) const Gap(10),
//     //                               if (isBeforeToday)
//     //                                 Text(
//     //                                   DateFormat.MMMEd(
//     //                                     Get.deviceLocale?.languageCode,
//     //                                   ).format(date).toString(),
//     //                                   style: AppTypography.h1.copyWith(
//     //                                     color: AppTheme.colorScheme.onPrimary
//     //                                         .withOpacity(0.5),
//     //                                   ),
//     //                                 ),
//     //                               if (!isBeforeToday)
//     //                                 Text(
//     //                                   DateFormat.MMMEd(
//     //                                     Get.deviceLocale?.languageCode,
//     //                                   ).format(date).toString(),
//     //                                   style: !isToday
//     //                                       ? AppTypography.h1
//     //                                       : AppTypography.h3.copyWith(
//     //                                           color: AppTheme
//     //                                               .colorScheme.onPrimary
//     //                                               .withOpacity(0.5),
//     //                                         ),
//     //                                 ),
//     //                               const Spacer(),
//     //                               if (todos.isNotEmpty)
//     //                                 Text(
//     //                                   todos.length.toString(),
//     //                                   style: AppTypography.body,
//     //                                 ),
//     //                             ],
//     //                           ),
//     //                         ),
//     //                         Expanded(
//     //                           child: todos.isEmpty
//     //                               ? Obx(
//     //                                   () => AddRefreshIndicator(
//     //                                     widget: SingleChildScrollView(
//     //                                       physics:
//     //                                           AlwaysScrollableScrollPhysics(),
//     //                                       child: Column(
//     //                                         mainAxisSize: MainAxisSize.min,
//     //                                         children: [
//     //                                           Container(
//     //                                             height: Get.height,
//     //                                             alignment: Alignment.center,
//     //                                             width: double.infinity,
//     //                                             padding: EdgeInsets.only(
//     //                                               bottom: Get.height * 0.2,
//     //                                             ),
//     //                                             child: Text(
//     //                                               'Have a nice day!',
//     //                                               style: AppTypography.body,
//     //                                             ),
//     //                                           ),
//     //                                         ],
//     //                                       ),
//     //                                     ),
//     //                                     date: _selectedDate.value,
//     //                                   ),
//     //                                 )
//     //                               : Obx(
//     //                                   () => AddRefreshIndicator(
//     //                                     widget: Scrollbar(
//     //                                       controller: scrollController,
//     //                                       child: ListView.builder(
//     //                                         controller: scrollController,
//     //                                         physics:
//     //                                             AlwaysScrollableScrollPhysics(),
//     //                                         itemCount: todos.length,
//     //                                         itemBuilder: (context, index) {
//     //                                           final TodoModel todo =
//     //                                               todos[index];
//     //                                           Offset? startOffset;
//     //                                           bool isRight = true;
//     //                                           bool isLeft = true;
//     //                                           return Listener(
//     //                                             child: Slidable(
//     //                                               key: Key(todo.id),
//     //                                               endActionPane: ActionPane(
//     //                                                 motion:
//     //                                                     const ScrollMotion(),
//     //                                                 dismissible:
//     //                                                     DismissiblePane(
//     //                                                   onDismissed: () async {
//     //                                                     controller.deleteTodo(
//     //                                                       todo,
//     //                                                       context,
//     //                                                     );
//     //                                                   },
//     //                                                 ),
//     //                                                 children: [
//     //                                                   SlidableAction(
//     //                                                     onPressed: (BuildContext
//     //                                                         buildContext) {
//     //                                                       controller
//     //                                                           .updateTodoDate(
//     //                                                         todo,
//     //                                                         todo.date.add(
//     //                                                           Duration(
//     //                                                               days: -1),
//     //                                                         ),
//     //                                                       );
//     //                                                     },
//     //                                                     backgroundColor:
//     //                                                         AppColors.green,
//     //                                                     foregroundColor:
//     //                                                         AppTheme.colorScheme
//     //                                                             .primary,
//     //                                                     icon: LineIcons
//     //                                                         .chevronLeft,
//     //                                                   ),
//     //                                                   SlidableAction(
//     //                                                     onPressed: (BuildContext
//     //                                                         buildContext) async {
//     //                                                       controller.deleteTodo(
//     //                                                         todo,
//     //                                                         context,
//     //                                                       );
//     //                                                     },
//     //                                                     backgroundColor:
//     //                                                         AppTheme.colorScheme
//     //                                                             .secondary,
//     //                                                     foregroundColor:
//     //                                                         AppTheme.colorScheme
//     //                                                             .primary,
//     //                                                     icon: LineIcons.trash,
//     //                                                   ),
//     //                                                 ],
//     //                                               ),
//     //                                               startActionPane: ActionPane(
//     //                                                 motion:
//     //                                                     const ScrollMotion(),
//     //                                                 dismissible:
//     //                                                     DismissiblePane(
//     //                                                   onDismissed: () async {
//     //                                                     // _dataStore
//     //                                                     //     .removeTodosByDate(
//     //                                                     //         todo);
//     //                                                     _dataStore
//     //                                                         .removeAllTodos(
//     //                                                             todo);

//     //                                                     await Future.delayed(
//     //                                                       Duration(
//     //                                                           milliseconds:
//     //                                                               200),
//     //                                                     );

//     //                                                     await controller
//     //                                                         .updateTodoIsPinned(
//     //                                                       todo,
//     //                                                       !todo.isPinned,
//     //                                                     );
//     //                                                   },
//     //                                                 ),
//     //                                                 children: [
//     //                                                   SlidableAction(
//     //                                                     onPressed: (BuildContext
//     //                                                         buildContext) async {
//     //                                                       await controller
//     //                                                           .updateTodoIsPinned(
//     //                                                         todo,
//     //                                                         !todo.isPinned,
//     //                                                       );
//     //                                                     },
//     //                                                     backgroundColor:
//     //                                                         AppColors.pin,
//     //                                                     foregroundColor:
//     //                                                         AppTheme.colorScheme
//     //                                                             .primary,
//     //                                                     icon:
//     //                                                         LineIcons.thumbtack,
//     //                                                   ),
//     //                                                   SlidableAction(
//     //                                                     onPressed: (BuildContext
//     //                                                         buildContext) {
//     //                                                       controller
//     //                                                           .updateTodoDate(
//     //                                                         todo,
//     //                                                         todo.date.add(
//     //                                                             Duration(
//     //                                                                 days: 1)),
//     //                                                       );
//     //                                                     },
//     //                                                     backgroundColor:
//     //                                                         AppColors.green,
//     //                                                     foregroundColor:
//     //                                                         AppTheme.colorScheme
//     //                                                             .primary,
//     //                                                     icon: LineIcons
//     //                                                         .chevronRight,
//     //                                                   ),
//     //                                                 ],
//     //                                               ),
//     //                                               child: Container(
//     //                                                 padding: EdgeInsets.only(
//     //                                                   left: 20,
//     //                                                   right: 20,
//     //                                                 ),
//     //                                                 child: Stack(
//     //                                                   children: [
//     //                                                     Positioned(
//     //                                                       top: 10,
//     //                                                       bottom: 10,
//     //                                                       left: 0,
//     //                                                       child: Container(
//     //                                                         width: 5,
//     //                                                         color:
//     //                                                             todo.background,
//     //                                                       ),
//     //                                                     ),
//     //                                                     Container(
//     //                                                       alignment:
//     //                                                           Alignment.center,
//     //                                                       decoration:
//     //                                                           BoxDecoration(
//     //                                                         border: Border(
//     //                                                           bottom:
//     //                                                               BorderSide(
//     //                                                             color: AppTheme
//     //                                                                 .colorScheme
//     //                                                                 .onPrimary
//     //                                                                 .withOpacity(
//     //                                                                     0.2),
//     //                                                             width: 1,
//     //                                                           ),
//     //                                                         ),
//     //                                                       ),
//     //                                                       child: ListTile(
//     //                                                         onTap: () async {
//     //                                                           HapticFeedback
//     //                                                               .mediumImpact();
//     //                                                           await controller
//     //                                                               .updateTodoIsDone(
//     //                                                                   todo,
//     //                                                                   !todo
//     //                                                                       .isDone);
//     //                                                         },
//     //                                                         focusColor: Colors
//     //                                                             .transparent,
//     //                                                         hoverColor: Colors
//     //                                                             .transparent,
//     //                                                         splashColor: Colors
//     //                                                             .transparent,
//     //                                                         contentPadding:
//     //                                                             const EdgeInsets
//     //                                                                 .only(
//     //                                                           left: 5,
//     //                                                           right: 0,
//     //                                                         ),
//     //                                                         leading: Container(
//     //                                                           padding:
//     //                                                               EdgeInsets
//     //                                                                   .only(
//     //                                                             left: 10,
//     //                                                           ),
//     //                                                           child:
//     //                                                               CustomCheckbox(
//     //                                                             isChecked:
//     //                                                                 todo.isDone,
//     //                                                           ),
//     //                                                         ),
//     //                                                         title: Row(
//     //                                                           children: [
//     //                                                             Transform
//     //                                                                 .translate(
//     //                                                               offset: Offset(
//     //                                                                   -Get.width *
//     //                                                                       0.02,
//     //                                                                   0),
//     //                                                               child: Icon(
//     //                                                                 todo.isPinned
//     //                                                                     ? LineIcons
//     //                                                                         .thumbtack
//     //                                                                     : null,
//     //                                                                 color:
//     //                                                                     AppColors
//     //                                                                         .pin,
//     //                                                                 size:
//     //                                                                     todo.isPinned
//     //                                                                         ? 25
//     //                                                                         : 0,
//     //                                                               ),
//     //                                                             ),
//     //                                                             Expanded(
//     //                                                               child: Text(
//     //                                                                 todo.name,
//     //                                                                 style:
//     //                                                                     TextStyle(
//     //                                                                   fontFamily:
//     //                                                                       'EbiharaNoKuseji',
//     //                                                                   color: AppTheme
//     //                                                                       .colorScheme
//     //                                                                       .onPrimary,
//     //                                                                   fontWeight:
//     //                                                                       FontWeight
//     //                                                                           .bold,
//     //                                                                   decoration: todo
//     //                                                                           .isDone
//     //                                                                       ? TextDecoration
//     //                                                                           .lineThrough
//     //                                                                       : null,
//     //                                                                   decorationThickness:
//     //                                                                       2.0,
//     //                                                                 ),
//     //                                                                 overflow:
//     //                                                                     TextOverflow
//     //                                                                         .ellipsis,
//     //                                                                 maxLines: 2,
//     //                                                               ),
//     //                                                             ),
//     //                                                           ],
//     //                                                         ),
//     //                                                         trailing:
//     //                                                             CupertinoButton(
//     //                                                           child: Icon(
//     //                                                             LineIcons.pen,
//     //                                                             color: AppTheme
//     //                                                                 .colorScheme
//     //                                                                 .onPrimary,
//     //                                                           ),
//     //                                                           onPressed: () {
//     //                                                             showCupertinoModalBottomSheet(
//     //                                                               context:
//     //                                                                   context,
//     //                                                               builder: (_) {
//     //                                                                 return TodoForm(
//     //                                                                   todo:
//     //                                                                       todo,
//     //                                                                   todoController:
//     //                                                                       Get.find<
//     //                                                                           TodoController>(),
//     //                                                                   appController:
//     //                                                                       Get.find<
//     //                                                                           AppController>(),
//     //                                                                   dataStore:
//     //                                                                       Get.find<
//     //                                                                           DataStore>(),
//     //                                                                 );
//     //                                                               },
//     //                                                             );
//     //                                                           },
//     //                                                         ),
//     //                                                       ),
//     //                                                     ),
//     //                                                   ],
//     //                                                 ),
//     //                                               ),
//     //                                             ),
//     //                                             // onPointerDown:
//     //                                             //     (PointerDownEvent event) {
//     //                                             //   startOffset =
//     //                                             //       event.position;
//     //                                             // },
//     //                                             // onPointerMove:
//     //                                             //     (PointerMoveEvent move) {
//     //                                             //   double dx =
//     //                                             //       move.localPosition.dx -
//     //                                             //           startOffset!.dx;
//     //                                             //   if (dx > 15 && isRight) {
//     //                                             //     isRight = false;
//     //                                             //     isLeft = true;
//     //                                             //     HapticFeedback
//     //                                             //         .lightImpact();
//     //                                             //   } else if (dx < -15 &&
//     //                                             //       isLeft) {
//     //                                             //     isLeft = false;
//     //                                             //     isRight = true;
//     //                                             //     HapticFeedback
//     //                                             //         .lightImpact();
//     //                                             //   }
//     //                                             // },
//     //                                           );
//     //                                         },
//     //                                       ),
//     //                                     ),
//     //                                     date: _selectedDate.value,
//     //                                   ),
//     //                                 ),
//     //                         ),
//     //                       ],
//     //                     );
//     //                   },
//     //                 );
//     //               },
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //     Positioned(
//     //       bottom: 0,
//     //       left: 0,
//     //       right: 0,
//     //       child: Container(
//     //         height: kBottomNavigationBarHeight +
//     //             MediaQuery.paddingOf(context).bottom,
//     //         decoration: BoxDecoration(
//     //           border: Border.all(
//     //             color: theme.onBackground,
//     //             width: 0.5,
//     //           ),
//     //           borderRadius: const BorderRadius.all(
//     //             Radius.circular(10),
//     //           ),
//     //         ),
//     //         alignment: Alignment.topCenter,
//     //         child: Row(
//     //           mainAxisAlignment: MainAxisAlignment.center,
//     //           crossAxisAlignment: CrossAxisAlignment.center,
//     //           children: [
//     //             Container(
//     //               padding: const EdgeInsets.only(
//     //                 left: 7,
//     //               ),
//     //               width: 35,
//     //               child: BaseButton(
//     //                 // padding: EdgeInsets.zero,
//     //                 onPressed: () {
//     //                   // Get.back();
//     //                 },
//     //                 child: BaseIcon(
//     //                   Symbols.arrow_left_rounded,
//     //                   size: 35,
//     //                   color: AppTheme.colorScheme.onPrimary,
//     //                 ),
//     //               ),
//     //             ),
//     //             Expanded(
//     //               child: GestureDetector(
//     //                 behavior: HitTestBehavior.translucent,
//     //                 onHorizontalDragEnd: (details) {
//     //                   if (details.primaryVelocity == 0) return;

//     //                   if (details.primaryVelocity! > 0) {
//     //                     // _pageController.previousPage(
//     //                     //   duration: Duration(milliseconds: 300),
//     //                     //   curve: Curves.easeInOut,
//     //                     // );
//     //                   } else {
//     //                     // _pageController.nextPage(
//     //                     //   duration: Duration(milliseconds: 300),
//     //                     //   curve: Curves.easeInOut,
//     //                     // );
//     //                   }
//     //                 },
//     //                 child: Container(
//     //                   height: 45,
//     //                   width: screenWidth * 0.65,
//     //                   alignment: Alignment.center,
//     //                   child: Row(
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     mainAxisAlignment: MainAxisAlignment.center,
//     //                     crossAxisAlignment: CrossAxisAlignment.center,
//     //                     children: [
//     //                       GestureDetector(
//     //                         onLongPressStart: (details) {
//     //                           // HapticFeedback.mediumImpact();
//     //                           // _startLongPressTimer(details, 'back');
//     //                         },
//     //                         onLongPressEnd: (details) {
//     //                           // _longPressTimer?.cancel();
//     //                         },
//     //                         child: Center(
//     //                           child: BaseIcon(
//     //                             Symbols.arrow_back_ios_new_rounded,
//     //                             color: AppTheme.colorScheme.onBackground,
//     //                           ),
//     //                         ),
//     //                       ),
//     //                       Gap(10),
//     //                       GestureDetector(
//     //                         onLongPress: () {
//     //                           // HapticFeedback.mediumImpact();
//     //                           // _pageController.animateToPage(
//     //                           //   todayIndex.value,
//     //                           //   duration: Duration(milliseconds: 500),
//     //                           //   curve: Curves.ease,
//     //                           // );
//     //                         },
//     //                         child: BaseIcon(
//     //                           Symbols.calendar_month_rounded,
//     //                           size: 30,
//     //                           color: AppTheme.colorScheme.onBackground,
//     //                         ),
//     //                       ),
//     //                       Gap(10),
//     //                       GestureDetector(
//     //                         onLongPressStart: (details) {
//     //                           // HapticFeedback.mediumImpact();
//     //                           // _startLongPressTimer(details, 'forward');
//     //                         },
//     //                         onLongPressEnd: (details) {
//     //                           // _longPressTimer?.cancel();
//     //                         },
//     //                         child: Center(
//     //                           child: BaseIcon(
//     //                             Symbols.arrow_forward_ios_rounded,
//     //                             color: AppTheme.colorScheme.onBackground,
//     //                           ),
//     //                         ),
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ),
//     //             ),
//     //             const Gap(35),
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ],
//     // );
//     // return
//     // Scaffold(
//     //   resizeToAvoidBottomInset: false,
//     //   body: SafeArea(
//     //     bottom: false,
//     //     child: Stack(
//     //       children: [
//     //         Column(
//     //           children: [
//     //             Expanded(
//     //               child: PageView.builder(
//     //                 controller: _pageController,
//     //                 onPageChanged: (int i) {
//     //                   HapticFeedback.lightImpact();
//     //                   final DateTime newDate =
//     //                       _initialDate.add(Duration(days: i - _initialPage));
//     //                   _selectedDate.value = newDate;
//     //                 },
//     //                 itemBuilder: (BuildContext context, int index) {
//     //                   _currentDate.value = _initialDate
//     //                       .add(Duration(days: index - _initialPage));
//     //                   final scrollController = ScrollController();
//     //                   final DateTime date = _currentDate.value;
//     //                   final bool isToday = _appController.isSameDate(date, now);
//     //                   final bool isBeforeToday =
//     //                       date.isBefore(_appController.truncateTime(now));

//     //                   final todayDiff = _appController
//     //                       .truncateTime(now)
//     //                       .difference(_appController.truncateTime(date))
//     //                       .inDays;
//     //                   todayIndex.value = index + todayDiff;
//     //                   currentIndex.value = index;

//     //                   return Obx(
//     //                     () {
//     //                       // final List<TodoModel> todos =
//     //                       //     _dataStore.todosByDate[date] ?? [];
//     //                       final List<TodoModel> todos = [];
//     //                       return Column(
//     //                         children: [
//     //                           Container(
//     //                             alignment: Alignment.topLeft,
//     //                             padding: EdgeInsets.only(
//     //                               top: 10,
//     //                               left: 20,
//     //                               right: 20,
//     //                               bottom: 10,
//     //                             ),
//     //                             child: Row(
//     //                               crossAxisAlignment: CrossAxisAlignment.end,
//     //                               children: [
//     //                                 if (isToday)
//     //                                   Text(
//     //                                     LocaleKeys.today.tr,
//     //                                     style: AppTypography.h1,
//     //                                   ),
//     //                                 if (isToday) const Gap(10),
//     //                                 if (isBeforeToday)
//     //                                   Text(
//     //                                     DateFormat.MMMEd(
//     //                                       Get.deviceLocale?.languageCode,
//     //                                     ).format(date).toString(),
//     //                                     style: AppTypography.h1.copyWith(
//     //                                       color: AppTheme.colorScheme.onPrimary
//     //                                           .withOpacity(0.5),
//     //                                     ),
//     //                                   ),
//     //                                 if (!isBeforeToday)
//     //                                   Text(
//     //                                     DateFormat.MMMEd(
//     //                                       Get.deviceLocale?.languageCode,
//     //                                     ).format(date).toString(),
//     //                                     style: !isToday
//     //                                         ? AppTypography.h1
//     //                                         : AppTypography.h3.copyWith(
//     //                                             color: AppTheme
//     //                                                 .colorScheme.onPrimary
//     //                                                 .withOpacity(0.5),
//     //                                           ),
//     //                                   ),
//     //                                 const Spacer(),
//     //                                 if (todos.isNotEmpty)
//     //                                   Text(
//     //                                     todos.length.toString(),
//     //                                     style: AppTypography.body,
//     //                                   ),
//     //                               ],
//     //                             ),
//     //                           ),
//     //                           Expanded(
//     //                             child: todos.isEmpty
//     //                                 ? Obx(
//     //                                     () => AddRefreshIndicator(
//     //                                       widget: SingleChildScrollView(
//     //                                         physics:
//     //                                             AlwaysScrollableScrollPhysics(),
//     //                                         child: Column(
//     //                                           mainAxisSize: MainAxisSize.min,
//     //                                           children: [
//     //                                             Container(
//     //                                               height: Get.height,
//     //                                               alignment: Alignment.center,
//     //                                               width: double.infinity,
//     //                                               padding: EdgeInsets.only(
//     //                                                 bottom: Get.height * 0.2,
//     //                                               ),
//     //                                               child: Text(
//     //                                                 'Have a nice day!',
//     //                                                 style: AppTypography.body,
//     //                                               ),
//     //                                             ),
//     //                                           ],
//     //                                         ),
//     //                                       ),
//     //                                       date: _selectedDate.value,
//     //                                     ),
//     //                                   )
//     //                                 : Obx(
//     //                                     () => AddRefreshIndicator(
//     //                                       widget: Scrollbar(
//     //                                         controller: scrollController,
//     //                                         child: ListView.builder(
//     //                                           controller: scrollController,
//     //                                           physics:
//     //                                               AlwaysScrollableScrollPhysics(),
//     //                                           itemCount: todos.length,
//     //                                           itemBuilder: (context, index) {
//     //                                             final TodoModel todo =
//     //                                                 todos[index];
//     //                                             Offset? startOffset;
//     //                                             bool isRight = true;
//     //                                             bool isLeft = true;
//     //                                             return Listener(
//     //                                               child: Slidable(
//     //                                                 key: Key(todo.id),
//     //                                                 endActionPane: ActionPane(
//     //                                                   motion:
//     //                                                       const ScrollMotion(),
//     //                                                   dismissible:
//     //                                                       DismissiblePane(
//     //                                                     onDismissed: () async {
//     //                                                       controller.deleteTodo(
//     //                                                         todo,
//     //                                                         context,
//     //                                                       );
//     //                                                     },
//     //                                                   ),
//     //                                                   children: [
//     //                                                     SlidableAction(
//     //                                                       onPressed:
//     //                                                           (BuildContext
//     //                                                               buildContext) {
//     //                                                         controller
//     //                                                             .updateTodoDate(
//     //                                                           todo,
//     //                                                           todo.date.add(
//     //                                                             Duration(
//     //                                                                 days: -1),
//     //                                                           ),
//     //                                                         );
//     //                                                       },
//     //                                                       backgroundColor:
//     //                                                           AppColors.green,
//     //                                                       foregroundColor:
//     //                                                           AppTheme
//     //                                                               .colorScheme
//     //                                                               .primary,
//     //                                                       icon: LineIcons
//     //                                                           .chevronLeft,
//     //                                                     ),
//     //                                                     SlidableAction(
//     //                                                       onPressed: (BuildContext
//     //                                                           buildContext) async {
//     //                                                         controller
//     //                                                             .deleteTodo(
//     //                                                           todo,
//     //                                                           context,
//     //                                                         );
//     //                                                       },
//     //                                                       backgroundColor:
//     //                                                           AppTheme
//     //                                                               .colorScheme
//     //                                                               .secondary,
//     //                                                       foregroundColor:
//     //                                                           AppTheme
//     //                                                               .colorScheme
//     //                                                               .primary,
//     //                                                       icon: LineIcons.trash,
//     //                                                     ),
//     //                                                   ],
//     //                                                 ),
//     //                                                 startActionPane: ActionPane(
//     //                                                   motion:
//     //                                                       const ScrollMotion(),
//     //                                                   dismissible:
//     //                                                       DismissiblePane(
//     //                                                     onDismissed: () async {
//     //                                                       // _dataStore
//     //                                                       //     .removeTodosByDate(
//     //                                                       //         todo);
//     //                                                       _dataStore
//     //                                                           .removeAllTodos(
//     //                                                               todo);

//     //                                                       await Future.delayed(
//     //                                                         Duration(
//     //                                                             milliseconds:
//     //                                                                 200),
//     //                                                       );

//     //                                                       await controller
//     //                                                           .updateTodoIsPinned(
//     //                                                         todo,
//     //                                                         !todo.isPinned,
//     //                                                       );
//     //                                                     },
//     //                                                   ),
//     //                                                   children: [
//     //                                                     SlidableAction(
//     //                                                       onPressed: (BuildContext
//     //                                                           buildContext) async {
//     //                                                         await controller
//     //                                                             .updateTodoIsPinned(
//     //                                                           todo,
//     //                                                           !todo.isPinned,
//     //                                                         );
//     //                                                       },
//     //                                                       backgroundColor:
//     //                                                           AppColors.pin,
//     //                                                       foregroundColor:
//     //                                                           AppTheme
//     //                                                               .colorScheme
//     //                                                               .primary,
//     //                                                       icon: LineIcons
//     //                                                           .thumbtack,
//     //                                                     ),
//     //                                                     SlidableAction(
//     //                                                       onPressed:
//     //                                                           (BuildContext
//     //                                                               buildContext) {
//     //                                                         controller
//     //                                                             .updateTodoDate(
//     //                                                           todo,
//     //                                                           todo.date.add(
//     //                                                               Duration(
//     //                                                                   days: 1)),
//     //                                                         );
//     //                                                       },
//     //                                                       backgroundColor:
//     //                                                           AppColors.green,
//     //                                                       foregroundColor:
//     //                                                           AppTheme
//     //                                                               .colorScheme
//     //                                                               .primary,
//     //                                                       icon: LineIcons
//     //                                                           .chevronRight,
//     //                                                     ),
//     //                                                   ],
//     //                                                 ),
//     //                                                 child: Container(
//     //                                                   padding: EdgeInsets.only(
//     //                                                     left: 20,
//     //                                                     right: 20,
//     //                                                   ),
//     //                                                   child: Stack(
//     //                                                     children: [
//     //                                                       Positioned(
//     //                                                         top: 10,
//     //                                                         bottom: 10,
//     //                                                         left: 0,
//     //                                                         child: Container(
//     //                                                           width: 5,
//     //                                                           color: todo
//     //                                                               .background,
//     //                                                         ),
//     //                                                       ),
//     //                                                       Container(
//     //                                                         alignment: Alignment
//     //                                                             .center,
//     //                                                         decoration:
//     //                                                             BoxDecoration(
//     //                                                           border: Border(
//     //                                                             bottom:
//     //                                                                 BorderSide(
//     //                                                               color: AppTheme
//     //                                                                   .colorScheme
//     //                                                                   .onPrimary
//     //                                                                   .withOpacity(
//     //                                                                       0.2),
//     //                                                               width: 1,
//     //                                                             ),
//     //                                                           ),
//     //                                                         ),
//     //                                                         child: ListTile(
//     //                                                           onTap: () async {
//     //                                                             HapticFeedback
//     //                                                                 .mediumImpact();
//     //                                                             await controller
//     //                                                                 .updateTodoIsDone(
//     //                                                                     todo,
//     //                                                                     !todo
//     //                                                                         .isDone);
//     //                                                           },
//     //                                                           focusColor: Colors
//     //                                                               .transparent,
//     //                                                           hoverColor: Colors
//     //                                                               .transparent,
//     //                                                           splashColor: Colors
//     //                                                               .transparent,
//     //                                                           contentPadding:
//     //                                                               const EdgeInsets
//     //                                                                   .only(
//     //                                                             left: 5,
//     //                                                             right: 0,
//     //                                                           ),
//     //                                                           leading:
//     //                                                               Container(
//     //                                                             padding:
//     //                                                                 EdgeInsets
//     //                                                                     .only(
//     //                                                               left: 10,
//     //                                                             ),
//     //                                                             child:
//     //                                                                 CustomCheckbox(
//     //                                                               isChecked: todo
//     //                                                                   .isDone,
//     //                                                             ),
//     //                                                           ),
//     //                                                           title: Row(
//     //                                                             children: [
//     //                                                               Transform
//     //                                                                   .translate(
//     //                                                                 offset: Offset(
//     //                                                                     -Get.width *
//     //                                                                         0.02,
//     //                                                                     0),
//     //                                                                 child: Icon(
//     //                                                                   todo.isPinned
//     //                                                                       ? LineIcons
//     //                                                                           .thumbtack
//     //                                                                       : null,
//     //                                                                   color: AppColors
//     //                                                                       .pin,
//     //                                                                   size: todo
//     //                                                                           .isPinned
//     //                                                                       ? 25
//     //                                                                       : 0,
//     //                                                                 ),
//     //                                                               ),
//     //                                                               Expanded(
//     //                                                                 child: Text(
//     //                                                                   todo.name,
//     //                                                                   style:
//     //                                                                       TextStyle(
//     //                                                                     fontFamily:
//     //                                                                         'EbiharaNoKuseji',
//     //                                                                     color: AppTheme
//     //                                                                         .colorScheme
//     //                                                                         .onPrimary,
//     //                                                                     fontWeight:
//     //                                                                         FontWeight.bold,
//     //                                                                     decoration: todo.isDone
//     //                                                                         ? TextDecoration.lineThrough
//     //                                                                         : null,
//     //                                                                     decorationThickness:
//     //                                                                         2.0,
//     //                                                                   ),
//     //                                                                   overflow:
//     //                                                                       TextOverflow
//     //                                                                           .ellipsis,
//     //                                                                   maxLines:
//     //                                                                       2,
//     //                                                                 ),
//     //                                                               ),
//     //                                                             ],
//     //                                                           ),
//     //                                                           trailing:
//     //                                                               CupertinoButton(
//     //                                                             child: Icon(
//     //                                                               LineIcons.pen,
//     //                                                               color: AppTheme
//     //                                                                   .colorScheme
//     //                                                                   .onPrimary,
//     //                                                             ),
//     //                                                             onPressed: () {
//     //                                                               showCupertinoModalBottomSheet(
//     //                                                                 context:
//     //                                                                     context,
//     //                                                                 builder:
//     //                                                                     (_) {
//     //                                                                   return TodoForm(
//     //                                                                     todo:
//     //                                                                         todo,
//     //                                                                     todoController:
//     //                                                                         Get.find<TodoController>(),
//     //                                                                     appController:
//     //                                                                         Get.find<AppController>(),
//     //                                                                     dataStore:
//     //                                                                         Get.find<DataStore>(),
//     //                                                                   );
//     //                                                                 },
//     //                                                               );
//     //                                                             },
//     //                                                           ),
//     //                                                         ),
//     //                                                       ),
//     //                                                     ],
//     //                                                   ),
//     //                                                 ),
//     //                                               ),
//     //                                               // onPointerDown:
//     //                                               //     (PointerDownEvent event) {
//     //                                               //   startOffset =
//     //                                               //       event.position;
//     //                                               // },
//     //                                               // onPointerMove:
//     //                                               //     (PointerMoveEvent move) {
//     //                                               //   double dx =
//     //                                               //       move.localPosition.dx -
//     //                                               //           startOffset!.dx;
//     //                                               //   if (dx > 15 && isRight) {
//     //                                               //     isRight = false;
//     //                                               //     isLeft = true;
//     //                                               //     HapticFeedback
//     //                                               //         .lightImpact();
//     //                                               //   } else if (dx < -15 &&
//     //                                               //       isLeft) {
//     //                                               //     isLeft = false;
//     //                                               //     isRight = true;
//     //                                               //     HapticFeedback
//     //                                               //         .lightImpact();
//     //                                               //   }
//     //                                               // },
//     //                                             );
//     //                                           },
//     //                                         ),
//     //                                       ),
//     //                                       date: _selectedDate.value,
//     //                                     ),
//     //                                   ),
//     //                           ),
//     //                         ],
//     //                       );
//     //                     },
//     //                   );
//     //                 },
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //         Positioned(
//     //           bottom: 0,
//     //           left: 0,
//     //           right: 0,
//     //           child: GlassmorphicContainer(
//     //             borderRadius: 10,
//     //             blur: 6,
//     //             border: 0.5,
//     //             borderGradient: LinearGradient(
//     //               colors: [
//     //                 Colors.white.withOpacity(0.5),
//     //                 Colors.white.withOpacity(0.5),
//     //               ],
//     //             ),
//     //             height: kBottomNavigationBarHeight +
//     //                 MediaQuery.paddingOf(context).bottom,
//     //             linearGradient: LinearGradient(
//     //               colors: [
//     //                 Colors.white.withOpacity(0.1),
//     //                 Colors.white.withOpacity(0.1),
//     //               ],
//     //             ),
//     //             width: double.infinity,
//     //             child: Container(
//     //               height: kBottomNavigationBarHeight +
//     //                   MediaQuery.paddingOf(context).bottom,
//     //               decoration: BoxDecoration(
//     //                 border: Border.all(
//     //                   color: AppTheme.colorScheme.onPrimary,
//     //                   width: 0.5,
//     //                 ),
//     //                 borderRadius: const BorderRadius.all(
//     //                   Radius.circular(10),
//     //                 ),
//     //                 // color: AppTheme.colorScheme.primary,
//     //               ),
//     //               alignment: Alignment.topCenter,
//     //               child: Row(
//     //                 mainAxisAlignment: MainAxisAlignment.center,
//     //                 children: [
//     //                   Container(
//     //                     padding: const EdgeInsets.only(
//     //                       left: 7,
//     //                     ),
//     //                     width: 35,
//     //                     child: CupertinoButton(
//     //                       padding: EdgeInsets.zero,
//     //                       onPressed: () {
//     //                         Get.back();
//     //                       },
//     //                       child: Icon(
//     //                         LineIcons.angleLeft,
//     //                         size: 35,
//     //                         color: AppTheme.colorScheme.onPrimary,
//     //                       ),
//     //                     ),
//     //                   ),
//     //                   Expanded(
//     //                     child: GestureDetector(
//     //                       behavior: HitTestBehavior.translucent,
//     //                       onHorizontalDragEnd: (details) {
//     //                         if (details.primaryVelocity == 0) return;

//     //                         if (details.primaryVelocity! > 0) {
//     //                           _pageController.previousPage(
//     //                             duration: Duration(milliseconds: 300),
//     //                             curve: Curves.easeInOut,
//     //                           );
//     //                         } else {
//     //                           _pageController.nextPage(
//     //                             duration: Duration(milliseconds: 300),
//     //                             curve: Curves.easeInOut,
//     //                           );
//     //                         }
//     //                       },
//     //                       child: Container(
//     //                         height: 45,
//     //                         width: Get.width * 0.65,
//     //                         alignment: Alignment.center,
//     //                         child: Row(
//     //                           mainAxisSize: MainAxisSize.min,
//     //                           children: [
//     //                             GestureDetector(
//     //                               onLongPressStart: (details) {
//     //                                 HapticFeedback.mediumImpact();
//     //                                 _startLongPressTimer(details, 'back');
//     //                               },
//     //                               onLongPressEnd: (details) {
//     //                                 _longPressTimer?.cancel();
//     //                               },
//     //                               child: Icon(
//     //                                 LineIcons.alternateLongArrowLeft,
//     //                                 size: 35,
//     //                                 color: AppTheme.colorScheme.onPrimary
//     //                                     .withOpacity(0.5),
//     //                               ),
//     //                             ),
//     //                             Gap(10),
//     //                             GestureDetector(
//     //                               onLongPress: () {
//     //                                 HapticFeedback.mediumImpact();
//     //                                 _pageController.animateToPage(
//     //                                   todayIndex.value,
//     //                                   duration: Duration(milliseconds: 500),
//     //                                   curve: Curves.ease,
//     //                                 );
//     //                               },
//     //                               child: Icon(
//     //                                 LineIcons.calendarWithDayFocus,
//     //                                 size: 30,
//     //                                 color: AppTheme.colorScheme.onPrimary
//     //                                     .withOpacity(0.5),
//     //                               ),
//     //                             ),
//     //                             Gap(10),
//     //                             GestureDetector(
//     //                               onLongPressStart: (details) {
//     //                                 HapticFeedback.mediumImpact();
//     //                                 _startLongPressTimer(details, 'forward');
//     //                               },
//     //                               onLongPressEnd: (details) {
//     //                                 _longPressTimer?.cancel();
//     //                               },
//     //                               child: Icon(
//     //                                 LineIcons.alternateLongArrowRight,
//     //                                 size: 35,
//     //                                 color: AppTheme.colorScheme.onPrimary
//     //                                     .withOpacity(0.5),
//     //                               ),
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     ),
//     //                   ),
//     //                   const Gap(35),
//     //                 ],
//     //               ),
//     //             ),
//     //           ),
//     //         ),
//     //         Positioned(
//     //           bottom: kBottomNavigationBarHeight +
//     //               MediaQuery.paddingOf(context).bottom +
//     //               -28,
//     //           right: 7,
//     //           child: Obx(() => CustomFloatingActionButton(
//     //                 date: _selectedDate.value,
//     //               )),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }
