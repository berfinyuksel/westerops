import 'dart:convert';

import 'package:dongu_mobile/data/model/store.dart';

import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class StoreRepository {
  Future<List<Store>> getStores();
}

class SampleStoreRepository implements StoreRepository {
  final url = "${UrlConstant.EN_URL}store/";

  @override
  Future<List<Store>> getStores() async {
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<Store> storeLists = List<Store>.from(jsonBody.map((model) => Store.fromJson(model)));
      return storeLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
