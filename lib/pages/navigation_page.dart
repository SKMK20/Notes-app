import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _page = 0;
  late PageController pageController;

  // Creating state for pageController
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  // Disposing the state for pageController
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // Function for navigation to other page
  void navigationOnTap(int page) {
    pageController.jumpToPage(page);
  }

  // Setting state to onPageChanged to change index
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // Properties of pageView
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: navigationItems,
      ),

      // Navigation icons in bottom tab bar
      bottomNavigationBar: CupertinoTabBar(
        onTap: navigationOnTap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded,
                  color: _page == 0 ? Colors.black : Colors.grey[600])),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search,
                  color: _page == 1 ? Colors.black : null)),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_text_fill,
                  color: _page == 2 ? Colors.black : null)),
          BottomNavigationBarItem(
            icon: _page == 3
                ? const CircleAvatar(
                    radius: 15.5,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://wallpapercave.com/wp/wp6409639.jpg'),
                      radius: 14,
                    ),
                  )
                : const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://wallpapercave.com/wp/wp6409639.jpg'),
                    radius: 14,
                  ),
          ),
        ],
      ),
    );
  }
}
