import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/constants/drawer_configuration.dart';
import 'package:pets_app/core/models/product_model.dart';
import 'package:pets_app/ui/screens/menu/widgets/menu_icon_widget.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';
import 'package:provider/provider.dart';

import 'pet_card.dart';

class AnimalList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<AnimalList> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    final sizeConfig = SizeConfig();
    sizeConfig.init(context);

    return SingleChildScrollView(
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
                      FontAwesomeIcons.solidHeart,
                      color: primaryGreen,
                    ),
                    SizedBox(
                      width: sizeConfig.getProportionateScreenWidth(5),
                    ),
                    Text(
                      'Favorites',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            /*decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search),
                Text('Search pet'),
                Icon(Icons.settings)
              ],
            ),*/
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return AnimalCard(product: products[index]);
            },
          ),
        ],
      ),
    );
  }
}
