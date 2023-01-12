import 'package:flutter/cupertino.dart';
import 'package:m_100/src/models/mList.dart';
import 'package:m_100/src/repository/MListRepository.dart';
import 'package:flutter/material.dart';


class MListProvider extends ChangeNotifier{
  final MListRepository _mlRepository = MListRepository();

  List<Ml> _mls = [];
  List<Ml> get mls => _mls;

  loadMls() async{
    print('provider 아니 왜 안되는겨 제발 좀 되라1');
    List<Ml>? listMls = await _mlRepository.loadMls();
    print('provider 아니 왜 안되는겨 제발 좀 되라2');
    _mls = listMls!;
    print(listMls);
    print('provider 아니 왜 안되는겨 제발 좀 되라3');
    notifyListeners();
    print('provider 아니 왜 안되는겨 제발 좀 되라4');
  }
}