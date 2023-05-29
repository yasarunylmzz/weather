import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/api/models/five_days_model.dart';
import 'package:weather/api/models/location_data_model.dart';

class ApiHelper {
  // Future<List> getCityData(String location) async {
  //   try {
  //     final response = await Dio().get(
  //         "https://api.openweathermap.org/data/2.5/weather?lang=tr&units=metric&appid=e50e14194862612654674aefa053465b&q=Ankara");

  //     print(response.data.toString());
  //     List list = [];
  //     var data = response.data;
  //     if (data is List) {
  //       list = data.map((e) => LocationDataModel.fromMap(e)).toList();
  //     } else {
  //       return [];
  //     }
  //     debugPrint(list.toString());
  //     return list;
  //   } catch (e) {
  //     debugPrint(Future.error(e..toString()).toString());
  //     return [];
  //   }
  // }

  Future<LocationDataModel> locationData(String location) async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lang=tr&units=metric&appid=e50e14194862612654674aefa053465b&q=$location'));
    if (response.statusCode == 200) {
      debugPrint(response.toString());
      return LocationDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<FiveDaysModel> fiveDaysData(String location) async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?appid=e50e14194862612654674aefa053465b&q=$location&units=metric&lang=tr'));
    if (response.statusCode == 200) {
      debugPrint(response.toString());
      return FiveDaysModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
