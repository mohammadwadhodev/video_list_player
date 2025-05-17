# video_list_player

A Flutter package that allows you to play a list of videos using the `video_player` package.
It supports automatic playback of videos one after another and provides manual controls for play, 
pause, next, and previous.

## ✨ Features

- Play multiple videos in sequence
- Auto mode (automatically plays the next video)
- Manual control (next, previous, play, pause)
- Customizable aspect ratio

## Platform Support

- ✅ Android
- ✅ iOS

## 🚀Getting Started

Add this to your `pubspec.yaml`:

dependencies:
  video_list_player: ^<latest_version>

Then run:
flutter pub get

🛠️ Usage
1. Create a list of VideoPlayerController instances.
2. Initialize each controller.
3. Pass the list to VideoListPlayerController.
4. Use the VideoListPlayer widget in your UI.

🧱 Constructor Parameters
VideoListPlayer

| Parameter     | Type                        | Description                         |
| ------------- | --------------------------- | ----------------------------------- |
| `controller`  | `VideoListPlayerController` | Required. Controls video playback.  |
| `aspectRatio` | `double?`                   | Optional. Default taken from video. |


VideoListPlayerController

| Parameter     | Type                          | Description                          |
| ------------- | ----------------------------- | ------------------------------------ |
| `controllers` | `List<VideoPlayerController>` | Required. List of video controllers. |
| `autoMode`    | `bool`                        | Optional. Default is `true`.         |


📌 Notes
Currently supports Android and iOS.
More features and improvements will be added in future updates.

👤 Author
Mohammad Wadho
📧 mohammadwadho5@gmail.com

📄 License
MIT © 2025

