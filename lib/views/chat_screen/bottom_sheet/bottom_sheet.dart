import 'dart:developer';
import 'dart:io';
import 'package:buzztalk/controller/chat_provider.dart';
import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/chat_service.dart';
import 'package:buzztalk/views/chat_screen/bottom_sheet/widgets/chat_selection_circle.dart';
import 'package:buzztalk/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class BottomSheetPage extends StatefulWidget {
  final UserModel? user;
  BottomSheetPage({super.key, this.user});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  String locationMessage = '';
  dynamic lat;
  dynamic long;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.20,
      width: size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 15, 17, 19),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Consumer<ChatProvider>(
          builder: (context, controller, child) => 
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChatSelectionCircle(
                size: size,
                icon: Iconsax.location,
                text: 'Location',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 19, 25, 35),
                        actions: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image:
                                          AssetImage("assets/location_png.png")),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Iconsax.location, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                "Share your current location?",
                                style:
                                    TextStyle(fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 33, 215, 243)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  getCurrentLocation().then((value) {
                                    setState(() {
                                      locationMessage =
                                          'Latitude: $lat, Longitude: $long';
                                    });
                                    print('lat: ${lat}');
                                    print('lon: ${long}');
                                    ChatService().sendLocationMessage(
                                      '${lat},${long}',
                                      widget.user?.userId ?? '',
                                    );
                                  });
                                },
                                child: Text(
                                  'Share',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 33, 215, 243)),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              spacingWidth(20),
              ChatSelectionCircle(
                size: size,
                icon: Iconsax.document,
                text: 'Docs',
                onTap: () {
                  controller.pickDocument(widget.user!.userId!);
                },
              ),
              spacingWidth(20),
              ChatSelectionCircle(
                size: size,
                icon: Iconsax.gallery,
                text: 'Gallery',
                onTap: () async {
                  await Provider.of<StoryController>(context, listen: false)
                      .pickMedia();
                  final file =
                      Provider.of<StoryController>(context, listen: false)
                          .selectedMedia;
                  log('${Provider.of<StoryController>(context, listen: false).selectedMedia}');
                  if (file != null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              image: file.path.endsWith('.jpg') ||
                                      file.path.endsWith('.png')
                                  ? DecorationImage(
                                      fit: BoxFit.contain,
                                      image: FileImage(file),
                                    )
                                  : null,
                            ),
                            child: file.path.endsWith('.mp4')
                                ? VideoWidget(
                                    videoUrl: file.path,mediaType: VideoType.videoplay,)
                                : null,
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 33, 243, 222)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final receiverId = widget.user?.userId ?? '';
                                    sendFiles(receiverId, context);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Share',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 33, 243, 222)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendFiles(String receiverId, BuildContext context) async {
    final pro = Provider.of<StoryController>(context, listen: false);
    if (pro.selectedMedia != null) {
      await ChatService()
          .addImageMessage(receiverId, File(pro.selectedMedia!.path));
      log('$receiverId');
    }
    pro.selectedMedia == null;
  }

Future<void> getCurrentLocation() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        print("Permission denied");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("Location denied forever");
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
  } catch (e) {
    print("Error fetching location: $e");
  }
}

}


