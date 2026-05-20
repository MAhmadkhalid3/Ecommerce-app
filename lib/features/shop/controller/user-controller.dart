import 'dart:io';
import 'package:ecommerce/features/personalization/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images_string.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/http/Image_upload.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../screens/reauthenticate_user/reauthenticate_user_screen.dart';


class UserController extends GetxController {
  static UserController get instance => Get.find();

  // Variables
  Rx<UserModel> user = UserModel.empty().obs;
  Rx<bool> isloading = false.obs;

  // ✅ Naya Add Kiya
  Rx<File?> profileImage = Rx<File?>(null);
  Rx<bool> isUploadingImage = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchUserDetail();
  }

  Future<void> fetchUserDetail() async {
    try {
      isloading.value = true;
      final user = await UserRepository.instance.fetchUserDetail();
      this.user.value = user;
    } catch (e) {
      this.user.value = UserModel.empty();
    } finally {
      isloading.value = false;
    }
  }

  // ================================
  // ✅ Image Pick
  // ================================
  Future<void> pickAndUploadImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile == null) return;

      // Foran show karo
      profileImage.value = File(pickedFile.path);
      isUploadingImage.value = true;

      // Cloudinary pe upload karo
      final url = await CloudinaryHelper.uploadImage(profileImage.value!);

      // Firebase mein URL save karo
      await UserRepository.instance.updateSingleField({"profileImage": url});

      // User model update karo
      user.value.profileImage = url;
      user.refresh();

      isUploadingImage.value = false;
      TLoaders.successSnackBar(
        title: "Done!",
        message: "Profile picture update ",
      );
    } catch (e) {;
      isUploadingImage.value = false;
      TLoaders.warningSnackBar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  // ================================
  // ✅ Bottom Sheet
  // ================================
  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading:  Icon(Icons.photo_library,color: TColors.primary,),
              title: const Text("Gallery "),
              onTap: () {
                Navigator.pop(context);
                pickAndUploadImage(ImageSource.gallery);
              },
            ),

            ListTile(
              leading: const Icon(Icons.camera_alt,color: TColors.primary),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                pickAndUploadImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Delete Account Warning
  void deleteAccountWarningPopup(BuildContext context) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSizes.md(context)),
      title: 'Delete Account',
      middleText:
      'Are you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg(context)),
          child: const Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  // Delete User Account
  Future<void> deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.lottieDocer);
      final auth = AuthenticationRepository.instance;
      final provider = auth.currentUser?.providerData.first.providerId;
      if (provider != null) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      } else {
        TFullScreenLoader.stopLoading();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}