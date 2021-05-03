import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:myapp/helpers/base.dart';
import 'package:myapp/providers/categoryProvider.dart';
import 'package:myapp/providers/comboProvider.dart';
import 'package:myapp/providers/restorantsProvider.dart';
import 'package:myapp/services/servicesAPI.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ServicesAPI _servicesAPI;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    RestorantsProvider restorantsProvider = context.watch<RestorantsProvider>();
    ComboProvider comboProvider = context.watch<ComboProvider>();
    CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    String value = 'hy';
    switch (context.locale.toString()) {
      case 'ru_RU':
        value = 'ru';
        break;
      case 'en_EN':
        value = 'en';
        break;
      case 'am_AM':
        value = 'hy';
        break;
      default:
    }
    return (!_isLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Center(
              child: DropdownButton<String>(
                value: value,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (newValue) {
                  Base.language = newValue;
                  setState(() {
                    value = newValue;
                    _isLoading = false;
                  });
                  //change data
                  _servicesAPI = ServicesAPI();
                  _servicesAPI
                      .getHomePage(Base.apiKey, Base.language, Base.sid)
                      .then((value) {
                    restorantsProvider.setValueRestorants = value;
                    _servicesAPI
                        .getMenu(
                            Base.restId, Base.apiKey, Base.language, Base.sid)
                        .then((value) {
                      _isLoading = true;
                      comboProvider.setValueCombo = value['combo'];
                      categoryProvider.setValueCategory = value['category'];
                    });
                  });
                  //change data end
                  switch (newValue) {
                    case 'hy':
                      context.locale = Locale('am', 'AM');
                      break;
                    case 'ru':
                      context.locale = Locale('ru', 'RU');
                      break;
                    case 'en':
                      context.locale = Locale('en', 'EN');
                      break;
                    default:
                  }
                },
                items: <String>['hy', 'ru', 'en']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
