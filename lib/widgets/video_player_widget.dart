import 'package:buzztalk/constants/app_colors.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum VideoType { story, chat, videoplay }

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  final VideoType mediaType;

  const VideoWidget({
    Key? key,
    required this.videoUrl,
    required this.mediaType,
  }) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          if (widget.mediaType == VideoType.story) {
            controller.setLooping(true);
            controller.play();
          }
        });
      });
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
                : Center(child: CircularProgressIndicator()),
          ),
        ),
        if (widget.mediaType == VideoType.videoplay)
          InkWell(
            onTap: () {
              setState(() {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              });
            },
            child: controller.value.isPlaying
                ? null
                : CircleAvatar(
                    backgroundColor: white.withOpacity(0.2),
                    radius: 35,
                    child: Center(
                      child: Icon(
                        EneftyIcons.play_outline,
                        size: 50,
                        color: white,
                      ),
                    ),
                  ),
          ),
        if (widget.mediaType == VideoType.chat)
          CircleAvatar(
            backgroundColor: white.withOpacity(0.2),
            radius: 25,
            child: Center(
              child: Icon(
                EneftyIcons.play_outline,
                size: 25,
                color: white,
              ),
            ),
          ),
        if (widget.mediaType == VideoType.story && !controller.value.isPlaying)
          InkWell(
            onTap: () {
              setState(() {
                controller.play();
              });
            },
          ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
