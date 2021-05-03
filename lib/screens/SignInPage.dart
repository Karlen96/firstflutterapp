import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool obscureTextValue = true;

  void _changeobscureTextValue() {
    setState(() {
      obscureTextValue = !obscureTextValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'sign_in'.tr().toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    TextFormField(
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'email'.tr().toString(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'password'.tr().toString(),
                        suffixIcon: (obscureTextValue)
                            ? IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: _changeobscureTextValue)
                            : IconButton(
                                icon: Icon(Icons.add),
                                onPressed: _changeobscureTextValue),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).primaryColorLight),
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'sign_in'.tr().toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
