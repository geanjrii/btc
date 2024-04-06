import 'package:btc/feature_layer/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    context.read<HomeCubit>().onValueLoaded();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(
          32,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset(
                'images/bitcoin.png',
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 30,
                  bottom: 30,
                ),
                child: BtcValue(),
              ),
              // const RefreshButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// class RefreshButton extends StatelessWidget {
//   const RefreshButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         context.read<HomeCubit>().getValor();
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.orange,
//         padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
//       ),
//       child: const Text(
//         'Atualizar',
//         style: TextStyle(
//           fontSize: 20,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

class BtcValue extends StatelessWidget {
  const BtcValue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'R\$ ${context.watch<HomeCubit>().state}',
      style: const TextStyle(
        fontSize: 35,
      ),
    );
  }
}
