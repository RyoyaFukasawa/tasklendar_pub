// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/presentation/components/button/base_button.dart';
import 'package:tasklendar/presentation/components/floating_action_button/custom_floating_action_button.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/components/snack_bar/custom_snack_bar.dart';
import 'package:tasklendar/presentation/notifier/global_vars/snack_bar/snack_bar_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/splash/splash_notifier.dart';
import 'package:tasklendar/presentation/pages/drawer/drawer_page.dart';
import 'package:tasklendar/presentation/provider/global_vars/scaffold_key/scaffold_key.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';
import 'package:tasklendar/presentation/state/snack_bar/snack_bar_state.dart';

class AppPage extends HookConsumerWidget {
  const AppPage({
    super.key,
    required Widget child,
    void Function(BuildContext context, WidgetRef ref)? onTitlePressed,
    List<Widget>? Function(BuildContext context, WidgetRef ref)? actions,
    bool? isSafeAreaBottom,
  })  : _child = child,
        _onTitlePressed = onTitlePressed,
        _actions = actions,
        _isSafeAreaBottom = isSafeAreaBottom ?? false;

  final Widget _child;
  final Function(BuildContext context, WidgetRef ref)? _onTitlePressed;
  final List<Widget>? Function(BuildContext context, WidgetRef ref)? _actions;
  final bool _isSafeAreaBottom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // notifier
    final SplashNotifier splashNotifier =
        ref.read(splashNotifierProvider.notifier);

    // provider
    final GlobalKey<ScaffoldState> scaffoldKey = ref.watch(scaffoldKeyProvider);

    // state
    final AppPageState state = ref.watch(appPageNotifierProvider);

    final ColorScheme theme = AppTheme.colorScheme;

    useEffect(
      () {
        splashNotifier.initialized();
        return null;
      },
      const [],
    );

    ref.listen(
      snackBarNotifierProvider,
      (prev, next) {
        if (next.isShown) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showCustomSnackBar(
            context: context,
            content: Text(
              next.message,
              style: AppTypography.h5.copyWith(
                color: theme.background,
              ),
            ),
            type: next.type,
          );
        }
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.background,
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.background,
        shadowColor: transparent,
        leadingWidth: 44,
        leading: BaseButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: const BaseIcon(
            Symbols.menu_rounded,
          ),
        ),
        title: GestureDetector(
          onTap: () {
            _onTitlePressed?.call(context, ref);
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Text(
                  state.appBarTitle,
                  style: AppTypography.h4.copyWith(
                    color: state.titleColor ?? theme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_onTitlePressed != null)
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: BaseIcon(
                    Symbols.arrow_drop_down,
                    color: theme.onBackground,
                    size: 25,
                  ),
                ),
            ],
          ),
        ),
        actions: _actions?.call(context, ref),
      ),
      drawer: DrawerPage(),
      body: SafeArea(
        bottom: _isSafeAreaBottom,
        // child: compiledChild,
        child: _child,
      ),
      floatingActionButton: CustomFloatingActionButton(),
      drawerScrimColor: theme.onBackground.withOpacity(AppOpacity.barrier),
    );
  }
}
