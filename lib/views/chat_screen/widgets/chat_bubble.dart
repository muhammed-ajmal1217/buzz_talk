import 'dart:developer';
import 'package:buzztalk/controller/chat_provider.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          child: Text('No messages', style: TextStyle(color: Colors.white)),
        );
      } else {
        return ListView.builder(
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Align(
                alignment: alignment,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: widget.size.height * 0.05,
                    minWidth: widget.size.width * 0.2,
                    maxWidth: widget.size.width * 0.7,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: borderRadius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chats.content!,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            width: widget.size.width * 0.14,
                            child: Align(
                              alignment: alignment,
                              child: Text(
                                '$formattedTime',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white.withOpacity(0.7),
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
        );
      }
    });
  }
}
