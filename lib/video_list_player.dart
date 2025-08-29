import 'package:flutter/material.dart';
import 'package:video_list_player/video_list_player_controller.dart';
import 'package:video_player/video_player.dart';

/// A widget that plays a list of videos in sequence using the [video_player] package.
///
/// It provides automatic or manual playback controls. You can set the [aspectRatio]
/// for the video player. The widget uses a [VideoListPlayerController] to manage the
/// list of video controllers and video playback.
class VideoListPlayer extends StatefulWidget {
  /// The controller used to control video playback.
  ///
  /// This controller manages the video controllers, plays videos in sequence, and controls playback.
  final VideoListPlayerController controller;

  /// The aspect ratio for the video player.
  ///
  /// If not provided, the aspect ratio of the current video will be used.
  final double? aspectRatio;

  /// Creates a [VideoListPlayer] widget.
  ///
  /// The [controller] is required to control the video playback, and [aspectRatio] can be
  /// specified to override the video's default aspect ratio.
  const VideoListPlayer({
    super.key,
    required this.controller,
    this.aspectRatio,
  });

  @override
  State<VideoListPlayer> createState() => _VideoListPlayerState();
}

class _VideoListPlayerState extends State<VideoListPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Disposes all video controllers in the controller when the widget is removed.
    for (var controller in widget.controller.controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current video controller from the [VideoListPlayerController].
    final current = widget.controller.currentController;

    // Return an [AspectRatio] widget that maintains the aspect ratio of the video.
    return AspectRatio(
      aspectRatio: widget.aspectRatio ?? current.value.aspectRatio,
      // Display the current video using the [VideoPlayer] widget.
      child: VideoPlayer(current),
    );
  }
}
