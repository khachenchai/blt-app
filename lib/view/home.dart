import 'package:bunlungthong/view/book.dart';
import 'package:bunlungthong/view/profile.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 244, 224),
          appBar: AppBar(
            title: const Text('ร้านอาหาร', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            centerTitle: true,
            toolbarHeight: 65,
            actions: [
              IconButton(
                  padding: const EdgeInsets.only(right: 30),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfliePage()));
                  },
                  icon: const Icon(Icons.person, size: 32))
            ],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: ListView(
              // padding: const EdgeInsets.all(0),
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    trailing: IconButton(
                        onPressed: () {
                          print("Searching");
                        },
                        icon: const Icon(
                          Icons.search_outlined,
                          size: 36,
                          color: Colors.black,
                        )),
                  ),
                ),
                ShopList(name: "name"),
                ShopList(name: "name"),
                ShopList(name: "name"),
                ShopList(name: "name"),
                ShopList(name: "name"),
                ShopList(name: "nme"),
                ShopList(name: "name"),
              ],
            ),
          )),
    );
  }
}

class ShopList extends StatelessWidget {
  String? name;
  // String? address;

  ShopList({Key? key, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("Tile");
        Navigator.push(context, MaterialPageRoute(builder: (context) => const BookPage()));
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0)),
      child: Card(
        elevation: 2,
        child: SizedBox(
          height: 70,
          child: Center(
            child: ListTile(
              title: Text(name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              leading: const Icon(Icons.restaurant, size: 36),
              trailing: const Icon(Icons.arrow_right, size: 40, color: Color(0xFF366C00)),
            ),
          ),
        ),
      ),
    );
  }
}
