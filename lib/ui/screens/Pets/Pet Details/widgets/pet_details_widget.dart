import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/core/providers/menu_provider.dart';
import 'package:pets_app/core/services/pets_service.dart';
import 'package:pets_app/ui/screens/Pets/Add%20Pet/view/add_pet_view.dart';
import 'package:pets_app/ui/screens/menu/view/menu_view.dart';
import 'package:pets_app/ui/screens/menu/view/menu_view2.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetailsWidget extends StatefulWidget {
  final Animal animal;
  PetDetailsWidget({required this.animal});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<PetDetailsWidget> {
  String toastMsg = "";

  share(BuildContext context, Animal animal) {
    final RenderBox box = context.findRenderObject() as RenderBox;

    Share.share(
        "Pet Name : ${animal.name}\nPet Type : ${animal.type}\nPet Age  : ${animal.age}\nPet Description :${animal.description}\nImage : ${animal.imageUrl}\n\nBy Adopt Me App",
        subject: "Informations about ${animal.name}",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final data = Provider.of<UserData>(context);
    final user = Provider.of<UserModel?>(context);
    final sizeConfig = SizeConfig();
    sizeConfig.init(context);
    final petsProvider = PetsService();
    final List? list = widget.animal.myFavorites;

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Delete ${widget.animal.name} ')),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Are you sure to delete ${widget.animal.name} ?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: sizeConfig.getProportionateScreenWidth(40),
              ),
              TextButton(
                child: Text('Confirm'),
                onPressed: () async {
                  print('Confirmed');
                  PetsService petsService = PetsService();
                  petsService.deletePet(
                      widget.animal.userID, widget.animal.id.toString());
                  menuProvider.setMenuIndex(1);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => MenuView()));
                },
              ),
              SizedBox(
                width: sizeConfig.getProportionateScreenWidth(30),
              ),
            ],
          );
        },
      );
    }

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
                              InkWell(
                                onTap: () async {
                                  await share(context, widget.animal);
                                },
                                child: Icon(FontAwesomeIcons.share,
                                    color: Theme.of(context).primaryColor),
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
                    child: widget.animal.imageUrl != ""
                        ? Image(
                            image: NetworkImage(widget.animal.imageUrl),
                            fit: BoxFit.fitHeight,
                          )
                        : Image(
                            image:
                                AssetImage('assets/images/adopt_me_logo.png'),
                            fit: BoxFit.fitHeight,
                          ),
                  ),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 22.0,
                            backgroundImage: NetworkImage(data.imageUrl),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.animal.date.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: sizeConfig
                                      .getProportionateScreenHeight(8),
                                ),
                                Text(
                                  'Owner',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizeConfig.getProportionateScreenHeight(20),
                      ),
                      Text(
                        widget.animal.description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              )),
              widget.animal.userID != user!.id
                  ? Container(
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
                                      if (list!.contains(user.id) &&
                                          list.contains(widget.animal.id)) {
                                        list.remove(user.id);
                                        list.remove(widget.animal.id);
                                        petsProvider.addPetToFavorites(user,
                                            widget.animal.id.toString(), list);
                                        toastMsg = 'Removed from Favorites';
                                      } else {
                                        list.add(user.id);
                                        list.add(widget.animal.id);
                                        petsProvider.addPetToFavorites(user,
                                            widget.animal.id.toString(), list);
                                        toastMsg = 'Added to Favorites';
                                      }
                                    });
                                    Fluttertoast.showToast(
                                        msg: toastMsg,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP);
                                  },
                                  icon: list!.contains(user.id)
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
                                  await launch("tel://+216${data.phoneNumber}");
                                },
                                elevation: 4.0,
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'Contact',
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
                  : Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(20.0),
                              elevation: 4.0,
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(7),
                                child: IconButton(
                                  onPressed: () async {
                                    _showMyDialog();
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.trash,
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
                                onPressed: () {
                                  menuProvider.setMenuIndex(2);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          StreamProvider<Animal>.value(
                                        value: PetsService().getAnimal(
                                            user.id, widget.animal.id),
                                        initialData: Animal(
                                            id: widget.animal.id,
                                            userID: widget.animal.userID,
                                            name: widget.animal.name,
                                            type: widget.animal.type,
                                            age: widget.animal.age,
                                            description:
                                                widget.animal.description,
                                            gender: widget.animal.gender,
                                            imageUrl: widget.animal.imageUrl),
                                        child: MenuView2(),
                                      ),
                                    ),
                                  );
                                },
                                elevation: 4.0,
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'Update',
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
                        Icon(
                          widget.animal.gender == 'Female'
                              ? FontAwesomeIcons.venus
                              : FontAwesomeIcons.mars,
                          color: Colors.grey,
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
                          widget.animal.type,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.animal.age} years old',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeConfig.getProportionateScreenHeight(2.5),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Theme.of(context).primaryColor,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: sizeConfig.getProportionateScreenWidth(6),
                        ),
                        Text(
                          data.address,
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
