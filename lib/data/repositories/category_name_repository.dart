import 'dart:convert';

import '../model/category_name.dart';
import 'package:dongu_mobile/utils/network_error.dart';
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

      return categoryNames;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
