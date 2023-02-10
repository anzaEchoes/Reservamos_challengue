// ignore_for_file: unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservamos_app/aplication/models/api_response_model.dart';
import 'package:reservamos_app/aplication/static/colors_api_map%20.dart';
import 'package:reservamos_app/aplication/static/icons_api_map.dart';

import 'package:reservamos_app/presentation/shared/widgets/gradiant_container.dart';
import 'package:reservamos_app/presentation/shared/widgets/icon_api_widget.dart';
import 'package:reservamos_app/presentation/shared/widgets/icon_widget.dart';
import 'package:reservamos_app/presentation/shared/widgets/tittle_widget.dart';

class DetailSearchingCity extends StatelessWidget {
  DetailSearchingCity({super.key, this.weatherList = const []});
  List weatherList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: TittleWidget(
              texto: weatherList[2] ?? "",
              size: 20,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        body: Container(
            width: Get.width,
            height: Get.height,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  _container(_infoViewCurrent(weatherList[0])),
                  Column(
                    children: _generateDailysidget(dailies: weatherList[1]),
                  )
                ])),
      ),
    );
  }

  _container(Widget child) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }

  _generateDailysidget({List<Daily> dailies = const []}) {
    List<Widget> widgets = [];
    for (var i = 0; i < dailies.length; i++) {
      widgets.add(_infoViewDaily(dailies[i]));
    }
    return widgets;
  }

  _infoViewDaily(Daily daily) {
    final w = daily.weather![0];
    ICONSAPI[w.icon];

    return _container(Stack(children: [
      _gradientContainer(w.icon!),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [_headInfo(codeImage: w.icon!), _centerInfo()],
        ),
      ),
    ]));
  }

  _infoViewCurrent(Current current) {
    final w = current.weather![0];
    ICONSAPI[w.icon];

    return Stack(children: [
      _gradientContainer(w.icon!),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            _headInfo(codeImage: w.icon!),
            const TittleWidget(
              texto: "Today",
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              padding: EdgeInsets.only(left: 10),
            ),
            _centerInfo(
                viento: current.windSpeed!.toInt(),
                humedad: current.humidity!.toInt(),
                temp: current.temp!.toInt())
          ],
        ),
      ),
    ]);
  }

  Padding _centerInfo({int viento = 0, int humedad = 0, int temp = 0}) {
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
                texto: humedad.toString(),
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          TittleWidget(
            texto: "$temp°",
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
                texto: viento.toString(),
                fontWeight: FontWeight.bold,
              ),
            ],
          )
        ],
      ),
    );
  }

  GradiantContainer _gradientContainer(String code) {
    List<Color>? colors = COLORSAPI[code];
    colors ??= [];
    return GradiantContainer(
      colors: colors,
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
      ],
    );
  }
}
