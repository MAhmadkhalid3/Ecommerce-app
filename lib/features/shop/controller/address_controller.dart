import 'package:get/get.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/loaders.dart';
import '../models/address_model.dart';

const String _kAddressesStorageKey = 'user_addresses';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final _localStorage = TLocalStorage();
  final RxList<AddressModel> addresses = <AddressModel>[].obs;

  AddressModel? get defaultAddress {
    return addresses.firstWhereOrNull((a) => a.isDefault) ??
        (addresses.isNotEmpty ? addresses.first : null);
  }

  @override
  void onInit() {
    super.onInit();
    _loadAddressesFromStorage();
  }

  void _loadAddressesFromStorage() {
    try {
      final raw = _localStorage.readData<List<dynamic>>(_kAddressesStorageKey);
      if (raw == null || raw.isEmpty) return;

      final loaded = raw
          .map((e) => AddressModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .where((a) => a.id.isNotEmpty)
          .toList();

      addresses.assignAll(loaded);
    } catch (_) {
      addresses.clear();
      _localStorage.removeData(_kAddressesStorageKey);
    }
  }

  Future<void> _saveAddressesToStorage() async {
    final data = addresses.map((a) => a.toJson()).toList();
    await _localStorage.saveData(_kAddressesStorageKey, data);
  }

  void _persist() {
    addresses.refresh();
    _saveAddressesToStorage();
  }

  Future<void> addAddress(
    AddressModel address, {
    bool showSnackBar = true,
  }) async {
    final list = List<AddressModel>.from(addresses);

    if (list.isEmpty || address.isDefault) {
      for (var i = 0; i < list.length; i++) {
        list[i] = list[i].copyWith(isDefault: false);
      }
    }

    final newAddress = list.isEmpty
        ? address.copyWith(isDefault: true)
        : address;

    list.add(newAddress);
    addresses.assignAll(list);
    _persist();

    if (showSnackBar) {
      TLoaders.successSnackBar(
        title: 'Address saved',
        message: 'Delivery address added successfully.',
      );
    }
  }

  Future<bool> updateAddress(
    AddressModel address, {
    bool showSnackBar = true,
  }) async {
    final index = addresses.indexWhere((a) => a.id == address.id);
    if (index < 0) return false;

    final list = List<AddressModel>.from(addresses);

    if (address.isDefault) {
      for (var i = 0; i < list.length; i++) {
        list[i] = list[i].copyWith(isDefault: i == index ? true : false);
      }
      list[index] = address;
    } else {
      list[index] = address;
    }

    addresses.assignAll(list);
    _persist();

    if (showSnackBar) {
      TLoaders.successSnackBar(
        title: 'Address updated',
        message: 'Your address has been saved.',
      );
    }
    return true;
  }

  Future<void> deleteAddress(String addressId) async {
    final list = List<AddressModel>.from(addresses);
    final removed = list.firstWhereOrNull((a) => a.id == addressId);
    if (removed == null) return;

    list.removeWhere((a) => a.id == addressId);

    if (removed.isDefault && list.isNotEmpty) {
      list[0] = list[0].copyWith(isDefault: true);
    }

    addresses.assignAll(list);
    _persist();

    TLoaders.successSnackBar(
      title: 'Address removed',
      message: 'Delivery address deleted.',
    );
  }

  Future<void> setDefaultAddress(String addressId) async {
    final list = addresses
        .map((a) => a.copyWith(isDefault: a.id == addressId))
        .toList();

    addresses.assignAll(list);
    _persist();
  }
}
