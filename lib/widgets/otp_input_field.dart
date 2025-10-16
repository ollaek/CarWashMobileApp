import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function()? onDeleted;
  final bool isLast;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.onDeleted,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Color(0xFF0D4A58),
        ),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFA0D0D8), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFA0D0D8), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2F6F7A), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
        onTap: () {
          if (controller.text.isNotEmpty) {
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          }
        },
        onFieldSubmitted: (value) {
          if (value.isEmpty && onDeleted != null) {
            onDeleted!();
          }
        },
      ),
    );
  }
}
