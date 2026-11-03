import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:slot10_responsive_dashboard/main.dart';

Future<void> pumpAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const ResponsiveDashboardApp());
}

void main() {
  // Overflow sẽ làm test fail → kiểm tra layout không vỡ ở nhiều kích thước.
  for (final width in [320.0, 400.0, 700.0, 1200.0]) {
    testWidgets('No overflow at width $width', (tester) async {
      await pumpAt(tester, Size(width, 800));
      expect(find.text('Dashboard'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Grid columns follow width', (tester) async {
    await pumpAt(tester, const Size(400, 800));
    expect(find.textContaining('2 columns'), findsOneWidget);

    await pumpAt(tester, const Size(1200, 800));
    expect(find.textContaining('4 columns'), findsOneWidget);
  });
}
