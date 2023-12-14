import 'package:amazon_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final num quantity;
  final List<String> images;
  final String category;
  final num price;
  final String? id;
  final List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      '_id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: map['quantity'],
      category: map['category'] as String,
      price: map['price'],
      id: map['_id'] as String,

      ///[List<dynamic> is not a subtype of type List<String> in type cast in this code]
      //images: List<String>.from((map['images'] as List<String>)),

      images: (map['images'] as List<dynamic>)
          .map((dynamic item) => item as String)
          .toList(),
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }
}
