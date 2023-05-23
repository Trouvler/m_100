import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../components/message_popup.dart';
import '../models/musermtinfo.dart';
import '../pages/upload.dart';
import '../repository/user_repository.dart';
import 'mypage_controller.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomhistory = [0];
  ValueNotifier<dynamic> result = ValueNotifier(null);
  List<dynamic> mtCompleteList = [];
  List<dynamic> wishList = [];
  Rx<MUserinfo> userinfo = MUserinfo().obs;

  int getMtCompleteNum(){
    return mtCompleteList.length;
  }

  int getwishListNum(){
    return wishList.length;
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomhistory.last != value) {
      bottomhistory.add(value);
    }
  }

  void changeBottomNav(int value, {bool hasGesture = true}) async {
    var page = PageName.values[value];
    switch (page) {
      case PageName.UPLOAD:
        {
          await _tagRead();
          Get.to(() => const Upload());
          break;
        }
      case PageName.HOME:
        {
          _changePage(value, hasGesture: hasGesture);
          break;
        }
      case PageName.SEARCH:
        {
          _changePage(value, hasGesture: hasGesture);
          break;
        }
      case PageName.ACTIVITY:
        {
          _changePage(value, hasGesture: hasGesture);
          break;
        }
      case PageName.MYPAGE:
        {

          _changePage(value, hasGesture: hasGesture);
          Get.find<MypageController>().increase();
          break;
        }
    }
  }

  Future<void> _tagRead() async {
    String? message = null;
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      bool isRes = false;
      result.value = tag.data;
      Get.back();
      sleep(Duration(seconds: 1));
      NfcManager.instance.stopSession();

      if (result.value != null) {
        Fluttertoast.showToast(
            msg: 'nfc인식되었음',
            gravity: ToastGravity.BOTTOM,
            fontSize: 20.0,
            toastLength: Toast.LENGTH_SHORT);
        print(result.value);
        List<String> EncodeMessage = result.value
            .toString()
            .split("payload")[1]
            .split("[")[1]
            .split(']')[0]
            .split(",");
        EncodeMessage.removeRange(0, 3);
        List<int> rawMessage = [];
        EncodeMessage.forEach((element) {
          rawMessage.add(int.parse(element));
        });
        message = utf8.decode(rawMessage);
        FirebaseAuth auth = FirebaseAuth.instance;
        await FirebaseFirestore.instance
            .collection('MtDoneList')
            .doc(auth.currentUser?.uid)
            .update({
          'DoneList': FieldValue.arrayUnion([message])
        });
      }
      Get.find<MypageController>().increase();
    });
  }

  Future<bool> willPopAction() async {
    if (bottomhistory.length == 1) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          title: '시스템',
          message: '종료하시겠습니까?',
          okCallback: () {
            exit(0);
          },
          cancelCallback: Get.back,
        ),
      );
      return true;
    } else {
      bottomhistory.removeLast();
      var index = bottomhistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }
}
