import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isSignedIn = false;

  checkSignInStatus() async{
    _auth.onAuthStateChanged.listen((user){
      if(user == null){
        Navigator.pushReplacementNamed(context, "/SignInPage");
      }
    });
  }

  getInfo() async{
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if(firebaseUser != null){
      setState(() {
        this.user = firebaseUser;
        this.isSignedIn = true;
      });
    }
  }

  signOut(){
    // Navigator.pushReplacementNamed(context, "/SignInPage");
    // or 
    _auth.signOut();
  }

  @override
  void initState(){
    super.initState();
    this.checkSignInStatus();
    this.getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body:Container(
        child: Center(
          child: isSignedIn
            ?Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Image(
                  image: AssetImage("assets/logo.png"),
                  width: 200.0,
                  height: 200.0,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 60.0),
                child: Text(
                  "Hello ${user.displayName}, You Are SignIn as ${user.email}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                ),
              ),
              ButtonTheme(
                height: 30.0,
                minWidth: 250.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.blue,
                  child: Text("Sign Out",
                    style: TextStyle(fontSize: 16.0,color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: signOut,
                ),
              ),
            ],
          )
         :CircularProgressIndicator(),
        ),
      ),
    );
  }
}