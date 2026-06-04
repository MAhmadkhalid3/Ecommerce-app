import 'package:get/get.dart';

import '../../../utils/local_storage/storage_utility.dart';

const String _kNotificationSettingsKey = 'notification_settings';

class NotificationSettingsController extends GetxController {
  static NotificationSettingsController get instance => Get.find();

  final _localStorage = TLocalStorage();

  final RxBool orderUpdates = true.obs;
  final RxBool promotions = false.obs;
  final RxBool emailAlerts = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    final data = _localStorage.readData<Map<String, dynamic>>(_kNotificationSettingsKey);
    if (data == null) return;

    orderUpdates.value = data['orderUpdates'] ?? true;
    promotions.value = data['promotions'] ?? false;
    emailAlerts.value = data['emailAlerts'] ?? true;
  }

  Future<void> _saveSettings() async {
    await _localStorage.saveData(_kNotificationSettingsKey, {
      'orderUpdates': orderUpdates.value,
      'promotions': promotions.value,
      'emailAlerts': emailAlerts.value,
    });
  }

  void toggleOrderUpdates(bool value) {
    orderUpdates.value = value;
    _saveSettings();
  }

  void togglePromotions(bool value) {
    promotions.value = value;
    _saveSettings();
  }

  void toggleEmailAlerts(bool value) {
    emailAlerts.value = value;
    _saveSettings();
  }
}
