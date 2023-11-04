// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/data/factory/user_factory_impl.dart';
import 'package:tasklendar/domain/factory/user_factory.dart';

part 'user_factory.g.dart';

@riverpod
UserFactory userFactory(
  UserFactoryRef ref,
) {
  //
  return UserFactoryImpl();
}
