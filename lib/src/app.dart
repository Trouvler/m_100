import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/image_data.dart';
import 'package:m_100/src/controller/bottom_nav_controller.dart';
import 'package:m_100/src/pages/active_history.dart';
import 'package:m_100/src/pages/home.dart';
import 'package:m_100/src/pages/mypage.dart';
import 'package:m_100/src/pages/search.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              const Home(),
              const Search(),
              Container(
                child: Text('Upload'),
              ),
              const ActiveHistory(),
              const Mypage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                  icon: ImageData(IconPath.homeOff),
                  activeIcon: ImageData(IconPath.homeOn),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: ImageData(IconPath.searchOff),
                  activeIcon: ImageData(IconPath.searchOn),
                  label: 'search'),
              BottomNavigationBarItem(
                  icon: ImageData(IconPath.uploadIcon), label: 'add'),
              BottomNavigationBarItem(
                  icon: ImageData(IconPath.activeOff),
                  activeIcon: ImageData(IconPath.activeOn),
                  label: 'home'),
              BottomNavigationBarItem(
                  label: 'home',
                  icon: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
