import 'package:flutter/material.dart';
import 'package:movies_app/ui/home_screen/tabs/browse_tab/browse_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/profile_screen/profile_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/search_tab/search_screen.dart';
import 'package:movies_app/utils/asset_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    SearchScreen(),
    BrowseScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: tabs[currentIndex],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.022, vertical: height * 0.002),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              currentIndex: currentIndex,
              items: [
                buildBottomNavItem(
                  index: 0,
                  imageNameSelected: AssetsManager.homeSelectedIcon,
                  imageName: AssetsManager.homeIcon,
                ),
                buildBottomNavItem(
                  index: 1,
                  imageNameSelected: AssetsManager.searchSelectedIcon,
                  imageName: AssetsManager.searchIcon,
                ),
                buildBottomNavItem(
                  index: 2,
                  imageNameSelected: AssetsManager.browseSelectedIcon,
                  imageName: AssetsManager.browseIcon,
                ),
                buildBottomNavItem(
                  index: 3,
                  imageNameSelected: AssetsManager.profileSelectedIcon,
                  imageName: AssetsManager.profileIcon,
                ),
              ]),
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavItem(
      {required String imageName,
      required int index,
      required String imageNameSelected}) {
    return BottomNavigationBarItem(
      icon: Image.asset(currentIndex == index ? imageNameSelected : imageName),
      label: '',
    );
  }
}
