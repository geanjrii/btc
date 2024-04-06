import 'package:btc/data_layer/data_layer.dart';

class BtcPriceRepository {
  final BtcPriceApi _api;

  BtcPriceRepository({required BtcPriceApi api}) : _api = api;

  Stream<String> getBuyPrice() {
    return Stream.periodic(const Duration(), (_) async {
      return await _api.getPrice();
    }).asyncMap((event) => event);
  }
}
