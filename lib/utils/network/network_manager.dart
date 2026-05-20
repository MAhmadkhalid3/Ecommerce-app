import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../popups/loaders.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();

  // 🔹 UPDATED: List<ConnectivityResult>
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final Rx<ConnectivityResult> _connectionStatus =
      ConnectivityResult.none.obs;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((results) {
          // 🔹 List se first result le rahe hain
          _updateConnectionStatus(results.first);
        });
  }

  /// Update the connection status based on changes in connectivity
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;

    if (result == ConnectivityResult.none) {
      TLoaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  /// Check the internet connection status.
  /// Returns true if connected, false otherwise.
  Future<bool> isConnected() async {
    try {
      final results = await _connectivity.checkConnectivity();

      return results.any(
            (result) => result != ConnectivityResult.none,
      );
    } catch (e) {
      return false;
    }
  }


  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
