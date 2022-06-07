// To parse this JSON data, do
//
//     final riderWayList = riderWayListFromJson(jsonString);

import 'dart:convert';

class RiderWayList {
  RiderWayList({
    required this.data,
  });

  List<RiderWayListData> data;

  factory RiderWayList.fromRawJson(String str) =>
      RiderWayList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RiderWayList.fromJson(Map<String, dynamic> json) => RiderWayList(
        data: List<RiderWayListData>.from(
            json["data"].map((x) => RiderWayListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RiderWayListData {
  RiderWayListData({
    required this.id,
    required this.type,
    required this.attribute,
  });

  String id;
  String type;
  Attribute attribute;

  factory RiderWayListData.fromRawJson(String str) =>
      RiderWayListData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RiderWayListData.fromJson(Map<String, dynamic> json) =>
      RiderWayListData(
        id: json["id"],
        type: json["type"],
        attribute: Attribute.fromJson(json["attribute"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attribute": attribute.toJson(),
      };
}

class Attribute {
  Attribute({
    required this.voucherId,
    required this.deliveredDate,
    required this.township,
    required this.customer,
    required this.remark,
    required this.orderStatusId,
    required this.deliFee,
    required this.rider,
    required this.deliverAddressId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  String voucherId;
  DateTime deliveredDate;
  Township township;
  Customer customer;
  String remark;
  OrderStatusId orderStatusId;
  String deliFee;
  CreatedBy rider;
  String deliverAddressId;
  CreatedBy createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Attribute.fromRawJson(String str) =>
      Attribute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        voucherId: json["voucher_id"],
        deliveredDate: DateTime.parse(json["delivered_date"]),
        township: Township.fromJson(json["township"]),
        customer: Customer.fromJson(json["customer"]),
        remark: json["remark"],
        orderStatusId: OrderStatusId.fromJson(json["order_status_id"]),
        deliFee: json["deli_fee"],
        rider: CreatedBy.fromJson(json["rider"]),
        deliverAddressId: json["deliver_address_id"],
        createdBy: CreatedBy.fromJson(json["created_by"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "voucher_id": voucherId,
        "delivered_date":
            "${deliveredDate.year.toString().padLeft(4, '0')}-${deliveredDate.month.toString().padLeft(2, '0')}-${deliveredDate.day.toString().padLeft(2, '0')}",
        "township": township.toJson(),
        "customer": customer.toJson(),
        "remark": remark,
        "order_status_id": orderStatusId.toJson(),
        "deli_fee": deliFee,
        "rider": rider.toJson(),
        "deliver_address_id": deliverAddressId,
        "created_by": createdBy.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.status,
    required this.deviceKey,
    required this.web,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String status;
  String deviceKey;
  String web;
  DateTime? createdAt;
  DateTime updatedAt;

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        status: json["status"],
        deviceKey: json["device_key"],
        web: json["web"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "device_key": deviceKey,
        "web": web,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Customer {
  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.remark,
  });

  int id;
  String name;
  String phone;
  String address;
  dynamic remark;

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "remark": remark,
      };
}

class OrderStatusId {
  OrderStatusId({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory OrderStatusId.fromRawJson(String str) =>
      OrderStatusId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderStatusId.fromJson(Map<String, dynamic> json) => OrderStatusId(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Township {
  Township({
    required this.id,
    required this.name,
    required this.deliveryFee,
  });

  int id;
  String name;
  String deliveryFee;

  factory Township.fromRawJson(String str) =>
      Township.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Township.fromJson(Map<String, dynamic> json) => Township(
        id: json["id"],
        name: json["name"],
        deliveryFee: json["delivery_fee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "delivery_fee": deliveryFee,
      };
}
