import 'package:flutter/material.dart';
import 'package:myapp/helpers/config.dart';
import 'package:myapp/routing/appRoutes.dart';

class CardProduct extends StatelessWidget {
  final provider;
  final item;
  const CardProduct({Key key, this.item, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = item['linkfoto'] != null
        ? Config.imageUrl + item['linkfoto']
        : 'http://placehold.it/100x100';
    return ListTile(
      title: Text(item['name']),
      leading: Image.network(imageUrl),
      trailing: IconButton(
        icon: Icon(
          (item['favorit']) ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          provider.changeStatusFavorit(item['ident']);
        },
      ),
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.productPage, arguments: item);
      },
    );
  }
}
