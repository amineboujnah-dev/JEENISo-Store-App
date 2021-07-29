class Animal {
  String? id;
  String userID;
  String name;
  String type;
  String age;
  String gender;
  String description;
  String imageUrl;
  String? date;
  List? myFavorites;
  Animal(
      {this.id,
      required this.userID,
      required this.name,
      required this.type,
      required this.age,
      required this.description,
      required this.gender,
      required this.imageUrl,
      this.date,
      this.myFavorites});
}
