/*final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser!.uid;
    String name = "";
    /* String email = "";
    String phoneNumber = "";
    String password = "";*/

    UserService userService = UserService(uid);
    final loginProvider = Provider.of<AuthService>(context);
    final loginWithGoogleprovider = Provider.of<GoogleSignProvider>(context);
    Future<void> getData() async {
      final userCollection = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot ds = await userCollection.doc(uid).get();

      name = ds.get('name');
      email = ds.get('email');
      password = ds.get('password');
      phoneNumber = ds.get('phoneNumber');
      print(name);*/