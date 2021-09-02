
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemoapp/Authenctication/Method.dart';
import 'package:flutterdemoapp/bloc/register_bloc.dart';
import 'package:flutterdemoapp/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Color(0xffc2e0f9),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                StreamBuilder<Object>(
                    stream: bloc.name,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.text,
                        controller: _name,
                        decoration: InputDecoration(
                          hintText: "Enter Name",
                          labelText: "Name",
                          errorText: snapshot.error?.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => bloc.changeName(value),
                      );
                    }),
                SizedBox(height: 30),
                StreamBuilder<Object>(
                    stream: bloc.emailId,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelText: "Email",
                          errorText: snapshot.error?.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: bloc.changeEmailId,
                      );
                    }),
                SizedBox(height: 30),
                StreamBuilder<Object>(
                    stream: bloc.phoneNumber,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Enter Phone number",
                          labelText: "phone number",
                          errorText: snapshot.error?.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: bloc.changePhoneNumber,
                      );
                    }),
                SizedBox(height: 30),
                StreamBuilder<Object>(
                    stream: bloc.password,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _password,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "password",
                          errorText: snapshot.error?.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: bloc.changePassword,
                      );
                    }),
                SizedBox(height: 30),
                StreamBuilder<Object>(
                    stream: bloc.confirmPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          labelText: "confirm pasword",
                          errorText: snapshot.error?.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: isVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: bloc.changeConfirmPassword,
                      );
                    }),
                SizedBox(height: 30),
                _buildButton(),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    WidgetSpan(child: SizedBox(width: 5)),
                    TextSpan(
                        text: "Login here",
                        style: TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                          })
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return StreamBuilder<Object>(
        stream: bloc.isValid,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
                setState(() {
                  isLoading = true;
                });
                createAccount(_name.text, _email.text,_phone.text, _password.text).then((user) {
                  if (user != null) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                    print("Account Created Sucessfull");
                  } else {
                    print("Login Failed");
                    setState(() {
                      isLoading = false;
                    });
                  }
                });


                  },
            child: Container(
              height: 40,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: snapshot.hasError || !snapshot.hasData
                    ? Colors.grey
                    : Color(0xffff69b4),
              ),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
          );
        });
  }
}
