import 'package:flutter/material.dart';
import 'package:video_list_player/video_list_player.dart';
import 'package:video_list_player/video_list_player_controller.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MaterialApp(
    home: MyScreen(),
  ));
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  VideoListPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final controllers = [
      VideoPlayerController.networkUrl(Uri.parse("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")),
      VideoPlayerController.networkUrl(Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
    ];

    for (var c in controllers) {
      await c.initialize();
    }

    final controller =
        VideoListPlayerController(controllers: controllers, autoMode: true);

    setState(() {
      _controller = controller;
    });

    _controller!.onUpdate = () {
      if (mounted) setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VideoListPlayer(aspectRatio: 9 / 16, controller: _controller!),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: _controller!.previous,
                  icon: const Icon(Icons.skip_previous)),
              IconButton(
                  onPressed: () {
                    _controller!.currentController.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                  },
                  icon: Icon(_controller!.currentController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow)),
              IconButton(
                  onPressed: _controller!.next,
                  icon: const Icon(Icons.skip_next)),
            ],
          )
        ],
      ),
    );
  }
}
