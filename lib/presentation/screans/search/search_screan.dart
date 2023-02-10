import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservamos_app/aplication/models/city_response_model.dart';
import 'package:reservamos_app/infrastrure/api/api_open_weather.dart';
import 'package:reservamos_app/infrastrure/api/api_reservamos.dart';
import 'package:reservamos_app/main.dart';
import 'package:reservamos_app/presentation/screans/detail_searching_city_screan/detail_searching_city_screan.dart';
import 'package:reservamos_app/presentation/shared/widgets/tittle_widget.dart';

class SearchScrean extends StatefulWidget {
  const SearchScrean({super.key});

  @override
  State<SearchScrean> createState() => _SearchScreanState();
}

class _SearchScreanState extends State<SearchScrean> {
  TextEditingController controlador = TextEditingController();
  final ApiReservamos _apiReservamos = ApiReservamos();
  final ApiOpenWeather _apiOpenWeather = ApiOpenWeather();

  List<CityResponse> listCitys = [];
  List<Widget> _resultWidgetList = [];
  List weatherDays = [];
  bool isSearching = false;
  String _focusPlace = "";

  _searching(bool val) {
    isSearching = val;
    setState(() {});
  }

  _toWidgetList() {
    for (var city in listCitys) {
      final place = city.cityName ?? "";
      final state = city.state ?? "";
      final country = city.country ?? "";

      _focusPlace = "$place,$state,$country";
      double? lat = double.tryParse(city.lat ?? "0");
      double? long = double.tryParse(city.long ?? "0");

      _resultWidgetList.add(ListTile(
        leading: const Icon(Icons.location_city_outlined),
        title: TittleWidget(
          texto: place,
          padding: EdgeInsets.zero,
          fontWeight: FontWeight.bold,
        ),
        subtitle: TittleWidget(
          texto: '$state, $country ',
          padding: EdgeInsets.zero,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_sharp),
        onTap: () => _navigate(latitude: lat!, longitude: long!),
      ));
    }
  }

  _callApi({double latitude = 0, double longitude = 0}) async {
    var weatherDaysAux = await _apiOpenWeather.getWeathersDaysByCity(
        lat: latitude, long: longitude);
    if (weatherDaysAux != null) {
      weatherDays = weatherDaysAux;
      weatherDays.add(_focusPlace);
      Get.to(() => DetailSearchingCity(
            weatherList: weatherDays,
          ));
    }
  }

  _navigate({double latitude = 0, double longitude = 0}) {
    _snackBar();
    _callApi(latitude: latitude, longitude: longitude);
  }

  _searchByCity() async {
    _searching(true);
    FocusScope.of(context).unfocus();
    var text = controlador.value.text;
    if (text != "") {
      listCitys = await _apiReservamos.getCityByName(nameCity: text);
      _toWidgetList();
    }
    _searching(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _inputSearchView(),
              const SizedBox(
                height: 10,
              ),
              isSearching ? _loadingView() : _listCitysView()
            ],
          ),
        ),
      ),
    );
  }

  _snackBar({String state = "waiting"}) {
    var title = "Loading";
    var color = Colors.black;

    var icon = Icons.api_rounded;

    if (state == "error") {
      title = "Error, Try later :(";
      color = Colors.red;
      icon = Icons.error_outline_rounded;
    }

    Get.snackbar(
      title,
      "",
      colorText: Colors.white,
      backgroundColor: color,
      icon: Icon(icon),
    );
  }

  Expanded _listCitysView() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: _resultWidgetList,
      ),
    );
  }

  Center _loadingView() {
    return const Center(child: CircularProgressIndicator());
  }

  TextField _inputSearchView() {
    return TextField(
      controller: controlador,
      decoration: InputDecoration(
        hintText: 'Enter a city name',
        suffixIcon: IconButton(
          onPressed: _searchByCity,
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
