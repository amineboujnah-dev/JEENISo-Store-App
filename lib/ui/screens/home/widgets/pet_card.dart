import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/models/product_model.dart';
import 'package:pets_app/ui/screens/Products/Pet%20Details/view/pet_details_view.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';

class AnimalCard extends StatelessWidget {
  final Product product;
  AnimalCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PetDetailsView(
                      product: product,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 10.0,
          right: 20.0,
          left: 20.0,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: deviceWidth * 0.4,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                product.name,
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
                          Text(
                            product.price,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: sizeConfig.getProportionateScreenHeight(10),
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
                                width:
                                    sizeConfig.getProportionateScreenWidth(6),
                              ),
                              Text(
                                product.date.toString(),
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
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: sizeConfig.getProportionateScreenHeight(190),
                  width: deviceWidth * 0.4,
                ),
                Hero(
                    tag: product.name,
                    child: Image(
                      image: NetworkImage(product.imageUrl),
                      height: sizeConfig.getProportionateScreenHeight(220),
                      fit: BoxFit.fitHeight,
                      width: deviceWidth * 0.4,
                    )),
              ],
              alignment: Alignment.center,
            )
          ],
        ),
      ),
    );
  }
}
