import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:opticalapp/src/pages/addcli_page.dart';
import 'package:opticalapp/src/pages/search_page.dart';
import 'package:opticalapp/src/pages/settings_page.dart';
import 'package:opticalapp/src/utilities/utilites.dart';
import 'package:opticalapp/src/widgets/appbar_widget.dart';

class MyHomePage extends StatefulWidget {
  final titles = [
    'Agregar Cliente',
    'Buscar Cliente',
    'Configuracion',
  ];
  final colors = [
    primaryColor,
    primaryColor,
    primaryColor,
  ];
  final icons = [
    CupertinoIcons.person_add,
    CupertinoIcons.search,
    CupertinoIcons.settings_solid,
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBarWid(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              checkUserDragging(scrollNotification);
            },
            child: PageView(
              controller: _pageController,
              children: [
                AddClientPage(),
                SearchPage(),
                SettingsPage(),
              ],
              onPageChanged: (page) {},
            ),
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          animationCurve: Curves.easeInCubic,
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Colors.transparent,
          defaultBubbleColor: Colors.blue,
          onTap: (index) {
            _pageController.animateToPage(index,
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 500));
          },
          items: widget.titles.map((title) {
            var index = widget.titles.indexOf(title);
            var color = widget.colors[index];
            return BubbledNavigationBarItem(
              icon: getIcon(index, thirdColor),
              activeIcon: getIcon(index, primaryColor),
              bubbleColor: lightblue,
              title: Text(
                title,
                style: TextStyle(
                    color: color, fontSize: 14, fontFamily: 'SemiBold'),
              ),
            );
          }).toList(),
        ));
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(widget.icons[index], size: 20, color: color),
    );
  }
}
