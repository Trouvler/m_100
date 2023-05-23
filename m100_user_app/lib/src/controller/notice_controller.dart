import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/models/notice_model.dart';

import '../repository/noticeRepository.dart';

class NoticeController extends GetxController {
  RxList<NoticeModel> notice = <NoticeModel>[].obs;

  late NoticeRepository _NoticeRepository;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _NoticeRepository = NoticeRepository();
    fetchNoticelist();
  }

  Future fetchNoticelist() async {
    var result = await _NoticeRepository.fetchNoticelist();
    notice.addAll(result);
  }

}