import 'package:bunlungthong/view/add_shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfliePage extends StatefulWidget {
  const ProfliePage({ Key? key }) : super(key: key);

  @override
  State<ProfliePage> createState() => _ProfliePageState();
}

class _ProfliePageState extends State<ProfliePage> {
  final user = FirebaseAuth.instance.currentUser!;
  String nameText = "Loading...";
  String idText = "Loading...";
  final Future<FirebaseApp> firebase = Firebase.initializeApp();


  Future fetchUserData() async {
     await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          nameText = value.data()?["name"];
          idText = value.data()?["id"];
        });
      }
    });
  }

  @override
  void initState() {

    super.initState();
    fetchUserData();
  }

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
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Profile", style: GoogleFonts.ubuntu(fontSize: 22)),
                centerTitle: true,
              ),
              body: SafeArea(
                child: SizedBox(
                  child: Center(
                    child: Text("${nameText} : ${idText}", style: GoogleFonts.ubuntu(fontSize: 30)),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddShopPage()));
                },
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }


  
}