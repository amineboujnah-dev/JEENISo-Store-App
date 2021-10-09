class Product {
  String? id;
  String userID;
  String name;
  String price;
  String imageUrl;
  String? date;
  List? myFavorites;
  Product(
      {this.id,
      required this.userID,
      required this.name,
      required this.price,
      required this.imageUrl,
      this.date,
      this.myFavorites});
}
