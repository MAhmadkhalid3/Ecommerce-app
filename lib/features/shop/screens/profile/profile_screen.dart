import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top:  TSizes.defaultSpace(context),left: TSizes.defaultSpace(context),right: TSizes.defaultSpace(context)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/products/user_img.jpg"),
                    radius: 45,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Center(child: Text("Change Profile Pic",style: Theme.of(context).textTheme.bodySmall)),
            SizedBox(height: TSizes.spaceBtwItems(context)),
            const Divider(height: 20,thickness: 1.5,),
            SizedBox(height: TSizes.spaceBtwItems(context)),
        const Text(
          "Profile Information",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600 ),
          textScaleFactor: 1.0,
        ),
  ProfileMenueTile(ontab: () {  }, title: 'Name', value: 'Ahmad',),
            ProfileMenueTile(ontab: () {  }, title: 'UserName', value: 'ahmad app dev',),
            const SizedBox(height: 10,),
            const Text(
              "Peresonal Information",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w600 ),
              textScaleFactor: 1.0,
            ),
            ProfileMenueTile(ontab: () {  }, title: 'User ID', value: '64787',),
            ProfileMenueTile(ontab: () {  }, title: 'E-mail', value: 'ahmad@gmail.com',),
            ProfileMenueTile(ontab: () {  }, title: 'Phone no', value: '032364687229',),
            ProfileMenueTile(ontab: () {  }, title: 'Date of Birth', value: '3 0ct 2025',)
          ],
        ),
      ),
    );
  }
}

class ProfileMenueTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback ontab;
  const ProfileMenueTile({

    super.key,  required this.ontab, required this.title, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: [Expanded(flex: 3,child: Text(title,style: Theme.of(context).textTheme.bodySmall,)),Expanded(flex: 3,child: Text(value,style: Theme.of(context).textTheme.bodyMedium,)),IconButton(onPressed:ontab, icon: const Expanded(flex: 2,child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,size: 18)))],);
  }
}
