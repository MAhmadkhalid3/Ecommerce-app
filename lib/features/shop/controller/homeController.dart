import 'package:get/get.dart';

class Homecontroller extends GetxController {
  final currentIndex = 0.obs;
  void updateCurserIndicator(index) {
    currentIndex.value = index;
  }
}
