import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ValueNotifier<double> offset = ValueNotifier<double>(0);

class FlutterParallax extends StatefulWidget {
  final List<Widget> screens;
  final Axis scrollDirection;
  final ImageProvider backgroundImage;

  const FlutterParallax({
    Key key,
    @required this.screens,
    this.scrollDirection = Axis.vertical,
    this.backgroundImage,
  }) : super(key: key);

  @override
  _FlutterParallaxState createState() => _FlutterParallaxState();
}

class _FlutterParallaxState extends State<FlutterParallax> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 1);
    pageController.addListener(() {
      offset.value = pageController.page;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageViewWidget = PageView(
      scrollDirection: widget.scrollDirection,
      children: widget.screens,
      pageSnapping: true,
      controller: pageController,
    );

    if (widget.backgroundImage is ImageProvider) {
      return ValueListenableBuilder<double>(
        valueListenable: offset,
        builder: (
          BuildContext context,
          double pageOffset,
          Widget child,
        ) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.backgroundImage,
                alignment: Alignment(0, pageOffset.abs() / 3),
                fit: BoxFit.cover,
              ),
            ),
            child: pageViewWidget,
          );
        },
      );
    }

    return pageViewWidget;
  }
}

class FlutterParallaxChild extends StatefulWidget {
  final Widget child;

  const FlutterParallaxChild({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _FlutterParallaxChildState createState() => _FlutterParallaxChildState();
}

class _FlutterParallaxChildState extends State<FlutterParallaxChild> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: offset,
      builder: (
        BuildContext context,
        double pageOffset,
        Widget child,
      ) {
        return Container(
          alignment: Alignment(
            -3 + 3 * pageOffset.abs() - .75,
            -2.25 + 1.5 * pageOffset.abs(),
          ),
          child: widget.child,
        );
      },
    );
  }
}
