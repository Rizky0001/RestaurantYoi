class DetailResult {
  DetailResult({
    required this.error,
    required this.message,
    required this.detail,
  });

  bool error;
  String message;
  Detail detail;

  factory DetailResult.fromJson(Map<String, dynamic> json) => DetailResult(
        error: json["error"],
        message: json["message"],
        detail: Detail.fromJson(json["restaurant"]),
      );
}

class Detail {
  Detail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Item> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Item>.from(
          json["categories"].map(
            (x) => Item.fromJson(x),
          ),
        ),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map(
            (x) => CustomerReview.fromJson(x),
          ),
        ),
      );
}

class Item {
  Item({
    required this.name,
  });

  String name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
      );
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}

class ComposeReview {
  ComposeReview({
    required this.id,
    required this.name,
    required this.review,
  });

  String id;
  String name;
  String review;

  Map<String, String> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Item> foods;
  List<Item> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Item>.from(json["foods"].map((x) => Item.fromJson(x))),
        drinks: List<Item>.from(json["drinks"].map((x) => Item.fromJson(x))),
      );
}
