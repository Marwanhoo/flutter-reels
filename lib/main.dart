import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reels/controller/cubit/reels_cubit.dart';
import 'package:flutter_reels/view/reels_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => ReelsCubit()..fetchReels(),
          child: const ReelsView(),
        )
    );
  }
}
