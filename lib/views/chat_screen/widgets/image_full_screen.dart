import 'package:buzztalk/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';

class ImageFullDesplay extends StatelessWidget {
  String filePath;
  ImageFullDesplay({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Center(child:filePath.contains('.jpg')? Image.network(filePath):VideoWidget(videoUrl: filePath,mediaType: VideoType.videoplay,)),
    );
  }
}