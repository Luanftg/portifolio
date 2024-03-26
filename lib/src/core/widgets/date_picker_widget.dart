import 'package:flutter/material.dart';
import 'package:portifolio/src/core/extensions/date_format_extension.dart';
import 'package:portifolio/src/core/widgets/text_form_widget.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    super.key,
    required this.label,
    this.onChanged,
    this.validator,
    this.controller,
  });

  final String label;
  final Function(String)? onChanged;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = widget.controller ??
        TextEditingController(text: DateTime.now().toBrasilianFormat());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDatePicker(context),
      child: TextFormWidget(
        labelText: widget.label,
        validator: widget.validator,
        enabled: false,
        icon: const Icon(Icons.date_range_outlined),
        textEditingController: _textEditingController,
        onChanged: widget.onChanged,
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      context: context,
      lastDate: DateTime.now(),
    );

    if (datePicked != null) {
      _textEditingController.text = datePicked.toBrasilianFormat();
    }
  }
}
