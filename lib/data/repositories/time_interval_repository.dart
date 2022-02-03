import 'dart:convert';

import '../model/time_interval.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class TimeIntervalRepository {
  Future<List<Result>> getTimeInterval(int storeId);
}

class SampleTimeIntervalRepository implements TimeIntervalRepository {
  @override
  Future<List<Result>> getTimeInterval(int storeId) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/time_interval/?store=$storeId"),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<Result> searchStoreLists = List<Result>.from(
          jsonBody["results"].map((model) => Result.fromJson(model)));

      return searchStoreLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
