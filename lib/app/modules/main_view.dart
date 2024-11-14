import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/modules/Post/post_view.dart';
import 'package:project_domestic_violence/app/modules/Home/home_view.dart';
import 'package:project_domestic_violence/app/modules/Phone/phone_view.dart';
import 'package:project_domestic_violence/app/modules/Profile/profile_view.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  List loadedPages = [0];

  @override
  Widget build(BuildContext context) {
    var screens = [
      HomeView(),
      PhoneView(),
      PostView(),
      ProfileView(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        child: Container(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: ColorData.colorNavBar,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorData.colorMain,
            unselectedItemColor: ColorData.colorIcon,
            onTap: (index) {
              var pages = loadedPages;
              if (!pages.contains(index)) {
                pages.add(index);
              }
              setState(() {
                _currentIndex = index;

                loadedPages = pages;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 28,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.contact_page,
                  size: 28,
                ),
                label: 'My contact',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                  size: 28,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 28,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
