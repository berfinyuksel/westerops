import 'dart:convert';

//import 'package:dongu_mobile/data/model/search.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter/material.dart';
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
      Uri.parse(
          "${UrlConstant.EN_URL}store/searchstore/?minp=$minPrice&?maxp=$maxPrice"),
    );
    debugPrint(response.statusCode.toString());
    debugPrint(response.request.toString());
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      // List<Store> storeLists =
      //     List<Store>.from(jsonBody.map((model) => Store.fromJson(model)));
      // return storeLists;
      //utf8.decode for turkish characters
      List<SearchStore> searchLists = List<SearchStore>.from(
          jsonBody[0].map((model) => SearchStore.fromJson(model)));
      return searchLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<SearchStore>> getPackageDelivery(bool ca) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/searchstore/?ca=$ca"),
    );
    debugPrint(response.statusCode.toString());
    debugPrint(response.request.toString());
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      // List<Store> storeLists =
      //     List<Store>.from(jsonBody.map((model) => Store.fromJson(model)));
      // return storeLists;
      //utf8.decode for turkish characters
      List<SearchStore> searchLists = List<SearchStore>.from(
          jsonBody[0].map((model) => SearchStore.fromJson(model)));
      return searchLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<SearchStore>> getPackageCategory(String category) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/searchstore/?cat=$category"),
    );
    print("QUERY PACKAGE ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      // List<Store> storeLists =
      //     List<Store>.from(jsonBody.map((model) => Store.fromJson(model)));
      // return storeLists;
      //utf8.decode for turkish characters
      List<SearchStore> searchLists = List<SearchStore>.from(
          jsonBody[0].map((model) => SearchStore.fromJson(model)));
      return searchLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
