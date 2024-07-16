import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reels/cubit/reels_cubit.dart';
import 'package:flutter_reels/cubit/reels_state.dart';
import 'package:flutter_reels/reel_widget.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reels"),
      ),
      body: BlocBuilder<ReelsCubit, ReelsStates>(
        builder: (context, state) {
          if (state is ReelsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReelsLoadedState) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.reels.length,
              itemBuilder: (context, index) {
                //return VideoPlayerWidget(reelsModel: state.reels[index],);
                return VideoPlayerWidget2(reelsModel: state.reels[index],);
              },
            );

          } else if (state is ReelsErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
