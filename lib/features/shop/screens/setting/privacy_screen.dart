import 'package:ecommerce/common/widgets/home_Widgets/custom_appbar.dart';
import 'package:ecommerce/features/shop/screens/profile/profile_screen.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Account Privacy',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Last updated: ${DateTime.now().year}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: TSizes.spaceBtwItems(context)),
            const _PrivacySection(
              title: 'Introduction',
              body:
                  'Welcome to our e-commerce application. We are committed to protecting '
                  'your personal information and your right to privacy. This Privacy Policy '
                  'explains how we collect, use, disclose, and safeguard your information when '
                  'you use our mobile application, including when you create an account, browse '
                  'products, add items to your cart, save delivery addresses, place orders, and '
                  'manage your notification preferences.\n\n'
                  'Please read this policy carefully. If you do not agree with the terms of this '
                  'privacy policy, please discontinue use of the application. By continuing to '
                  'use the app, you acknowledge that you have read and understood this policy.',
            ),
            const _PrivacySection(
              title: 'Information We Collect',
              body:
                  'We may collect information that you voluntarily provide when using the app, '
                  'including but not limited to:\n\n'
                  '• Personal identification information such as your full name, email address, '
                  'and profile photograph when you register or update your account.\n'
                  '• Contact details including your mobile phone number when provided during '
                  'checkout or address management.\n'
                  '• Delivery and billing addresses that you save for shipping purposes.\n'
                  '• Shopping activity such as products added to your cart, wishlist items, '
                  'and order history including payment method selection and order totals.\n'
                  '• Communication preferences including whether you wish to receive order '
                  'updates, promotional offers, or email alerts.\n\n'
                  'We may also automatically collect certain technical information when you use '
                  'the app, such as device type, operating system version, and general usage '
                  'patterns to improve app performance and user experience.',
            ),
            const _PrivacySection(
              title: 'How We Use Your Information',
              body:
                  'We use the information we collect for legitimate business purposes, including:\n\n'
                  '• To create and manage your user account and authenticate your identity.\n'
                  '• To process and fulfill your orders, including arranging delivery to your '
                  'saved addresses.\n'
                  '• To communicate with you about your orders, account, or customer service '
                  'requests.\n'
                  '• To send notifications you have opted in to receive, such as order status '
                  'updates or promotional messages.\n'
                  '• To personalize your shopping experience and display relevant products.\n'
                  '• To maintain the security and integrity of our platform and prevent fraud.\n'
                  '• To comply with applicable legal obligations and resolve disputes.\n\n'
                  'We will not use your personal information for purposes incompatible with those '
                  'described in this policy without notifying you and, where required, obtaining '
                  'your consent.',
            ),
            const _PrivacySection(
              title: 'Data Storage',
              body:
                  'Your data may be stored in two ways:\n\n'
                  '• Cloud storage: Account profile information is stored securely using '
                  'Firebase Authentication and Cloud Firestore when you are signed in. This '
                  'allows your profile to sync across sessions and devices linked to your account.\n'
                  '• Local storage: Cart items, saved addresses, order history, and notification '
                  'settings are stored on your device using secure local storage. This data '
                  'remains on your device and helps the app function quickly even when offline.\n\n'
                  'Local data is associated with your installation of the app. If you uninstall '
                  'the application or clear app data from your device settings, locally stored '
                  'information may be permanently deleted.',
            ),
            const _PrivacySection(
              title: 'Sharing of Your Information',
              body:
                  'We do not sell, rent, or trade your personal information to third parties for '
                  'their marketing purposes. We may share your information only in the following '
                  'circumstances:\n\n'
                  '• With service providers who assist us in operating the app, such as cloud '
                  'hosting and authentication services, subject to confidentiality agreements.\n'
                  '• With delivery partners when necessary to ship your orders to the address you '
                  'provide.\n'
                  '• When required by law, court order, or governmental authority.\n'
                  '• To protect the rights, property, or safety of our users, employees, or others.\n\n'
                  'Any third party receiving your data is expected to handle it in accordance '
                  'with applicable privacy laws and only for the specified purpose.',
            ),
            const _PrivacySection(
              title: 'Your Rights & Choices',
              body:
                  'Depending on your location, you may have certain rights regarding your personal '
                  'data, including:\n\n'
                  '• The right to access and review the personal information we hold about you.\n'
                  '• The right to correct inaccurate or incomplete profile information through '
                  'the profile settings screen.\n'
                  '• The right to delete saved addresses or clear your cart at any time.\n'
                  '• The right to manage notification preferences in the Notifications settings.\n'
                  '• The right to sign out of your account, which ends your active session.\n\n'
                  'To request deletion of your cloud-stored account data, you may contact us using '
                  'the support channels listed in the app. We will respond to legitimate requests '
                  'within a reasonable timeframe.',
            ),
            const _PrivacySection(
              title: 'Data Security',
              body:
                  'We implement appropriate technical and organizational security measures designed '
                  'to protect your personal information against unauthorized access, alteration, '
                  'disclosure, or destruction. These measures include secure authentication, '
                  'encrypted connections where supported, and restricted access to user data.\n\n'
                  'However, no method of transmission over the internet or electronic storage is '
                  '100% secure. While we strive to protect your information, we cannot guarantee '
                  'absolute security. You are responsible for keeping your login credentials '
                  'confidential and notifying us immediately if you suspect unauthorized access '
                  'to your account.',
            ),
            const _PrivacySection(
              title: 'Children\'s Privacy',
              body:
                  'Our application is not intended for use by children under the age of 13 (or '
                  'the minimum age required in your jurisdiction). We do not knowingly collect '
                  'personal information from children. If you believe we have inadvertently collected '
                  'information from a child, please contact us so we can promptly delete such data.',
            ),
            const _PrivacySection(
              title: 'Changes to This Policy',
              body:
                  'We may update this Privacy Policy from time to time to reflect changes in our '
                  'practices, technology, legal requirements, or other factors. When we make '
                  'material changes, we will update the "Last updated" date at the top of this '
                  'screen. We encourage you to review this policy periodically to stay informed '
                  'about how we protect your information.\n\n'
                  'Your continued use of the app after any changes constitutes acceptance of the '
                  'updated policy.',
            ),
            const _PrivacySection(
              title: 'Contact Us',
              body:
                  'If you have questions, concerns, or requests regarding this Privacy Policy or '
                  'your personal data, please reach out through the customer support section of '
                  'the app or contact your account administrator. We are committed to addressing '
                  'your privacy-related inquiries in a timely and transparent manner.\n\n'
                  'Thank you for trusting us with your information. We value your privacy and '
                  'are dedicated to maintaining a safe and secure shopping experience.',
            ),
            SizedBox(height: TSizes.spaceBtwSections(context)),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              icon: const Icon(Iconsax.edit),
              label: const Text('Manage Profile'),
            ),
            SizedBox(height: TSizes.spaceBtwSections(context)),
          ],
        ),
      ),
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(height: 1.6, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
