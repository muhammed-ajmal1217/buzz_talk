import 'dart:developer';
import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/controller/chat_provider.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:buzztalk/service/chat_service.dart';
import 'package:buzztalk/views/chat_screen/bottom_sheet/bottom_sheet.dart';
import 'package:buzztalk/views/chat_screen/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;

  ChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isFavorite = false;
  TextEditingController messageController = TextEditingController();
  AuthenticationService service = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => ChatProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 19, 25, 35),
          title: Row(
            children: [
              goBackArrow(context),
              spacingWidth(size.width * 0.02),
              CircleAvatar(
                backgroundImage: widget.user.profilePic != null &&
                        widget.user.profilePic!.isNotEmpty
                    ? NetworkImage(widget.user.profilePic!)
                    : AssetImage(userIcon) as ImageProvider,
              ),
              spacingWidth(size.width * 0.02),
              GestureDetector(
                onTap: () {
                  log('Pic: ${widget.user.profilePic ?? ''}');
                },
                child: Text(
                  widget.user.userName ?? '',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {},
                    child: Icon(Icons.favorite),
                  ),
                  spacingWidth(10),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 19, 25, 35),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Color.fromARGB(255, 52, 68, 80),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      child: ChatBubble(
                        size: size,
                        audioFilePath: '',
                        user: widget.user,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 5,
                      right: 5,
                      child: Container(
                        height: 130,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: TextFormField(
                                      controller: messageController,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                      decoration: InputDecoration(
                                        fillColor:
                                            Color.fromARGB(255, 19, 25, 35),
                                        filled: true,
                                        hintText: 'Message...',
                                        hintStyle: GoogleFonts.raleway(
                                            color: Colors.white, fontSize: 12),
                                        floatingLabelStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: size.height * 0.20,
                                                  width: size.width,
                                                  child: BottomSheetPage(
                                                      user: widget.user),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.attach_file,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.mic,
                                      color: Colors.white,
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 26, 34, 46),
                                    radius: size.height * 0.036,
                                  ),
                                  onTap: () async {},
                                ),
                                spacingWidth(size.width * 0.02),
                                InkWell(
                                  onTap: () => sendMessage(),
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Color(0xff02B4BF),
                                    radius: size.height * 0.036,
                                  ),
                                ),
                                spacingWidth(size.width * 0.01),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      ChatService().sendMessage(
        widget.user.userId ?? "",
        messageController.text,
      );
      messageController.clear();
    }
  }
}
