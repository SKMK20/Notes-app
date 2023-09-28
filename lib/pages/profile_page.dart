import 'package:flutstar/services/auth/bloc/auth_bloc.dart';
import 'package:flutstar/services/auth/bloc/auth_event.dart';
import 'package:flutstar/widgets/followers_following.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ProfileMenuAction { settings, editProfile, signOut }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileMenuAction? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FlutStar Name',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                        // Divider
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            thickness: 0.1,
                          ),
                        ),
                        // Following, Followers, Posts and Stars
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildStatsColumn(1222200, 'Following'),
                            buildStatsColumn(2000600, 'Followers'),
                            buildStatsColumn(30000, 'Posts'),
                            buildStatsColumn(2200000000, 'Stars'),
                          ],
                        ),
                        // Divider
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            thickness: 0.1,
                          ),
                        ),
                        const TabBar(
                          tabs: [
                            Tab(text: 'Photos'),
                            Tab(text: 'Videos'),
                            Tab(text: 'Articles'),
                          ],
                        ),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              Center(child: Text('Posts here')),
                              Center(child: Text('Videos here')),
                              Center(child: Text('Articles here')),
                            ],
                          ),
                        ),
                      ],
                    ),
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
              child: PopupMenuButton<ProfileMenuAction>(
                initialValue: selectedMenu,
                onSelected: (item) async {
                  switch (item) {
                    case ProfileMenuAction.signOut:
                      final shouldSignOut = await showSignOutDialog(context);
                      if (shouldSignOut) {
                        // await AuthService.firebase().logOut();
                        if (!mounted) return;
                        context.read<AuthBloc>().add(const AuthEventLogOut());

                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     loginRoute, (route) => false);
                      }
                    default:
                      null;
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<ProfileMenuAction>>[
                  const PopupMenuItem<ProfileMenuAction>(
                    value: ProfileMenuAction.settings,
                    child: Text('Settings and privacy'),
                  ),
                  const PopupMenuItem<ProfileMenuAction>(
                    value: ProfileMenuAction.editProfile,
                    child: Text('Edit profile'),
                  ),
                  const PopupMenuItem<ProfileMenuAction>(
                    value: ProfileMenuAction.signOut,
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
