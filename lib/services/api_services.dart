import 'dart:convert';

import 'package:dio/dio.dart';

class ApiServices {
  getresturents(String lat, String long) async {
    Dio dio = Dio();
    var response = await dio.get(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=1000&type=mosque&key=AIzaSyC7aO2ri5wsZEBhI3iqm70A1-m7vTYmehg");
    if (response.statusCode == 200) {
      return response.data['results'];
    } else {
      print("=========== ERROR ============");
    }
  }

  getNimazTime(String city) async {
    Dio dio = Dio();
    var response = await dio.get(
        "https://muslimsalat.com/${city}.json?key=be2bfbfdcafd21d86ad0ec8fee3cf54a");
    if (response.statusCode == 200) {
      return response.data['items'];
    } else {
      print("=========== ERROR ============");
    }
  }

  getHijri(String lat, String long, String month, String year) async {
    Dio dio = Dio();
    var response = await dio.get(
        "http://api.aladhan.com/v1/calendar?latitude=$lat&longitude=$long&method=1&month=$month&year=$year");
    if (response.statusCode == 200) {
      // print("Data is ${response.data['data']}");
      return response.data['data'];
    } else {
      print("=========== ERROR ============");
    }
  }
}

