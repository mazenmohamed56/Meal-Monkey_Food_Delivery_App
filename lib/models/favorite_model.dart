class FavoriteModel {
  late String id;

  FavoriteModel({
    required this.id,
  });

  FavoriteModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
