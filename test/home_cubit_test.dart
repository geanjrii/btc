import 'package:bloc_test/bloc_test.dart';
import 'package:btc/domain_layer/domain_layer.dart';
import 'package:btc/feature_layer/feature_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBtcPriceRepository extends Mock implements BtcPriceRepository {}

void main() {
  group('HomeCubit', () {
    late HomeCubit homeCubit;
    late BtcPriceRepository mockRepository;

    setUp(() {
      mockRepository = MockBtcPriceRepository();
      homeCubit = HomeCubit(repository: mockRepository);
    });

    tearDown(() {
      homeCubit.close();
    });

    group('onValueLoaded |', () {
      blocTest<HomeCubit, String>(
        'emits the buy price when value is loaded',
        setUp: () {
          when(() => mockRepository.getBuyPrice())
              .thenAnswer((_) => Stream.fromIterable(['50000']));
        },
        build: () => homeCubit,
        act: (cubit) => cubit.onValueLoaded(),
        expect: () => const ['50000'],
      );
    });
  });
}
