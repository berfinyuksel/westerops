import 'dart:convert';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class SearchRepository {
  Future<List<SearchStore>> getSearches(String query);
}

class SampleSearchRepository implements SearchRepository {
  final url = "${UrlConstant.EN_URL}store/searchstore/";

  @override
  Future<List<SearchStore>> getSearches(String query) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/searchstore/?keyword=$query"),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); 

      List<SearchStore> searchLists =
          List<SearchStore>.from(jsonBody[0].map((model) => SearchStore.fromJson(model)));
      
      return searchLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}