import 'package:flutter/material.dart';
import 'package:flutter_reels/model/reel_model.dart';
import 'package:video_player/video_player.dart';

class ReelWidget extends StatefulWidget {
  final ReelsModel reelsModel;
  const ReelWidget({super.key, required this.reelsModel});

  @override
  State<ReelWidget> createState() => _ReelWidgetState();
}

class _ReelWidgetState extends State<ReelWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  bool _showControls = false;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.reelsModel.videoUrl))
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

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _seekBack() {
    final newPosition = _currentPosition - const Duration(seconds: 1);
    _controller
        .seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void _seekForward() {
    final newPosition = _currentPosition + const Duration(seconds: 1);
    _controller.seekTo(newPosition < _controller.value.duration
        ? newPosition
        : _controller.value.duration);
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _showControls = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: _toggleControls,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: VideoPlayer(_controller),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: IconButton(
                              icon: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow),
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
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_showControls)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.replay_10,
                                color: Colors.white),
                            onPressed: _seekBack,
                          ),
                          IconButton(
                            icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white),
                            onPressed: _togglePlayPause,
                          ),
                          IconButton(
                            icon: const Icon(Icons.forward_10,
                                color: Colors.white),
                            onPressed: _seekForward,
                          ),
                        ],
                      ),
                    ),
                  ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.favorite),
                      ),
                      Container(
                        color: Colors.black,
                        child: Text("${widget.reelsModel.likesCount}",style: const TextStyle(color: Colors.white),),
                      ),
                      Container(
                        color: Colors.black,
                        child: const Text("Likes",style: TextStyle(color: Colors.white),),
                      ),
                      const SizedBox(height: 15),

                      const CircleAvatar(
                        child: Icon(Icons.comment),
                      ),
                      Container(
                        color: Colors.black,
                        child: const Text("Comment",style: TextStyle(color: Colors.white),),
                      ),
                      const SizedBox(height: 15),

                      const CircleAvatar(
                        child: Icon(Icons.share),
                      ),
                      Container(
                        color: Colors.black,
                        child: const Text("Share",style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
