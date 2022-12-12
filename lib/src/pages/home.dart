import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/avatar_widget.dart';
import 'package:m_100/src/components/image_data.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _mystory() {
    return Stack(
      children: [
        AvatarWidget(
            type: AvatarType.TYPE2,
            size: 70,
            thumbPath:
            'https://soichi04.com/wp-content/uploads/2022/08/remove-background-before-qa1.png'),
      ],
    );
  }

  Widget _imagePreview() {
    return Container(
      width: Get.width,
      height: Get.width * 0.5,
      color: Colors.grey,
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
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index){
          return Container(color: Colors.red,
          );
        });
  }

  Widget _postlist() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _imagePreview(),
          _header(),
          _imageSelectList(),
        ],
      ),
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        _mystory(),
        const SizedBox(
          width: 5,
        ),
        ...List.generate(
            100,
                (index) =>
                AvatarWidget(
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
          _storyBoardList(),
          _postlist(),
        ],
      ),
    );
  }
}
