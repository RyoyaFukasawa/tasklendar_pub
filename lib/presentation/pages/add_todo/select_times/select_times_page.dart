// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/presentation/notifier/global_vars/select_times/select_times_notifier.dart';

class SelectTimesPage extends HookConsumerWidget {
  const SelectTimesPage({
    super.key,
    required this.time,
  });

  final int time;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectTimesNotifier = ref.watch(selectTimesNotifierProvider.notifier);
    final theme = AppTheme.colorScheme;

    final controller = useState(
      FixedExtentScrollController(
        initialItem: time - 1,
      ),
    );

    return Container(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      height: 250,
      child: CupertinoPicker(
        itemExtent: 32,
        scrollController: controller.value,
        onSelectedItemChanged: (int value) {
          HapticFeedback.selectionClick();
          selectTimesNotifier.updateState(value + 1);
        },
        children: [
          for (int i = 1; i < 7; i++)
            Center(
              child: Text(
                i.toString(),
                style: AppTypography.h4.copyWith(
                  fontWeight: FontWeight.w400,
                  color: theme.onBackground,
                ),
              ),
            ),
        ],
      ),
      // child: Stack(
      //   children: [
      //     Positioned.fill(
      //       child: Center(
      //         child: Transform(
      //           transform: Matrix4.translationValues(
      //             0,
      //             25,
      //             0,
      //           ),
      //           child: CustomPaint(
      //             painter: TrianglePainter(),
      //             size: const Size(20, 20),
      //           ),
      //         ),
      //       ),
      //     ),
      //     RotatedBox(
      //       quarterTurns: 3,
      //       child: ListWheelScrollView(
      //         controller: controller,
      //         physics: const FixedExtentScrollPhysics(),
      //         itemExtent: 50,
      //         onSelectedItemChanged: (int value) {
      //           HapticFeedback.selectionClick();
      //         },
      //         children: [
      //           for (int i = 0; i < 24; i++)
      //             RotatedBox(
      //               quarterTurns: 1,
      //               child: Center(
      //                 child: Text(
      //                   i.toString(),
      //                   style: const TextStyle(
      //                     fontSize: 20,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.red
      ..style = PaintingStyle.fill; // 塗りつぶしスタイル

    final double halfWidth = size.width / 2;
    final double height = size.height;

    final Path path = Path()
      ..moveTo(0, height) // 左下の角から始める
      ..lineTo(halfWidth, 0) // 上の頂点
      ..lineTo(size.width, height) // 右下の角
      ..close(); // パスを閉じる

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
