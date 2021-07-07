class User {
  late String uid;
  late String name;
  late String email;
  late String phoneNumber;
  late String address;
  late String password;

  User(this.uid, this.name, this.email, this.phoneNumber, this.address,
      this.password);

  Map<String, dynamic> toJson() => {
        'id': uid,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password
      };
}
