import 'package:buzztalk/controller/auth_provider.dart';
import 'package:buzztalk/controller/chat_provider.dart';
import 'package:buzztalk/controller/drawer_controller.dart';
import 'package:buzztalk/controller/login_provider.dart';
import 'package:buzztalk/controller/phone_auth_provider.dart';
import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/controller/users_provider.dart';
import 'package:buzztalk/firebase_options.dart';
import 'package:buzztalk/widgets/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider(),),
        ChangeNotifierProvider(create: (context) => AuthenticationProvider(),),
        ChangeNotifierProvider(create: (context) => PhoneAuthProvider(),),
        ChangeNotifierProvider(create: (context) => ChatProvider(),),
        ChangeNotifierProvider(create: (context) => UsersProvider(),),
        ChangeNotifierProvider(create: (context) => StoryController(),),
        ChangeNotifierProvider(create: (context) => DrawerControllers(),),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
      ),
    );
  }
}