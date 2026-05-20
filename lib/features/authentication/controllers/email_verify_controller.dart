import 'dart:async';
import 'package:ecommerce/common/widgets/success_screen.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../bottomNavigatorBar/bottombar.dart';
import '../../../utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  Timer? _timer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sendEmailVerification();
    setTimerForAutoRedirect();
  }
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
/// Send Email Verification and show snack bar
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: "Please check you inbox and verify your email");
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  setTimerForAutoRedirect(){
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async{
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if(user?.emailVerified ?? false){
        timer.cancel();

        Get.off(SuccessScreen(
          image: 'assets/images/animations/72462-check-register.json',
          title: 'Your account successfully created',
          subTitle: 'Welcome to Your Ultimate Shopping Destination',
          onPressed: () {
            Get.offAll(BottomNavigatorBar());
          },
        ));
      }
    });
  }
  checkEmailVerificationStatus()async{
    await FirebaseAuth.instance.currentUser?.reload();
    final user =  FirebaseAuth.instance.currentUser;
    if(user?.emailVerified??false){
      Get.off(SuccessScreen(image: 'assets/images/animations/72462-check-register.json', title: 'Your account successfully created', subTitle: 'Welcome to Your Ultimate Shopping Destination Your Account is Created, Unleash the Joy of Seamless Online Shopping!', onPressed: () {Get.offAll(HomeScreen()) ; },));
    }
  }

}

