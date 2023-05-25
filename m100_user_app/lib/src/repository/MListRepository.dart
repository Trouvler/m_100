
import 'package:dio/dio.dart';
import 'package:m_100/src/models/mList.dart';
import 'package:xml/xml.dart';



class MListRepository {

  late var _dio;

  MListRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://openapi.forest.go.kr/",
        queryParameters: {
            'servicekey' :'GDU4h2rr1pnBExc8zdWScRCyJt1FbeD1h6yhLX5EJYy41cwCgtsBmPbzT/Ym1YxeY4goxVF1ic0ORMn27nD6oA==',

        },
      ),
    );
  }

  Future<List<Ml>>fetchMlist() async{
    var response =
        await _dio.get('/openapi/service/cultureInfoService/gdTrailInfoOpenAPI',queryParameters:{'numOfRows' : '100'});
    final document = XmlDocument.parse(response.data);
    print(document);
    final results = document.findAllElements('item');

    print("가가가가가각");
    print(results);
    if(results.isNotEmpty){
      return results.map<Ml>((elements)=>Ml.fromXml(elements)).toList();
    }else{
      return Future.value(null);
    }
  }

}