import 'dart:convert';

AcceptOrder acceptOrderFromJson(String str) =>
    AcceptOrder.fromJson(json.decode(str));

String acceptOrderToJson(AcceptOrder data) => json.encode(data.toJson());

class AcceptOrder {
  AcceptOrder({
    required this.orderStatusId,
    required this.message,
    required this.firebaseResponse,
  });

  int orderStatusId;
  String message;
  String firebaseResponse;

  factory AcceptOrder.fromJson(Map<String, dynamic> json) => AcceptOrder(
        orderStatusId: json["order_status_id"],
        message: json["message"],
        firebaseResponse: json["firebase_response"],
      );

  Map<String, dynamic> toJson() => {
        "order_status_id": orderStatusId,
        "message": message,
        "firebase_response": firebaseResponse,
      };
}
