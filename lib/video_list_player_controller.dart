import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoListPlayerController {

  final List<VideoPlayerController> controllers;
  int _currentIndex = 0;
  VoidCallback? onUpdate;
  bool? autoMode;

  VideoListPlayerController({required this.controllers, this.autoMode = true});

  VideoPlayerController get currentController => controllers[_currentIndex];

  void play() {
    _removePreviousListener();
    currentController.play();
    currentController.addListener(_videoListener);
    onUpdate?.call();
  }

  void pause() {
    currentController.pause();
    onUpdate?.call();
  }

  Future<void> next() async {
    currentController.pause();
    _removePreviousListener();
    _currentIndex = (_currentIndex + 1) % controllers.length;
    currentController.seekTo(Duration(seconds: 0));
    await Future.delayed(Duration(seconds: 1));
    play();
  }

  Future<void> previous() async {
    currentController.pause();
    _removePreviousListener();
    _currentIndex =
        (_currentIndex - 1 + controllers.length) % controllers.length;
    currentController.seekTo(Duration(milliseconds: 0));
    await Future.delayed(Duration(seconds: 1));
    play();
  }

  void _removePreviousListener() {
    currentController.removeListener(_videoListener);
  }

  void _videoListener() {
    final controller = currentController;

    final isFinished = controller.value.position >= controller.value.duration;

    if (isFinished && !controller.value.isPlaying) {
      controller.removeListener(_videoListener);
      controller.pause();
      if (autoMode!) {
        if (_currentIndex + 1 < controllers.length) {
          _currentIndex++;
          play();
        }
      }
    }
  }
}
