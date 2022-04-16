import 'package:bunlungthong/models/user_model.dart';
import 'package:bunlungthong/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  UserModel profile = UserModel();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  bool statusRedEye = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Error", style: TextStyle(fontSize: 36)), 
              backgroundColor: Colors.red,
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    children: [
                      Container(
                        child: Image.asset('assets/img/logo-no-bg.png'),
                        width: 200,
                        height: 200,
                        margin: const EdgeInsets.only(top: 20, bottom: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            child: Text("Login", style: GoogleFonts.ubuntu(fontSize: 30, decoration: TextDecoration.underline, fontWeight: FontWeight.w600),),
                            tag: 'login'
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      emailFormFeild(),
                      const SizedBox(height: 15),
                      passwordFormFeild(),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          child: Center(
                            child: Text("Login", style: GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.w600)),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              print("Sign In");
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: profile.email!, 
                                password: profile.password!
                              );
                              checkUser(profile.email!, profile.password!);
                              formKey.currentState!.reset();
                            }
                          },
                        ),
                      )
                      // idFormFeild(),
                    ],
                  ),
                ),
              ),
            ),
            
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
    }

  TextFormField nameFormFeild() {
    return TextFormField(
      validator: RequiredValidator(errorText: 'กรุณากรอกชื่อด้วยครับ'),
      onSaved: (String? name) {
        profile.name = name;
      },
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'โปรดกรอกชื่อจริง ไม่ต้องใส่คำนำหน้าชื่อ',
        icon: const Icon(Icons.person, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  TextFormField emailFormFeild() {
    return TextFormField(
      validator: MultiValidator([
        EmailValidator(errorText: 'รูปแบบอีเมลไม่ถูกต้อง'),
        RequiredValidator(errorText: 'กรุณากรอกอีเมลด้วยครับ')
      ]),
      onSaved: (String? email) {
        profile.email = email;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'โปรดกรอก Email ของท่าน',
        icon: const Icon(Icons.email, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  TextFormField passwordFormFeild() {
    return TextFormField(
      validator: RequiredValidator(errorText: 'กรุณากรอกรหัสผ่านด้วยครับ'),
      onSaved: (String? password) {
        profile.password = password;
      },
      obscureText: statusRedEye,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'โปรดกรอกรหัสผ่านของท่าน',
        icon: const Icon(Icons.lock, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              statusRedEye = !statusRedEye;
              print("status : $statusRedEye");
            });
          }, 
          icon: statusRedEye ? const Icon(Icons.remove_red_eye_outlined, size: 28, color: Colors.black) : const Icon(Icons.remove_red_eye, size: 28, color: Colors.blue),
        ),
      ),
    );
  }

  TextFormField idFormFeild() {
    return TextFormField(
      validator: RequiredValidator(errorText: 'กรุณากรอกเลขบัตรประชาชนด้วยครับ'),
      onSaved: (String? id) {
        profile.id = id;
      },
      decoration: InputDecoration(
        labelText: 'เลขบัตรประชาชน 13 หลัก',
        hintText: 'โปรดกรอกเลขบัตรประชาชน 13 หลักของท่าน',
        icon: const Icon(Icons.lock_outline, color: Colors.black),
        labelStyle: GoogleFonts.kanit(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  Future<void>? checkUser(String email, String password) {
    final auth = FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    auth.then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false));

  }
}

