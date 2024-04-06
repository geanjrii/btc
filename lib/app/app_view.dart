import 'package:btc/data_layer/data_layer.dart';
import 'package:btc/domain_layer/domain_layer.dart';
import 'package:btc/feature_layer/feature_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          RepositoryProvider(
              create: (_) => BtcPriceRepository(
                  api: BtcPriceApi(httpClient: http.Client()))),
          BlocProvider(
              create: (context) =>
                  HomeCubit(repository: context.read<BtcPriceRepository>())),
        ],
        child: const HomeView(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
