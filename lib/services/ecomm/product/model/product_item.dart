import 'package:flu_go_jwt/services/ecomm/product/model/option.dart';

class ProductItem {
  final String id;
  final int stock;
  final int discount;
  final int rating;
  final double price;
  final String imgUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Option>? options;

  // * variable
  //final int quantity;
  String? productGroupName; // para poder mostrar el nombre dentro del carrito
  int? quantity;

  ProductItem({
    required this.id,
    required this.stock,
    required this.discount,
    required this.rating,
    required this.price,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.options,
    this.productGroupName,
    this.quantity,
  });
  List<Object?> get props => [
        id,
        stock,
        discount,
        rating,
        price,
        imgUrl,
        createdAt,
        updatedAt,
        options,
        productGroupName,
        quantity
      ];

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] as String,
      stock: json['stock'] as int,
      discount: json['discount'] as int,
      rating: json['rating'] as int,
      price: (json['price'] as num).toDouble(),
      imgUrl: json['img_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      productGroupName: json['productGroupName'] as String?,
      quantity: json['quantity'] as int?,
    );
  }

  // ! esta mal verificar
  /* factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        // ! product depende de esta entidad
        stock: 10,
        discount: 2,
        rating: 4,
        imgUrl: json["img_url"],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        options: null,
    ); */

  // * para todo la clase al formato json - no se va usar de seguro
  /* Map<String, dynamic> toJson() => {
        "id": id,
        "stock": stock,
        "discount": discount,
        "rating": rating,
        "price": price,
        "img_url": imgUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_id": id,
        "quantity": quantity, // si es para crear el order no deberia ser nulo
        "options": options == null 
              ?[]
              : List<dynamic>.from(options!.map((x) => x.toJson())),
      }; */

  Map<String, dynamic> toOrderJson() {
    /* if (quantity== null) {
      // podría tener validaciones como que no sea nulo desde aqui o desde elbloc
      // si queremos ser extricost retornar el error
      // si no queremos ser extrictos ponerlo en 0
    } */
    return {
      "product_item_id": id,
      "quantity": quantity, // si es para crear el order no deberia ser nulo
      "price": price,
    };
  }
}

extension ProductItemCopy on ProductItem {
  ProductItem copyWith({
    String? productGroupName,
    int? quantity,
    String? id,
    int? stock,
    int? discount,
    int? rating,
    double? price,
    String? imgUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Option>? options,
  }) {
    return ProductItem(
      productGroupName: productGroupName ?? this.productGroupName,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
      stock: stock ?? this.stock,
      discount: discount ?? this.discount,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      options: options ?? this.options,
    );
  }
}
