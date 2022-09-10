import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rajagiri_connect/Screen/HomeScreen.dart';
import 'package:rajagiri_connect/Screen/MainReg.dart';
import 'package:rajagiri_connect/Screen/StudentReg.dart';
import 'package:rajagiri_connect/Screen/home2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  var userData = {};
  bool isLoading = false;
//Firebase
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Email

    final emailfield = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+.[a-z]")
            .hasMatch(value)) {
          return ("Please Enter a valid Rajagiri mail");
        }
        return null;
      },
      onSaved: (value) {
        emailcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(IconData(0xe043, fontFamily: 'MaterialIcons')),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "UID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          )),
    );

// Password

    final passwordfield = TextFormField(
      autofocus: false,
      controller: passwordcontroller,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter Password");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password (Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          )),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red[700],
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailcontroller.text, passwordcontroller.text);
        },
        child: Container(
          child: !isLoading
              ? Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              : const CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 5,
                ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            "lib/asset/logo.jpg",
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 45),
                      emailfield,
                      SizedBox(height: 5),
                      passwordfield,
                      SizedBox(height: 45),
                      loginButton,
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Choose(),
                                  ));
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            )),
      )),
    );
  }

  void signIn(String uid, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        await _auth
            .signInWithEmailAndPassword(email: uid, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                });
        User? user = _auth.currentUser!;
        var db = await FirebaseFirestore.instance
            .collection('student')
            .doc(user.uid)
            .get();
        userData = db.data()!;
        if (userData['role'] == 'user') {
          // Text('data');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => HomeScreen2())));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => HomeScreen())));
          // Text('hello');
        }
        setState(() {
          isLoading = false;
        });
        //   .catchError((e) {
        // Fluttertoast.showToast(msg: e!.message);
        // });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
