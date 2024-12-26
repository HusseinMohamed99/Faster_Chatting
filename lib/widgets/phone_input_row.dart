import 'package:faster_chatting/text_input.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneInputRow extends StatelessWidget {
  final CountryCode countryCode;
  final VoidCallback onCountryCodeTap;
  final ValueChanged<String> onPhoneChanged;

  const PhoneInputRow({
    super.key,
    required this.countryCode,
    required this.onCountryCodeTap,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: AppTextFormField(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            validator: (value) => '',
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
        Expanded(
          child: AppTextFormField(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            onChanged: (value) {
              onPhoneChanged(value ?? '');
              return null; // No need to handle null
            },
            validator: Validator(rules: [
              RequiredRule(validationMessage: 'Phone is required'),
              MinLengthRule(9, validationMessage: 'Invalid phone number'),
            ]).call,
            hintText: 'Phone Number',
          ),
        ),
      ],
    );
  }
}
