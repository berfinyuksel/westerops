import 'dart:convert';

import '../model/user_address.dart';
import '../shared/shared_prefs.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/url_constant.dart';

enum StatusCode { success, error }

abstract class UserAdressRepository {
  Future<List<Result>> getUserAddress();
}

class SampleUserAdressRepository implements UserAdressRepository {
  @override
  Future<List<Result>> getUserAddress() async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}user/address/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );

    if (response.statusCode == 200) {
      print(response);
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      List<Result> rest = List<Result>.from(
          jsonBody['results'].map<Result>((model) => Result.fromJson(model)));

      return rest;
    }

    print(response.statusCode);
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
