import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/constants/login_and_register_constants.dart';
import 'package:pets_app/core/providers/google_sign_in_provider.dart';
import 'package:pets_app/core/providers/authentication_provider.dart';
import 'package:pets_app/ui/ui_utils/config_setup/config.dart';
import 'package:pets_app/ui/ui_utils/values/styles.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function toggleScreen;

  Login(this.toggleScreen);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  late SizeConfig p;
  bool _isObscure = true;

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

    final loginwithGoogleProvider = Provider.of<GoogleSignProvider>(context);
    final p = new SizeConfig();
    p.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: p.getProportionateScreenHeight(60)),
                  Text(
                    welcomeLabel,
                    style: welcomeLabelStyle,
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(10)),
                  Text(
                    signInLabel,
                    style: authMsgslStyle,
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(30)),
                  SizedBox(height: p.getProportionateScreenHeight(30)),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  SizedBox(height: p.getProportionateScreenHeight(30)),
                  TextFormField(
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return nullPasswordMsg;
                      } else if (value.length < 6) {
                        return lengthPasswordMsg;
                      }
                      return null;
                    },
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: pwdHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                    ),
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(30)),
                  MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print("Email : ${_emailController.text}");
                        print("Password : ${_passwordController.text}");
                        await loginProvider.login(_emailController.text.trim(),
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
                        ? Center(
                            widthFactor: 3,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          )
                        : Text(
                            loginLabel,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  //SizedBox(height: 30),
                  /*MaterialButton(
                    onPressed: () {
                      loginwithGoogleProvider.googleLogin();
                    },
                    height: p.getProportionateScreenHeight(70),
                    minWidth: loginProvider.isLoading ? null : double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      signInWithGoogle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),*/
                  SizedBox(height: p.getProportionateScreenHeight(20)),
                  Text(
                    '- OR -',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(10)),
                  Text(
                    'Sign in with',
                    style: authMsgslStyle,
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(20)),
                  GestureDetector(
                    onTap: () {
                      loginwithGoogleProvider.googleLogin();
                    },
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/google.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(missingAccLabel),
                      SizedBox(width: p.getProportionateScreenWidth(5)),
                      TextButton(
                        onPressed: () => widget.toggleScreen(),
                        child: Text(registerLabel),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
