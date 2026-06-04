import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/controller/address_controller.dart';
import 'package:ecommerce/features/shop/models/address_model.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:ecommerce/utils/validator/validator.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key, this.address});

  final AddressModel? address;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalController = TextEditingController();
  final _countryController = TextEditingController(text: 'Pakistan');

  String _addressType = 'Home';
  bool _isDefault = false;
  bool _isSaving = false;

  bool get _isEditing => widget.address != null;

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    if (a != null) {
      _nameController.text = a.fullName;
      _phoneController.text = a.phoneNumber;
      _streetController.text = a.street;
      _cityController.text = a.city;
      _stateController.text = a.state;
      _postalController.text = a.postalCode;
      _countryController.text = a.country;
      _addressType = a.addressType;
      _isDefault = a.isDefault;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final controller = AddressController.instance;
    final address = AddressModel(
      id: widget.address?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      street: _streetController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      postalCode: _postalController.text.trim(),
      country: _countryController.text.trim(),
      addressType: _addressType,
      isDefault: _isDefault,
    );

    final bool saved;
    if (_isEditing) {
      saved = await controller.updateAddress(address, showSnackBar: false);
    } else {
      await controller.addAddress(address, showSnackBar: false);
      saved = true;
    }

    if (!saved || !mounted) {
      if (mounted) setState(() => _isSaving = false);
      return;
    }

    setState(() => _isSaving = false);
    Navigator.of(context).pop();

    TLoaders.successSnackBar(
      title: _isEditing ? 'Address updated' : 'Address saved',
      message: _isEditing
          ? 'Your address has been saved.'
          : 'Delivery address added successfully.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          _isEditing ? 'Edit Address' : 'Add Address',
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
              DropdownButtonFormField<String>(
                value: _addressType,
                decoration: const InputDecoration(
                  labelText: 'Address Type',
                  prefixIcon: Icon(Icons.home_outlined),
                ),
                items: const ['Home', 'Office', 'Other']
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _addressType = value);
                },
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name is required.' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '03XXXXXXXXX',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: TValidator.validatePhoneNumber,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _streetController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Street address is required.'
                    : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  prefixIcon: Icon(Icons.location_city_outlined),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'City is required.' : null,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'State / Province (optional)',
                  prefixIcon: Icon(Icons.map_outlined),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _postalController,
                decoration: const InputDecoration(
                  labelText: 'Postal Code (optional)',
                  prefixIcon: Icon(Icons.markunread_mailbox_outlined),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields(context)),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  prefixIcon: Icon(Icons.public_outlined),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Country is required.'
                    : null,
              ),
              SizedBox(height: TSizes.spaceBtwItems(context)),
              SwitchListTile(
                value: _isDefault,
                onChanged: (v) => setState(() => _isDefault = v),
                title: const Text('Set as default address'),
                subtitle: const Text('Used for checkout & delivery'),
              ),
              SizedBox(height: TSizes.spaceBtwSections(context)),
              ElevatedButton(
                onPressed: _isSaving ? null : _saveAddress,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_isEditing ? 'Update Address' : 'Save Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
