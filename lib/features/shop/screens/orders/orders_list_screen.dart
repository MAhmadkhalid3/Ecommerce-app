import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/controller/order_controller.dart';
import 'package:ecommerce/features/shop/models/order_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    final isDark = THelperFunction.isDrak(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.box,
                  size: 72,
                  color: isDark ? Colors.white38 : Colors.black26,
                ),
                SizedBox(height: TSizes.spaceBtwItems(context)),
                Text(
                  'No orders yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text('Your placed orders will appear here.'),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(TSizes.defaultSpace(context)),
          itemCount: controller.orders.length,
          separatorBuilder: (_, __) =>
              SizedBox(height: TSizes.spaceBtwItems(context)),
          itemBuilder: (context, index) {
            return _OrderCard(order: controller.orders[index]);
          },
        );
      }),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDrak(context);
    final date = DateTime.tryParse(order.createdAt);
    final dateText = date != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(date)
        : order.createdAt;

    Color statusColor;
    switch (order.status) {
      case 'shipped':
        statusColor = Colors.blue;
        break;
      case 'delivered':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Card(
      elevation: 0,
      color: isDark ? TColors.darkGrey : TColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusMd(context)),
        side: BorderSide(
          color: isDark ? TColors.darkerGrey : TColors.grey,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Order #${order.id.substring(order.id.length > 6 ? order.id.length - 6 : 0)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(dateText, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Text('${order.itemCount} item(s) • \$${order.totalAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 4),
            Text(
              'Payment: ${_formatPayment(order.paymentMethod)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              order.deliveryAddress,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  String _formatPayment(String method) {
    switch (method) {
      case 'cashOnDelivery':
        return 'Cash on Delivery';
      case 'jazzcash':
        return 'JazzCash';
      case 'EasyPasa':
        return 'EasyPaisa';
      case 'creditCard':
        return 'Credit Card';
      default:
        return method;
    }
  }
}
