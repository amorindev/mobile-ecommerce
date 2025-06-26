import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/screens/ecomm/product/shipping_screen.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/bloc/order_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/core/resp.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurcharsesScreen extends StatefulWidget {
  const PurcharsesScreen({super.key});

  @override
  State<PurcharsesScreen> createState() => _PurcharsesScreenState();
}

class _PurcharsesScreenState extends State<PurcharsesScreen> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthStateSignedIn) {
      final accessToken = authState.authResponse!.session!.accessToken;
      BlocProvider.of<OrderBloc>(context).add(
        OrderEventGetAll(accessToken: accessToken),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) async {
        if (state is OrderStateLoaded) {
          if (state.exception != null) {
            await showErrorDialog(context, state.exception.toString());
          }
          /* if (state.isLoading) {
            if (context.mounted) {
              LoadingScreen().show(
                context: context,
                text: state.loadingText ?? 'loading ...',
              );
            }
          } else {
            LoadingScreen().hide();
          }
          return; */
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Purcharses",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.brandColor,
        ),
        backgroundColor: AppColors.whiteColor,
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderStateLoaded) {
              if (state.orders == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.orders!.isEmpty) {
                return const Center(
                  child: Text("No tienes ordenes"),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalMediumPadding,
                  vertical: AppSizes.verticalP,
                ),
                itemCount: state.orders!.length,
                itemBuilder: (context, index) {
                  final order = state.orders![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: CustomOrderCard(order: order),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
/*
Center(
          child: Text(
            "se pueden hacer dos cosas un stream o un reload para ver el estado de compra",
          ),
        ), */

class CustomOrderCard extends StatelessWidget {
  final OrderResp order;
  const CustomOrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: AppColors.blackColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextRich(text: "Order id: ", value: "ORD-${order.id}"),
          CustomStatus(status: order.payment.status),
          CustomTextRich(text: "DeliveryType: ", value: order.deliveryType),
          CustomTextRich(text: "Total: ", value: order.total.toString()),
          CustomTextRich(
              text: "PaymentMethod: ", value: order.payment.paymentMethod),
          CustomTextRich(text: "Data: ", value: order.createdAt.toString()),
          const SizedBox(height: 8.0),
          const Text(
            "Productos",
            style: TextStyle(fontSize: 16.0),
          ),
          const Divider(),
          // * no se si agregar mas datos a cada metofo  hay mas ver shopify
          /* order.deliveryType == "delivery"
              ? Column(
                  children: [Text(order.delivery!.reference)],
                )
              : const SizedBox(),
          order.deliveryType == "pickup"
              ? Column(
                  children: [Text(order.pickup!.storeId)],
                )
              : const SizedBox(), */
          ...order.orderItems.map(
            (o) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("- Product name ${o.name}"),
                  Text("  - Product price ${o.price}"),
                  Text("  - Product quantity ${o.quantity}"),
                  //Text("Imagen?"),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class CustomStatus extends StatelessWidget {
  final String status;
  const CustomStatus({super.key, required this.status});

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.greyColor;
      case 'paid':
        return AppColors.greenColor;
      case 'failed':
        return AppColors.redColor;
      case 'refunded':
        return AppColors.orangeColor;
      default:
        return AppColors.whiteColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Status: ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: _getStatusColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(status),
        )
      ],
    );
  }
}
