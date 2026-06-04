import 'package:ecommerce/features/shop/controller/app_settings_controller.dart';
import 'package:ecommerce/features/shop/screens/address/address_list_screen.dart';
import 'package:ecommerce/features/shop/screens/Cart/cart_screen.dart';
import 'package:ecommerce/features/shop/screens/orders/orders_list_screen.dart';
import 'package:ecommerce/features/shop/screens/setting/bank_account_screen.dart';
import 'package:ecommerce/features/shop/screens/setting/coupons_screen.dart';
import 'package:ecommerce/features/shop/screens/setting/load_data_screen.dart';
import 'package:ecommerce/features/shop/screens/setting/notification_settings_screen.dart';
import 'package:ecommerce/features/shop/screens/setting/privacy_screen.dart';
import 'package:ecommerce/features/shop/screens/setting/widgets.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/customShapes/curves_edges.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettings = AppSettingsController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                width: double.infinity,
                height: 165,
                color: TColors.primary,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace(context)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Account",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(
                                    color: THelperFunction.isDrak(context)
                                        ? Colors.black
                                        : Colors.white)),
                        const InkWell(child: UserProfileCard())
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account Settings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const AddressListScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and completed orders',
                    onTap: () => Get.to(() => const OrdersListScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Save bank details for refunds & withdrawals',
                    onTap: () => Get.to(() => const BankAccountScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'Available discount codes — copy & use at checkout',
                    onTap: () => Get.to(() => const CouponsScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Order updates, offers and email alerts',
                    onTap: () =>
                        Get.to(() => const NotificationSettingsScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'How your data is used and managed',
                    onTap: () => Get.to(() => const PrivacyScreen()),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections(context)),
                  const Text(
                    "App Settings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems(context)),
                  SettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload sample products to Firebase',
                    onTap: () => Get.to(() => const LoadDataScreen()),
                  ),
                  Obx(
                    () => SettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'Geolocation',
                      subTitle: 'Recommendations based on your location',
                      trailing: Switch(
                        value: appSettings.geolocationEnabled.value,
                        onChanged: appSettings.toggleGeolocation,
                      ),
                    ),
                  ),
                  Obx(
                    () => SettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Safe Mode',
                      subTitle: 'Family-friendly search results',
                      trailing: Switch(
                        value: appSettings.safeModeEnabled.value,
                        onChanged: appSettings.toggleSafeMode,
                      ),
                    ),
                  ),
                  Obx(
                    () => SettingsMenuTile(
                      icon: Iconsax.image,
                      title: 'HD Image Quality',
                      subTitle: 'Higher quality product images',
                      trailing: Switch(
                        value: appSettings.hdImageQuality.value,
                        onChanged: appSettings.toggleHdImageQuality,
                      ),
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems(context)),
                  const LogoutButton(),
                  SizedBox(height: TSizes.spaceBtwItems(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
