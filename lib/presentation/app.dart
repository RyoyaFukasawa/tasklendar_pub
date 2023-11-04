// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/presentation/navigation/page_navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate: PageNavigation.goRouter.routerDelegate,
      routeInformationParser: PageNavigation.goRouter.routeInformationParser,
      routeInformationProvider:
          PageNavigation.goRouter.routeInformationProvider,
      title: "Tasklendar",
      theme: AppTheme.light,
    );
  }
}
