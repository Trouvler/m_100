import 'package:flutter/material.dart';
import 'package:m_100/src/models/mList.dart';
import 'package:m_100/src/models/mList_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MlistWidget extends StatelessWidget {
  MlistWidget({Key? key}) : super(key: key);

  late MListProvider _mListProvider;

  Widget _makeListView(List<Ml> mls) {
    return SliverFixedExtentList(
      itemExtent: 80.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 산이름
                Text(
                  mls[index].mntnm.toString(),
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                // 해발고도
                Text(
                  mls[index].subnm.toString(),
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            )
        );
      }, childCount: mls.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('아니 왜 안되는겨 제발 돼라');
    _mListProvider = Provider.of<MListProvider>(context, listen: false);
    _mListProvider.loadMls();
    print('아니 왜 안되는겨 제발 좀 되라');
    print(_mListProvider.mls);

    return Consumer<MListProvider>(
        builder: (context, provider, SliverFixedExtentList) {
      // 데이터가 있으면 _makeListView에 데이터를 전달
      print('widget pro 아니 왜 안되는겨 제발 좀 되라');
      print(provider.mls);
      if (provider.mls.isNotEmpty) {
        return _makeListView(provider.mls);
      }

      // 데이터가 없으면 CircularProgressIndicator 수행(로딩)
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
