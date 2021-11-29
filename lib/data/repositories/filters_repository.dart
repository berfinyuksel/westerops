import 'dart:convert';

//import 'package:dongu_mobile/data/model/search.dart';
import 'package:dongu_mobile/data/model/search_store.dart';

import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class FiltersRepository {
  Future<List<SearchStore>> getPackagePrice(int minPrice, int maxPrice);
  Future<List<SearchStore>> getPackageDelivery(bool ca);
  Future<List<SearchStore>> getPackageCategory(String category);

}

class SampleFiltersRepository implements FiltersRepository {
  final url = "${UrlConstant.EN_URL}store/searchstore/";

  @override
  Future<List<SearchStore>> getPackagePrice(int minPrice, int maxPrice) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/searchstore/?minp=$minPrice&?maxp=$maxPrice"),
    );
    print(response.statusCode);
    print(response.request);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      // List<Store> storeLists =
      //     List<Store>.from(jsonBody.map((model) => Store.fromJson(model)));
      // return storeLists;
      //utf8.decode for turkish characters
      List<SearchStore> searchLists =
          List<SearchStore>.from(jsonBody[0].map((model) => SearchStore.fromJson(model)));
      return searchLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
 @override
  Future<List<SearchStore>> getPackageDelivery(bool ca) async {
    final response = await http.get(
      Uri.parse(
          "${UrlConstant.EN_URL}store/searchstore/?ca=$ca"),
    );
    print(response.statusCode);
    print(response.request);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      // List<Store> storeLists =
      //     List<Store>.from(jsonBody.map((model) => Store.fromJson(model)));
      // return storeLists;
      //utf8.decode for turkish characters
      List<SearchStore> searchLists =
          List<SearchStore>.from(jsonBody[0].map((model) => SearchStore.fromJson(model)));
      return searchLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
  @override
  Future<List<SearchStore>> getPackageCategory(String category) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/searchstore/?cat=$category"),
    );
    print(response.statusCode);
    print(response.request);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      // List<Store> storeLists =
      //     List<Store>.from(jsonBody.map((model) => Store.fromJson(model)));
      // return storeLists;
      //utf8.decode for turkish characters
      List<SearchStore> searchLists =
          List<SearchStore>.from(jsonBody[0].map((model) => SearchStore.fromJson(model)));
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
