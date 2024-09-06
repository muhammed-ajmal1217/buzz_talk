import 'dart:developer';
import 'package:buzztalk/constants/app_colors.dart';
import 'package:buzztalk/constants/app_urls.dart';
import 'package:buzztalk/controller/chat_provider.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/views/chat_screen/widgets/image_full_screen.dart';
import 'package:buzztalk/views/chat_screen/widgets/pdf_view_download_widget.dart';
import 'package:buzztalk/widgets/video_player_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBubble extends StatefulWidget {
  final Size size;
  final String? audioFilePath;
  final UserModel user;

  ChatBubble({
    Key? key,
    required this.size,
    required this.user,
    this.audioFilePath,
  }) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  void initState() {
    super.initState();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.getMessages(widget.user.userId ?? '');
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      if (chatProvider.messages.isEmpty) {
        return Center(
          child: Text('No messages', style: TextStyle(color: white)),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: ListView.builder(
            controller: chatProvider.scrollController,
            itemCount: chatProvider.messages.length,
            itemBuilder: (context, index) {
              final chats = chatProvider.messages[index];
              log('${chatProvider.messages.length}');
          
              var alignment = chats.senderId == auth.currentUser!.uid
                  ? Alignment.centerRight
                  : Alignment.centerLeft;
              var bubbleColor = chats.senderId == auth.currentUser!.uid
                  ? Color.fromARGB(255, 47, 60, 68)
                  : Color.fromARGB(255, 4, 93, 108);
          
              var borderRadius = chats.senderId == auth.currentUser!.uid
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    );
              DateTime dateTime = (chats.time as Timestamp).toDate();
              String formattedTime = DateFormat('hh:mm a').format(dateTime);
          
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Align(
                  alignment: alignment,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: widget.size.height * 0.05,
                      maxWidth: widget.size.width * 0.7,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: borderRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (chats.messageType == "text")
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  chats.content!,
                                  style: GoogleFonts.raleway(
                                    color: white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                            else if (chats.messageType == "files")
                              SizedBox(
                                  height: widget.size.height * 0.35,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: GestureDetector(
                                      child: chats.content!.contains('.jpg')
                                          ? Container(
                                              width: widget.size.width,
                                              height: widget.size.height,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          chats.content!))),
                                            )
                                          : VideoWidget(
                                              videoUrl: chats.content ?? '',
                                              mediaType: VideoType.chat,
                                            ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => ImageFullDesplay(
                                            filePath: chats.content ?? '',
                                          ),
                                        ));
                                      },
                                    ),
                                  ))
                            else if (chats.messageType == "location")
                              InkWell(
                                onTap: () async {
                                  await launchUrl(Uri.parse(
                                      "${AppUrls.locationBaseUrl}${chats.content ?? ''}"));
                                  log('chat: ${chats.content}');
                                },
                                child: Container(
                                  width: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Icon(EneftyIcons.location_outline,
                                            color: lightPeakoke),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Location",
                                          style: GoogleFonts.raleway(
                                            color: lightPeakoke,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            else if (chats.messageType == 'pdf')
                              Container(
                                width: 130,
                                decoration: BoxDecoration(),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PDFWithDownload(
                                        pdfUrl: chats
                                            .content!,
                                      ),
                                    ));
                                    log('PDF${chats.content}');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          EneftyIcons.document_2_outline,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'PDF File',
                                          style: GoogleFonts.raleway(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: widget.size.width * 0.10,
                              child: Align(
                                alignment: alignment,
                                child: Text(
                                  '$formattedTime',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }
}


