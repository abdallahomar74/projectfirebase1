import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectfirebase1/category/edit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;
  getdata() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () {
            Navigator.of(context).pushNamed("addcategory");
          },
          child: Icon(Icons.add, color: Colors.orange),
          backgroundColor: Colors.black,
        ),
        appBar: AppBar(
          title: Text(
            'Home',
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('login', (route) => false);
                },
                icon: Icon(
                  Icons.logout_rounded,
                ))
          ],
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(color: Colors.orange),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 150,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Remove',
                              desc:
                                  'are you sure you want to Edit category name ${data[index]['name']}?',
                              btnOkOnPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => editcategory(
                                        docid: data[index].id , oldname: data[index]['name'])));
                              },
                              btnCancelOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection("categories")
                                    .doc(data[index].id)
                                    .delete();
                                Navigator.of(context)
                                    .pushReplacementNamed("homepage");
                              },
                              btnCancelText: "delete",
                              btnOkText: "Edit")
                          .show();
                    },
                    child: Card(
                      color: Color(0xffeef0f2),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                                height: 110,
                                child: Image.asset(
                                  "assets/folder.png",
                                  fit: BoxFit.fill,
                                )),
                            Text(
                              data[index]['name'],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
