import 'dart:io';

import 'package:bunlungthong/models/shop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddShopPage extends StatefulWidget {
  const AddShopPage({Key? key}) : super(key: key);

  @override
  State<AddShopPage> createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  final formKey = GlobalKey<FormState>();
  ShopModel shop = ShopModel();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Adding shop', style: GoogleFonts.ubuntu(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
          toolbarHeight: 65,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                children: [
                  const SizedBox(height: 15),
                  nameFormFeild(),
                  const SizedBox(height: 15),
                  descriptionFormFeild(),
                  const SizedBox(height: 15),
                  addressFormFeild(),
                  const SizedBox(height: 15),
                  locationFormFeild(),
                  const SizedBox(height: 15),
                  phomeNumberFormFeild(),
                  const SizedBox(height: 15),
                  allSeatsFormFeild(),
                  const SizedBox(height: 30),
                  pickImage(context),
                  // const SizedBox(height: 30),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Center(
                        child: Text("Add", style: GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.w600)),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          int allOfSeats = int.parse(shop.allSeats);
                          Uuid uid = const Uuid();
                          var uid4 = uid.v4();
                          print("Adding shop");
                          final shop_config = ShopModel(
                            shopName: shop.shopName,
                            description: shop.description,
                            shopAddress: shop.shopAddress,
                            location: shop.location,
                            allSeats: allOfSeats,
                            id: uid4
                          );
                          print("name = ${shop.shopName}");
                          createShop(shop_config, uid4);
                          formKey.currentState!.reset();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  TextFormField nameFormFeild() {
    return TextFormField(
      validator: RequiredValidator(errorText: 'กรุณากรอกชื่อด้วยครับ'),
      onSaved: (String? name) {
        shop.shopName = name;
      },
      decoration: InputDecoration(
        labelText: 'Shop name',
        hintText: 'โปรดกรอกชื่อร้านของท่าน',
        icon: const Icon(Icons.restaurant, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  TextFormField addressFormFeild() {
    return TextFormField(
      validator: RequiredValidator(errorText: 'กรุณากรอกที่อยู่ของร้านด้วยครับ'),
      onSaved: (String? address) {
        shop.shopAddress = address;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Address',
        hintText: 'โปรดกรอกที่อยู่ของร้านของท่าน',
        icon: const Icon(Icons.map_outlined, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  TextFormField locationFormFeild() {
    return TextFormField(
      validator: RequiredValidator(errorText: 'กรุณากรอกที่อยู่ของร้านด้วยครับ'),
      onSaved: (String? address) {
        shop.shopAddress = address;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Location (Google map link)',
        hintText: 'โปรดกรอกลิ้ง Google map ของร้านท่าน',
        icon: const Icon(Icons.add_location_alt, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  TextFormField descriptionFormFeild() {
    return TextFormField(
      validator: RequiredValidator(errorText: 'กรุณากรอกรายละเอียดด้วยครับ'),
      onSaved: (String? description) {
        shop.description = description;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Description',
        hintText: 'โปรดกรอกรายละเอียด',
        icon: const Icon(Icons.lock, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  TextFormField phomeNumberFormFeild() {
    return TextFormField(
      validator: RequiredValidator(errorText: 'กรุณากรอกเบอร์โทรศัพท์ด้วยครับ'),
      onSaved: (String? phone) {
        shop.phoneNumber = phone;
      },
      obscureText: true,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
        labelText: 'Phone number',
        hintText: 'โปรดกรอกเบอร์โทรศัพท์',
        icon: const Icon(Icons.phone, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  TextFormField allSeatsFormFeild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: RequiredValidator(errorText: 'กรุณากรอกจำนวนที่นั่งทั้งหมดด้วยครับ'),
      onSaved: (String? amount) {
        shop.allSeats = amount;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Amount of your seats',
        hintText: 'โปรดกรอกจำนวนที่นั่งทั้งหมด',
        icon: const Icon(Icons.table_bar, color: Colors.black),
        labelStyle: GoogleFonts.ubuntu(color: Colors.black),
        hintStyle: GoogleFonts.kanit()
      ),
    );
  }

  Row pickImage(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {chooseImage(ImageSource.camera);}, icon: const Icon(Icons.add_a_photo, size: 36)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          width: MediaQuery.of(context).size.width * 0.5,
          child: imageFile == null ? Image.asset('assets/img/logo-no-bg.png') : Image.file(imageFile!),
        ),
        IconButton(onPressed: () => chooseImage(ImageSource.gallery), icon: const Icon(Icons.add_photo_alternate, size: 36)),
      ]
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
      try {
        var result = await ImagePicker().pickImage(
          source: source,
          maxHeight: 500,
          maxWidth: 500
        );
        setState(() {
          imageFile = File(result!.path);
        });
      } catch (e) {
        print(e);
      }
  }
}

Future createShop(shop, uid) async {
  final docShop = FirebaseFirestore.instance.collection('shops').doc(uid);

    final json = shop.toJson();
    await docShop.set(json);
}
