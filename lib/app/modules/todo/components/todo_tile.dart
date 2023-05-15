import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/components/custom_check_box/custom_check_box.dart';
import 'package:tasklendar/app/data/models/todo_model.dart';
import 'package:tasklendar/app/modules/todo/components/todo_form.dart';
import 'package:tasklendar/app/modules/todo/controllers/todo_controller.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/styles/app_colors.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/generated/locales.g.dart';

class TodoTile extends GetView<TodoController> {
  TodoTile({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        color: AppColors.pin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(25),
            Icon(
              FontAwesomeIcons.thumbtack,
              color: AppTheme.colorScheme.primary,
            ),
            const Gap(5),
            Text(
              !todo.isPinned ? LocaleKeys.pin.tr : LocaleKeys.unpin.tr,
              style: AppTypography.dismissibleText,
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: AppColors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              LocaleKeys.delete.tr,
              style: AppTypography.dismissibleText,
            ),
            const Gap(5),
            Icon(
              FontAwesomeIcons.trashCan,
              color: AppTheme.colorScheme.primary,
            ),
            const Gap(25),
          ],
        ),
      ),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          controller.toggleIsPinned(todo.id, todo.isPinned);
        }
        if (direction == DismissDirection.endToStart) {
          controller.deleteTodo(todo.id);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.colorScheme.tertiary,
            ),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(
            left: 5,
            right: 0,
          ),
          onTap: () {
            controller.toggleIsDone(todo.id, todo.isDone);
          },
          leading: CustomCheckbox(
            size: 33,
            isChecked: todo.isDone,
            borderWidth: 3,
            borderColor: AppTheme.colorScheme.tertiary,
            iconColor: AppTheme.colorScheme.secondary,
            icon: FontAwesomeIcons.check,
          ),
          title: Row(
            children: [
              Transform.translate(
                offset: Offset(-Get.width * 0.02, 0),
                child: Transform.rotate(
                  angle: -(3.14 / 8),
                  child: Icon(
                    todo.isPinned ? FontAwesomeIcons.thumbtack : null,
                    color: AppColors.pin,
                    size: todo.isPinned ? 18 : 0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  todo.title,
                  style: todo.isDone
                      ? AppTypography.todo(
                          lineThrough: true,
                          fontWeight: false,
                        )
                      : AppTypography.todo(
                          lineThrough: false,
                          fontWeight: true,
                        ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => TodoForm(
                  todo: todo,
                  appController: Get.find<AppController>(),
                  calendarComponentController:
                      Get.find<CalendarComponentController>(),
                  dataStore: Get.find<DataStore>(),
                ),
              );
            },
            icon: Icon(
              FontAwesomeIcons.pencil,
              size: 23,
              color: AppTheme.colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
