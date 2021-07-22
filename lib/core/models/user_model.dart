class UserModel {
  late String id;

  UserModel(this.id);
}

class UserData {
  final String id;
  final String name;
  final String phoneNumber;
  final String address;
  final String imageUrl;

  UserData(this.id, this.name, this.phoneNumber, this.address, this.imageUrl);
}
