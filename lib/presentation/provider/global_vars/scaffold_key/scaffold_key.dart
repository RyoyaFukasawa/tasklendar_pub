// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scaffold_key.g.dart';

@riverpod
GlobalKey<ScaffoldState> scaffoldKey(
  ScaffoldKeyRef ref,
) {
  return GlobalKey<ScaffoldState>();
}
