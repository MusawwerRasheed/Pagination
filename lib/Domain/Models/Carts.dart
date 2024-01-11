import 'dart:convert';
class Cart {
 final int? id;
 final String? title;
 bool? load = false;
 final int? price;
 final int? quantity;
 final int? total;
 final double? discountPercentage;
 final int? discountedPrice;
 final String? thumbnail;


 Cart({
  this.id,
  this.title,
  this.price,
  this.quantity,
  this.total,
  this.discountPercentage,
  this.discountedPrice,
  this.thumbnail,

 });

 Cart copyWith({
  int? id,
  String? title,
  int? price,
  int? quantity,
  int? total,
  double? discountPercentage,
  int? discountedPrice,
  String? thumbnail,
  bool? isNoMoreProducts,
 }) =>
     Cart(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      thumbnail: thumbnail ?? this.thumbnail,

     );

 factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

 String toRawJson() => json.encode(toJson());

 factory Cart.fromJson(Map<String, dynamic> json) => Cart(
  id: json["id"],
  title: json["title"],
  price: json["price"],
  quantity: json["quantity"],
  total: json["total"],
  discountPercentage: json["discountPercentage"]?.toDouble(),
  discountedPrice: json["discountedPrice"],
  thumbnail: json["thumbnail"],
    // Default value
 );

 Map<String, dynamic> toJson() => {
  "id": id,
  "title": title,
  "price": price,
  "quantity": quantity,
  "total": total,
  "discountPercentage": discountPercentage,
  "discountedPrice": discountedPrice,
  "thumbnail": thumbnail,
 };
}

















