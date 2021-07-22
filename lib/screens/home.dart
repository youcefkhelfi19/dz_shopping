import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/inner_screens/brands_navigation_rail.dart';
import 'package:dz_shopping/models/product.dart';
import 'package:dz_shopping/provider/products_list.dart';
import 'package:dz_shopping/screens/feeds.dart';
import 'package:dz_shopping/widgets/back_layer.dart';
import 'package:dz_shopping/widgets/category_widget.dart';
import 'package:dz_shopping/widgets/popular_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String routeName  = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List images = ['brands/adidas.jpg', 'brands/apple.jpg','brands/hw.png','brands/kalenji.png','brands/nike.jpg','brands/samsung.png','brands/sony.jpg'];
   @override
  void initState() {
     final products = Provider.of<Products>(context, listen: false);
     products.fetchProducts();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context,listen: false);
    final List<Product> popularProducts = products.popularProducts;
    return BackdropScaffold(
      frontLayerBackgroundColor:Colors.grey[100],
        appBar: BackdropAppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Backdrop Example"),
          leading:  BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          actions: <Widget>[
          IconButton(
              icon:CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage('images/person.png'),

              ),
              onPressed:(){

              })
          ],
        ),
        backLayer: BackLayerMenu(),
        frontLayer:SingleChildScrollView(
          
          child: Column(
            children: [
              SizedBox(
                  height:MediaQuery.of(context).size.height*0.25,
                  width: double.infinity,
                  child: Carousel(
                    images: [
                      NetworkImage('https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'),
                      NetworkImage('https://images.unsplash.com/photo-1513116476489-7635e79feb27?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=684&q=80'),
                      NetworkImage('https://images.unsplash.com/photo-1532298229144-0ec0c57515c7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=708&q=80'),
                      NetworkImage('https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'),
                      NetworkImage('https://images.unsplash.com/photo-1525904097878-94fb15835963?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80')
                      //ExactAssetImage("assets/images/LaunchImage.jpg")
                    ],
                    boxFit: BoxFit.fill,
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: AppColors.primaryColor,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.black12,
                    borderRadius: false,
                    autoplay: true,
                    moveIndicatorFromBottom: 180.0,
                    noRadiusForIndicator: true,
                    overlayShadow: false,
                    overlayShadowColors: Colors.white,
                    overlayShadowSize: 0.7,
                  )
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Text('Categories',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.21,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                    itemBuilder: (context , index){
                      return CategoryWidget(index);
                    }),
              ),
             Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                width: double.infinity,
                child:  Row(
                  children: [
                    Text(
                      'Popular Brands',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          BrandNavigationRailScreen.routeName,
                          arguments: {
                            7,
                          },
                        );                      },
                      child: Text(
                        'View all...',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Colors.orange),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.2,
                width: MediaQuery.of(context).size.width * 0.95,

                child: Swiper(
                  itemCount: images.length,
                  autoplay: true,
                  viewportFraction: 0.7,
                  scale: 0.9,
                  onTap: (index){
                    Navigator.of(context).pushNamed(
                      BrandNavigationRailScreen.routeName,
                      arguments: {
                        index,
                      },
                    );
                  },
                  itemBuilder: (BuildContext ctx, int index) {
                    return ClipRRect(

                      borderRadius: BorderRadius.circular(10),
                      child: Container(

                        color: Colors.blueGrey,
                        child: Image.asset(images[index], fit: BoxFit.fill,),),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular products',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(
                          Feeds.routeName,
                         arguments: 'popular'
                        );
                      },
                      child: Text(
                        'View all...',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularProducts.length,
                    itemBuilder: (context , index){
                      return ChangeNotifierProvider.value(
                        value: popularProducts[index],
                        child: ProductWidget(),
                      );
                    }),
              ),

            ],
          ),
        ),
      );

  }
}
