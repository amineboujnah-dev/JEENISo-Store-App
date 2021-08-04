import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/constants/drawer_configuration.dart';
import 'package:pets_app/core/constants/login_and_register_constants.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/core/providers/menu_provider.dart';
import 'package:pets_app/core/services/pets_service.dart';
import 'package:pets_app/core/services/user_service.dart';
import 'package:pets_app/ui/screens/menu/view/menu_view.dart';
import 'package:pets_app/ui/screens/menu/widgets/menu_icon_widget.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';
import 'package:provider/provider.dart';

import 'button_widget.dart';

class AddPet2 extends StatefulWidget {
  @override
  _AddPetWidgetState createState() => _AddPetWidgetState();
}

class _AddPetWidgetState extends State<AddPet2> {
  late Animal animal;
  late String _currentGender;

  @override
  void initState() {
    animal = Provider.of<Animal>(context, listen: false);
    _currentGender = animal.gender;
    print(animal.id);
    super.initState();
  }

  String _currentName = "";
  String _currentAge = "";
  String _currentType = "";
  String _currentImageUrl = "";
  String _currentDescription = "";
  String dropdownValue = 'Male';
  String imageLabel = 'No image selected';
  String imageUrl = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final menuProvider = Provider.of<MenuProvider>(context);
    UserService userService = UserService(uid: user!.id);
    final petsService = PetsService();
    final sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: sizeConfig.getProportionateScreenHeight(50),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  MenuIconWidget(),
                  SizedBox(
                    width: sizeConfig.getProportionateScreenWidth(100),
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.edit,
                        color: primaryGreen,
                      ),
                      SizedBox(
                        width: sizeConfig.getProportionateScreenWidth(5),
                      ),
                      Text(
                        'Update pet',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: sizeConfig.getProportionateScreenHeight(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                  height: sizeConfig
                                      .getProportionateScreenHeight(15)),
                              TextFormField(
                                initialValue: animal.name,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onChanged: (val) {
                                  setState(() => _currentName = val);
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return nullNameMsg;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: sizeConfig.getProportionateScreenWidth(10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Age',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                  height: sizeConfig
                                      .getProportionateScreenHeight(8)),
                              TextFormField(
                                initialValue: animal.age,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (val) {
                                  setState(() => _currentAge = val);
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return nullAgeMsg;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: sizeConfig.getProportionateScreenHeight(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                  height: sizeConfig
                                      .getProportionateScreenHeight(8)),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500),
                                  hintText: _currentGender,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        Icons.arrow_drop_down_circle_rounded),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading: Icon(Icons.male),
                                                title: Text('Male'),
                                                onTap: () {
                                                  setState(() {
                                                    _currentGender = 'Male';
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.female),
                                                title: Text('Female'),
                                                onTap: () {
                                                  setState(() {
                                                    _currentGender = 'Female';
                                                  });

                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: sizeConfig.getProportionateScreenWidth(10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                  height: sizeConfig
                                      .getProportionateScreenHeight(8)),
                              TextFormField(
                                initialValue: animal.type,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onChanged: (val) {
                                  setState(() => _currentType = val);
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return nullTypeMsg;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: sizeConfig.getProportionateScreenHeight(24)),
                    Text(
                      "Image",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                        height: sizeConfig.getProportionateScreenHeight(8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            text: 'Select File',
                            icon: Icons.upload,
                            onClicked: () async {
                              await userService.uploadImage();
                              setState(() {
                                imageUrl = userService.url;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: sizeConfig.getProportionateScreenWidth(10),
                        ),
                        Expanded(
                          flex: 1,
                          child: imageUrl != ""
                              ? Container(
                                  height: sizeConfig
                                      .getProportionateScreenHeight(70),
                                  child: Image(
                                    image: NetworkImage(imageUrl),
                                  ),
                                )
                              : Text(imageLabel),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: sizeConfig.getProportionateScreenHeight(24)),
                    Text(
                      'About',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                        height: sizeConfig.getProportionateScreenHeight(8)),
                    TextFormField(
                      initialValue: animal.description,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        setState(() => _currentDescription = val);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return nullAboutMsg;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizeConfig.getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            menuProvider.setMenuIndex(1);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => MenuView()));
                          },
                          child: Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final Future<Animal> addResponse =
                                  petsService.updatePetData(
                                      animal.userID,
                                      animal.id,
                                      _currentName.isEmpty
                                          ? animal.name
                                          : _currentName,
                                      _currentAge.isEmpty
                                          ? animal.age
                                          : _currentAge,
                                      _currentGender.isEmpty
                                          ? animal.gender
                                          : _currentGender,
                                      _currentType.isEmpty
                                          ? animal.type
                                          : _currentType,
                                      imageUrl.isEmpty
                                          ? animal.imageUrl
                                          : imageUrl,
                                      _currentDescription.isEmpty
                                          ? animal.description
                                          : _currentDescription);
                              if (addResponse != null) {
                                menuProvider.setMenuIndex(1);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MenuView()));
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
