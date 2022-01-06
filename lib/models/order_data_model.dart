class OrderModel {
  late String orderId;
  late String userId;
  late String status;
  late String paymentMethod;
  late String address;
  late String note;
  late List<Item> data;
  late var totalPrice;
  late var discount;

  OrderModel(
      {required this.orderId,
      required this.userId,
      required this.status,
      required this.paymentMethod,
      required this.address,
      required this.note,
      required this.data,
      required this.totalPrice,
      required this.discount});

  OrderModel.fromJson(Map<String, dynamic>? json) {
    orderId = json!['orderId'];
    userId = json['userId'];
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    address = json['address'];
    note = json['note'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Item.fromJson(v));
      });
    }

    totalPrice = json['totalPrice'];
    discount = json['discount'];
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'status': status,
      'paymentMethod': paymentMethod,
      'address': address,
      'note': note,
      'data': data,
      'totalPrice': totalPrice,
      'discount': discount,
    };
  }
}

class Item {
  late String id;
  late String title;
  late var totalPrice;
  late var itemCount;

  Item(
      {required this.id,
      required this.title,
      required this.itemCount,
      required this.totalPrice});

  Item.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    title = json['title'];
    itemCount = json['itemCount'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'itemCount': itemCount,
      'totalPrice': itemCount
    };
  }
}
