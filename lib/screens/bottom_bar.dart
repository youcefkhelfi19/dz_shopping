import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/screens/Profile.dart';
import 'package:dz_shopping/screens/cart.dart';
import 'package:dz_shopping/screens/feeds.dart';
import 'package:dz_shopping/screens/home.dart';
import 'package:dz_shopping/screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  List<Map<String, Object>> _tabs ;
  int _selectedTabIndex = 0;
  @override
  void initState() {
     _tabs =[
       {'tab': Home()},
       {'tab': Feeds()},
       {'tab': Search()},
       {'tab': Cart()},
       {'tab': Profile()},
     ];
    super.initState();
  }
  void _selectTab(int index){
    setState(() {
      _selectedTabIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _tabs[_selectedTabIndex]['tab'],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
          child: Container(
            height: kBottomNavigationBarHeight*0.98,
              child: Container(
                decoration: BoxDecoration(
                 // color: Colors.red,
                  border: Border(
                    top: BorderSide(
                      color:  Theme.of(context).primaryColor,
                      width: 0.5
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  onTap: _selectTab,
                  backgroundColor: Theme.of(context).primaryColor,
                  unselectedItemColor: Colors.grey,
                 selectedItemColor: Theme.of(context).primaryColor,
                  currentIndex: _selectedTabIndex,
                  items: [
                  BottomNavigationBarItem(
                      icon:Icon(AppIcons.home),
                       label: 'Home',
                  ),
                    BottomNavigationBarItem(
                      icon:Icon(AppIcons.feeds),
                      label: 'Feeds',
                    ),
                    BottomNavigationBarItem(
                      icon:Icon(null),
                      activeIcon: null,
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon:Icon(AppIcons.bag),
                      label: 'Bag',
                    ),
                    BottomNavigationBarItem(
                      icon:Icon(AppIcons.user),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
          ),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Color(0xffffcd86),
            hoverElevation: 10.0,
            splashColor:  Colors.grey,
            tooltip: 'Search',
            elevation: 4.0,
            child: Icon(AppIcons.search,size: 30.0,),
            onPressed: (){
              setState(() {
                _selectedTabIndex = 2;
              });
            },
          ),
      ),
    );
  }
}
