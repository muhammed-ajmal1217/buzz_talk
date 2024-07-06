import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/model/story_model.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/story_service.dart';
import 'package:buzztalk/views/add_story_screen/widgets/gradient_border_paint.dart';
import 'package:buzztalk/views/add_story_screen/widgets/story_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryCircle extends StatefulWidget {
  final UserModel user;
  final StoryController pro;
  final int index;
  final BuildContext context;

  const StoryCircle({
    Key? key,
    required this.user,
    required this.pro,
    required this.index,
    required this.context,
  }) : super(key: key);

  @override
  _StoryCircleState createState() => _StoryCircleState();
}

class _StoryCircleState extends State<StoryCircle> {
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          setState(() {
            animate = true;
          });
          await Future.delayed(Duration(seconds: 2));
          List<Story> userStories = await StoryService().getStories(widget.user.userId!);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (userStories.isNotEmpty) {
                  return StoryViewPage(
                    stories: userStories,
                    currentIndex: widget.index,
                    usersWithStories: widget.pro.usersWithStories,
                  );
                } else {
                  return Scaffold(
                    appBar: AppBar(title: Text('No Stories')),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text('Add Story'),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ).then((_) {
            setState(() {
              animate = false;
            });
          });
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: GradientBorderPaint(animate: animate),
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  radius: 35,
                  backgroundImage: widget.user.profilePic != null
                      ? NetworkImage(widget.user.profilePic!)
                      : AssetImage(userIcon) as ImageProvider,
                ),
              ],
            ),
            spacingHeight(5),
            Text(widget.user.userName??'',style: GoogleFonts.montserrat(fontSize: 10,color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
