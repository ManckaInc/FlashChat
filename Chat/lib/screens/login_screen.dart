import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class LoginScreen extends StatefulWidget {

  static const String id = 'Login_Screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                    email = value;
                  //Do something with the user input.
                },
                decoration: kInputDecorationTextField.copyWith(hintText: 'Enter your email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                    password = value;
                  //Do something with the user input.
                },
                decoration: kInputDecorationTextField.copyWith(hintText: 'Enter your password')
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(title: 'Log In', colour: Colors.lightBlueAccent,onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try{
                  final regUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(regUser != null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                }
                catch (e){
                  print(e);
                }

                // Navigator.pop(context, ChatScreen.id);
                //Implement login functionality.
              },),
            ],
          ),
        ),
      ),
    );
  }
}
