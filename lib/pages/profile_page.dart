import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum SampleItem { settings, editProfile, signOut }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://wallpapercave.com/wp/wp5382827.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                const Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40, right: 210),
                        child: Text(
                          'FlutStar Name',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 280),
                        child: Text(
                          '@Username',
                        ),
                      ),
                      TabBar(
                        tabs: [
                          Tab(text: 'Photos'),
                          Tab(text: 'Videos'),
                          Tab(text: 'Articles'),
                          Tab(text: 'Stats'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Center(child: Text('Posts here')),
                            Center(child: Text('Videos here')),
                            Center(child: Text('Articles here')),
                            Center(child: Text('Stats here')),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            // Profile photo of the user
            const Positioned(
              top: 180,
              left: 20,
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage('https://wallpapercave.com/wp/wp6409639.jpg'),
              ),
            ),

            Positioned(
              top: 215,
              right: 1,
              child: PopupMenuButton<SampleItem>(
                initialValue: selectedMenu,
                onSelected: (item) async {
                  switch (item) {
                    case SampleItem.signOut:
                      final shouldSignOut = await showSignOutDialog(context);
                      if (shouldSignOut) {
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) return;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/', (route) => false);
                      }
                    default: null;
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SampleItem>>[
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.settings,
                    child: Text('Settings and privacy'),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.editProfile,
                    child: Text('Edit profile'),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.signOut,
                    child: Text('Sign out'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showSignOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Center(child: Text('Sign out')),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sign out')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
