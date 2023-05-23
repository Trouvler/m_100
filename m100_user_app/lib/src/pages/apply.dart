import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../components/image_data.dart';
import '../controller/mlist_controller.dart';
import '../controller/mypage_controller.dart';

class ApplyGift extends GetView<MypageController> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Widget _name() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextField(
          controller: name_controller,
          decoration: InputDecoration(
            labelText: '이름',
            hintText: '이름을 입력하세요',
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ));
  }

  Widget _phone() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextField(
          controller: phone_controller,
          decoration: InputDecoration(
            labelText: '연락처',
            hintText: '연락처를 입력하세요',
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ));
  }

  Widget _address() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextField(
          controller: address_controller,
          decoration: InputDecoration(
            labelText: '주소',
            hintText: '주소를 입력하세요',
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: ImageData(IconPath.logo, width: 270),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ImageData(
              IconPath.directMessage,
              width: 50,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 50,
            ),
            _name(),
            const SizedBox(
              height: 15,
            ),
            _phone(),
            const SizedBox(
              height: 15,
            ),
            _address(),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            if (name_controller.text == "") {
              Fluttertoast.showToast(msg: "이름을 입력해주세요.");
              return;
            }
            if (phone_controller.text == "") {
              Fluttertoast.showToast(msg: "전화번호를 입력해주세요.");
              return;
            }
            if (address_controller.text == "") {
              Fluttertoast.showToast(msg: "주소를 입력해주세요.");
              return;
            }
            Map<String, dynamic> data = {};
            data['등급'] = controller.userinfo.value.mtcomList!.length == 100
                ? "골드"
                : controller.userinfo.value.mtcomList!.length >= 50
                    ? "실버"
                    : controller.userinfo.value.mtcomList!.length >= 30
                        ? "없음"
                        : null;
            data['이름'] = name_controller.text;
            data['연락처'] = phone_controller.text;
            data['주소'] = address_controller.text;
            data['운송장번호'] = null;
            if (data['등급'] != null) {
              await _db
                  .collection('completeList')
                  .doc(controller.targetUser.value.uid)
                  .set(data);
            } else {
              Fluttertoast.showToast(msg: "신청할 수 없습니다.");
            }
          },
          child: Text("신청 하기"),
        ),
      ),
    );
  }
}
