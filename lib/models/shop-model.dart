class ShopModel {
  late final String? id;
  late final dynamic shopName;
  late final dynamic shopAddress;
  late final dynamic location;
  late final dynamic description;
  late final dynamic imagePath;
  // late final List<dynamic>? imageDetails;
  late final dynamic allSeats;
  late final dynamic phoneNumber;
  late final dynamic selectedSeats;
  late final List<dynamic>? eachSeat;

  ShopModel({this.id, 
    this.shopName,
    this.shopAddress,
    this.location,
    this.description,
    this.imagePath,
    this.phoneNumber,
    this.allSeats,
    this.selectedSeats,
    this.eachSeat});

  Map<String, dynamic> toJson() => {
    'id' : id,
    'shopName': shopName,
    'shopAddress': shopAddress,
    'loction': location,
    'imagePath': imagePath,
    'phoneNumber' : phoneNumber,
    'allSeats': allSeats,
    'selectedSeats': selectedSeats,
    'eachSeat' : eachSeat,
  };

  static ShopModel fromJson(Map<String, dynamic> json) => ShopModel(
    id: json['id'],
    allSeats: json['allSeats'],
    description: json['description'],
    phoneNumber: json['phoneNumber'],
    imagePath: json['imagePath'],
    location: json['location'],
    selectedSeats: json['selectedSeats'],
    shopAddress: json['shopAddress'],
    shopName: json['shopName'],
    eachSeat: json['eachSeat']
  );
}