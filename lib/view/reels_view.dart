import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reels/controller/cubit/reels_cubit.dart';
import 'package:flutter_reels/controller/cubit/reels_state.dart';
import 'package:flutter_reels/view/widget/reel_widget.dart';

class ReelsView extends StatelessWidget {
  const ReelsView({super.key});

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
                return ReelWidget(
                  reelsModel: state.reels[index],
                );
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
