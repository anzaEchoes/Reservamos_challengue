import 'package:dio/dio.dart';
import 'package:reservamos_app/aplication/models/api_response_model.dart';

class ApiOpenWeather {
  Future<WeatherResponse?> getWeatherByCords(
      {double lat = 0, double long = 0}) async {
    const String appId = "a5a47c18197737e8eeca634cd6acb581";
    try {
      var response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/onecall?lon=$long&appid=$appId&lat=$lat&units=metric');

      return WeatherResponse().fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<List?> getWeathersDaysByCity({double lat = 0, double long = 0}) async {
    const String appId = "a5a47c18197737e8eeca634cd6acb581";

    try {
      var response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/onecall?lon=$long&appid=$appId&lat=$lat&units=metric');

      if (response.data == null) {
        return [];
      }
      Current current = Current().fromJson(response.data["current"]);

      List<Daily> days = [];
      for (var i = 0; i < response.data["daily"].length; i++) {
        days.add(Daily().fromJson(response.data["daily"][i]));
      }

      return [current, days];
    } catch (e) {
      return null;
    }
  }

  Future<String?> getNamePlaceByCords({double lat = 0, double long = 0}) async {
    const String appId = "AIzaSyBMmcq0xsZyTFYCht7rRGYDAp6tHtTJScw";

    try {
      var response = await Dio().get(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&sensor=true&key=$appId');
      if (response.data == null) {
        return null;
      }
      return response.data["plus_code"]["compound_code"];
    } catch (e) {
      return null;
    }
  }
}


/* 


 */