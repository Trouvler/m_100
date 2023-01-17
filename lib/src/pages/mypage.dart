import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/avatar_widget.dart';
import 'package:m_100/src/components/image_data.dart';
import 'package:m_100/src/controller/auth_controller.dart';
import 'package:m_100/src/controller/mypage_controller.dart';

import '../controller/bottom_nav_controller.dart';

class Mypage extends GetView<MypageController> {
  const Mypage({Key? key}) : super(key: key);

  Widget _statlisticOne(String title, int value) {
    print("123");
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _infomation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AvatarWidget(
                  type: AvatarType.TYPE1,
                  thumbPath: controller.targetUser.value.thumbnail!,
                  size: 80,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statlisticOne(
                          '달성',
                          controller.userinfo.value.mtcomList == null
                              ? -1
                              : controller.userinfo.value.mtcomList!.length),
                      _statlisticOne(
                          '미달성',
                          controller.userinfo.value.mtcomList == null
                              ? -1
                              : 100 -
                                  controller.userinfo.value.mtcomList!.length),
                      _statlisticOne(
                          '찜',
                          controller.userinfo.value.mtwishList == null
                              ? -1
                              : controller.userinfo.value.mtwishList!.length),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menu() {
    print("1236");
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {print('adssad');},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: const Color(0xffdedede)),
                  ),
                  child: const Text(
                    '기념품 신청',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabMenu() {
    print("1237");
    return TabBar(
        controller: controller.tabController,
        indicatorColor: Colors.black,
        indicatorWeight: 1,
        tabs: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ImageData(IconPath.gridViewOn),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ImageData(IconPath.myTagImageOff),
          )
        ]);
  }

  Widget _tabView() {
    print("123123");
    return TabBarView(
        controller: controller.tabController,
        children: [
      GridView.builder(
          shrinkWrap: true,
          itemCount: 100,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.grey,
            );
          }),
      GridView.builder(
          shrinkWrap: true,
          itemCount: 100,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.red,
            );
          }),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    print("1245513");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Obx(
          () => Text(
            controller.targetUser.value.nickname ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () {},
              child: ImageData(
                IconPath.uploadIcon,
                width: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {},
              child: ImageData(
                IconPath.menuIcon,
                width: 50,
              ),
            ),
          ),
        ],bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height*4.1), child: Column(children: [
        _infomation(),
        _menu(),
        _tabMenu(),
      ],),
      )
      ),
      body: _tabView(),
    );
  }
}
