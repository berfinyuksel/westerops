import 'package:dongu_mobile/data/model/store_courier_hours.dart';
import 'dart:convert';

import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class StoreCourierHoursRepository {
  Future<List<StoreCourierHours>> getCourierHours(int storeId);
  Future<List<StoreCourierHours>> updateCourierHours(
    int courierHourId,
  );
}

class SampleStoreCourierHoursRepository implements StoreCourierHoursRepository {
  Future<List<StoreCourierHours>> getCourierHours(int storeId) async {
    String json = '{"store":"$storeId"}';

    final response = await http.post(
      Uri.parse(
          "${UrlConstant.EN_URL}store/courier_time_interval/store_today_couriers/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<StoreCourierHours> storeCourierHoursList =
          List<StoreCourierHours>.from(
              jsonBody.map((model) => StoreCourierHours.fromJson(model)));

      return storeCourierHoursList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<StoreCourierHours>> updateCourierHours(int courierHourId) async {
    String json = '{"is_available":false}';
    final response = await http.patch(
        Uri.parse(
            "${UrlConstant.EN_URL}store/courier_time_interval/$courierHourId/"),
        headers: {
          'Authorization': 'JWT ${SharedPrefs.getToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<StoreCourierHours> storeCourierHoursList =
          List<StoreCourierHours>.from(
              jsonBody.map((model) => StoreCourierHours.fromJson(model)));

      return storeCourierHoursList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
