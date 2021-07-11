class UserModel {
  late String uid;

  UserModel(this.uid);
}

class UserData {
  final String uid;
  final String name;
  final String phoneNumber;
  final String address;
  final String imageUrl;

  UserData(this.uid, this.name, this.phoneNumber, this.address, this.imageUrl);

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'address': address,
        'imagePath': imageUrl
      };
}
