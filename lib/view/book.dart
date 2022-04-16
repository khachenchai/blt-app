import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class BookPage extends StatefulWidget {
  const BookPage({ Key? key }) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking", style: GoogleFonts.kanit(fontSize: 26)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.5,
              child: Container(
                child: Image.asset('assets/img/logo.jpg'),
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("อร่อยโภชนา", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: () {
                    print("Calling");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF94FF98))
                  ),
                  icon: const Icon(Icons.phone), 
                  label: const Text("โทรหาเจ้าของร้าน", style: TextStyle(fontSize: 16)),
                )
              ],
            ),
            const Text("จำนวนที่นั่งทั้งหมด 50 ที่นั่ง", style: TextStyle(fontSize: 18)),
            const Text("จำนวนที่นั่งที่ถูกจอง 30 ที่นั่ง", style: TextStyle(fontSize: 18)),
            const Text("จำนวนที่นั่งที่เหลือ 20 ที่นั่ง", style: TextStyle(fontSize: 18)),
            const ReadMoreText("Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quaerat dignissimos mollitia vitae id impedit! Excepturi nihil quibusdam cupiditate quisquam accusantium?", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}