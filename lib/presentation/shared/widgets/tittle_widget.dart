import 'package:flutter/material.dart';

class TittleWidget extends StatelessWidget {
  final String texto;
  final double? size;
  final TextAlign? textAlign;
  final Color? color;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;

  const TittleWidget(
      {Key? key,
      required this.texto,
      this.size = 16,
      this.textAlign = TextAlign.start,
      this.color = Colors.black,
      this.padding = const EdgeInsets.symmetric(vertical: 20),
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Text(
        texto,
        style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
        textAlign: textAlign,
      ),
    );
  }
}
