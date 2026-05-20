import 'package:ecommerce/features/shop/controller/user-controller.dart';
import 'package:ecommerce/features/personalization/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../utils/constants/images_string.dart';
import '../../../utils/network/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class ChangeNameController extends GetxController{

  final TextEditingController firstNameController =  TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> saveFormKey = GlobalKey<FormState>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await InitilizeName();

  }
  Future<void> InitilizeName()async {
    final controller= UserController.instance;

    firstNameController.text = controller.user.value.firstName;
    lastNameController.text = controller.user.value.lastName;
  }
  Future<void> updateUserName() async {
    try {
      // Form Validation
      if (!saveFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Updating ...', TImages.lottieDocer);

      // update Name
      await UserRepository.instance.updateSingleField({"firstName": firstNameController.text,
      "lastName": lastNameController.text},);
      UserController.instance.user.value.firstName = firstNameController.text;
      UserController.instance.user.value.lastName = lastNameController.text;
      final controller= UserController.instance;

       controller.user.value.firstName = firstNameController.text;
       controller.user.value.lastName = lastNameController.text;
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "Update Successfully");

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}