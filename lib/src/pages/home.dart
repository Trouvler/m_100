import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/avatar_widget.dart';
import 'package:m_100/src/components/image_data.dart';
import 'package:m_100/src/components/mlist_widget.dart';

import '../models/mList_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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

  Widget _storyBoardList() {
    return Row(children: [
      const SizedBox(
        width: 5,
      ),
      ...List.generate(
          5,
              (index) =>
              AvatarWidget(
                type: AvatarType.TYPE1,
                thumbPath:
                'https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E',
              )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          elevation: 1,
          title: ImageData(IconPath.logo, width: 270),
          actions: <Widget>[
            GestureDetector(
                onTap: () {},
                child: ImageData(
                  IconPath.directMessage,
                  width: 50,
                ))
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            child:
            _imagePreview(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: _header(),
          ),
        ),
        MlistWidget(),
        //
      ],
    );
  }
}


