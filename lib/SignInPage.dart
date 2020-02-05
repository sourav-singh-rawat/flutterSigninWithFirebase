import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _form  =  GlobalKey<FormState>();

  // FirebaseUser user;
  String _email,_pass;

  checkCurrentUser() async{
    _auth.onAuthStateChanged.listen((user) async{
      if(user != null){
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  void signIn() async {
    if(_form.currentState.validate()){
      _form.currentState.save();
      try{
        FirebaseUser user = await _auth.signInWithEmailAndPassword(email: _email, password: _pass);
      } 
      catch(e){
        showError(e.message);
      }
    }
  }

  showError(String str) async{
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Error"),
          content: Text(str),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  toSignUp() async{
    Navigator.pushReplacementNamed(context, "/SignUpPage");
  }

  @override
  void initState(){
    super.initState();
    this.checkCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: Image(
                image: AssetImage("assets/logo.png"),
                width: 200.0,
                height: 200.0,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 5.0),
                      child: TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Provide Email";
                          }
                        },
                        decoration: InputDecoration(
                          focusColor: Colors.blue,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'Email',
                        ),
                        onSaved: (input){
                          _email = input;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                      child: TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Provide Password";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          focusColor: Colors.blue,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onSaved: (input) => _pass = input,
                      ),
                    ),
                    ButtonTheme(
                      // padding: EdgeInsets.only(bottom: 20.0),
                      height: 20.0,
                      minWidth: 200.0,
                      child:RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        elevation: 5.0,
                        child: Text("Sign In",
                          style: TextStyle(fontSize: 20.0,color: Colors.white),
                        ),
                        onPressed: signIn,
                        color: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    GestureDetector(
                      onTap: toSignUp,
                      child: Text("Create Account!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0,decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
      ),
      );
    }
}