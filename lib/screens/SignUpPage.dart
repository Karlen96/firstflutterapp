import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String dropdownValue = 'ru';
  TextEditingController phoneNumberValue = TextEditingController();
  TextEditingController passwordNumberValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    setState(() {
      switch (context.locale.toString()) {
        case 'en_EN':
          dropdownValue = 'en';
          break;
        case 'ru_RU':
          dropdownValue = 'ru';
          break;
        case 'am_AM':
          dropdownValue = 'am';
          break;
        default:
      }
    });
    void validation() {
      if (formkey.currentState.validate()) {
      } else {
        print('error');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      size: 16,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        switch (newValue) {
                          case 'am':
                            EasyLocalization.of(context).locale =
                                Locale('am', 'AM');
                            break;
                          case 'ru':
                            EasyLocalization.of(context).locale =
                                Locale('ru', 'RU');
                            break;
                          case 'en':
                            EasyLocalization.of(context).locale =
                                Locale('en', 'EN');
                            break;
                          default:
                        }
                      });
                    },
                    items: <String>['am', 'ru', 'en']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: phoneNumberValue,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: const EdgeInsets.all(10.0),
                                labelText: 'email'.tr().toString(),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'empty_input'.tr().toString();
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: passwordNumberValue,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: const EdgeInsets.all(10.0),
                                labelText: 'password'.tr().toString(),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'empty_input'.tr().toString();
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: const EdgeInsets.all(10.0),
                                labelText: 'password_reapet'.tr().toString(),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'empty_input'.tr().toString();
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Theme.of(context).primaryColorLight),
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'sign_up'.tr().toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: validation,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
