import 'package:domi_id/feature/presentation/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SliderPainter renders correctly with specified size',
      (WidgetTester tester) async {
    final testWidget = Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: 300,
        height: 100,
        child: CustomPaint(
          painter: SliderPainter(0.5, 100),
        ),
      ),
    );

    await tester.pumpWidget(
      Builder(builder: (BuildContext context) {
        ScreenUtil.init(context,
            designSize: const Size(375, 812), minTextAdapt: true);
        return testWidget;
      }),
    );

    expect(find.byType(CustomPaint), findsOneWidget);

    final RenderBox renderBox = tester.renderObject(find.byType(CustomPaint));
    expect(renderBox.size, const Size(800.0, 600.0));
  });
}
