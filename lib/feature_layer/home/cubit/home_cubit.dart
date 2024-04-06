import 'dart:async';

import 'package:btc/domain_layer/domain_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<String> {
  HomeCubit({required BtcPriceRepository repository})
      : _repository = repository,
        super('');
  final BtcPriceRepository _repository;

  late final StreamSubscription<String> _streamSubscription;

  void onValueLoaded() {
    _streamSubscription = _repository.getBuyPrice().listen((event) {
      emit(event);
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
