import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/views/all_users/all_users_screen.dart';
import 'package:buzztalk/views/friends_and_request/widgets/friend_list.dart';
import 'package:buzztalk/views/friends_and_request/widgets/request_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Friends_RequestPage extends StatelessWidget {
  
  Friends_RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 19, 25, 35),
          bottom: TabBar(
            dividerColor: Color.fromARGB(255, 33, 43, 61),
            unselectedLabelColor: Colors.white,
            indicatorColor: Color(0xff02B4BF),
            labelStyle: GoogleFonts.raleway(color: Color(0xff02B4BF)),
            tabs: [
              Tab(
                child: tabBarContent(icon: Icons.check, text: 'Friends',height: height),
              ),
              Tab(child: tabBarContent(icon: Icons.group, text: 'Requests',height: height)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color:Color.fromARGB(255, 19, 25, 35),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 30),
                    child: SizedBox(
                      height: height*0.050,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(163, 255, 255, 255)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          prefixStyle: TextStyle(color: Colors.grey),
                          hintText: 'Search...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  spacingHeight(height * 0.02),
                  FriendsList(),
                ],
              ),
            ),
            FriendsRequest(),
          ],
        ),
       
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FriendsSuggestions(),
        ));
      },
      shape: CircleBorder(),
      backgroundColor: Color(0xffFA7B06),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
      ),
    );
  }
}