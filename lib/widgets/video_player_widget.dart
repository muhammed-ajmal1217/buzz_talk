import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        setState(() {
          controller.play(); 
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: size.height,
            width: size.width,
            child: controller.value.isInitialized
                ? VideoPlayer(controller)
                : Container(),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              controller.value.isPlaying ? controller.pause() : controller.play();
            });
          },
          
        )
      ],
    );
  }
}