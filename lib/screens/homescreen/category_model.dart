class CategoryModel {
  final String name;
  final String image;
  final String id;
  final int itemIndex;

  CategoryModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.itemIndex});

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
        name: json['name'],
        image: json['image'],
        id: json['id'],
        itemIndex: json['itemIndex']);
  }
}
