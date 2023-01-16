import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/controller/auth_controller.dart';
import 'package:m_100/src/models/m100_user.dart';

import '../models/musermtinfo.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<MUser> targetUser = MUser().obs;
  Rx<MUserinfo> userinfo = MUserinfo().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
    _loadUserData();
  }
  void setTargetUser(){
    var uid = Get.parameters['targetUid'];
    if(uid == null){
      targetUser(AuthController.to.user.value);
    }else{
      //상대 uid 로 조회

    }
  }
  void _loadData(){
    setTargetUser();
  }

  Future<MUserinfo?> _loadUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var data = await FirebaseFirestore.instance
        .collection('MtDoneList')
        .doc(auth.currentUser?.uid)
        .get();
    List<dynamic> mtCompleteList = data['DoneList'];
    List<dynamic> wishList = data['WishList'];
    print('tlqksdkasknckxjc');
    print(data.data());
    var result = MUserinfo.fromJson(data.data());
    print(result);
    userinfo(result);
  }

  void increase() {
    print("이거되니?");
    _loadUserData();
    print(userinfo.value.mtcomList);
    update();
  }
}