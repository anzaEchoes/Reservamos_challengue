import 'package:flutter/material.dart';

class GradiantContainer extends StatefulWidget {
  List<Color> colors;

  GradiantContainer({
    super.key,
    this.colors = const [],
  });

  @override
  _GradiantContainerState createState() => _GradiantContainerState();
}

class _GradiantContainerState extends State<GradiantContainer> {
  List<Alignment> alignmentList = [
    Alignment.topCenter,
    Alignment.bottomCenter,
  ];
  int index = 0;
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;
  late Color topColor;
  late Color bottomColor;

  _update() {
    Future.delayed(_duration(seconds: 3), () {
      try {
        setState(() {
          bottomColor = widget.colors[0];
        });
      } catch (e) {}
    });
  }

  _initColors() {
    if (widget.colors.length > 1) {
      topColor = widget.colors[0];
      bottomColor = widget.colors[1];
    } else {
      topColor = Colors.green;
      bottomColor = Colors.yellow;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.colors.length != 0) {
      _initColors();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.colors.length != 0) {
      _update();
    }

    return Stack(
      children: [
        widget.colors.length == 0
            ? const SizedBox()
            : AnimatedContainer(
                duration: _duration(),
                onEnd: () {
                  setState(() {
                    index = index + 1;
                    // animate the color
                    bottomColor = widget.colors[index % widget.colors.length];
                    topColor =
                        widget.colors[(index + 1) % widget.colors.length];

                    //// animate the alignment
                    /*   begin = alignmentList[index % alignmentList.length];
              end = alignmentList[(index + 2) % alignmentList.length]; */
                  });
                },
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: begin, end: end, colors: [
                  topColor,
                  widget.colors[1],
                  widget.colors[2],
                  bottomColor,
                ])),
              ),
      ],
    );
  }

  Duration _duration({int seconds = 3}) => Duration(seconds: seconds);
}
