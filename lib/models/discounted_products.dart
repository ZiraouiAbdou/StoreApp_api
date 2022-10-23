// ignore_for_file: unnecessary_this, unnecessary_new

class DiscountedProducts {
  List<String>? images;
  Category? category;

  DiscountedProducts({this.images, this.category});

  DiscountedProducts.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }
}

class Category {
  String? image;

  Category({this.image});

  Category.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }
}
