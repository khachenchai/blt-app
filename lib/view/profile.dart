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
          idText = value.data()?["password"];
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
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                  children: [
                    Card(
                      elevation: 6,
                      child: SizedBox(
                        // color: Colors.green,
                        height: 150,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.orange,
                                minRadius: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(nameText, style: GoogleFonts.ubuntu(fontSize: 26, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ExpansionTile(
                      title: Text("ประวัติการจอง", style: GoogleFonts.kanit(fontSize: 25, fontWeight: FontWeight.bold)),
                      children: [
                        ListTile(
                          leading: const Icon(Icons.history, size: 36),
                          title: Text("Aroi",style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w500)),
                          subtitle: Text("12/4/2022",style: GoogleFonts.kanit(fontSize: 16)),
                        )
                      ],
                      textColor: Colors.black,
                    )
                  ],
                ),
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => const AddShopPage()));
              //   },
              // ),
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