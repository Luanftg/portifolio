import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.labelText,
    required this.textEditingController,
    this.backgroundColor,
    this.width,
    this.enabled = true,
    this.icon,
    this.onChanged,
    this.validator,
  });

  final TextEditingController textEditingController;
  final Color? backgroundColor;
  final double? width;
  final String labelText;
  final bool enabled;
  final Widget? icon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor ?? Colors.grey.shade800,
        ),
        child: TextFormField(
          enabled: enabled,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            label: Text(labelText),
            icon: icon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: icon,
                  )
                : null,
            contentPadding: const EdgeInsets.all(8),
          ),
          controller: textEditingController,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
