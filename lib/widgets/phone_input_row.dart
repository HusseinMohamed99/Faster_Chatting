import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numchat/text_input.dart';

class PhoneInputRow extends StatelessWidget {
  final TextEditingController controller;
  final CountryCode countryCode;
  final VoidCallback onCountryCodeTap;
  final ValueChanged<String> onPhoneChanged;

  const PhoneInputRow({
    super.key,
    required this.controller,
    required this.countryCode,
    required this.onCountryCodeTap,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Country Code Button
       SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: AppTextFormField(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              if (value.length < 9) {
                return '';
              }
              return null;
            },
            onChanged: onPhoneChanged,
            prefixIcon: GestureDetector(
              onTap: onCountryCodeTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      countryCode.dialCode,
                    ),
                    SizedBox(width: 8.w),
                    countryCode.flagImage(
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Phone Number Input
        Expanded(
          child: AppTextFormField(
            hintText: 'Phone number',
            controller: controller,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }
              if (value.length < 9) {
                return 'Invalid phone number';
              }
              return null;
            },
            onChanged: onPhoneChanged,
          ),
        ),
      ],
    );
  }
}
