 
import 'package:btc/data_layer/data_layer.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('BtcPriceApi', () {
    late BtcPriceApi btcApi;
    late http.Client httpClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      btcApi = BtcPriceApi(httpClient: httpClient);
    });

    group('recuperarPreco |', () {
      test('should return the buy price in BRL', () async {
        const String expectedPrice = '50000';
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body)
            .thenReturn('{"BRL": {"buy": $expectedPrice}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final result = await btcApi.getPrice();
        expect(result, expectedPrice);
        verify(() =>
                httpClient.get(Uri.parse('https://blockchain.info/ticker')))
            .called(1);
      });

      test(
          'should throw a BtcPriceRequestFailure exception if the response status code is not 200',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(500);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(btcApi.getPrice(), throwsA(isA<BtcPriceRequestFailure>()));
      });

      test(
          'should throw a BtcPriceNotFoundFailure exception if the response body does not contain the BRL key',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
            btcApi.getPrice(), throwsA(isA<BtcPriceNotFoundFailure>()));
      });

      test(
          'should throw a BtcPriceNotFoundFailure exception if the buy key is empty',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"BRL": {"buy": ""}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
            btcApi.getPrice(), throwsA(isA<BtcPriceNotFoundFailure>()));
      });
    });
  });
}
