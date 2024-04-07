import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectfirebase1/comp.dart/textformfield.dart';

class editcategory extends StatefulWidget {
  final String docid;
  final String oldname;
  const editcategory({super.key, required this.docid, required this.oldname});

  @override
  State<editcategory> createState() => _editcategoryState();
}

class _editcategoryState extends State<editcategory> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  bool isloading = false;

  editcategory() async {
    if (formstate.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        await categories.doc(widget.docid).update({"name": name.text});
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
  void initState() {
    super.initState();
    name.text = widget.oldname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Category"),
      ),
      body: Form(
        key: formstate,
        child: isloading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : Column(
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
                      editcategory();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.black,
                    child: Text(
                      "  save  ",
                      style: TextStyle(color: Colors.orange),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
