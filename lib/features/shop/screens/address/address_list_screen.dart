import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/controller/address_controller.dart';
import 'package:ecommerce/features/shop/models/address_model.dart';
import 'package:ecommerce/features/shop/screens/address/add_address_screen.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final isDark = THelperFunction.isDrak(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'My Addresses',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const AddAddressScreen()),
        icon: const Icon(Iconsax.add),
        label: const Text('Add Address'),
      ),
      body: Obx(() {
        if (controller.addresses.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.location,
                    size: 72,
                    color: isDark ? Colors.white38 : Colors.black26,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems(context)),
                  Text(
                    'No addresses saved',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add a delivery address for faster checkout.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.fromLTRB(
            TSizes.defaultSpace(context),
            TSizes.defaultSpace(context),
            TSizes.defaultSpace(context),
            TSizes.defaultSpace(context) * 5,
          ),
          itemCount: controller.addresses.length,
          separatorBuilder: (_, __) =>
              SizedBox(height: TSizes.spaceBtwItems(context)),
          itemBuilder: (context, index) {
            final address = controller.addresses[index];
            return _AddressCard(address: address);
          },
        );
      }),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final isDark = THelperFunction.isDrak(context);

    return Card(
      elevation: 0,
      color: isDark ? TColors.darkGrey : TColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusMd(context)),
        side: BorderSide(
          color: address.isDefault
              ? TColors.primary
              : (isDark ? TColors.darkerGrey : TColors.grey),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  address.addressType == 'Office'
                      ? Iconsax.building
                      : Iconsax.home,
                  color: TColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  address.addressType,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                if (address.isDefault)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: TColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Default',
                      style: TextStyle(
                        color: TColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems(context) / 2),
            Text(
              address.fullName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(address.phoneNumber),
            const SizedBox(height: 8),
            Text(
              address.fullAddress,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: TSizes.spaceBtwItems(context)),
            Row(
              children: [
                if (!address.isDefault)
                  TextButton(
                    onPressed: () =>
                        controller.setDefaultAddress(address.id),
                    child: const Text('Set as Default'),
                  ),
                const Spacer(),
                IconButton(
                  onPressed: () => Get.to(
                    () => AddAddressScreen(address: address),
                  ),
                  icon: const Icon(Iconsax.edit, color: TColors.primary),
                ),
                IconButton(
                  onPressed: () => _confirmDelete(context, address.id),
                  icon: const Icon(Iconsax.trash, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String addressId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Address'),
        content: const Text(
          'Are you sure you want to remove this delivery address?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              AddressController.instance.deleteAddress(addressId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
