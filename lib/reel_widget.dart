import 'package:flutter/material.dart';
import 'package:flutter_reels/reel_model.dart';
import 'package:video_player/video_player.dart';

class ReelWidget extends StatefulWidget {
  final ReelsModel reel;
  const ReelWidget({super.key, required this.reel});
  @override
  State<ReelWidget> createState() => _ReelWidgetState();
}

class _ReelWidgetState extends State<ReelWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    //    controller = VideoPlayerController.networkUrl(Uri.parse(widget.reel.videoUrl))
    controller = VideoPlayerController.network(widget.reel.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                )
              : const CircularProgressIndicator(),
          //Text(widget.reel.likesCountTranslated),
        ],
      ),
    );
  }
}



class VideoPlayerWidget extends StatefulWidget {
  //final String videoUrl;
  final ReelsModel reelsModel;

  const VideoPlayerWidget({Key? key, required this.reelsModel}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //_controller = VideoPlayerController.network(widget.videoUrl)
    _controller = VideoPlayerController.network(widget.reelsModel.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(_controller),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}












class VideoPlayerWidget2 extends StatefulWidget {
  final ReelsModel reelsModel;
  const VideoPlayerWidget2({super.key, required this.reelsModel});

  @override
  State<VideoPlayerWidget2> createState() => _VideoPlayerWidget2State();
}

class _VideoPlayerWidget2State extends State<VideoPlayerWidget2> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.reelsModel.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(() {
          setState(() {
            _currentPosition = _controller.value.position;
          });
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(_controller),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: VideoProgressIndicator(_controller, allowScrubbing: true),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                setState(() {
                  if (_isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                  _isPlaying = !_isPlaying;
                });
              },
            ),
            Expanded(
              child: Slider(
                value: _currentPosition.inSeconds.toDouble(),
                min: 0,
                max: _controller.value.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _controller.seekTo(Duration(seconds: value.toInt()));
                  });
                },
              ),
            ),
            Text(
              '${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
            ),
          ],
        ),
      ],
    )
        : const Center(child: CircularProgressIndicator());
  }
}





