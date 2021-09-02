import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemoapp/Authenctication/Method.dart';
import 'package:flutterdemoapp/bloc/login_bloc.dart';
import 'package:flutterdemoapp/screens/home_screen.dart';
import 'package:flutterdemoapp/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Color(0xffc2e0f9),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                StreamBuilder<String>(
                  stream: bloc.loginEmail,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        errorText: snapshot.error?.toString(),
                        hintText: "Enter email",
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: bloc.changeloginEmail,
                    );
                  },
                ),
                SizedBox(height: 30),
                StreamBuilder<String>(
                    stream: bloc.loginPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          labelText: "Password",
                          errorText: snapshot.error?.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: bloc.changeLoginPassword,
                      );
                    }),
                SizedBox(height: 30),
                _buildButton(),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Need an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    WidgetSpan(child: SizedBox(width: 5)),
                    TextSpan(
                        text: "Register here",
                        style: TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
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
    final bloc = Provider.of<LoginBloc>(context, listen: false);

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
              logIn(_email.text, _password.text).then((user) {
                if (user != null) {
                  // saveValue(user.displayName,user.email);
                  print("Login Sucessfull");
                  setState(() {
                    isLoading = false;
                  });
                  String? username=user.displayName;
                  String? useremail=user.email;
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
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
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
          );
        });
  }
  saveValue(String? name,String? email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name!);
    prefs.setString('email', email!);
  }
}

