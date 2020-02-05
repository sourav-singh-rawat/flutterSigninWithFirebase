import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  String _name, _email, _pass;

  checkAuthentication() async{
    _auth.onAuthStateChanged.listen((user){
      if(user != null){
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  signInPage() async{
    Navigator.pushReplacementNamed(context, "/SignInPage");
  }

  void update() async{
    if(_form.currentState.validate()){
      _form.currentState.save();
      try{
        FirebaseUser user = await _auth.createUserWithEmailAndPassword(
          email: _email , password: _pass
        );
        if(user != null){
          UserUpdateInfo update = UserUpdateInfo();
          update.displayName = _name;

          user.updateProfile(update);
        }
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
            ),
          ],
        );
      }
    );
  }

  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage("assets/logo.png"),
                width: 200.0,
                height: 200.0,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Provide Name";
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: "Name",
                        ),
                        onSaved: (input) => _name= input,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                      child: TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Provide Email";
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: "Email",
                        ),
                        onSaved: (input) => _email= input,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 25.0),
                      child: TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Provide Password";
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: "Password",
                        ),
                        onSaved: (input) => _pass= input,
                      ),
                    ),
                    ButtonTheme(
                      height: 50.0,
                      minWidth: 300.0,
                      child: RaisedButton(
                        child: Text("Save",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25.0),
                        ),
                        onPressed: update,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: signInPage,
              child: Text("Sign In!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}