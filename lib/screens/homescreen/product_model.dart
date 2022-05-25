class ProductModel {
  final String id;
  final String productId;
  final String name;
  final List<dynamic> image;
  final String mrp;
  final String productType;
  final String price;
  final String productBy;
  final String storeName;
  final String rating;
  final String shortDescription;
  final Map<dynamic, dynamic> productData;
  final List<dynamic> location;
  final List<dynamic> tags;
  final bool isAvailable;
  final String totalProductCount;

  ProductModel(
      {required this.id,
      required this.productId,
      required this.name,
      required this.image,
      required this.mrp,
      required this.productType,
      required this.price,
      required this.productBy,
      required this.storeName,
      required this.rating,
      required this.shortDescription,
      required this.productData,
      required this.location,
      required this.tags,
      required this.isAvailable,
      required this.totalProductCount});

  factory ProductModel.fromJson(Map<dynamic, dynamic> value) {
    return ProductModel(
        id: value["id"] ?? "001",
        productId: value["productId"] ?? "0001",
        name: value["name"] ?? "",
        image: value["image"] ?? "",
        mrp: value["mrp"] ?? "",
        productType: value["productType"] ?? "",
        price: value["price"] ?? "",
        productBy: value["productBy"] ?? "",
        storeName: value["storeName"] ?? "",
        rating: value["rating"] ?? "",
        shortDescription: value["shortDescription"] ?? "",
        productData: value["productData"] ?? "",
        location: value["location"] ?? "",
        totalProductCount: value["totalProductCount"] ?? "",
        tags: value["tags"] ?? "",
        isAvailable: value["isAvailable"] ?? "");
  }
}
