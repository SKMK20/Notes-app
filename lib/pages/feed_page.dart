import 'package:flutstar/pages/notes/notes_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),

          // Profile Picture
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://wallpapercave.com/wp/wp6409639.jpg',
            ),
          ),
        ),
        title: RichText(
          text: const TextSpan(
            text: 'Welcome,',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
            children: [
              TextSpan(
                text: '\nFlutStar Name',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          // Notification Icon button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bell,
            ),
          ),
          // NotesPage Icon button
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotesPage(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.news_solid),
          ),
        ],
      ),

      // Floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple.shade200,
        elevation: 2,
        child: const Icon(CupertinoIcons.add, color: Colors.black),
      ),
    );
  }
}
