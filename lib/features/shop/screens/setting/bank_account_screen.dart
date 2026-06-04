import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/controller/bank_account_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _holderController;
  late final TextEditingController _bankController;
  late final TextEditingController _accountController;
  late final TextEditingController _ibanController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final c = BankAccountController.instance;
    _holderController = TextEditingController(text: c.accountHolderName.value);
    _bankController = TextEditingController(text: c.bankName.value);
    _accountController = TextEditingController(text: c.accountNumber.value);
    _ibanController = TextEditingController(text: c.iban.value);
  }

  @override
  void dispose() {
    _holderController.dispose();
    _bankController.dispose();
    _accountController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    await BankAccountController.instance.saveBankAccount(
      holderName: _holderController.text,
      bank: _bankController.text,
      accountNo: _accountController.text,
      ibanNumber: _ibanController.text,
    );

    if (mounted) {
      setState(() => _isSaving = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Bank Account',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Save your bank details for refunds or withdrawals. '
                'Information is stored locally on this device only.',
                style: TextStyle(height: 1.5),
              ),
              SizedBox(height: TSizes.spaceBtwSections(context)),
              TextFormField(
                controller: _holderController,
                decoration: const InputDecoration(
                  labelText: 'Account Holder Name',
                  prefixIcon: Icon(Iconsax.user),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _bankController,
                decoration: const InputDecoration(
                  labelText: 'Bank Name',
                  prefixIcon: Icon(Iconsax.bank),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Account Number',
                  prefixIcon: Icon(Iconsax.card),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _ibanController,
                decoration: const InputDecoration(
                  labelText: 'IBAN (optional)',
                  prefixIcon: Icon(Iconsax.document),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections(context)),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Bank Account'),
              ),
              Obx(() {
                if (!BankAccountController.instance.hasBankAccount) {
                  return const SizedBox.shrink();
                }
                return TextButton(
                  onPressed: () async {
                    await BankAccountController.instance.clearBankAccount();
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Remove saved account',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
