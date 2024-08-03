import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/chat_service.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';

class BottomSheetPage extends StatefulWidget {
  UserModel? user;
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
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
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
                                      image: AssetImage(
                                          "assets/location_png.png"))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Share you'r current location?",
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
                                )),
                            TextButton(
                                onPressed: () {
                                  // getCurrentLocation().then((value) {
                                  //   setState(() {
                                  //     locationMessage =
                                  //         'Latitude: $lat, Longitude: $long';
                                  //   });
                                  //   print('lat: ${lat}');
                                  //   print('lon: ${long}');
                                  //   ChatService().sendLocationMessage(
                                  //     '${userIcon}${lat},${long}',
                                  //     widget.user?.userId ?? '',
                                  //   );
                                  // });
                                },
                                child: Text('Share',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 33, 215, 243))))
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
              onTap: () {},
            ),
            spacingWidth(20),
            ChatSelectionCircle(
              size: size,
              icon: Iconsax.gallery,
              text: 'Images',
              onTap: () {},
            ),
            spacingWidth(20),
            ChatSelectionCircle(
              size: size,
              icon: Iconsax.video,
              text: 'Video',
              onTap: () {},
            ),
            spacingWidth(20),
          ],
        ),
      ),
    );
  }

  // try {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.video,
  //     allowMultiple: false,
  //   );
  //   if (result != null) {
  //     final file = File(result.files.single.path!);
  //     ChatService()
  //         .selectAndSendVideo(file, widget.user!.userId!);
  //   }
  // } catch (e) {
  //   print('Error picking video: $e');
  // }
  // getCurrentLocation() async {
  //   try {
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission != LocationPermission.whileInUse &&
  //           permission != LocationPermission.always) {
  //         print("permission denid");
  //         return null;
  //       }
  //     }
  //     if (permission == LocationPermission.deniedForever) {
  //       print("Location denied forever");
  //       return null;
  //     }
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     setState(() {
  //       lat = position.latitude;
  //       long = position.longitude;
  //     });
  //   } catch (e) {}
  // }
}

class ChatSelectionCircle extends StatelessWidget {
  const ChatSelectionCircle({
    super.key,
    required this.size,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Size size;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: size.height * 0.03,
            backgroundColor: Color.fromARGB(255, 41, 114, 133).withOpacity(0.4),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Color.fromARGB(255, 91, 136, 142)),
        ),
      ],
    );
  }
}
