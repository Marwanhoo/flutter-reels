import 'package:flutter_reels/reel_model.dart';

abstract class ReelsStates {}

class ReelsInitialState extends ReelsStates {}

class ReelsLoadingState extends ReelsStates {}

class ReelsLoadedState extends ReelsStates {
  final List<ReelsModel> reels;

  ReelsLoadedState(this.reels);
}

class ReelsErrorState extends ReelsStates {
  final String message;

  ReelsErrorState(this.message);
}
