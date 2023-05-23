import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/image_data.dart';
import 'package:m_100/src/controller/search_mlist.dart';

import 'mt_info.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  String? title;
  late String inText;
  late TabController tabController;

  Widget _tabMenueOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        height: AppBar().preferredSize.height,
        width: Size.infinite.width,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffe4e4e4),
            ),
          ),
        ),
        child: TabBar(
            controller: tabController,
            indicatorColor: Colors.black,
            tabs: [
              _tabMenueOne('이름'),
              _tabMenueOne('지역'),
            ]),
      ),
    );
  }

  Widget _body(text) {
    return TabBarView(
      controller: tabController,
      children: [
        _searchList(text),
        Center(
          child: Text('인기페이지'),
        ),
      ],
    );
  }

  Widget _searchList(text) {
    //Get.find<SearchMlistController>().msearchArlist(text);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: TabBarView(
        controller: tabController,
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: Get.find<SearchMlistController>().msearchNmlist.value.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.map),
                title: Text(Get.find<SearchMlistController>().msearchNmlist.value[index].mntnm.toString()),
                subtitle: Text(" "),
                onTap: () {
                  Get.to(() => const MtInfo(), arguments: [index,Get.find<SearchMlistController>().msearchNmlist.value]);
                },
              );
            },
            separatorBuilder: (context, index) {
              if (index == 0) return SizedBox.shrink();
              return const Divider();
            },
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount:
                Get.find<SearchMlistController>().msearchArlist.value.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.map),
                title: Text(Get.find<SearchMlistController>().msearchArlist.value[index].mntnm.toString()),
                subtitle: Text(" "),
                onTap: () {
                  Get.to(() => const MtInfo(), arguments: [index,Get.find<SearchMlistController>().msearchArlist.value]);
                },
              );
            },
            separatorBuilder: (context, index) {
              if (index == 0) return SizedBox.shrink();
              return const Divider();
            },
          ),
        ],
      ),
    );
  }

  // Future loadData(String text) async => Obx((){
  //     var result = seachController.fetchSearchlist(text);
  //     //return result;
  //  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: Get.back,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconPath.backBtnIcon),
            )),
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffefefef),
          ),
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (text) {
              //loadData(text)
              setState(() {
                title = text;
                //Get.find<SearchMlistController>().initList();
                Get.find<SearchMlistController>().fetchSearchMnlist(text);
                Get.find<SearchMlistController>().fetchSearchArlist(text);
                Get.find<SearchMlistController>().update();


              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '검색',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true,
            ),
          ),
        ),
        bottom: _tabMenu(),
      ),
      body: _searchList(title),
    );
  }
}
