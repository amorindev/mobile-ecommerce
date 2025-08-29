import 'package:flu_go_jwt/services/ecomm/order/core/resp.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product_item.dart';

class OrderRequest {
  final double total;
  final String deliveryType;
  final List<ProductItem> productItems;
  final Pickup? pickupInfo;
  final Delivery? deliveryInfo;
  final PaymentResp payment;

  OrderRequest({
    required this.total,
    required this.deliveryType,
    required this.productItems,
    this.pickupInfo,
    this.deliveryInfo,
    required this.payment,
  });

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'delivery_type': deliveryType,
      'product_items': productItems.map((e) => e.toOrderJson()).toList(),
      if (deliveryType == 'pickup') 'pickup_info': pickupInfo?.toOrderJson(),
      if (deliveryType == 'delivery') 'delivery_info': deliveryInfo?.toOrderJson(),
      'payment': payment.toOrderJson(),
    };
  }
}

/* class ProductItem {
  final String productItemId;
  final int quantity;
  final double price;

  ProductItem({
    required this.productItemId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_item_id': productItemId,
      'quantity': quantity,
      'price': price,
    };
  }
} */

/* class PickupInfo {
  final String phoneId;
  final String addressId;
  final String storeId;

  PickupInfo({
    required this.phoneId,
    required this.addressId,
    required this.storeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_id': phoneId,
      'address_id': addressId,
      'store_id': storeId,
    };
  }
}

class DeliveryInfo {
  final String phoneId;
  final String addressId;
  final String reference;

  DeliveryInfo({
    required this.phoneId,
    required this.addressId,
    required this.reference,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_id': phoneId,
      'address_id': addressId,
      'reference': reference,
    };
  }
} */

/* class PaymentInfo {
  final String currency;
  final String paymentMethod;

  PaymentInfo({
    required this.currency,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'payment_method': paymentMethod,
    };
  }
} */
