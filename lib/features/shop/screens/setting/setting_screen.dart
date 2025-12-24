import 'package:ecommerce/features/shop/screens/profile/profile_screen.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/customShapes/curves_edges.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
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
                        Text(
                          "Account",
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color:  THelperFunction.isDrak(context)?Colors.black:Colors.white)
                        ),
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
            
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
            "Account Settings",
            style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600,),
            textScaleFactor: 1.0,
            ),
            const SettingsMenuTile(
              icon: Iconsax.safe_home,
              title: 'My Addresses',
              subTitle: 'Set shopping delivery address',
            ),
            const SettingsMenuTile(
              icon: Iconsax.shopping_cart,
              title: 'My Cart',
              subTitle: 'Add, remove products and move to checkout',
            ),
            const SettingsMenuTile(
              icon: Iconsax.bag_tick,
              title: 'My Orders',
              subTitle: 'In-progress and Completed Orders',
            ),
            const SettingsMenuTile(
              icon: Iconsax.bank,
              title: 'Bank Account',
              subTitle: 'Withdraw balance to registered bank account',
            ),
            const SettingsMenuTile(
              icon: Iconsax.discount_shape,
              title: 'My Coupons',
              subTitle: 'List of all the discounted coupons',
            ),
            const SettingsMenuTile(
              icon: Iconsax.notification,
              title: 'Notifications',
              subTitle: 'Set any kind of notification message',
            ),
            const SettingsMenuTile(
              icon: Iconsax.security_card,
              title: 'Account Privacy',
              subTitle: 'Manage data usage and connected accounts',
            ),
            
            /// -- App Settings
            SizedBox(height: TSizes.spaceBtwSections(context)),
            const Text(
              "App Settings",
              style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600,),
              textScaleFactor: 1.0,
            ),
            SizedBox(height: TSizes.spaceBtwItems(context)),
            const SettingsMenuTile(
              icon: Iconsax.document_upload,
              title: 'Load Data',
              subTitle: 'Upload Data to your Cloud Firebase',
            ),
            SettingsMenuTile(
              icon: Iconsax.location,
              title: 'Geolocation',
              subTitle: 'Set recomentation based on location',
              trailing: Switch(value: false, onChanged: (value){}),
            ),
            SettingsMenuTile(
              icon: Iconsax.security_user,
              title: 'Safe Mode',
              subTitle: 'Search result is safe for all ages',
              trailing: Switch(value: true, onChanged: (value){}),
            ),
            SettingsMenuTile(
              icon: Iconsax.image,
              title: 'HD Image Quality',
              subTitle: 'Set image quality to be safe',
              trailing: Switch(value: false, onChanged: (value){}),
            ),
              SizedBox(height: TSizes.spaceBtwItems(context),),
              const LogoutButton(),
            SizedBox(height: TSizes.spaceBtwItems(context),)
          ],
        ),
            )
          ],
        ),
      ),
    
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    return InkWell(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfileScreen()));},
      child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: const CircleAvatar(
          backgroundImage:
              AssetImage("assets/images/products/user_img.jpg"),
          radius: 22,
        ),
        title: Text("Ahmad ",style: Theme.of(context).textTheme.headlineSmall!.apply(color:  THelperFunction.isDrak(context)?Colors.black:Colors.white),),
        subtitle: Text("M.Ahmad@gmail.com",style: Theme.of(context).textTheme.bodyLarge!.apply(color:  THelperFunction.isDrak(context)?Colors.black:Colors.white),),
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
