import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pigment/pigment.dart';

import 'HeaderSection.dart';
import 'ContentSection.dart';

var data = [
  {
    "logoLink": "assets/Asics_Logo_1.png",
    "shoeImage": "assets/shoes/red.png",
    "headerHeading": 'GEL KAYANO TRAINER',
    "headerDescription":
        'This entry-level model features a full-length Gum Rubber Outsole for excellent traction on the court. Rearfoot GEL Cushioning System provides enhanced cushioning - while the combination synthetic leather and mesh upper provides breathability and comfort. A great value for the multi-court player.',
    "contentHeading": "ASICS GEL KAYANO",
    "contentSubHeading": "RUNNING COLLECTION",
    "contentBadge": "NEW",
    "colors": ["#bfeb84", "#82d4f1", "#363158"]
        .map((String color) => Pigment.fromString(color))
        .toList()
  },
  {
    "logoLink": "assets/Asics_Logo_2.png",
    "shoeImage": "assets/shoes/yellow.png",
    "headerHeading": 'GEL KAYANO TRAINER',
    "headerDescription":
        'This entry-level model features a full-length Gum Rubber Outsole for excellent traction on the court. Rearfoot GEL Cushioning System provides enhanced cushioning - while the combination synthetic leather and mesh upper provides breathability and comfort. A great value for the multi-court player.',
    "contentHeading": "ASICS GEL KAYANO",
    "contentSubHeading": "RUNNING COLLECTION",
    "contentBadge": "NEW",
    "colors": ['#d4d9a0', '#59524a', '#68947f']
        .map((String color) => Pigment.fromString(color))
        .toList(),
  },
  {
    "logoLink": "assets/Asics_Logo_3.png",
    "shoeImage": "assets/shoes/blue.png",
    "headerHeading": 'GEL KAYANO TRAINER',
    "headerDescription":
        'This entry-level model features a full-length Gum Rubber Outsole for excellent traction on the court. Rearfoot GEL Cushioning System provides enhanced cushioning - while the combination synthetic leather and mesh upper provides breathability and comfort. A great value for the multi-court player.',
    "contentHeading": "ASICS GEL KAYANO",
    "contentSubHeading": "RUNNING COLLECTION",
    "contentBadge": "NEW",
    "colors": ['#6899c0', '#38499d', '#7b2e48']
        .map((String color) => Pigment.fromString(color))
        .toList(),
  },
];

class ShoesConceptOptimize extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ShoesConceptOptimizeState();
}

class ShoesConceptOptimizeState extends State<ShoesConceptOptimize> {
  double scrollPercant = 0.0;
  double startDarg;
  double startDargPercantScroll;
  double finishScrollStart;
  double finishScrollEnd;
  ScrollController _scrollController = new ScrollController();

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  bool _onScroll(ScrollNotification s) {
    double screenSize = MediaQuery.of(context).size.width;
    double current = s.metrics.pixels;
    if (s is ScrollStartNotification) {
      // print(s.metrics.pixels);
      startDarg = s.metrics.pixels;
      startDargPercantScroll = scrollPercant;
    }
    if (s is ScrollUpdateNotification) {
      double distance = current - startDarg;
      final per = distance / screenSize;
      setState(() {
        scrollPercant = (startDargPercantScroll + (-per / data.length))
            .clamp(0.0, 1.0 - (1 / data.length));
      });
    }
    if (s is ScrollEndNotification) {
      finishScrollStart = scrollPercant;
      finishScrollEnd = (scrollPercant * data.length).round() / data.length;
      setState(() {
        startDarg = null;
        startDargPercantScroll = null;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: new CustomScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        slivers: this._buildViews(),
      ),
    ));
  }

  List<Widget> _buildViews() {
    return [
      new SliverToBoxAdapter(
        child: _buildView(1, data.length, scrollPercant),
      ),
      new SliverToBoxAdapter(
        child: _buildView(1, data.length, scrollPercant),
      ),
      new SliverToBoxAdapter(
        child: _buildView(1, data.length, scrollPercant),
      ),
    ];
  }

  Widget _buildView(int cardIndex, int count, double scroll) {
    final parallax = scrollPercant - (cardIndex / data.length);

    return new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: new Content(
        logoLink: data[cardIndex]['logoLink'],
        shoeImage: data[cardIndex]['shoeImage'],
        headerHeading: data[cardIndex]['headerHeading'],
        headerDescription: data[cardIndex]['headerDescription'],
        contentHeading: data[cardIndex]['contentHeading'],
        contentSubHeading: data[cardIndex]['contentSubHeading'],
        contentBadge: data[cardIndex]['contentBadge'],
        colors: data[cardIndex]['colors'],
        parallax: parallax,
      ),
    );
  }
}

class Content extends StatefulWidget {
  Content({
    this.colors,
    this.logoLink,
    this.shoeImage,
    this.headerHeading,
    this.headerDescription,
    this.contentHeading,
    this.contentSubHeading,
    this.contentBadge,
    this.parallax,
  });
  final List<Color> colors;
  final String logoLink;
  final String shoeImage;
  final String headerHeading;
  final String headerDescription;
  final String contentHeading;
  final String contentSubHeading;
  final String contentBadge;
  final double parallax;

  @override
  State<StatefulWidget> createState() => new ContentState(
        colors: colors,
        logoLink: logoLink,
        shoeImage: shoeImage,
        headerHeading: headerHeading,
        headerDescription: headerDescription,
        contentHeading: contentHeading,
        contentSubHeading: contentSubHeading,
        contentBadge: contentBadge,
      );
}

class ContentState extends State<Content> {
  ContentState({
    this.colors,
    this.logoLink,
    this.shoeImage,
    this.headerHeading,
    this.headerDescription,
    this.contentHeading,
    this.contentSubHeading,
    this.contentBadge,
  }) : _currentColor = colors[0];
  final List<Color> colors;
  final String logoLink;
  final String shoeImage;
  final String headerHeading;
  final String headerDescription;
  final String contentHeading;
  final String contentSubHeading;
  final String contentBadge;
  Color _currentColor;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void _changeCurrentColor(Color color) {
    if (color != _currentColor) {
      this.setState(() {
        this._currentColor = color;
      });
    }
  }

  final double _contnetHeight = 270.0;

  @override
  Widget build(BuildContext context) {
    double _headerHeight = MediaQuery.of(context).size.height - _contnetHeight;

    return new Stack(
      fit: StackFit.loose,
      children: <Widget>[
        new HeaderSection(
          headerDescription: this.headerDescription,
          headerHeading: this.headerHeading,
          logoLink: this.logoLink,
          headerHeight: _headerHeight,
          gradientColors: this.colors,
          parallax: widget.parallax,
        ),
        new Positioned(
          // top: _headerHeight,
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          height: _contnetHeight,
          child: new ContentSection(
            headerHeight: _headerHeight,
            contentHeading: this.contentHeading,
            contentSubHeading: this.contentSubHeading,
            contentBadge: this.contentBadge,
            colors: this.colors,
            currentColor: this._currentColor,
            changeCurrentColor: this._changeCurrentColor,
            parallax: widget.parallax,
          ),
        ),
        new Positioned(
          top: 200.0,
          left: 60.0,
          right: 60.0,
          child: new Container(
            child: new Transform(
              alignment: Alignment.center,
              transform: new Matrix4.rotationZ(0.38 +
                  ((widget.parallax > 0
                          ? (widget.parallax)
                          : (-widget.parallax)) *
                      1.5))
                ..leftTranslate(16.0, 40.0)
                ..scale(1.0 +
                    ((widget.parallax > 0
                            ? (-widget.parallax)
                            : (widget.parallax)) *
                        1.8)),
              child: new AnimatedOpacity(
                duration: new Duration(milliseconds: 100),
                opacity: 1.0 +
                    ((widget.parallax > 0
                            ? (-widget.parallax)
                            : (widget.parallax)) *
                        1.5),
                child: new Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: null,
                      height: 12.0,
                      decoration: new BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(16.0),
                        ),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 26.0,
                            offset: new Offset(0.0, -8.0),
                          ),
                        ],
                      ),
                    ),
                    new Image(
                      image: new AssetImage(shoeImage),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}