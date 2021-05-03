import 'dart:io';

import 'package:badges/badges.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/helpers/base.dart';
import 'package:myapp/providers/cartProvider.dart';
import 'package:myapp/providers/categoryProvider.dart';
import 'package:myapp/providers/comboProvider.dart';
import 'package:myapp/screens/HomePage.dart';
import 'package:myapp/screens/CartPage.dart';
import 'package:myapp/screens/FavoritsPage.dart';
import 'package:myapp/screens/MapPage.dart';
import 'package:myapp/screens/ProfilePage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:myapp/services/servicesAPI.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/restorantsProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBottomTabNavigationContent extends StatefulWidget {
  MainBottomTabNavigationContent({Key key}) : super(key: key);

  @override
  _MainBottomTabNavigationContentState createState() =>
      _MainBottomTabNavigationContentState();
}

class _MainBottomTabNavigationContentState
    extends State<MainBottomTabNavigationContent> {
  bool _isInit = true;
  bool _isLoading = false;
  ServicesAPI _servicesAPI;

  int selectedIndexPage = 0;
  List screens = [
    HomePage(),
    FavoritsPage(),
    CartPage(),
    MapPage(),
    ProfilePage()
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      RestorantsProvider restorantsProvider =
          context.watch<RestorantsProvider>();
      ComboProvider comboProvider = context.watch<ComboProvider>();
      CategoryProvider categoryProvider = context.watch<CategoryProvider>();
      _getDefaultSettings().then((value) {
        Base.apiKey = value['apiKey'];
        Base.sid = value['sid'];
        Base.language = value['language'];
        Base.restId = value['restId'];
        Base.deviceId = value['deviceId'];
        _servicesAPI = ServicesAPI();
        _servicesAPI
            .getHomePage(Base.apiKey, Base.language, Base.sid)
            .then((value) {
          restorantsProvider.setValueRestorants = value;
          _servicesAPI
              .getMenu(Base.restId, Base.apiKey, Base.language, Base.sid)
              .then((value) {
            if (value == null) {
              showAlertDialog(context);
            }
            setState(() {
              _isLoading = true;
              print('loaded');
            });
            comboProvider.setValueCombo = value['combo'];
            categoryProvider.setValueCategory = value['category'];
          });
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<dynamic> _getDefaultSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //get device
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceIdValue = '';
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdValue = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdValue = iosInfo.utsname.machine;
    }
    String languageValue = 'hy';
    switch (context.locale.toString()) {
      case 'en_EN':
        languageValue = 'en';
        break;
      case 'ru_RU':
        languageValue = 'ru';
        break;
      default:
    }
    // prefs.clear();
    final String apiKey = prefs.getString('apiKey') ?? '';
    final String language = languageValue;
    final int restId = prefs.getInt('restId');

    return {
      "apiKey": apiKey,
      "sid": '',
      "language": language,
      "restId": restId,
      "deviceId": deviceIdValue
    };
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cart = context.watch<CartProvider>();
    return (_isLoading)
        ? Scaffold(
            body: screens[selectedIndexPage],
            floatingActionButton: _floatingActionButton(cart.getCartLength),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _bottomAppBar(),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget _floatingActionButton(countItemsToCart) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Badge(
        position: BadgePosition(top: 1, end: 3),
        badgeContent: Text(
          countItemsToCart.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        shape: BadgeShape.circle,
        badgeColor: Colors.red,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 75,
          height: 75,
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              setState(() {
                selectedIndexPage = 2;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/basket.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 50,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.home,
                      color:
                          (selectedIndexPage == 0) ? Colors.red : Colors.grey),
                  onPressed: () {
                    setState(() {
                      selectedIndexPage = 0;
                    });
                  }),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.heart,
                      color:
                          (selectedIndexPage == 1) ? Colors.red : Colors.grey),
                  onPressed: () {
                    setState(() {
                      selectedIndexPage = 1;
                    });
                  }),
              SizedBox.shrink(),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.map,
                      color:
                          (selectedIndexPage == 3) ? Colors.red : Colors.grey),
                  onPressed: () {
                    setState(() {
                      selectedIndexPage = 3;
                    });
                  }),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.user,
                    color: (selectedIndexPage == 4) ? Colors.red : Colors.grey),
                onPressed: () {
                  setState(() {
                    selectedIndexPage = 4;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'notification'.tr().toString(),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'please_login'.tr().toString(),
            textAlign: TextAlign.center,
          ),
          actions: [
            FlatButton(
              child: Text('sign_in'.tr().toString()),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('sign_up'.tr().toString()),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
