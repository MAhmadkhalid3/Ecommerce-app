import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/controller/notification_settings_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NotificationSettingsController.instance;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        child: Obx(
          () => Column(
            children: [
              SwitchListTile(
                secondary: const Icon(Iconsax.box),
                title: const Text('Order updates'),
                subtitle: const Text('Status changes for your orders'),
                value: controller.orderUpdates.value,
                onChanged: controller.toggleOrderUpdates,
              ),
              SwitchListTile(
                secondary: const Icon(Iconsax.discount_shape),
                title: const Text('Promotions & offers'),
                subtitle: const Text('Sales, coupons and new arrivals'),
                value: controller.promotions.value,
                onChanged: controller.togglePromotions,
              ),
              SwitchListTile(
                secondary: const Icon(Iconsax.sms),
                title: const Text('Email alerts'),
                subtitle: const Text('Important account notifications'),
                value: controller.emailAlerts.value,
                onChanged: controller.toggleEmailAlerts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
