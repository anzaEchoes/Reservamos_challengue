import 'package:flutter/material.dart';
import 'package:reservamos_app/aplication/static/icons_api_map.dart';

class IconApiWidget extends StatelessWidget {
  String str;
  double size;

  IconApiWidget({super.key, this.str = "", this.size = 50});

  _getImage(String str) {
    final res = ICONSAPI[str];
    return res ?? ICONSAPI["01d"];
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _getImage(str),
      width: size,
      height: size,
      filterQuality: FilterQuality.low,
      fit: BoxFit.fill,
    );
  }
}
