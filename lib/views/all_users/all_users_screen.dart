
import 'package:buzztalk/controller/users_provider.dart';
import 'package:buzztalk/views/all_users/widgets/users_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsSuggestions extends StatefulWidget {
  FriendsSuggestions({Key? key}) : super(key: key);

  @override
  State<FriendsSuggestions> createState() => _FriendsSuggestionsState();
}

class _FriendsSuggestionsState extends State<FriendsSuggestions> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UsersProvider>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 19, 25, 35),
        title: Text(
          'Suggestions for you',
          style: GoogleFonts.aBeeZee(color: Colors.white),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 19, 25, 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                onChanged: (value) {
                  
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixStyle: TextStyle(color: Colors.grey),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Consumer<UsersProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading && provider.usersList.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: provider.usersList.length,
                      itemBuilder: (context, index) {
                        final userDetails = provider.usersList[index];
                        return UsersContainer(provider: provider,user: userDetails,);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
