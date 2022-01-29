import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/providers/providers.dart';
import 'package:riverpod_prac/providers/states.dart';

class SecondPage extends StatelessWidget {
  static const routeName = 'SecondPage';
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (ctx, ref, child) {
          final state = ref.read(planeDetailsProvider) as Loaded;
          int length =
              state.planeDetails.data!.where((x) => x.isFav).toList().length;
          return Text(
            length.toString(),
          );
        }),
      ),
    );
  }
}
