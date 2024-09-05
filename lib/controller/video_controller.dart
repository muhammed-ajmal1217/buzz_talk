// import 'package:buzztalk/widgets/video_player_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoController with ChangeNotifier {
//   late VideoPlayerController controller;
//   bool isInitialized = false;

//   void initializeController(String videoUrl, VideoType mediaType) {
//     controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
//       ..initialize().then((_) {
//         isInitialized = true;
//         notifyListeners();
//         if (mediaType == VideoType.story) {
//           controller.setLooping(true);
//           controller.play();
//         }
//       });
//   }

//   void playVideo() {
//     controller.play();
//     notifyListeners();
//   }

//   void pauseVideo() {
//     controller.pause();
//     notifyListeners();
//   }

//   void disposeController() {
//     controller.dispose();
//   }
// }
