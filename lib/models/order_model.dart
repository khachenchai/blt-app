class OrderModel {
  late int seatNumber;
  late String bookerId;
  late DateTime bookingTime;
  late String orderId;
  late String shopId;
  late String? detail;

  OrderModel({required this.seatNumber, required this.bookerId, required this.bookingTime, required this.orderId, required this.shopId, this.detail});

  Map<String, dynamic> toJson() => {
    'seatNumber' : seatNumber,
    'bookerId' : bookerId,
    'bookingTime' : bookingTime,
    'orderId' : orderId,
    'shopId' : shopId
  };

  static OrderModel fromJson(Map<String, dynamic> json) => OrderModel(
    seatNumber: json['seatNumber'], 
    bookerId: json['bookerId'], 
    bookingTime: json['bookingTime'], 
    orderId: json['orderId'],
    shopId: json['shopId'],
  );
}