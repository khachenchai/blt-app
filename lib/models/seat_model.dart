class SeatModel {
  late String shopId;
  late String seatId;
  late bool status;
  late String bookerId;
  late DateTime bookingTime;

  SeatModel({required this.shopId, required this.seatId, required this.status, required this.bookerId, required this.bookingTime});

  Map<String, dynamic> toJson() => {
    'shopId' : shopId,
    'seatId' : seatId,
    'status' : status,
    'bookerId' : bookerId,
    'bookingTime' : bookingTime
  };

  static SeatModel fromJson(Map<String, dynamic> json) => SeatModel(
    shopId: json['shopId'],
    seatId: json['seatId'],
    status: json['status'],
    bookerId: json['bookerId'],
    bookingTime: json['bookingTime']
  );
}