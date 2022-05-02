import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class BookPage extends StatefulWidget {
  const BookPage({ Key? key }) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking", style: GoogleFonts.kanit(fontSize: 26)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFFFDF9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                child: Container(
                  child: Image.asset('assets/img/logo.jpg'),
                  // color: Colors.red,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("อร่อยโภชนา", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  ElevatedButton.icon(
                    onPressed: () async {
                      print("Calling");
                      launch('tel://0953163103');
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
              const SizedBox(height: 10),
              const Divider(thickness: 3),
              const SizedBox(height: 20),
              Center(
                child: Form(
                  child: Column(
                    children: [
                      const Text("ประสงค์จะจองทั้งหมด", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      orderField(),
                      const SizedBox(height: 20),
                      const Text("ที่นั่ง", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("เวลา :", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          ElevatedButton.icon(
                            onPressed: () {
                              print("Pick time and day");
                              pickDateTime();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF9ED3FF)),
                              elevation: MaterialStateProperty.all<double>(0)
                            ),
                            icon: const Icon(Icons.timelapse_outlined), 
                            label: const Text("โปรดเลือกวันและเวลา", style: TextStyle(fontSize: 16)),
                          )
                        ],
                      ),
                      Text("วันที่จอง : ${dateTime.day}/${dateTime.month}/${dateTime.year + 543}, เวลา : $hours:$minutes น.", style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      const Divider(thickness: 3),
                      const SizedBox(height: 10),
                      orderDetail(),
                      SizedBox(height: (MediaQuery.of(context).size.height / 25) / 2),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print("Order");
                            
                          },
                          style: ButtonStyle(
                            // elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFFE600))
                          ), 
                          child: const Text("จอง", style: TextStyle(fontSize: 36),),
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField orderField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 26),
      decoration: InputDecoration(
        hintText: 'โปรดกรอกจำนวนโต๊ะ',
        labelStyle: GoogleFonts.kanit(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  TextFormField orderDetail() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 5,
      cursorColor: Colors.red,
      decoration: const InputDecoration(
        hintText: 'หมายเหตุ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
        )
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => this.dateTime = dateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  Future<TimeOfDay?> pickTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
  );

}