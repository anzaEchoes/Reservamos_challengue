import 'package:flutter/material.dart';
import 'package:reservamos_app/presentation/shared/widgets/icon_api_widget.dart';
import 'package:reservamos_app/presentation/shared/widgets/tittle_widget.dart';

class CardInfoWidget extends StatelessWidget {
  String codeImage;
  String text;
  CardInfoWidget({super.key, this.codeImage = "", this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          width: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            child: TittleWidget(
              texto: "$text°",
              textAlign: TextAlign.center,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              padding: EdgeInsets.zero,
              size: 30,
            ),
          ),
        ),
        IconApiWidget(
          str: codeImage,
          size: 100,
        ),
      ],
    );
  }
}
