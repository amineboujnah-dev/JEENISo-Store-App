import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/constants/login_and_register_constants.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/providers/pets_provider.dart';
import 'package:pets_app/core/services/user_service.dart';
import 'package:pets_app/ui/screens/Pets/Add%20Pet/view/add_pet_view.dart';
import 'package:pets_app/ui/screens/Pets/My%20pets/view/my_pets_view.dart';
import 'package:pets_app/ui/screens/menu/widgets/menu_icon_widget.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';
import 'package:provider/provider.dart';

import 'button_widget.dart';

class AddPetWidget extends StatefulWidget {
  const AddPetWidget({Key? key}) : super(key: key);

  @override
  _AddPetWidgetState createState() => _AddPetWidgetState();
}

class _AddPetWidgetState extends State<AddPetWidget> {
  String dropdownValue = 'Male';
  String imageLabel = 'No image selected';
  String imageUrl = "";
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _typeController;
  late TextEditingController _descriptionController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _typeController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    UserService userService = UserService(uid: currentUser!.uid);
    final petsProvider = Provider.of<PetsProvider>(context);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  MenuIconWidget(),
                  /*Column(
                    children: [
                      Text('Address'),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryGreen,
                          ),
                          Text('Tunisia'),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24.0,
                    backgroundImage:
                        AssetImage('assets/images/adopt_me_logo.png'),
                  ),*/
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
                                controller: _nameController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
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
                                controller: _ageController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
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
                                  hintText: dropdownValue,
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
                                                    dropdownValue = 'Male';
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.female),
                                                title: Text('Female'),
                                                onTap: () {
                                                  setState(() {
                                                    dropdownValue = 'Female';
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
                                controller: _typeController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
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
                                imageLabel = userService.fileName;
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
                          child: Text(
                            imageLabel,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
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
                      controller: _descriptionController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
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
                            _formKey.currentState!.reset();
                            setState(() {
                              dropdownValue = 'Male';
                              imageLabel = 'No image selected';
                            });
                          },
                          child: Text("RESET",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final Future<Animal> addResponse =
                                  petsProvider.addPet(
                                      _nameController.text.trim(),
                                      double.parse(_ageController.text),
                                      dropdownValue,
                                      _typeController.text.trim(),
                                      imageUrl,
                                      _descriptionController.text.trim());
                              if (addResponse != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MyPetsView()));
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
