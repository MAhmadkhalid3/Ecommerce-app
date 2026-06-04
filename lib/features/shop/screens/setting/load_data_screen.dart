import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoadDataScreen extends StatefulWidget {
  const LoadDataScreen({super.key});

  @override
  State<LoadDataScreen> createState() => _LoadDataScreenState();
}

class _LoadDataScreenState extends State<LoadDataScreen> {
  bool _isUploading = false;

  Future<void> _uploadProducts() async {
    setState(() => _isUploading = true);
    try {
      final repo = ProductRepository();
      await repo.uploadProducts();
      TLoaders.successSnackBar(
        title: 'Upload complete',
        message: 'Sample products uploaded to Firebase.',
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Upload failed',
        message: e.toString(),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Load Data',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Iconsax.document_upload, size: 64),
            SizedBox(height: TSizes.spaceBtwItems(context)),
            const Text(
              'Upload sample product data to your Firebase Firestore database. '
              'Use this once during development or when setting up a fresh project.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: TSizes.spaceBtwSections(context)),
            const Text(
              'This will upload 20 sample Nike products. Make sure you are '
              'connected to the internet and Firebase is configured correctly.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: TSizes.spaceBtwSections(context)),
            ElevatedButton.icon(
              onPressed: _isUploading ? null : _uploadProducts,
              icon: _isUploading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Iconsax.cloud_add),
              label: Text(_isUploading ? 'Uploading...' : 'Upload Products'),
            ),
          ],
        ),
      ),
    );
  }
}
