import 'package:bloc_test/bloc_test.dart';
import 'package:btc/feature_layer/feature_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeCubit extends MockCubit<String> implements HomeCubit {}

void main() {
  group('HomeView', () {
    late HomeCubit mockHomeCubit;

    setUp(() {
      mockHomeCubit = MockHomeCubit();
    });

    testWidgets('should display the correct BTC value',
        (WidgetTester tester) async {
      when(() => mockHomeCubit.state).thenReturn('50000');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockHomeCubit,
            child: const BtcValue(),
          ),
        ),
      );

      expect(find.text('R\$ 50000'), findsOneWidget);
    });

    testWidgets('should use the correct text style',
        (WidgetTester tester) async {
      when(() => mockHomeCubit.state).thenReturn('50000');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockHomeCubit,
            child: const BtcValue(),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontSize, 35);
    });
  });
}
