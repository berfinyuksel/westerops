import 'dart:convert';

import 'package:dongu_mobile/data/model/store_boxes.dart';

import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class StoreBoxesRepository {
  Future<List<StoreBoxes>> getStoreBoxess(int id);
}

class SampleStoreBoxesRepository implements StoreBoxesRepository {
  @override
  Future<List<StoreBoxes>> getStoreBoxess(int id) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/$id/store_boxes/"),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<StoreBoxes> storeBoxesLists = List<StoreBoxes>.from(
          jsonBody.map((model) => StoreBoxes.fromJson(model)));

      return storeBoxesLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
