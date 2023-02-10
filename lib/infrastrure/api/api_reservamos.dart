import 'package:dio/dio.dart';
import 'package:reservamos_app/aplication/models/city_response_model.dart';

class ApiReservamos {
  Future<List<CityResponse>> getCityByName({String nameCity = ""}) async {
    List<CityResponse> crList = [];
    try {
      var response = await Dio()
          .get('https://search.reservamos.mx/api/v2/places?q=$nameCity');

      for (var i = 0; i < response.data.length; i++) {
        crList.add(CityResponse().fromJson(response.data[i]));
      }

      return crList;
    } catch (e) {
      return [];
    }
  }
}
