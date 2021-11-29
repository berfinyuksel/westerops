import 'dart:convert';

import 'package:dongu_mobile/data/model/search.dart';

import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class SearchRepository {
  Future<List<Search>> getSearches(String query);
}

class SampleSearchRepository implements SearchRepository {
  final url = "${UrlConstant.EN_URL}store/searchstore/";

  @override
  Future<List<Search>> getSearches(String query) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/searchstore/?keyword=$query"),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); 

      List<Search> searchLists =
          List<Search>.from(jsonBody[0].map((model) => Search.fromJson(model)));
      
      return searchLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
