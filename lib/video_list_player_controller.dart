import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

/// A controller class that manages a list of [VideoPlayerController] objects.
///
/// This controller controls the playback of videos, including play, pause, next, and previous.
/// It also supports automatic playback when one video finishes and moves to the next in the list.
class VideoListPlayerController {
  /// A list of [VideoPlayerController] objects used to play the videos.
  final List<VideoPlayerController> controllers;

  /// The current index in the list of controllers to track which video is currently playing.
  int _currentIndex = 0;

  /// A callback that is triggered whenever the video playback state is updated.
  VoidCallback? onUpdate;

  /// Whether to automatically move to the next video when the current one finishes.
  bool? autoMode;

  /// Creates a new [VideoListPlayerController] with the given list of video controllers.
  ///
  /// The [controllers] list contains the video controllers to be managed, and the [autoMode]
  /// indicates whether to automatically play the next video when the current video finishes.
  VideoListPlayerController({required this.controllers, this.autoMode = true});

  /// Returns the current [VideoPlayerController] for the video that is currently playing.
  VideoPlayerController get currentController => controllers[_currentIndex];

  /// Starts video playback by playing the current video controller.
  ///
  /// It also adds a listener to detect when the video finishes, allowing automatic switching to the next video.
  void play() {
    _removePreviousListener();
    currentController.play();
    currentController.addListener(_videoListener);
    onUpdate?.call();
  }

  /// Pauses the current video playback.
  void pause() {
    currentController.pause();
    onUpdate?.call();
  }

  /// Plays the next video in the sequence.
  ///
  /// Pauses the current video, moves to the next one, and then starts playback.
  Future<void> next() async {
    currentController.pause();
    _removePreviousListener();
    _currentIndex = (_currentIndex + 1) % controllers.length;
    currentController.seekTo(Duration(seconds: 0));
    await Future.delayed(Duration(seconds: 1));
    play();
  }

  /// Plays the previous video in the sequence.
  ///
  /// Pauses the current video, moves to the previous one, and then starts playback.
  Future<void> previous() async {
    currentController.pause();
    _removePreviousListener();
    _currentIndex =
        (_currentIndex - 1 + controllers.length) % controllers.length;
    currentController.seekTo(Duration(milliseconds: 0));
    await Future.delayed(Duration(seconds: 1));
    play();
  }

  /// Removes the listener for video playback events to stop unnecessary updates.
  void _removePreviousListener() {
    currentController.removeListener(_videoListener);
  }

  /// A listener that detects when a video finishes playing and triggers the next video if [autoMode] is true.
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
