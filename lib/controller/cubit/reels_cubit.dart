import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reels/controller/cubit/reels_state.dart';
import 'package:flutter_reels/model/reel_model.dart';
import 'package:http/http.dart' as http;

class ReelsCubit extends Cubit<ReelsStates> {
  ReelsCubit() : super(ReelsInitialState());

  Future<void> fetchReels() async {
    emit(ReelsLoadingState());
    try {
      final response = await http.get(
        Uri.parse("https://api.sawalef.app/api/v1/reels"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        final List<ReelsModel> reels =
            data.map((e) => ReelsModel.fromJson(e)).toList();
        emit(ReelsLoadedState(reels));
      } else {
        emit(ReelsErrorState("Failed to load reels"));
      }
    } catch (e) {
      emit(ReelsErrorState(e.toString()));
    }
  }
}
