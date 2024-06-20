import 'package:buzztalk/views/recent_chats/recent_chats.dart';
import 'package:buzztalk/widgets/toggle_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            return ChatListPage();
          } else {
            return ToggleAuth();
          }
        },
      ),
    );
  }
}