import 'dart:convert';

import '../model/category_name.dart';

import 'package:http/http.dart' as http;

abstract class CategoryNameRepository {
  Future<List<Result>> getCategories();
}

class SampleCategoryNameRepository implements CategoryNameRepository {
  @override
  Future<List<Result>> getCategories() async {
    final response = await http.get(
      Uri.parse("https://dongu.api.westerops.com/en/box/category-name/"),
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<Result> categoryNames = List<Result>.from(
          jsonBody['results'].map((model) => Result.fromJson(model)));

      //print(boxLists[].text_name);
      return categoryNames;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
