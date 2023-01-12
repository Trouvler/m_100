import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/controller/auth_controller.dart';
import 'package:m_100/src/models/m100_user.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<MUser> targetUser = MUser().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
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


    //postlist load
    //user info load
  }
}