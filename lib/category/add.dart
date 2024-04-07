import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectfirebase1/comp.dart/textformfield.dart';

class addnewcategory extends StatefulWidget {
  const addnewcategory({super.key});

  @override
  State<addnewcategory> createState() => _addnewcategoryState();
}

class _addnewcategoryState extends State<addnewcategory> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
      bool isloading = false;
  addcategory() async {

    if (formstate.currentState!.validate()) {
      try {
        isloading = true;
        setState((){});
        DocumentReference response = await categories.add(
            {"name": name.text, "id": FirebaseAuth.instance.currentUser!.uid});
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (route) => false);
      } catch (e) {
        isloading = false;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: '$e',
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Category"),
      ),
      body: Form(
        key: formstate,
        child:isloading ? Center(child: CircularProgressIndicator(color: Colors.orange,),) :
         Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child: customtextformfield(
                hinttext: "Enter Name Of Category",
                mycontroller: name,
                validator: (val) {
                  if (val == "") {
                    return "field cannot be empty";
                  }
                },
                ocurrency: false,
              ),
            ),
            MaterialButton(
              onPressed: () {
                addcategory();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              color: Colors.black,
              child: Text(
                "  Add  ",
                style: TextStyle(color: Colors.orange),
              ),
            )
          ],
        ),
      ),
    );
  }
}
