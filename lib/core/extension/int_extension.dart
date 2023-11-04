// Project imports:
import 'package:tasklendar/core/utils/l10n.dart';

extension IntExtension on int {
  String toDayOfWeekStr(int weekday) {
    switch (weekday % 7) {
      case 0:
        return L10n.of.day_of_week_sun;
      case 1:
        return L10n.of.day_of_week_mon;
      case 2:
        return L10n.of.day_of_week_tue;
      case 3:
        return L10n.of.day_of_week_wed;
      case 4:
        return L10n.of.day_of_week_thu;
      case 5:
        return L10n.of.day_of_week_fri;
      case 6:
        return L10n.of.day_of_week_sat;
      default:
        return '';
    }
  }

  String toHexColorStr() {
    String hex = this.toRadixString(16).substring(2);
    if (hex.length == 6) {
      return '#$hex';
    } else {
      return '#${'0' * (6 - hex.length)}$hex';
    }
  }
}
