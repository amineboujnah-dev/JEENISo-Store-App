import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/constants/login_and_register_constants.dart';
import 'package:pets_app/core/services/authentication_service.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;

  const Register({Key? key, required this.toggleScreen}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 60),
                  Text(
                    welcomeLabel.substring(0, 7),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    registerMsg,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !EmailValidator.validate(value)) {
                        return nullEmailMsg;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: emailHint,
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return nullPasswordMsg;
                      } else if (value.length < 6) {
                        return lengthPasswordMsg;
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: pwdHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print("Email : ${_emailController.text}");
                        print("Password : ${_passwordController.text}");
                        await loginProvider.register(
                            _emailController.text.trim(),
                            _passwordController.text.trim());
                      }
                    },
                    height: 70,
                    minWidth: loginProvider.isLoading ? null : double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: loginProvider.isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            registerLabel,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(existingAcc),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () => widget.toggleScreen(),
                        child: Text(loginLabel),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  /*if (loginProvider.errorMessage != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Text(loginProvider.errorMessage),
                        leading: Icon(Icons.error),
                        trailing: IconButton(
                          onPressed: () => loginProvider.setMessage(null),
                          icon: Icon(Icons.close),
                        ),
                      ),
                    ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
