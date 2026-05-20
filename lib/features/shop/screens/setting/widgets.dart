import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/features/shop/controller/user-controller.dart';
import 'package:ecommerce/utils/popups/shmiled_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/screens/login/login_screen.dart';
import '../profile/profile_screen.dart';
class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () async {
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();

      Get.offAll(() => const LoginScreen());
    },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(
              TSizes.cardRadiusLg(context),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text("Logout",style: Theme.of(context).textTheme.bodyLarge,),),
          )
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return InkWell(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfileScreen()));},
      child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: Obx(() {
          // Local file selected hai (abhi upload ho raha hai)
          if (controller.profileImage.value != null) {
            return CircleAvatar(
              radius: 28,
              backgroundImage: FileImage(controller.profileImage.value!),
            );
          }

          // Network image with cache
          if (controller.user.value.profileImage.isNotEmpty) {
            return CachedNetworkImage(
              imageUrl: controller.user.value.profileImage,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 28,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) =>  Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage("assets/images/products/user_img.jpg"),
              ),
            );
          }

          // Default asset image
          return const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage("assets/images/products/user_img.jpg"),
          );
        }),
        title: Obx(()=>controller.isloading.value?TShimmerEffect(width: 30, height: 16): Text(controller.user.value.firstName,style: Theme.of(context).textTheme.headlineSmall!.apply(color:  THelperFunction.isDrak(context)?Colors.black:Colors.white),)),
        subtitle: Obx(()=> controller.isloading.value?TShimmerEffect(width: 30, height: 16):Text(controller.user.value.email,style: Theme.of(context).textTheme.bodyLarge!.apply(color:  THelperFunction.isDrak(context)?Colors.black:Colors.white),)),
        trailing: IconButton( icon: const Icon(Iconsax.edit),color: THelperFunction.isDrak(context)?Colors.black:Colors.white,onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),));},),
      ),
    );
  }
}

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: TColors.primary),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}