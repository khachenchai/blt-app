import 'package:bunlungthong/view/login.dart';
import 'package:bunlungthong/view/sign-up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenPage extends StatefulWidget {
  const AuthenPage({ Key? key }) : super(key: key);

  @override
  State<AuthenPage> createState() => _AuthenPageState();
}

class _AuthenPageState extends State<AuthenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 229, 238, 255),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: Image.asset('assets/img/logo-no-bg.png'),
                width: 220,
                height: 220,
              ),
              Text("BunlungThong", style: GoogleFonts.ubuntu(fontSize: 24),),
              SizedBox(height: (MediaQuery.of(context).size.height / 10) * 2.5,),
              TextButton(
                child: Hero(
                  child: Text("Login", style: GoogleFonts.ubuntu(fontSize: 30, color: const Color.fromARGB(255, 255, 183, 0), fontWeight: FontWeight.w500)),
                  tag: 'login'
                ),
                onPressed: () {
                  print("Login");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
              ),
              const SizedBox(height: 28),
              TextButton(
                child: Hero(
                  child: Text("Sign up", style: GoogleFonts.ubuntu(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400)),
                  tag: 'Sign-Up'
                ),
                onPressed: () {
                  print("Sign up");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}