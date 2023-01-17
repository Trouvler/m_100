
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

import '../models/mList.dart';

class MsearchRepository {

  late var _dio;

  MsearchRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://openapi.forest.go.kr/",
        queryParameters: {
          'servicekey' :'GDU4h2rr1pnBExc8zdWScRCyJt1FbeD1h6yhLX5EJYy41cwCgtsBmPbzT/Ym1YxeY4goxVF1ic0ORMn27nD6oA==',
          'numOfRows' : '5'

        },
      ),
    );
  }

  Future<List<Ml>>fetchSearchArlist(String? searchitem) async{
    var query = Map<String,String>();
    if(searchitem != null)query.putIfAbsent('searchArNm', () => searchitem);
    print(query);
    var response =
    await _dio.get('/openapi/service/cultureInfoService/gdTrailInfoOpenAPI',queryParameters:query);
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');
    if(results.isNotEmpty){
      return results.map<Ml>((elements)=>Ml.fromXml(elements)).toList();
    }else{
      return Future.value(null);
    }
  }

  Future<List<Ml>>fetchSearchNmlist(String? searchitem) async{
    var query = Map<String,String>();
    if(searchitem != null)query.putIfAbsent('searchMtNm', () => searchitem);
    print(query);
    var response =
    await _dio.get('/openapi/service/cultureInfoService/gdTrailInfoOpenAPI',queryParameters:query);
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');
    if(results.isNotEmpty){
      return results.map<Ml>((elements)=>Ml.fromXml(elements)).toList();
    }else{
      return Future.value(null);
    }
  }

}