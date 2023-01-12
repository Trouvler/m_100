import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../models/mList.dart';


class MListRepository{
  var apiKey ="GDU4h2rr1pnBExc8zdWScRCyJt1FbeD1h6yhLX5EJYy41cwCgtsBmPbzT%2FYm1YxeY4goxVF1ic0ORMn27nD6oA%3D%3D";

  Future<List<Ml>?> loadMls() async {
    print("repo 아니 왜 제발 좀");
    String baseUrl ="http://openapi.forest.go.kr/openapi/service/cultureInfoService/gdTrailInfoOpenAPI?serviceKey=$apiKey&numOfRows=100";
    print(baseUrl);
    final response = await http.get(Uri.parse(baseUrl));
    // 정상적으로 데이터를 불러왔다면
    if (response.statusCode == 200) {
      print("repo url 접급완료");
      // 데이터 가져오기
      final body = convert.utf8.decode(response.bodyBytes);
      print("repo" + body);
      // xml => json으로 변환
      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      print("repo json 출력");
      print(json);

      // 필요한 데이터 찾기
      Map<String, dynamic> jsonResult = convert.json.decode(json);
      final jsonMl = jsonResult['response']['body']['items'];

      print("repo jsonMl 출력");
      print(jsonMl);

      print(jsonResult['response']['body']['items']['item']);
      // 필요한 데이터 그룹이 있다면
      if (jsonMl['item'] != null) {
        // map을 통해 데이터를 전달하기 위해 객체인 List로 만든다.
        List<dynamic> list = jsonMl['item'];
        print("repo list 출력");
        print(list);

        // map을 통해 Ev형태로 item을  => Ev.fromJson으로 전달
        return list.map<Ml>((item) => Ml.fromJson(item)).toList();

      }
    }
  }
}