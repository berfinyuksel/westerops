import 'dart:convert';

import 'package:dongu_mobile/data/model/search_store.dart';

import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class SearchStoreRepository {
  Future<List<SearchStore>> getSearchStores();
}

class SampleSearchStoreRepository implements SearchStoreRepository {
  final url = "${UrlConstant.EN_URL}store/searchstore/";

  @override
  Future<List<SearchStore>> getSearchStores() async {
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<SearchStore> searchStoreLists = List<SearchStore>.from(
          jsonBody[0].map((model) => SearchStore.fromJson(model)));

      return searchStoreLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
