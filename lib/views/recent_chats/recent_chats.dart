import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/views/chat_screen/chat_screen.dart';
import 'package:buzztalk/views/custom_drawer/drawer.dart';
import 'package:buzztalk/views/recent_chats/widgets/floating_action_button.dart';
import 'package:buzztalk/views/recent_chats/widgets/status_list/status_list.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      backgroundColor: Color(0xff111820),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                height: height * 0.08,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: TextFormField(
                    onChanged: (query) {},
                    style:
                        GoogleFonts.raleway(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white,)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 144, 142, 142),
                      ),
                      prefixStyle: TextStyle(color: Colors.grey),
                      hintText: 'Search...',
                      hintStyle: GoogleFonts.raleway(
                          color: Color.fromARGB(255, 144, 142, 142),
                          fontSize: 14),
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
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Stories',
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 17),
                        ),
                      ),
                      spacingHeight(5),
                      SizedBox(
                        height: height * 0.15,
                        child: StatusList(width: width),
                      ),
                      Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  messageHeadText(
                                      height: height,
                                      height1: 0.020,
                                      color: Colors.white,
                                      text: "Chat's"),
                                      
                                  Icon(
                                    Iconsax.message_2,
                                    color: Colors.grey,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                            spacingHeight(5),
                      Container(
                        height: height * 0.70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 34, 41, 59).withOpacity(0.57),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           ChatScreen(),
                                  //     ));
                                },
                                leading: CircleAvatar(),
                                title: Text('message',
                                    style:
                                        TextStyle(color: Colors.white)),
                                trailing: Text('msgcount',
                                    style:
                                        TextStyle(color: Colors.white)),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: NavigateToFriends(),
    );
  }
}
