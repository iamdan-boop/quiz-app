import 'package:flutter/material.dart';
import 'package:quiz_app/app/styles/app_colors.dart';
import 'package:quiz_app/app/styles/text_styles.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.headingText,
    required this.hintText,
    required this.obsecureText,
    this.suffixIcon,
    this.textInputType,
    this.textInputAction,
    this.controller,
    required this.maxLines,
    this.onChanged,
  }) : super(key: key);

  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final int maxLines;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headingText,
            style: KTextStyle.textFieldHeading,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: AppColors.grayshade,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              onChanged: onChanged,
              maxLines: maxLines,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              obscureText: obsecureText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: KTextStyle.textFieldHintStyle,
                border: InputBorder.none,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        )
      ],
    );
  }
}
