import 'dart:developer';

import 'package:faster_chatting/Core/app_buttons.dart';
import 'package:faster_chatting/Core/color_manager.dart';
import 'package:faster_chatting/Core/style_manager.dart';
import 'package:faster_chatting/widgets/footer_section.dart';
import 'package:faster_chatting/widgets/phone_input_row.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FasterChatForm extends StatefulWidget {
  const FasterChatForm({super.key});

  @override
  State<FasterChatForm> createState() => _FasterChatFormState();
}

class _FasterChatFormState extends State<FasterChatForm> {
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

  Future<void> _launchWhatsApp() async {
    log("Form validation status: ${_formKey.currentState?.validate()}");
    log("Phone: ${_phoneController.text}");
    log("Country code: ${_countryCode.dialCode}");

    if (_formKey.currentState?.validate() ?? false) {
      String sanitizedPhone =
          _phoneController.text.replaceAll(RegExp(r'\s+'), '');
      String url = 'https://wa.me/${_countryCode.dialCode}$sanitizedPhone';
      Uri uri = Uri.parse(url);

      log("Generated URL: $url");

      try {
        if (await canLaunchUrl(uri)) {
          log("Launching WhatsApp...");
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          _showErrorSnackBar("Could not launch WhatsApp. Invalid URL.");
          log("Could not launch $uri");
        }
      } catch (e) {
        _showErrorSnackBar("An error occurred while launching WhatsApp.");
        log("Error launching WhatsApp: $e");
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
      _showErrorSnackBar("Please correct the errors in the form.");
    }
  }

  Future<void> _pickCountryCode() async {
    final CountryCode? selectedCountry = await _countryPicker.showPicker(
      context: context,
      initialSelectedLocale: 'EG',
    );
    if (selectedCountry != null) {
      setState(() {
        _countryCode = selectedCountry;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
              onPhoneChanged: (value) {
                setState(() {});
              },
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
