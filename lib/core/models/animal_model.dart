class Animal {
  String name;
  String type;
  String age;
  String gender;
  String description;
  String imageUrl;
  String? date;
  Animal(
      {required this.name,
      required this.type,
      required this.age,
      required this.description,
      required this.gender,
      required this.imageUrl,
      this.date});
}
