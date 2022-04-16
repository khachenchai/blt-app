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
      backgroundColor: const Color(0xFFFFFAF1),
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
              height: MediaQuery.of(context).size.height / 20,
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
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF94FF98)),
                    elevation: MaterialStateProperty.all<double>(0)
                  ),
                  icon: const Icon(Icons.phone), 
                  label: const Text("โทรหาเจ้าของร้าน", style: TextStyle(fontSize: 16)),
                )
              ],
            ),
            const SizedBox(height: 10),
            
            const ReadMoreText(
              "รายละเอียด : Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quaerat dignissimos mollitia vitae id impedit! Excepturi nihil quibusdam cupiditate quisquam accusantium?", 
              style: TextStyle(fontSize: 18, color: Colors.black45),
              trimLines: 2,
              trimMode: TrimMode.Line,
              colorClickableText: Colors.orange,
              trimExpandedText: 'อ่านน้อยลง',
              trimCollapsedText: 'อ่านเพิ่มเติม',
            ),
            const SizedBox(height: 10),
            const ReadMoreText(
              "ที่ตั้ง : Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quaerat dignissimos mollitia vitae id impedit! Excepturi nihil quibusdam cupiditate quisquam accusantium?", 
              style: TextStyle(fontSize: 18),
              trimLines: 2,
              trimMode: TrimMode.Line,
              colorClickableText: Colors.orange,
              trimExpandedText: 'อ่านน้อยลง',
              trimCollapsedText: 'อ่านเพิ่มเติม',
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    print("Go to GG Map");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffffffff))
                  ),
                  icon: const Icon(Icons.location_on, color: Colors.red), 
                  label: const Text("Google Maps", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(height: 10),
            const Text("จำนวนที่นั่งทั้งหมด 50 ที่นั่ง", style: TextStyle(fontSize: 18)),
            const Text("จำนวนที่นั่งที่ถูกจอง 30 ที่นั่ง", style: TextStyle(fontSize: 18)),
            const Text("จำนวนที่นั่งที่เหลือ 20 ที่นั่ง", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}