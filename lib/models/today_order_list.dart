// To parse this JSON data, do
//
//     final todayOrder = todayOrderFromJson(jsonString);

import 'dart:convert';

class TodayOrder {
  TodayOrder({
    required this.data,
  });

  List<List<Datum>> data;

  factory TodayOrder.fromRawJson(String str) =>
      TodayOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TodayOrder.fromJson(Map<String, dynamic> json) => TodayOrder(
        data: List<List<Datum>>.from(json["data"]
            .map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.price,
    required this.unitWeight,
    required this.minWeight,
    required this.shopId,
    required this.status,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
    required this.quantity,
    required this.voucherId,
    required this.deliveredDate,
    required this.deliverFee,
    required this.remark,
    required this.orderStatusId,
    required this.orderStatusName,
    required this.shopTownshipName,
    required this.shopName,
    required this.shopPhone,
    required this.shopAddress,
    required this.orderOwnerName,
    required this.orderOwnerPhone,
    required this.deliverAddressName,
  });

  int id;
  String name;
  String price;
  String unitWeight;
  String minWeight;
  String shopId;
  String status;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  String orderId;
  String quantity;
  String voucherId;
  DateTime deliveredDate;
  String deliverFee;
  String remark;
  String orderStatusId;
  String orderStatusName;
  String shopTownshipName;
  String shopName;
  String shopPhone;
  String shopAddress;
  String orderOwnerName;
  String orderOwnerPhone;
  String deliverAddressName;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        unitWeight: json["unit_weight"],
        minWeight: json["min_weight"],
        shopId: json["shop_id"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderId: json["order_id"],
        quantity: json["quantity"],
        voucherId: json["voucher_id"],
        deliveredDate: DateTime.parse(json["delivered_date"]),
        deliverFee: json["deliver_fee"],
        remark: json["remark"],
        orderStatusId: json["order_status_id"],
        orderStatusName: json["order_status_name"],
        shopTownshipName: json["shop_township_name"],
        shopName: json["shop_name"],
        shopPhone: json["shop_phone"],
        shopAddress: json["shop_address"],
        orderOwnerName: json["order_owner_name"],
        orderOwnerPhone: json["order_owner_phone"],
        deliverAddressName: json["deliver_address_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "unit_weight": unitWeight,
        "min_weight": minWeight,
        "shop_id": shopId,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_id": orderId,
        "quantity": quantity,
        "voucher_id": voucherId,
        "delivered_date":
            "${deliveredDate.year.toString().padLeft(4, '0')}-${deliveredDate.month.toString().padLeft(2, '0')}-${deliveredDate.day.toString().padLeft(2, '0')}",
        "deliver_fee": deliverFee,
        "remark": remark,
        "order_status_id": orderStatusId,
        "order_status_name": orderStatusName,
        "shop_township_name": shopTownshipName,
        "shop_name": shopName,
        "shop_phone": shopPhone,
        "shop_address": shopAddress,
        "order_owner_name": orderOwnerName,
        "order_owner_phone": orderOwnerPhone,
        "deliver_address_name": deliverAddressName,
      };
}
