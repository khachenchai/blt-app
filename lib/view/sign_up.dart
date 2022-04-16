import 'package:bunlungthong/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  UserModel profile = UserModel();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  bool statusRedEye = true;
  // final CollectionReference _userProfileCollection = FirebaseFirestore.instance.collection("users");


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
                            child: Text("Sign Up", style: GoogleFonts.ubuntu(fontSize: 30, decoration: TextDecoration.underline, fontWeight: FontWeight.w600),),
                            tag: 'Sign-Up'
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      nameFormFeild(),
                      const SizedBox(height: 15),
                      emailFormFeild(),
                      const SizedBox(height: 15),
                      passwordFormFeild(),
                      const SizedBox(height: 15),
                      idFormFeild(),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, size: 36, color: Colors.black,),
              backgroundColor: const Color.fromARGB(255, 255, 198, 112),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  
                  final user_config = UserModel(
                    email: profile.email,
                    id: profile.id,
                    name: profile.name,
                    password: profile.password
                  );
                  print("email = ${profile.email}, password = ${profile.password}");
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: profile.email!, 
                    password: profile.password!)
                  .then((res) => createUser(user_config, res.user?.uid))
                  .catchError((e) {
                    if (e.code == 'week-password') {
                      print("To Weak Password");
                    } else if (e.code == 'email-already-in-use') {
                      print("Ready");
                    }
                  });

                  formKey.currentState!.reset();
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Sign Up สำเร็จแล้ว",
                              style: GoogleFonts.kanit(fontSize: 25)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green.shade300)),
                            ),
                          ],
                        )
                      );
                }
              }
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
          icon: statusRedEye ? const Icon(Icons.remove_red_eye_outlined, color: Colors.black, size: 28) : const Icon(Icons.remove_red_eye, color: Colors.blue, size: 28),
          onPressed: () {
            setState(() {
              statusRedEye = !statusRedEye;
            });
          },
        )
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
}}

Future createUser(user, uid) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    final json = user.toJson();
    await docUser.set(json);
}
