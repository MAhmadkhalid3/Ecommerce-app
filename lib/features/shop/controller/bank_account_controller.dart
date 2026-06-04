import 'package:get/get.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/loaders.dart';

const String _kBankAccountKey = 'bank_account';

class BankAccountController extends GetxController {
  static BankAccountController get instance => Get.find();

  final _localStorage = TLocalStorage();

  final RxString accountHolderName = ''.obs;
  final RxString bankName = ''.obs;
  final RxString accountNumber = ''.obs;
  final RxString iban = ''.obs;

  bool get hasBankAccount =>
      accountHolderName.value.isNotEmpty && bankName.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _loadBankAccount();
  }

  void _loadBankAccount() {
    final data = _localStorage.readData<Map<String, dynamic>>(_kBankAccountKey);
    if (data == null) return;

    accountHolderName.value = data['accountHolderName'] ?? '';
    bankName.value = data['bankName'] ?? '';
    accountNumber.value = data['accountNumber'] ?? '';
    iban.value = data['iban'] ?? '';
  }

  Future<void> saveBankAccount({
    required String holderName,
    required String bank,
    required String accountNo,
    required String ibanNumber,
  }) async {
    accountHolderName.value = holderName.trim();
    bankName.value = bank.trim();
    accountNumber.value = accountNo.trim();
    iban.value = ibanNumber.trim();

    await _localStorage.saveData(_kBankAccountKey, {
      'accountHolderName': accountHolderName.value,
      'bankName': bankName.value,
      'accountNumber': accountNumber.value,
      'iban': iban.value,
    });

    TLoaders.successSnackBar(
      title: 'Bank account saved',
      message: 'Your bank details have been stored securely on this device.',
    );
  }

  Future<void> clearBankAccount() async {
    accountHolderName.value = '';
    bankName.value = '';
    accountNumber.value = '';
    iban.value = '';
    await _localStorage.removeData(_kBankAccountKey);

    TLoaders.successSnackBar(
      title: 'Removed',
      message: 'Bank account details removed.',
    );
  }
}
