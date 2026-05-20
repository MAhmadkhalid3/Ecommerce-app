import 'dart:convert';
import 'package:ecommerce/data/repositories/user_repository.dart';
import 'package:ecommerce/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce/features/authentication/screens/on_boarding/on_boarding.dart';
import 'package:ecommerce/features/authentication/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../../bottomNavigatorBar/bottombar.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/firebase_exception.dart';
import '../../utils/exceptions/platform_exception.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variable
  final deviceStorage = GetStorage();
  FirebaseAuth get _auth => FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const BottomNavigatorBar());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: user.email,
            ));
      }
    } else {
      deviceStorage.writeIfNull("isFirstTime", true);
      deviceStorage.read("isFirstTime") != true
          ? Get.offAll(const LoginScreen())
          : Get.offAll(OnBoarding());
    }
  }

  /// EmailAuthentication - SignIn

  Future<UserCredential> loginWithEmailOrPassword(
      String email, String password)
  async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// SignUp User  - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  )
  async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    // } on FirebaseAuthException catch (e) {
    //   throw TFirebaseAuthException(e.code).message;
    // } on FirebaseException catch (e) {
    //   throw TFirebaseException(e.code).message;
    // } on FormatException catch (e) {
    //   throw TFirebaseAuthException(e.message);
    // } on PlatformException catch (e) {
    //   throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Google Authentication
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Reauth User
  Future<UserCredential> ReAuthUserWithEmailOrPassword(
      String email, String password)
  async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      return await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// Reset Password
  Future<void> forgetPassword(String email)
  async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// DELETE USER - Remove user Auth and Firestore Account.
  Future<void> deleteAccount()
  async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFirebaseAuthException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification()
  async {
    try {
      await _auth.currentUser!.reload(); // important
      final user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future sendEmail(String email) async
  {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': 'service_tq6ylcp',
        'template_id': 'template_yt2738i',
        'user_id': 'DcghQLLjoDcFBtz0S',
        'template_params': {
          'username': 'Ahmad',
          'message': 'Hello from Flutter',
          'to_email': "dg4784h@gmail.com"
        }
      }),
    );

    print(response.statusCode);
    print(response.body);
  }
}
