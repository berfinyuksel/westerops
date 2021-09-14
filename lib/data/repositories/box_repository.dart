import 'dart:convert';

import 'package:dongu_mobile/data/model/box.dart';

import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class BoxRepository {
  Future<List<Box>> getBoxes(int id);
}

class SampleBoxRepository implements BoxRepository {
  @override
  Future<List<Box>> getBoxes(int id) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/$id/store_boxes/"),
    );
    print(id);
    print(response.statusCode);
    print("body: ${response.body}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<Box> boxLists =
          List<Box>.from(jsonBody.map((model) => Box.fromJson(model))).toList();
      //print(boxLists[].text_name);
      return boxLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
