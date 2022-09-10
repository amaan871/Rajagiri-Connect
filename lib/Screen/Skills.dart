import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rajagiri_connect/Screen/HomeScreen.dart';
import 'package:rajagiri_connect/Screen/home2.dart';
import 'package:rajagiri_connect/model/skill_model.dart' as model;
import 'package:snippet_coder_utils/FormHelper.dart';

class Skill extends StatefulWidget {
  const Skill({Key? key}) : super(key: key);

  @override
  State<Skill> createState() => _SkillState();
}

class _SkillState extends State<Skill> {
  final _auth = FirebaseAuth.instance;

  List<dynamic> countries = [];
  List<dynamic> semester = [];
  List<dynamic> statesMasters = [];
  List<dynamic> states = [];
  List<dynamic> skill = [];

  String? countryId;
  String? stateId;
  String? semesterId;
  String? skillId;
  String? sem;

  @override
  void initState() {
    super.initState();
    this.semester.add({"Id": 1, "Label": "Semester 1"});
    this.semester.add({"Id": 2, "Label": "Semester 2"});
    this.semester.add({"Id": 3, "Label": "Semester 3"});
    this.semester.add({"Id": 4, "Label": "Semester 4"});
    this.semester.add({"Id": 5, "Label": "Semester 5"});
    this.semester.add({"Id": 6, "Label": "Semester 6"});
    this.semester.add({"Id": 7, "Label": "Semester 7"});
    this.semester.add({"Id": 8, "Label": "Semester 8"});

    this.countries.add({"id": 1, "label": "CSE"});
    this.countries.add({"id": 2, "label": "ECE"});
    this.countries.add({"id": 3, "label": "AEI"});
    this.countries.add({"id": 4, "label": "MECH"});
    this.countries.add({"id": 5, "label": "IT"});
    this.countries.add({"id": 6, "label": "EEE"});
    this.countries.add({"id": 7, "label": "CIVIL"});
    this.countries.add({"id": 8, "label": "CSBS"});
    this.countries.add({"id": 9, "label": "AIDS"});

    this.skill.add({"iD": 1, "LabeL": "Sports"});

    this.statesMasters = [
      {"ID": 1, "Name": "ALPHA", "ParentId": 4},
      {"ID": 2, "Name": "BETA", "ParentId": 4},
      {"ID": 1, "Name": "ALPHA", "ParentId": 2},
      {"ID": 2, "Name": "BETA", "ParentId": 2},
      {"ID": 3, "Name": "GAMMA", "ParentId": 2},
      {"ID": 1, "Name": "ALPHA", "ParentId": 1},
      {"ID": 2, "Name": "BETA", "ParentId": 1},
      {"ID": 3, "Name": "GAMMA", "ParentId": 1},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final SignButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(40),
      color: Colors.red[700],
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn();
        },
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
                padding: EdgeInsets.all(36.0),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 120,
                        child: Image.asset(
                          "lib/asset/logo.jpg",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 35),
                    Text(
                      "CLASS DETAILS",
                      style: TextStyle(
                          color: Color.fromARGB(255, 79, 74, 74),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                        width: 800.0,
                        child: FormHelper.dropDownWidget(
                            context,
                            "Select Semester",
                            this.semesterId,
                            this.semester, (onChangedVal) {
                          this.semesterId = onChangedVal;
                          print("Selected Semester : $onChangedVal");
                          sem = onChangedVal;
                        }, (onValidateVal) {
                          if (onValidateVal == null) {
                            return 'Please Select Semester';
                          }
                          setState(() {});
                          return null;
                        },
                            borderColor: Theme.of(context).primaryColor,
                            borderFocusColor: Theme.of(context).primaryColor,
                            borderRadius: 40,
                            optionValue: "Id",
                            optionLabel: "Label",
                            paddingLeft: 0.0,
                            paddingRight: 0.0)),
                    SizedBox(height: 5),
                    SizedBox(
                        width: 800.0,
                        child: FormHelper.dropDownWidget(
                            context,
                            "Select Branch",
                            this.countryId,
                            this.countries, (onChangedVal) {
                          this.countryId = onChangedVal;
                          print("Selected Branch : $onChangedVal");

                          this.states = this
                              .statesMasters
                              .where(
                                (stateItem) =>
                                    stateItem["ParentId"].toString() ==
                                    onChangedVal.toString(),
                              )
                              .toList();
                          this.stateId = null;
                        }, (onValidateVal) {
                          if (onValidateVal == null) {
                            return 'Please Select Branch';
                          }
                          setState(() {});
                          return null;
                        },
                            borderColor: Theme.of(context).primaryColor,
                            borderFocusColor: Theme.of(context).primaryColor,
                            borderRadius: 40,
                            optionValue: "id",
                            optionLabel: "label",
                            paddingLeft: 0.0,
                            paddingRight: 0.0)),
                    SizedBox(height: 5),
                    FormHelper.dropDownWidget(
                        context, "Select Division", this.stateId, this.states,
                        (onChangedVal) {
                      this.stateId = onChangedVal;
                      print("Selected Division : $onChangedVal");
                    }, (onValidate) {
                      return null;
                    },
                        borderColor: Theme.of(context).primaryColor,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderRadius: 40,
                        optionValue: "ID",
                        optionLabel: "Name",
                        paddingLeft: 0.0,
                        paddingRight: 0.0),
                    SizedBox(height: 25),
                    // Text(
                    //   "SKILLS AND INTERESTS",
                    //   style: TextStyle(
                    //       color: Color.fromARGB(255, 78, 73, 73),
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(height: 10),
                    // SizedBox(
                    //     width: 800.0,
                    //     child: FormHelper.dropDownWidget(
                    //         context, "Select Skill", this.skillId, this.skill,
                    //         (onChangedVal) {
                    //       this.skillId = onChangedVal;
                    //       print("Selected Semester : $onChangedVal");
                    //     }, (onValidateVal) {
                    //       if (onValidateVal == null) {
                    //         return 'Please Select Skill';
                    //       }
                    //       return null;
                    //     },
                    //         borderColor: Theme.of(context).primaryColor,
                    //         borderFocusColor: Theme.of(context).primaryColor,
                    //         borderRadius: 40,
                    //         optionValue: "iD",
                    //         optionLabel: "LabeL",
                    //         paddingLeft: 0.0,
                    //         paddingRight: 0.0)),
                    SizedBox(height: 25),
                    SignButton,
                  ],
                ))),
          )),
        ));
  }

  void signIn() async {
    User? user = _auth.currentUser;
    model.SkillModel skillModel =
        model.SkillModel(Class: countryId, sem: sem, Division: stateId);

    var db = FirebaseFirestore.instance.collection("student");

    await db.doc(user?.uid).collection("class").add(skillModel.toJson());

    Fluttertoast.showToast(msg: "Account created Successfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen2()),
        (route) => false);
  }
}
