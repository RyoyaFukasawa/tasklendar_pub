// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/extension/string_extension.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/core/utils/validator.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/components/text_field/base_text_field.dart';
import 'package:tasklendar/presentation/notifier/global_vars/custom_modal_bottom_sheet/modal_bottom_sheet_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/select_color/select_color_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/add_group/add_group_notifier.dart';
import 'package:tasklendar/presentation/pages/add_group/select_color/select_color_page.dart';
import 'package:tasklendar/presentation/state/add_group/add_group_state.dart';
import 'package:tasklendar/presentation/state/custom_modal_bottom_sheet/modal_bottom_sheet_state.dart';

// Project imports:;

class AddGroupPage extends HookConsumerWidget {
  AddGroupPage({
    required key,
    GroupEntity? group,
  })  : _key = key,
        _group = group,
        super(key: key);

  final Key _key;
  final GroupEntity? _group;

  final defaultColors = [
    AppColors.red,
    AppColors.pink,
    AppColors.blue,
    AppColors.green,
    AppColors.orange,
  ];

  Color getTextColorForBackground(Color backgroundColor) {
    // テキストカラーを選択するための閾値
    const threshold = 0.5;

    // 背景色の明るさを計算
    final brightness = backgroundColor.computeLuminance();

    // コントラスト比を計算
    final contrast = (brightness > threshold) ? Colors.black : Colors.white;

    return contrast;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // local notifier
    final AddGroupState state = ref.watch(addGroupNotifierProvider);
    final AddGroupNotifier viewModel =
        ref.read(addGroupNotifierProvider.notifier);

    // global notifier
    final ModalBottomSheetNotifier modalBottomSheetNotifier =
        ref.read(modalBottomSheetNotifierProvider.notifier);

    // consistence
    final emojiController = useTextEditingController(
      text: state.emoji,
    );
    final groupNameController = useTextEditingController(
      text: state.name,
    );
    final double screenWidth = Screen.width;
    final double screenHeight = Screen.height;
    final double keyboardHeight = Screen.keyboard;

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (_group != null) {
            viewModel.updateState(
              state.copyWith(
                name: _group!.name,
                emoji: _group!.emoji,
                color: _group!.color,
              ),
            );

            emojiController.text = _group!.emoji;
            groupNameController.text = _group!.name;
          }
        });
        return;
      },
      const [],
    );

    useEffect(
      () {
        final ModalBottomSheetState? modalState =
            modalBottomSheetNotifier.getState(
          _key,
        );

        void updateModalBottomState(value) {
          if (modalState != null) {
            modalBottomSheetNotifier.updateState(
              _key,
              modalState.copyWith(
                isSave: value,
              ),
            );
          }
        }

        if (emojiController.text.isValidEmoji() &&
            groupNameController.text.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            updateModalBottomState(true);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            updateModalBottomState(false);
          });
        }
        return null;
      },
      [
        emojiController.text,
        groupNameController.text,
      ],
    );

    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight * 0.8,
      ),
      padding: EdgeInsets.only(
        bottom: keyboardHeight,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                showCustomModalBottomSheet(
                  key: const Key('color_picker'),
                  context: context,
                  title: 'Select Color',
                  isScrollControlled: true,
                  enableSaveButton: true,
                  onSaveButtonPressed: (context, ref) {
                    final Color selectedColor =
                        ref.watch(selectColorNotifierProvider);
                    viewModel.updateColor(selectedColor);
                    context.pop(true);
                  },
                  child: (BuildContext context) {
                    return SelectColorPage(
                      initialColor: state.color,
                    );
                  },
                );
              },
              child: Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.color,
                ),
                alignment: Alignment.center,
                child: Text(
                  state.emoji,
                  style: const TextStyle(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Gap(5),
            Form(
              key: state.formKey,
              child: SizedBox(
                width: screenWidth * 0.8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              L10n.of.group_name,
                              style: AppTypography.body,
                            ),
                          ),
                          const Gap(5),
                          SizedBox(
                            child: BaseTextField(
                              controller: groupNameController,
                              hintText: L10n.of.group_name,
                              validator: (value) =>
                                  Validator.validateGroupName(value!, context),
                              onChanged: (value) {
                                viewModel.updateName(value);
                              },
                              maxLength: 20,
                              autoFocus: true,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              L10n.of.emoji,
                              style: AppTypography.body,
                            ),
                          ),
                          const Gap(5),
                          SizedBox(
                            child: BaseTextField(
                              controller: emojiController,
                              hintText: L10n.of.emoji,
                              onChanged: (value) {
                                if (value.isValidEmoji()) {
                                  viewModel.updateEmoji(value);
                                }
                                if (value.isEmpty) {
                                  viewModel.updateEmoji('');
                                }
                              },
                              maxLength: 1,
                              validator: (value) =>
                                  Validator.validateEmoji(value!, context),
                              textInputAction: TextInputAction.continueAction,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(10),
            SizedBox(
              height: 45,
              width: screenWidth * 0.8,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10,
                ),
                shrinkWrap: true,
                itemCount: defaultColors.length + 1,
                itemBuilder: (context, index) {
                  if (index == defaultColors.length) {
                    return InkWell(
                      onTap: () {
                        showCustomModalBottomSheet(
                          key: const Key('color_picker'),
                          context: context,
                          title: 'Select Color',
                          isScrollControlled: true,
                          enableSaveButton: true,
                          onSaveButtonPressed: (context, ref) {
                            final Color selectedColor =
                                ref.watch(selectColorNotifierProvider);
                            viewModel.updateColor(selectedColor);
                            context.pop(true);
                          },
                          child: (BuildContext context) {
                            return SelectColorPage(
                              initialColor: state.color,
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              Colors.purple,
                              Colors.pink,
                              Colors.red,
                              Colors.orange,
                              Colors.yellow,
                              Colors.green,
                              Colors.lightBlue,
                              Colors.blue,
                            ],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          margin: const EdgeInsets.all(7),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      viewModel.updateColor(defaultColors[index]);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: defaultColors[index],
                        ),
                        child: BaseIcon(
                          state.color == defaultColors[index]
                              ? Symbols.check_rounded
                              : null,
                          color: getTextColorForBackground(
                            defaultColors[index],
                          ),
                        )),
                  );
                },
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
