import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/provider/dark_theme_provider.dart';
import 'package:dz_shopping/screens/cart.dart';
import 'package:dz_shopping/screens/orders.dart';
import 'package:dz_shopping/screens/wish_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController _scrollController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _name = '';
  String _email = '';
  int _phone ;
  String _joinedAt = '';
  String _imageUrl ;
  var top = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});

    });
  }
  void getData()async{
   User user =  _auth.currentUser;
   String _uid = user.uid;
   final DocumentSnapshot userInfo = await  FirebaseFirestore.instance.collection('users').doc(_uid).get();
   setState(() {
     _name = userInfo.get('name');
     _email = user.email;
     _phone = userInfo.get('phoneNumber');
     _joinedAt = userInfo.get('createdAt').toString();
     _imageUrl = userInfo.get('imageUrl');
   });
  }
  @override
  Widget build(BuildContext context) {
    final changeTheme = Provider.of<DarkTheme>(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xfff5bb00),
                            Color(0xfffcc813),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                     scale: 1.0,
                                     image: NetworkImage(_imageUrl?? 'https://static.vecteezy.com/system/resources/previews/000/550/731/non_2x/user-icon-vector.jpg'),

                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  // 'top.toString()',
                                 _name,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      background: Image(
                        height: kToolbarHeight / 1.5,
                        width: kToolbarHeight / 1.5,
                        image: NetworkImage(_imageUrl?? 'https://static.vecteezy.com/system/resources/previews/000/550/731/non_2x/user-icon-vector.jpg'),

                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle('User Bag'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, Cart.routeName);
                          },
                          title: Text('Cart'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          leading: Icon(AppIcons.bag),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, WishList.routeName);
                          },
                          title: Text('Wish List'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          leading: Icon(AppIcons.favOff),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, Orders.routeName);
                          },
                          title: Text('My Orders'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          leading: Icon(AppIcons.fullBag),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Information')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    customListTile(context, 'Email', _email, 00),
                    customListTile(context, 'Phone', '$_phone', 1),
                    customListTile(context, 'shipping Address', 'street 14 build 4', 2),
                    customListTile(context, 'Joined Date', '$_joinedAt', 3),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle('User settings'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: changeTheme.isDark,
                      leading: Icon(Ionicons.md_moon),
                      onChanged: (value) {
                        setState(() {
                          changeTheme.darkTheme = value;
                        });
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.indigo,
                      title: Text('Dark theme'),
                    ),
                    customListTile(context, 'Logout', '', 4,
                    onTap: (){
                      signOutDialog();
                    }
                    ),
                  ],
                ),
              )
            ],
          ),
          _buildFab()
        ],
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  final List<IconData> icons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app
  ];

  Widget customListTile(
      BuildContext context, String title, String subtitle, int index,
      {Function onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap:onTap,
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(icons[index]),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }

  Future<void> signOutDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'images/mark.png',
                  height: 30.0,
                  width: 30.0,
                ),
                Text('Sign out'),
              ],
            ),
            content: Text('Are you sur you want to Sign out ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                  onPressed: () async {
                    await _auth.signOut().then((value) => Navigator.canPop(context)?Navigator.pop(context):null);
                  },
                  child: Text('Yes'))
            ],
          );
        });
  }
}
