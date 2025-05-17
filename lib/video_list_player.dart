import 'package:flutter/material.dart';
import 'package:video_list_player/video_list_player_controller.dart';
import 'package:video_player/video_player.dart';

class VideoListPlayer extends StatefulWidget {
  final VideoListPlayerController controller;
  double? aspectRatio;

  VideoListPlayer({
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
    for (var controller in widget.controller.controllers) {
      if (controller != null) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.controller.currentController;
    return AspectRatio(
      aspectRatio: widget.aspectRatio ?? current.value.aspectRatio,
      child: VideoPlayer(current),
    );
  }
}
