import 'package:buzztalk/controller/chat_provider.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatefulWidget {
  ChatBubble({
    Key? key,
    required this.service,
    required this.size,
    this.audioFilePath,
  }) : super(key: key);

  final AuthenticationService service;
  final Size size;
  final String? audioFilePath;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool isPlaying = false;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, value, child) {
      if (value.messages.isEmpty) {
        return Center(
          child: Lottie.asset(
            "assets/Animation - 1708780605424 (1).json",
            width: 230,
          ),
        );
      } else {
        return ListView.builder(
          controller: value.scrollController,
          itemCount: value.messages.length,
          itemBuilder: (context, index) {
            final chats = value.messages[index];

            var alignment =
                chats.senderId == widget.service.authentication.currentUser!.uid
                    ? Alignment.centerRight
                    : Alignment.centerLeft;
            var bubblecolor =
                chats.senderId == widget.service.authentication.currentUser!.uid
                    ? Color.fromARGB(255, 47, 60, 68)
                    : Color.fromARGB(255, 4, 93, 108);

            var borderradius =
                chats.senderId == widget.service.authentication.currentUser!.uid
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
                      color: bubblecolor,
                      borderRadius: borderradius,
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
                            width: widget.size.width * 0.13,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          )
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

  // void _openPdf(String pdfUrl, BuildContext context) async {
  //   PDFDocument doc = await PDFDocument.fromURL(pdfUrl);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PDFViewer(document: doc),
  //     ),
  //   );
  // }

  // playVoice(String audioFilePath) async {
  //   try {
  //     await widget.audioPlayer?.play(UrlSource(audioFilePath));
  //     widget.audioPlayer?.onPlayerComplete.listen((event) {
  //       setState(() {
  //         isPlaying = false;
  //       });
  //     });
  //   } catch (e) {
  //     print('Voice play error: $e');
  //   }
  // }

  // void dispose() {
  //   widget.audioPlayer!.dispose();
  //   super.dispose();
  // }
}
