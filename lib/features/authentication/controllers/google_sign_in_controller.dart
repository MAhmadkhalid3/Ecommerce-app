
import 'package:get/get.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../utils/constants/images_string.dart';
import '../../../utils/network/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../personalization/models/user_model.dart';

class GoogleSignInController extends GetxController{

  Future<void> signInWithGoogle() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {

        throw Exception('No Internet Connection');

      }
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.lottieDocer);


      final  userCredentials = await AuthenticationRepository
          .instance
          .signInWithGoogle()
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timed out. Check your internet.');
        },
      );
      final  user = userCredentials.user;
      final newUser = UserModel(id: user!.uid, firstName: user.displayName??"", lastName: user.displayName??"", username:user.displayName??"", email: user.email??"", phoneNumber: user.phoneNumber??"", profileImage: user.photoURL??"", createdAt: DateTime.now());
      final userRepo = UserRepository.instance;
     userRepo.saveUserRecord(  newUser);



      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      print(e);
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally{  TFullScreenLoader.stopLoading();}
}}