import 'package:flutter/material.dart';
import 'package:myapp/providers/categoryProvider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:myapp/widgets/CardProduct.dart';

class FavoritsPage extends StatelessWidget {
  const FavoritsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    List _categories = categoryProvider.getCategoryList;
    List _favorits = [];
    for (int i = 0; i < _categories.length; i++) {
      for (int j = 0; j < _categories[i]['menyu'].length; j++) {
        if (_categories[i]['menyu'][j]['favorit']) {
          _favorits.add(_categories[i]['menyu'][j]);
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'favorits'.tr().toString(),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _favorits.length,
        itemBuilder: (context, index) {
          return CardProduct(
              item: _favorits[index], provider: categoryProvider);
        },
      ),
    );
  }
}
