import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/models/product_model.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/core/providers/menu_provider.dart';
import 'package:pets_app/core/services/products_service.dart';
import 'package:pets_app/ui/screens/menu/view/menu_view.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetailsWidget extends StatefulWidget {
  final Product animal;
  PetDetailsWidget({required this.animal});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<PetDetailsWidget> {
  String toastMsg = "";

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final data = Provider.of<UserData>(context);
    final user = Provider.of<UserModel?>(context);
    final sizeConfig = SizeConfig();
    sizeConfig.init(context);
    final petsProvider = PetsService();
    final List? list = widget.animal.myFavorites;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: sizeConfig.screenHeight * 0.5,
                    color: Color.fromRGBO(203, 213, 216, 1.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: sizeConfig.getProportionateScreenHeight(250),
                      width: sizeConfig.getProportionateScreenWidth(300),
                      child: Image(
                        image: NetworkImage(widget.animal.imageUrl),
                        fit: BoxFit.fitHeight,
                      )),
                ],
              ),
              SizedBox(
                height: sizeConfig.getProportionateScreenHeight(45),
              ),
              Expanded(
                  child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 30.0,
                  ),
                ),
                color: Colors.white,
              )),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(20.0),
                        elevation: 4.0,
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: IconButton(
                            onPressed: () async {
                              setState(() {
                                if (list!.contains(user!.id) &&
                                    list.contains(widget.animal.id)) {
                                  list.remove(user.id);
                                  list.remove(widget.animal.id);
                                  petsProvider.addPetToFavorites(
                                      user, widget.animal.id.toString(), list);
                                  toastMsg = 'Removed from Favorites';
                                } else {
                                  list.add(user.id);
                                  list.add(widget.animal.id);
                                  petsProvider.addPetToFavorites(
                                      user, widget.animal.id.toString(), list);
                                  toastMsg = 'Added to Favorites';
                                }
                              });
                              Fluttertoast.showToast(
                                  msg: toastMsg,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP);
                            },
                            icon: list!.contains(user!.id)
                                ? Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: sizeConfig.getProportionateScreenWidth(24),
                      ),
                      Expanded(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          onPressed: () async {
                            await launch(
                                "mailto:contact@jeeniso.com?subject=Order for ${widget.animal.name}&body=I want to order this product please :\n-Product Name : ${widget.animal.name}\n-Product Price : ${widget.animal.price}\n\n\n ${data.name}");
                          },
                          elevation: 4.0,
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'Order',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                height: sizeConfig.getProportionateScreenHeight(100),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          widget.animal.name,
                          style: TextStyle(
                            fontSize: 26.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeConfig.getProportionateScreenHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.animal.price,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeConfig.getProportionateScreenHeight(10),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.calendar,
                          color: Theme.of(context).primaryColor,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: sizeConfig.getProportionateScreenWidth(6),
                        ),
                        Text(
                          widget.animal.date.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: sizeConfig.getProportionateScreenHeight(150),
              ),
            ),
          )
        ],
      ),
    );
  }
}
