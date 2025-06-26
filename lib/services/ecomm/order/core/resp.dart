// To parse this JSON data, do
//
//     final ordersResp = ordersRespFromJson(jsonString);

/* import 'dart:convert';

OrdersResp ordersRespFromJson(String str) {
    final jsonData = json.decode(str);
    return OrdersResp.fromJson(jsonData);
}

String ordersRespToJson(OrdersResp data) {
    final dyn = data.toJson();
    return json.encode(dyn);
} */

class OrdersResp {
  final List<OrderResp> orders;

  OrdersResp({
    required this.orders,
  });

  factory OrdersResp.fromJson(Map<String, dynamic> json) => OrdersResp(
        orders: List<OrderResp>.from(
            json["orders"].map((x) => OrderResp.fromJson(x))),
      );
      /* OrdersResp(
        orders: 
        json["orders"] == null ?
        null: 
        List<OrderResp>.from(
            json["orders"].map((x) => OrderResp.fromJson(x))),
      ); */

      /* AddressesResponse(
        addresses: json["addresses"] == null
            ? null
            : List<AddressResponse>.from(
                json["addresses"].map((x) => AddressResponse.fromJson(x))),
      ); */

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class OrderResp {
  final String id;
  final String userId;
  final List<OrderItemResp> orderItems;
  final double total;
  final String deliveryType;
  final PaymentResp payment;
  // ! ver como manejar los opcionales
  // * uno siempre separ aopconal
  final Pickup? pickup;
  final Delivery? delivery;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderResp({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.total,
    required this.deliveryType,
    required this.payment,
    required this.pickup,
    required this.delivery,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderResp.fromJson(Map<String, dynamic> json) => OrderResp(
        id: json["id"],
        userId: json["user_id"],
        orderItems: List<OrderItemResp>.from(json["order_items"].map(
          (x) => OrderItemResp.fromJson(x),
        )),
        total: (json["total"] as num).toDouble(),
        deliveryType: json["delivery_type"],
        payment: PaymentResp.fromJson(json["payment"]),
        pickup: json['pickup'] != null ? Pickup.fromJson(json['pickup']) : null,
        delivery: json['delivery'] != null
            ? Delivery.fromJson(json['delivery'])
            : null,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "total": total,
        "delivery_type": deliveryType,
        "payment": payment.toJson(),
        "pickup": pickup,
        "delivery": delivery,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class OrderItemResp {
  final String id;
  final String orderId;
  final String productItemId;
  final int quantity;
  final double price;
  final String name;

  OrderItemResp({
    required this.id,
    required this.orderId,
    required this.productItemId,
    required this.quantity,
    required this.price,
    required this.name,
  });

  factory OrderItemResp.fromJson(Map<String, dynamic> json) => OrderItemResp(
        id: json["id"],
        orderId: json["order_id"],
        productItemId: json["product_item_id"],
        quantity: json["quantity"],
        price:  (json["price"] as num).toDouble(),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_item_id": productItemId,
        "quantity": quantity,
        "price": price,
        "name": name,
      };
}

class PaymentResp {
  final String id;
  final String orderId;
  final String currency;
  final String status;
  final String paymentMethod;
  final String? providerPaymentId;
  // me parece que conla orden se crea y no hay necesitad de tener dos created
  // si van a ser la misma fecha
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentResp({
    required this.id,
    required this.orderId,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    required this.providerPaymentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentResp.fromJson(Map<String, dynamic> json) => PaymentResp(
        id: json["id"],
        orderId: json["order_id"],
        currency: json["currency"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        providerPaymentId: json["provider_payment_id"],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "currency": currency,
        "status": status,
        "payment_method": paymentMethod,
        "provider_payment_id": providerPaymentId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  Map<String, dynamic> toOrderJson() => {
        "currency": currency,
        "payment_method": paymentMethod,
      };
}

// ! falta el pickup o delivery entidade ver si se va a traer}

class Pickup {
  final String? id;
  final String? orderId;
  final String phoneId;
  final String addressId;
  final String storeId;

  // * Si es desde el backend es requerido pero para crear el Pickup desde
  // * shipping screen no tendremos id entonces crear las dos entidades
  Pickup({
    required this.id,
    required this.orderId,
    required this.phoneId,
    required this.addressId,
    required this.storeId,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) => Pickup(
        id: json['id'],
        orderId: json['order_id'],
        phoneId: json['phone_id'],
        addressId: json['address_id'],
        storeId: json['store_id'],
      );

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      'phone_id': phoneId,
      'address_id': addressId,
      'store_id': storeId,
    };
  }

  Map<String, dynamic> toOrderJson() {
    return {
      'phone_id': phoneId,
      'address_id': addressId,
      'store_id': storeId,
    };
  }
}

// crear las dos entidades de momento cambiarre a nulo algunos campos
class Delivery {
  final String? id;
  final String? orderId;
  final String phoneId;
  final String addressId;
  final String reference;

  Delivery({
    required this.id,
    required this.orderId,
    required this.phoneId,
    required this.addressId,
    required this.reference,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json['id'],
        orderId: json['order_id'],
        phoneId: json['phone_id'],
        addressId: json['address_id'],
        reference: json['reference'],
      );

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      'phone_id': phoneId,
      'address_id': addressId,
      'reference': reference,
    };
  }

  Map<String, dynamic> toOrderJson() {
    return {
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      'phone_id': phoneId,
      'address_id': addressId,
      'reference': reference,
    };
  }
}
