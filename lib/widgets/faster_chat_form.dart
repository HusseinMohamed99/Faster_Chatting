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
  String? _phone;
  CountryCode _countryCode =
      const CountryCode(code: 'EG', dialCode: '+20', name: 'Egypt');
  final FlCountryCodePicker _countryPicker = const FlCountryCodePicker();
  bool _autoValidate = false;

  Future<void> _launchWhatsApp() async {
    if (_formKey.currentState?.validate() ?? false) {
      String sanitizedPhone = _phone?.replaceAll(RegExp(r'\s+'), '') ?? '';
      String url = '${_countryCode.dialCode}$sanitizedPhone';
      Uri uri = Uri.parse('http://wa.me/$url');
      try {
        if (await canLaunchUrl(uri)) {
          log("Launching WhatsApp with URL: $uri");
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          _showErrorSnackBar("Could not launch WhatsApp. Invalid URL.");
          log("Could not launch $uri");
        }
      } catch (e) {
        _showErrorSnackBar("An error occurred while launching WhatsApp.");
        log("Error launching WhatsApp: $e");
      }
    } else if (!_autoValidate) {
      setState(() {
        _autoValidate = true;
      });
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
    return Form(
      key: _formKey,
      autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          PhoneInputRow(
            countryCode: _countryCode,
            onCountryCodeTap: _pickCountryCode,
            onPhoneChanged: (value) => _phone = value,
          ),
          SizedBox(height: 20.h),
          AppTextButton(
            onPressed: () {
              log('${_countryCode.dialCode}$_phone');
              _launchWhatsApp();
            },
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
    );
  }
}
