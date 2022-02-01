import 'dart:convert';

import '../model/store_time_interval.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class StoreTimeIntervalRepository {
  Future<List<StoreTimeInterval>> getStoreTimeInterval(int storeId);
}

class SampleStoreTimeIntervalsRepository
    implements StoreTimeIntervalRepository {
  @override
  Future<List<StoreTimeInterval>> getStoreTimeInterval(int storeId) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/time_interval/"),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<StoreTimeInterval> storeTimeIntervalList =
          List<StoreTimeInterval>.from(
              jsonBody.map((model) => StoreTimeInterval.fromJson(model)));

      return storeTimeIntervalList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}