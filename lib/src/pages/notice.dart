import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/image_data.dart';
import 'package:m_100/src/controller/notice_controller.dart';

import '../controller/mlist_controller.dart';

class Notice extends GetView<NoticeController> {
  const Notice({Key? key}) : super(key: key);

  Widget _titleSection() {
    var index = Get.arguments[0];
    var info = Get.arguments[1];
    print(info);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text("제목", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                      SizedBox(height: 5,),
                      Text("일자")
                    ],
                  ),
                  SizedBox(width: 13,),
                  Column(
                    children: [
                      Text(
                        info[index].title.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      SizedBox(height: 10,),
                      Text(info[index].date.toDate().toString()),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }


  Widget _infoSection() {
    var index = Get.arguments[0];
    var info = Get.arguments[1];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: Column(
        children: [
          Column(
            children: [
              const Text(
                "내 용",
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                info[index].description.toString(),
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
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
      body: ListView(
        children: [
          _titleSection(),
          _infoSection(),
        ],
      ),
    );
  }
}
