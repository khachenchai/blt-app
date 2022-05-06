class TableModel {
  late String shopId;
  late String tableId;
  late bool status;
  late String bookerId;
  late DateTime bookingTime;

  TableModel({required this.shopId, required this.tableId, required this.status, required this.bookerId, required this.bookingTime});

  Map<String, dynamic> toJson() => {
    'shopId' : shopId,
    'seatId' : tableId,
    'status' : status,
    'bookerId' : bookerId,
    'bookingTime' : bookingTime
  };

  static TableModel fromJson(Map<String, dynamic> json) => TableModel(
    shopId: json['shopId'],
    tableId: json['tableId'],
    status: json['status'],
    bookerId: json['bookerId'],
    bookingTime: json['bookingTime']
  );
}