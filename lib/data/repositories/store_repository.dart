import 'dart:convert';

import 'package:dongu_mobile/data/model/storeList.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class StoreRepository {
  Future<List<StoreList>> getStores();
}

class SampleStoreRepository implements StoreRepository {
  final url = "${UrlConstant.EN_URL}store/";

  @override
  Future<List<StoreList>> getStores() async {
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<StoreList> storeLists = [];
      storeLists.add(StoreList.fromJson(jsonBody));
      return storeLists;
      /*if (jsonBody is List) {
        return jsonBody.map((e) => StoreList.fromJson(e)).toList(); bu yontem list dönmemek için fazladan generic state yaratmamak için kullanılmadı. Boyle daha optimize olur.
      }*/
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
