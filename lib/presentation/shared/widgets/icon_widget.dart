import 'package:flutter/material.dart';

class IconImageAssetWidget extends StatelessWidget {
  String str;
  double size;

  IconImageAssetWidget({super.key, this.str = "", this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      str,
      width: size,
      height: size,
      filterQuality: FilterQuality.low,
      fit: BoxFit.fill,
    );
  }
}
