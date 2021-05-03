import 'package:flutter/material.dart';
import 'package:myapp/providers/categoryProvider.dart';
import 'package:myapp/providers/comboProvider.dart';
import 'package:myapp/widgets/CardProduct.dart';
import 'package:myapp/widgets/SliderItem.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ComboProvider comboProvider = context.watch<ComboProvider>();
    CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    List _category = categoryProvider.getCategoryList;
    List _combos = comboProvider.getCombo;
    return SafeArea(
      child: Column(
        children: [
          Container(
            child: CarouselSlider.builder(
              itemCount: _combos.length,
              itemBuilder: (BuildContext context, int itemIndex) {
                return SliderItem(item: _combos[itemIndex]);
              },
              aspectRatio: 16 / 9,
              viewportFraction: 0.6,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _category.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  child: Text(_category[index]['name']),
                );
              },
            ),
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: _category.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            _category[i]['name'],
                            style: TextStyle(color: Colors.red, fontSize: 26),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _category[i]['menyu'].length,
                            itemBuilder: (context, j) {
                              return CardProduct(
                                item: _category[i]['menyu'][j],
                                provider: categoryProvider,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
