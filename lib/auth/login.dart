import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectfirebase1/comp.dart/loginbutton.dart';
import 'package:projectfirebase1/comp.dart/logo.dart';
import 'package:projectfirebase1/comp.dart/textformfield.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isloading = false;

  Future signInWithGoogle() async {
    isloading = true;
    setState(() {
    });
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
     isloading = false;
    setState(() {
      
    });
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(color: Colors.orange ),
            )
          : Container(
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
                          "Login",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "login to continue using the app",
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    const Color.fromARGB(255, 158, 158, 158)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                        InkWell(
                          onTap: () async {
                            if (emailcontroller.text == "") {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Error!',
                                desc: 'Please enter your email then try again',
                              ).show();
                              return;
                            }
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: emailcontroller.text);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Password Reset',
                                desc:
                                    'The password reset message has been sent to your email.',
                              ).show();
                            } catch (e) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'There is no email with this name.',
                                desc: 'Please verify the email you entered.',
                              ).show();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 7),
                            alignment: Alignment.topRight,
                            child: const Text(
                              "Forget Password ?",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  ),
                  custombutton(
                    buttonName: "Login",
                    onpressed: () async {
                      if (formstate.currentState!.validate()) {
                        try {
                          isloading = true;
                          setState(() {});
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                          isloading = false;
                          setState(() {});
                          if (credential.user!.emailVerified) {
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Email Verification',
                              desc: 'please go to mail and verify your email',
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                           isloading = false;
                          setState(() {});
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc:
                                'Please verify the correctness of the email or password.',
                          ).show();
                        }
                      } else {
                        print("Not Vaild");
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                      onPressed: () {
                        signInWithGoogle();
                      },
                      height: 45,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Color.fromARGB(255, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Login With Google',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Image.asset(
                            "assets/4.png",
                            width: 20,
                          )
                        ],
                      )),
                  SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("signup");
                      },
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "dont have an account?  ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        TextSpan(
                            text: "Register",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w700))
                      ])),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
