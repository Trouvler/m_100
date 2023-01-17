import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/image_data.dart';

import '../controller/mlist_controller.dart';

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
          Container(
              child: Divider(color: Colors.grey, thickness: 1.0)),
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
          Container(
              child: Divider(color: Colors.grey, thickness: 1.0)),
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
          Container(
              child: Divider(color: Colors.grey, thickness: 1.0)),
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
          Container(
              child: Divider(color: Colors.grey, thickness: 1.0)),
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
          Container(
              child: Divider(color: Colors.grey, thickness: 1.0)),
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
            children: [_imagePreview(), _titleSection(), _infoSection()]));
  }
}
