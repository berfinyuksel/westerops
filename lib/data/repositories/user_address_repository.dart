import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/user_address.dart';
import '../shared/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:dongu_mobile/utils/network_error.dart';
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
    debugPrint("GET USER ADDRESS : ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      List<Result> rest = List<Result>.from(
          jsonBody['results'].map<Result>((model) => Result.fromJson(model)));

      return rest;
    }

    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
