// Flutter imports:
import 'package:flutter/material.dart';

enum DrawerKeyType {
  calendar,
  inbox,
  someday,
  routine,
  group,
  addGroup,
  me,
  setting,
}

class DrawerKey {
  static final keys = [
    const Key('calendar'),
    const Key('inbox'),
    const Key('someday'),
    const Key('routine'),
    const Key('group'),
    const Key('addGroup'),
    const Key('me'),
    const Key('settings'),
  ];

  static Key get(DrawerKeyType type) {
    return keys[type.index];
  }

  static DrawerKeyType? getType(Key key) {
    final int index = keys.indexOf(key);
    if (index == -1) {
      return null;
    }
    return DrawerKeyType.values[index];
  }
}
