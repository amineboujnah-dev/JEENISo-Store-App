import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/constants/login_and_register_constants.dart';
import 'package:pets_app/core/providers/authentication_provider.dart';
import 'package:pets_app/ui/screens/Authentication/widgets/login_widget.dart';
import 'package:pets_app/ui/ui_utils/config_setup/config.dart';
import 'package:pets_app/ui/ui_utils/values/styles.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
  late TextEditingController _confirmPasswordController;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void initState() {
    _confirmPasswordController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
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
                  if (loginProvider.errorMessage != "")
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Text(loginProvider.errorMessage),
                        leading: Icon(Icons.error),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              loginProvider.setMessage("");
                            });
                          },
                          icon: Icon(Icons.close),
                        ),
                      ),
                    ),
                  SizedBox(height: p.getProportionateScreenHeight(60)),
                  Text(
                    welcomeLabel.substring(0, 7),
                    style: welcomeLabelStyle,
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(10)),
                  Text(
                    registerMsg,
                    style: authMsgslStyle,
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(30)),
                  /*TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return nullNameMsg;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),*/
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
                  //SizedBox(height: p.getProportionateScreenHeight(30)),
                  /*TextFormField(
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return nullPhoneMsg;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: PhoneHint,
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),*/
                  SizedBox(height: p.getProportionateScreenHeight(30)),
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
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
                  TextFormField(
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value != _passwordController.text.trim()) {
                        return differentPasswordMsg;
                      }
                      return null;
                    },
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: confirmPasswordHint,
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
                        ? Center(
                            widthFactor: 3,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          )
                        : Text(
                            registerLabel,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: p.getProportionateScreenHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(existingAcc),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => Login()));
                          });
                        },
                        child: Text(loginLabel),
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
