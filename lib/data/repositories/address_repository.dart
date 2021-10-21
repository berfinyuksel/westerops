import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants/url_constant.dart';
import '../model/address.dart';
import '../shared/shared_prefs.dart';

enum StatusCode { success, error }

abstract class AdressRepository {
  Future<List<AddressValues>> updateAddress(
    String name,
    int type,
    String address,
    String description,
    String country,
    String city,
    String province,
    String phoneNumber,
    String tcknVkn,
    double latitude,
    double longitude,
  );
  Future<List<AddressValues>> addAddress(
    String name,
    int type,
    String address,
    String description,
    String country,
    String city,
    String province,
    String phoneNumber,
    String tcknVkn,
    double latitude,
    double longitude,
  );
  Future<List<AddressValues>> getAddress(int id);
  Future<List<AddressValues>> getActiveAddress();
  Future<List<AddressValues>> changeActiveAddress(int activeAdressId);

  Future<List<AddressValues>> deleteAddress();
}

class SampleAdressRepository implements AdressRepository {
  @override
  Future<List<AddressValues>> addAddress(
    String name,
    int type,
    String address,
    String description,
    String country,
    String city,
    String province,
    String phoneNumber,
    String tcknVkn,
    double latitude,
    double longitude,
  ) async {
    //  List<String> group = [];

    String json =
        '{"name":"$name","type":"$type","address": "$address","description": "$description","country": "$country","city": "$city","province":"$province","phone_number":"$phoneNumber","tckn_vkn":"$tcknVkn","latitude":"$latitude","longitude":"$longitude"}';
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}user/address/"),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );

    if (response.statusCode == 200) {
      SharedPrefs.setAddressName(name);
      SharedPrefs.setAddressType(type);
      SharedPrefs.setAddress(address);
      SharedPrefs.setAddressDescription(description);
      SharedPrefs.setAddressCountry(country);
      SharedPrefs.setAddressCity(city);
      SharedPrefs.setAddressProvince(province);
      SharedPrefs.setAddressPhoneNumber(phoneNumber);
      SharedPrefs.setAddressTcknVkn(tcknVkn);
      SharedPrefs.setAddressLatitude(latitude);
      SharedPrefs.setAddressLongitude(longitude);
    }

    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<AddressValues>> updateAddress(
    String name,
    int type,
    String address,
    String description,
    String country,
    String city,
    String province,
    String phoneNumber,
    String tcknVkn,
    double latitude,
    double longitude,
  ) async {
    //  List<String> group = [];

    String json =
        '{"name":"$name","type":"$type","address": "$address","description": "$description","country": "$country","city": "$city","province":"$province","phone_number":"$phoneNumber","tckn_vkn":"$tcknVkn","latitude":"$latitude","longitude":"$longitude"}';
    final response = await http.put(
      Uri.parse("${UrlConstant.EN_URL}user/address/${SharedPrefs.getUserId}/"),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );

    if (response.statusCode == 200) {
      SharedPrefs.setAddressName(name);
      SharedPrefs.setAddressType(type);
      SharedPrefs.setAddress(address);
      SharedPrefs.setAddressDescription(description);
      SharedPrefs.setAddressCountry(country);
      SharedPrefs.setAddressCity(city);
      SharedPrefs.setAddressProvince(province);
      SharedPrefs.setAddressPhoneNumber(phoneNumber);
      SharedPrefs.setAddressTcknVkn(tcknVkn);
      SharedPrefs.setAddressLatitude(latitude);
      SharedPrefs.setAddressLongitude(longitude);
      List<AddressValues> result = [];
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<AddressValues>> getAddress(int id) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}user/address/$id/"),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<AddressValues> addressValuesList = List<AddressValues>.from(
          jsonBody.map((model) => AddressValues.fromJson(model)));
      print(response);
      return addressValuesList;
    }
    print(response.statusCode);
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<AddressValues>> getActiveAddress() async {
    final response = await http.patch(
      Uri.parse("${UrlConstant.EN_URL}user/address/active_address/"),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<AddressValues> addressValuesList = List<AddressValues>.from(
          jsonBody.map((model) => AddressValues.fromJson(model)));

      return addressValuesList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<AddressValues>> changeActiveAddress(int activeAddressId) async {
    //  List<String> group = [];

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}user/address/change_address/"),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );

    if (response.statusCode == 200) {
      List<AddressValues> result = [];
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<AddressValues>> deleteAddress() async {
    final response = await http.delete(
      Uri.parse(
        ("${UrlConstant.EN_URL}user/address/${SharedPrefs.getUserId}/"),
      ),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
