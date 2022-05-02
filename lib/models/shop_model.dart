class ShopModel {
  late final String? id;
  late final dynamic shopName;
  late final dynamic shopAddress;
  late final dynamic location;
  late final dynamic description;
  late final dynamic imagePath;
  // late final List<dynamic>? imageDetails;
  late final dynamic allTables;
  late final dynamic phoneNumber;
  late final dynamic selectedTables;
  late final List<dynamic>? eachTable;

  ShopModel({this.id, 
    this.shopName,
    this.shopAddress,
    this.location,
    this.description,
    this.imagePath,
    this.phoneNumber,
    this.allTables,
    this.selectedTables,
    this.eachTable});

  Map<String, dynamic> toJson() => {
    'id' : id,
    'shopName': shopName,
    'shopAddress': shopAddress,
    'loction': location,
    'imagePath': imagePath,
    'phoneNumber' : phoneNumber,
    'allTables': allTables,
    'selectedTables': selectedTables,
    'eachTable' : eachTable,
  };

  static ShopModel fromJson(Map<String, dynamic> json) => ShopModel(
    id: json['id'],
    allTables: json['allTables'],
    description: json['description'],
    phoneNumber: json['phoneNumber'],
    imagePath: json['imagePath'],
    location: json['location'],
    selectedTables: json['selectedTables'],
    shopAddress: json['shopAddress'],
    shopName: json['shopName'],
    eachTable: json['eachTable']
  );
}