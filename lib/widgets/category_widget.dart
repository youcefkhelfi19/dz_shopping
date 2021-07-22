import 'package:dz_shopping/inner_screens/categories_feeds.dart';
import 'package:dz_shopping/screens/feeds.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget(this.index);
  final int index;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, Object>> categories = [
    {
      'category': 'Laptops',
      'image': 'images/categories/laptop.jpg',
    },
    {
      'category': 'Furniture',
      'image': 'images/categories/forniture.jpg',
    },
    {
      'category': 'SmartPhones',
      'image': 'images/categories/phones.jpg',
    },
    {
      'category': 'Shoes',
      'image': 'images/categories/shoes.jpg',
    },
    {
      'category': 'Watch',
      'image': 'images/categories/watch.jpg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(CategoriesFeeds.routeName,arguments: categories[widget.index]['category']);
        print('${categories[widget.index]['category']}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 4.0),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
              //color: Colors.red
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    categories[widget.index]['image'],
                  )),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.3,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Text(
              categories[widget.index]['category'],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
