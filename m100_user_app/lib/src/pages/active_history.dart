import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/post_widget.dart';
import 'package:m_100/src/controller/notice_controller.dart';
import 'package:m_100/src/pages/mt_info.dart';
import 'package:m_100/src/pages/notice.dart';

class ActiveHistory extends GetView<NoticeController> {
  const ActiveHistory({Key? key}) : super(key: key);


  Widget _postList() {
    return Obx(()=>
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.notice.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Get.to(() => Notice(), arguments: [index, controller.notice]);
                },
                title: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Text(
                    controller.notice[index].title.toString(),
                    textAlign: TextAlign.start,
                  ),
                ),
                subtitle: Text(controller.notice[index].date!.toDate().toString()),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(thickness: 1);
            },
          ),
         );
  }

  @override
  Widget build(BuildContext context) {
    print("공지사항?");
    print(controller.notice.value);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          '공지사항',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body:_postList()
      //SingleChildScrollView(
        //child: _postList(),
    );
  }
}
