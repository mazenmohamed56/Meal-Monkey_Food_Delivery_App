class ItemModel {
  late String id;
  late String title;
  late String description;
  late String category;
  late String imagepath;

  late String rate;
  late var price;
  late var discount;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imagepath,
    required this.rate,
    required this.price,
    required this.discount,
  });

  ItemModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    imagepath = json['imagepath'];
    rate = json['rate'];
    price = json['price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'imagepath': imagepath,
      'rate': rate,
      'price': price,
      'discount': discount,
    };
  }
}
