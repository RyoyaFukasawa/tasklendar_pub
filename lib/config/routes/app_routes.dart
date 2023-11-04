part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const CALENDAR = _Paths.CALENDAR;
  static const TODO = _Paths.TODO;
}

abstract class _Paths {
  _Paths._();
  static const CALENDAR = '/calendar';
  static const TODO = '/todo';
}
