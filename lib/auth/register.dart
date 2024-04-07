import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectfirebase1/comp.dart/loginbutton.dart';
import 'package:projectfirebase1/comp.dart/logo.dart';
import 'package:projectfirebase1/comp.dart/textformfield.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  logo(),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    "SignUp",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Enter Your Personal Information",
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 158, 158, 158)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5),
                    child: Text(
                      "Username",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  customtextformfield(
                    mycontroller: usernamecontroller,
                    ocurrency: false,
                    hinttext: "  enter your name",
                    validator: (val) {
                      if (val == "") {
                        return "feild cannot be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5),
                    child: Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  customtextformfield(
                    mycontroller: emailcontroller,
                    ocurrency: false,
                    hinttext: "  enter your email",
                    validator: (val) {
                      if (val == "") {
                        return "feild cannot be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5),
                    child: Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  customtextformfield(
                    mycontroller: passwordcontroller,
                    ocurrency: true,
                    hinttext: "  enter your password",
                    validator: (val) {
                      if (val == "") {
                        return "feild cannot be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            custombutton(
              buttonName: "Register",
              onpressed: () async {
                if (formstate.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailcontroller.text,
                      password: passwordcontroller.text,
                    );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'weak-password',
                        desc: 'The password provided is too weak.',
                      ).show();
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'email-already-in-use',
                        desc: 'The account already exists for that email.',
                      ).show();
                    }
                  } catch (e) {
                    print(e);
                  }
                } else {
                  print("not vaild");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
