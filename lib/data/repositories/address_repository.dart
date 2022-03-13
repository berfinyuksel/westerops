import 'dart:convert';

import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/url_constant.dart';
import '../model/address.dart';
import '../shared/shared_prefs.dart';

abstract class AdressRepository {
  Future<List<AddressValues>> updateAddress(
    int id,
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
  Future<List<AddressValues>> deleteAddress(int? id);
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
    int id,
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
    final response = await http.patch(
      Uri.parse("${UrlConstant.EN_URL}user/address/$id/"),
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

      return addressValuesList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<AddressValues>> getActiveAddress() async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}user/address/active_address/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      var activeAdressList = AddressValues.fromJson(jsonBody);
      List<AddressValues> result = [];
      result.add(activeAdressList);
      return result;
    }
    if (response.statusCode == 401) {
      List<AddressValues> result = [];

      return result;
    }
    if (response.statusCode == 204) {
      List<AddressValues> result = [];

      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<AddressValues>> deleteAddress(int? id) async {
    final response = await http.delete(
      Uri.parse(
        ("${UrlConstant.EN_URL}user/address/$id/"),
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

