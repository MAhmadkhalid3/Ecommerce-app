import 'package:get/get.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/loaders.dart';

const String _kAppSettingsKey = 'app_settings';

class AppSettingsController extends GetxController {
  static AppSettingsController get instance => Get.find();

  final _localStorage = TLocalStorage();

  final RxBool geolocationEnabled = false.obs;
  final RxBool safeModeEnabled = true.obs;
  final RxBool hdImageQuality = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    final data = _localStorage.readData<Map<String, dynamic>>(_kAppSettingsKey);
    if (data == null) return;

    geolocationEnabled.value = data['geolocation'] ?? false;
    safeModeEnabled.value = data['safeMode'] ?? true;
    hdImageQuality.value = data['hdImageQuality'] ?? false;
  }

  Future<void> _saveSettings() async {
    await _localStorage.saveData(_kAppSettingsKey, {
      'geolocation': geolocationEnabled.value,
      'safeMode': safeModeEnabled.value,
      'hdImageQuality': hdImageQuality.value,
    });
  }

  void toggleGeolocation(bool value) {
    geolocationEnabled.value = value;
    _saveSettings();
    TLoaders.successSnackBar(
      title: 'Geolocation',
      message: value
          ? 'Location-based recommendations enabled.'
          : 'Location-based recommendations disabled.',
    );
  }

  void toggleSafeMode(bool value) {
    safeModeEnabled.value = value;
    _saveSettings();
  }

  void toggleHdImageQuality(bool value) {
    hdImageQuality.value = value;
    _saveSettings();
    TLoaders.successSnackBar(
      title: 'Image quality',
      message: value ? 'HD images enabled.' : 'Standard image quality.',
    );
  }
}
