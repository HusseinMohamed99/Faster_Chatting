import 'dart:developer';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numchat/Core/app_buttons.dart';
import 'package:numchat/Core/color_manager.dart';
import 'package:numchat/Core/style_manager.dart';
import 'package:numchat/widgets/footer_section.dart';
import 'package:numchat/widgets/phone_input_row.dart';
import 'package:url_launcher/url_launcher.dart';

// Form with country picker + WhatsApp launcher + validation
class NumChatForm extends StatefulWidget {
  const NumChatForm({super.key});

  @override
  State<NumChatForm> createState() => _NumChatFormState();
}

class _NumChatFormState extends State<NumChatForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  CountryCode _countryCode =
      const CountryCode(code: 'EG', dialCode: '+20', name: 'Egypt');
  final FlCountryCodePicker _countryPicker = const FlCountryCodePicker();
  bool _autoValidate = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // Handles WhatsApp redirection logic
  Future<void> _launchWhatsApp() async {
    log("Validating form...");
    if (_formKey.currentState?.validate() ?? false) {
      final fullNumber =
          '${_countryCode.dialCode}${_phoneController.text.trim()}';
      final Uri uri = Uri.parse('https://wa.me/$fullNumber');

      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          _showErrorSnackBar("Could not launch WhatsApp. Invalid URL.");
        }
      } catch (e) {
        _showErrorSnackBar("An error occurred while launching WhatsApp.");
        log("Launch error: $e");
      }
    } else {
      setState(() => _autoValidate = true);
      _showErrorSnackBar("Please correct the errors in the form.");
    }
  }

  Future<void> _pickCountryCode() async {
    final CountryCode? selectedCountry = await _countryPicker.showPicker(
      context: context,
      initialSelectedLocale: 'EG',
    );
    if (selectedCountry != null) {
      setState(() => _countryCode = selectedCountry);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            PhoneInputRow(
              controller: _phoneController,
              countryCode: _countryCode,
              onCountryCodeTap: _pickCountryCode,
              onPhoneChanged: (_) {},
            ),
            SizedBox(height: 20.h),
            AppTextButton(
              onPressed: _launchWhatsApp,
              buttonText: 'Send Message',
              textStyle: StyleManager.font15.copyWith(
                color: ColorManager.whiteColor,
              ),
              backgroundColor: ColorManager.darkBlueColor,
            ),
            const Spacer(),
            const FooterSection(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
