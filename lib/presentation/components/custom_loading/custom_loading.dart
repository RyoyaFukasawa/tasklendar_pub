// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomLoading extends HookConsumerWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
