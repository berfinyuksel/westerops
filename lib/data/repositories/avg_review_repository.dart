import 'package:flutter/material.dart';

import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated, created }

class AvgReviewRepository {
  Future<StatusCode> postReview(
    int mealPoint,
    int servicePoint,
    int qualityPoint,
    int orderId,
    int userId,
    int storeId,
  ) async {
    String json =
        '{"meal_point":$mealPoint,"service_point":$servicePoint,"quality_point":$qualityPoint,"order":$orderId,"user":$userId,"store":$storeId}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}store/review/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    debugPrint("avg review added status ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 201:
        return StatusCode.created;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

  Future<StatusCode> getReview() async {
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}store​/review​/"),
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    debugPrint("avg review get status ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }
}
