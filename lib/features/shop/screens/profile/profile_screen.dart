import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/controller/user-controller.dart';
import 'package:ecommerce/features/shop/screens/change_name/changeName_screen.dart';
import 'package:ecommerce/features/shop/screens/profile/widgets.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: TSizes.defaultSpace(context),
            left: TSizes.defaultSpace(context),
            right: TSizes.defaultSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Yahan Replace Kiya
            Obx(() => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              // ✅ Profile Image with Cache
                              if (controller.profileImage.value != null)
                                // Local file — abhi upload ho raha hai
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage:
                                      FileImage(controller.profileImage.value!),
                                )
                              else if (controller
                                  .user.value.profileImage.isNotEmpty)
                                // Network image with cache
                                CachedNetworkImage(
                                  imageUrl: controller.user.value.profileImage,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 45,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: const CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                    radius: 45,
                                    backgroundImage: AssetImage(
                                      "assets/images/products/user_img.jpg",
                                    ),
                                  ),
                                )
                              else
                                // Default asset image
                                const CircleAvatar(
                                  radius: 45,
                                  backgroundImage: AssetImage(
                                    "assets/images/products/user_img.jpg",
                                  ),
                                ),

                              // Loading Indicator — upload ke waqt overlay
                              if (controller.isUploadingImage.value)
                                Positioned.fill(
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundColor: Colors.black45,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Change Profile Pic Button
                    GestureDetector(
                      onTap: controller.isUploadingImage.value
                          ? null
                          : () => controller.showImagePickerOptions(context),
                      child: Center(
                        child: Text(
                          controller.isUploadingImage.value
                              ? "Uploading..."
                              : "Change Profile Pic",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: controller.isUploadingImage.value
                                        ? Colors.grey
                                        : Colors.blue,
                                  ),
                        ),
                      ),
                    ),
                  ],
                )),

            SizedBox(height: TSizes.spaceBtwItems(context)),
            const Divider(
              height: 20,
              thickness: 1.5,
            ),
            SizedBox(height: TSizes.spaceBtwItems(context)),
            const Text(
              "Profile Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textScaleFactor: 1.0,
            ),
            Obx(() => ProfileMenueTile(
                ontab: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNameScreen(),
                      ));
                },
                title: "Name",
                value: controller.user.value.fullName)),
            ProfileMenueTile(ontab: () {}, title: "User Name", value: "appDev"),
            SizedBox(height: TSizes.spaceBtwItems(context)),
            const Divider(
              height: 20,
              thickness: 1.5,
            ),
            SizedBox(height: TSizes.spaceBtwItems(context)),
            const Text(
              "Peresonal Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textScaleFactor: 1.0,
            ),
            ProfileMenueTile(
              ontab: () {},
              title: 'User ID',
              value: '64787',
            ),
            ProfileMenueTile(
              ontab: () {},
              title: 'E-mail',
              value: 'ahmad@gmail.com',
            ),
            ProfileMenueTile(
              ontab: () {},
              title: 'Phone no',
              value: '032364687229',
            ),
            ProfileMenueTile(
              ontab: () {},
              title: 'Date of Birth',
              value: '3 0ct 2025',
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: TSizes.defaultSpace(context) * 2.9,
                  right: TSizes.defaultSpace(context),
                  top: TSizes.defaultSpace(context),
                  bottom: TSizes.defaultSpace(context)),
              child: Container(
                width: THelperFunction.ScreenWidth(context) * .5,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    UserController.instance.deleteAccountWarningPopup(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Text('Delete Account'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
