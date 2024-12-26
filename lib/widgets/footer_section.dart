import 'package:faster_chatting/Core/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Core/style_manager.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: ColorManager.semiDarkBlueColor,
        borderRadius: BorderRadius.all(Radius.circular(12).r),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Created By: ',
              style: StyleManager.font13LighterGrayRegular,
            ),
            TextSpan(
              text: 'Hussein Mohamed\n',
              style: StyleManager.font18.copyWith(
                color: ColorManager.yellowColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'Mobile Application Developer',
              style: StyleManager.font15,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
