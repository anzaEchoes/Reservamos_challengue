// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservamos_app/aplication/models/api_response_model.dart';
import 'package:reservamos_app/aplication/static/colors_api_map%20.dart';
import 'package:reservamos_app/aplication/static/icons_api_map.dart';
import 'package:reservamos_app/infrastrure/api/api_open_weather.dart';
import 'package:reservamos_app/presentation/screans/search/search_screan.dart';
import 'package:reservamos_app/presentation/shared/widgets/card_info_weather.dart';
import 'package:reservamos_app/presentation/shared/widgets/gradiant_container.dart';
import 'package:reservamos_app/presentation/shared/widgets/icon_api_widget.dart';
import 'package:reservamos_app/presentation/shared/widgets/icon_widget.dart';
import 'package:reservamos_app/presentation/shared/widgets/tittle_widget.dart';

import 'package:geolocator/geolocator.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  bool _isLoading = true;
  String _textCity = "";
  String _textTittle = "";
  WeatherResponse? _weatherResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfo();
  }

  Future<bool> _getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission.toString() == "LocationPermission.whileInUse" ||
        permission.toString() == "LocationPermission.always") {
      return true;
    } else {
      await Geolocator.requestPermission();
      return false;
    }
  }

  void _getInfo() async {
    final bool hasPermissed = await _getPermission();

    if (hasPermissed) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      ApiOpenWeather api = ApiOpenWeather();
      _weatherResponse = await api.getWeatherByCords(
          lat: position.latitude, long: position.longitude);

      var s = await api.getNamePlaceByCords(
          lat: position.latitude, long: position.longitude);

      if (s != null) {
        final indexSpace = s.indexOf(" ");
        if (indexSpace != -1) {
          s = s.substring(s.indexOf(" "), s.length);
        }
        _textCity = s;
        _textTittle = _weatherResponse!.current!.weather![0].description!;
      }
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _isLoading == true ? _loadingView() : _infoView(),
      ),
    );
  }

  Center _loadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  List<Widget> _listCards(List<Current>? hourly) {
    List<Widget> widgets = [];
    for (var item in hourly!) {
      widgets.add(CardInfoWidget(
        codeImage: item.weather![0].icon!,
        text: item.temp!.toInt().toString(),
      ));
    }
    return widgets;
  }

  Stack _infoView() {
    final w = _weatherResponse!.current!.weather![0];
    ICONSAPI[w.icon];

    return Stack(children: [
      _gradientContainer(),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [_headInfo(codeImage: w.icon!), _centerInfo()],
            ),
            SizedBox(
              height: 500,
              width: double.infinity,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _listCards(_weatherResponse!.hourly)),
            )
          ],
        ),
      ),
    ]);
  }

  Padding _centerInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 350),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconImageAssetWidget(
                str: "assets/icons/humedad.png",
              ),
              TittleWidget(
                texto: _weatherResponse!.current!.humidity.toString(),
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          TittleWidget(
            texto: "${_weatherResponse!.current!.temp!.toInt()}°",
            fontWeight: FontWeight.bold,
            size: 65,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconImageAssetWidget(
                str: "assets/icons/viento.png",
              ),
              TittleWidget(
                texto: _weatherResponse!.current!.windSpeed.toString(),
                fontWeight: FontWeight.bold,
              )
            ],
          )
        ],
      ),
    );
  }

  GradiantContainer _gradientContainer() {
    final w = _weatherResponse!.current!.weather![0];
    List<Color>? colors = COLORSAPI[w.icon];
    colors ??= [];
    return GradiantContainer(
      colors: colors,
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(onPressed: (() {}), icon: const Icon(Icons.menu)),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => SearchScrean());
            },
            icon: const Icon(Icons.search)),
      ],
      backgroundColor: Colors.white,
    );
  }

  Stack _headInfo({required String codeImage}) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Stack(
          children: [
            Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(150),
                    bottomRight: Radius.circular(150),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                child: IconApiWidget(
                  str: codeImage,
                  size: Get.width * 0.80,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              TittleWidget(
                texto: _textCity,
                size: 25,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                padding: EdgeInsets.zero,
              ),
              TittleWidget(
                textAlign: TextAlign.center,
                texto: _textTittle,
                size: 20,
              )
            ],
          ),
        )
      ],
    );
  }
}
