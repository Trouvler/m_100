import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/avatar_widget.dart';
import 'package:m_100/src/components/image_data.dart';
import 'package:m_100/src/controller/mlist_controller.dart';
import 'package:m_100/src/pages/apply.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'mt_info.dart';


Future<String> getImageUrl(String imagePath) async {
  try {
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref(imagePath);
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  } catch (e) {
    print('이미지 가져오기 오류: $e');
    throw Exception('이미지 URL을 가져오지 못했습니다.');
  }
}

// 이미지 가져오기 예시 사용
void fetchImage() async {
  String imagePath = 'moutain/가야산/image1.jpg';
  String imageUrl = await getImageUrl(imagePath);
  if (imageUrl != null) {
    // 이미지 가져오기 성공
    print('이미지 URL: $imageUrl');
    // TODO: 이미지를 표시하거나 다른 작업 수행
  } else {
    // 이미지 가져오기 실패
    print('이미지를 가져오지 못했습니다.');
  }
}

class Home extends GetView<MlistController> {
  Home({Key? key}) : super(key: key);

  Widget _imagePreview() {
    return ImageSlideshow(
      /// Width of the [ImageSlideshow].
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,

      /// Called whenever the page in the center of the viewport changes.
      onPageChanged: (value) {
        print('Page changed: $value');
      },

      /// Auto scroll interval.
      /// Do not auto scroll with null or 0.
      autoPlayInterval: 5000,

      /// Loops back to first slide.
      isLoop: true,
      children: [
        Image.network(
          'https://soichi04.com/wp-content/uploads/2022/08/remove-background-before-qa1.png',
          fit: BoxFit.cover,
        ),
        Image.network(
          'http://thumbnail.10x10.co.kr/webimage/image/basic600/149/B001497625-2.jpg?cmd=thumb&w=500&h=500&fit=true&ws=false',
          fit: BoxFit.cover,
        ),
        Image.network(
          'https://i.pinimg.com/originals/5b/71/81/5b7181665b406f117129e04203ddccc4.jpg',
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _header() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Text(
                '전체',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        )
      ],
    );
  }

  Widget _imageSelectList() {
    return Obx(() {
      var info = controller.mlist;
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: info.length,
        itemBuilder: (BuildContext context, int index) {
          String imagePath = 'mountain/${info[index].mntnm}/image1.jpg'; // Firestorage 이미지 경로 설정

          return ListTile(
            leading: FutureBuilder<String>(
              future: getImageUrl(imagePath),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // 로딩 중 표시
                } else if (snapshot.hasError) {
                  return Text('Error'); // 에러 발생 시 표시
                } else if (snapshot.hasData) {
                  return Image.network(snapshot.data!,width: 80,
                    fit: BoxFit.fitWidth,); // 이미지 표시
                } else {
                  return SizedBox.shrink(); // 데이터 없음 시 표시하지 않음
                }
              },
            ),
            title: Text(info[index].mntnm.toString()),
            subtitle: Text(info[index].mntnm.toString()),
            onTap: () {
              Get.to(() => MtInfo(), arguments: [index, controller.mlist]);
            },
          );
        },
        separatorBuilder: (context, index) {
          if (index == 0) return SizedBox.shrink();
          return const Divider();
        },
      );
    });
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(
          width: 5,
        ),
        ...List.generate(
            5,
            (index) => AvatarWidget(
                  type: AvatarType.TYPE1,
                  thumbPath:
                      'https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E',
                )),
      ]),
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
            onTap: () {
              Get.to(() => ApplyGift());
            },
            child: ImageData(
              IconPath.directMessage,
              width: 50,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _imagePreview(),
          _header(),
          _imageSelectList(),
        ],
      ),
    );
  }
}
