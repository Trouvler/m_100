import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/image_data.dart';

import '../controller/mlist_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MtInfo extends GetView<MlistController> {
  const MtInfo({Key? key}) : super(key: key);

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
              Column(
                children: [
                  Text(
                    info[index].mntnm.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(info[index].subnm.toString()),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.star,
                          size: 50,
                          color: Colors.red[500],
                        ),
                        Text('41'),
                      ],
                    ),
                  ],
                ),
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

  Widget _imagePreview() {
    var index = Get.arguments[0];
    var info = Get.arguments[1];
    var mountainName = info[index].mntnm; // 산 이름

    return FutureBuilder<List<String>>(
      future: _getImageUrls(mountainName),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child:CircularProgressIndicator()); // 로딩 중 표시
        } else if (snapshot.hasError) {
          return Text('Error'); // 에러 발생 시 표시
        } else if (snapshot.hasData) {
          var mountainImages = snapshot.data!;

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
            autoPlayInterval: 0,

            /// Loops back to first slide.
            isLoop: true,
            children: mountainImages.map((imagePath) {
              return Image.network(
                imagePath,
                fit: BoxFit.cover,
              );
            }).toList(),
          );
        } else {
          return SizedBox.shrink(); // 데이터 없음 시 표시하지 않음
        }
      },
    );
  }

  Future<List<String>> _getImageUrls(String mountainName) async {
    try {
      var imageCount = 5; // 이미지 파일의 개수
      var mountainImages = List.generate(
        imageCount,
            (index) => 'mountain/$mountainName/image${index + 1}.jpg', // 이미지 경로 리스트 생성
      );

      var validImageUrls = <String>[];
      for (var imagePath in mountainImages) {
        try {
          firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(imagePath);
          String imageUrl = await ref.getDownloadURL();
          validImageUrls.add(imageUrl);
        } catch (e) {
          print('이미지 가져오기 오류: $e');
        }
      }

      return validImageUrls;
    } catch (e) {
      print('이미지 URL을 가져오지 못했습니다.: $e');
      throw Exception('이미지 URL을 가져오지 못했습니다.');
    }
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
              Text(
                "고 도",
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                info[index].mntheight.toString(),
                softWrap: true,
              ),
            ],
          ),
          Container(child: Divider(color: Colors.grey, thickness: 1.0)),
          const SizedBox(height: 5),
          Column(
            children: [
              Text(
                "소재지",
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                info[index].areanm.toString(),
                softWrap: true,
              ),
            ],
          ),
          Container(child: Divider(color: Colors.grey, thickness: 1.0)),
          const SizedBox(height: 5),
          Column(
            children: [
              Text(
                "산 소 개",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                softWrap: true,
              ),
              Text(
                info[index].overview.toString(),
                softWrap: true,
              ),
            ],
          ),
          Container(child: Divider(color: Colors.grey, thickness: 1.0)),
          const SizedBox(height: 5),
          Column(
            children: [
              Text(
                "선 정 이 유",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                softWrap: true,
              ),
              Text(
                info[index].aeatreason.toString(),
                softWrap: true,
              ),
            ],
          ),
          Container(child: Divider(color: Colors.grey, thickness: 1.0)),
          const SizedBox(height: 5),
          Column(
            children: [
              Text(
                "코스정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                softWrap: true,
              ),
              Text(
                info[index].etccourse.toString(),
                softWrap: true,
              ),
            ],
          ),
          Container(child: Divider(color: Colors.grey, thickness: 1.0)),
          const SizedBox(height: 5),
          Column(
            children: [
              Text(
                "교 통 편",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                softWrap: true,
              ),
              Text(
                info[index].transport.toString(),
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
          _imagePreview(),
          _titleSection(),
          _infoSection(),
        ],
      ),
    );
  }
}
