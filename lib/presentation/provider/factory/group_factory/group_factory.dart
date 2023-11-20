// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasklendar/data/factory/group_factory_impl.dart';
import 'package:tasklendar/domain/factory/group_factory.dart';

// Project imports:

part 'group_factory.g.dart';

@riverpod
GroupFactory groupFactory(
  GroupFactoryRef ref,
) {
  return GroupFactoryImpl();
}
