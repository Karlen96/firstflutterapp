import 'package:flutter/material.dart';
import 'package:myapp/helpers/config.dart';
import 'package:myapp/routing/appRoutes.dart';

class SliderItem extends StatelessWidget {
  final item;
  const SliderItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = item['linkfoto'] != null
        ? Config.imageUrl + item['linkfoto']
        : 'http://placehold.it/100x100';
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.productPage, arguments: item);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
