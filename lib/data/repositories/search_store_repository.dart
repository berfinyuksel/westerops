import 'dart:convert';
import '../model/search_store.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class SearchStoreRepository {
  Future<List<SearchStore>> getSearchStores();
  Future<List<SearchStore>> getSearches(String query);
}

class SampleSearchStoreRepository implements SearchStoreRepository {
  final url = "${UrlConstant.EN_URL}store/searchstore/";
  List<SearchStore> searchStores = [];

  @override
  Future<List<SearchStore>> getSearchStores() async {
    if (searchStores.isEmpty) {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(utf8
            .decode(response.bodyBytes)); //utf8.decode for turkish characters

        List<SearchStore> searchStoreLists = List<SearchStore>.from(
            jsonBody[0].map((model) => SearchStore.fromJson(model)));
        searchStores = searchStoreLists;
        return searchStoreLists;
      }
      throw NetworkError(response.statusCode.toString(), response.body);
    } else {
      return searchStores;
    }
  }

  @override
  Future<List<SearchStore>> getSearches(String query) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/searchstore/?keyword=$query"),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      List<SearchStore> searchLists = List<SearchStore>.from(
          jsonBody[0].map((model) => SearchStore.fromJson(model)));

      return searchLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

