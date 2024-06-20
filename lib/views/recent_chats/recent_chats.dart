import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/views/chat_screen/chat_screen.dart';
import 'package:buzztalk/views/custom_drawer/drawer.dart';
import 'package:buzztalk/views/recent_chats/widgets/floating_action_button.dart';
import 'package:buzztalk/views/recent_chats/widgets/status_list.dart';
import 'package:buzztalk/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatListPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            spacingWidth(width * 0.04),
            Text(
              'CHITCHAT',
              style: GoogleFonts.raleway(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
      endDrawer: CustomDrawer(),
      backgroundColor: Color.fromARGB(255, 19, 25, 35),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            height: height * 0.08,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: TextFormField(
                onChanged: (query) {},
                style: GoogleFonts.raleway(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 38, 47, 57),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 144, 142, 142),
                  ),
                  prefixStyle: TextStyle(color: Colors.grey),
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.raleway(
                      color: Color.fromARGB(255, 144, 142, 142), fontSize: 14),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: titlesofAuth(screenHeight: height*0.5, title: 'Relations')
                  ),
                  SizedBox(
                    height: height * 0.2,
                    child: StatusList(width: width),
                  ),
                  Container(
                    height: height * 0.85,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 24, 31, 43),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 27, top: 20, right: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              messageHeadText(
                                  height: height,
                                  height1: 0.020,
                                  color: Colors.white,
                                  text: "CHAT'S"),
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.message_2,
                                    color: Colors.grey,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
                                  },
                                  leading: CircleAvatar(),
                                  title: Text('message',style:TextStyle(color:Colors.white)),
                                  trailing: Text('msgcount',style: TextStyle(color: Colors.white),),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: NavigateToFriends(),
    );
  }
}


