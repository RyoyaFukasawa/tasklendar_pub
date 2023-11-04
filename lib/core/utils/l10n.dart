// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class L10n {
  static AppLocalizations get of => AppLocalizations.of(useContext())!;
}
