import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:portifolio/src/core/services/file_picker_service.dart';

import 'package:portifolio/src/core/validators/validators.dart';
import 'package:portifolio/src/core/widgets/text_form_widget.dart';

enum PickerFileState { initial, loading, picking, picked, error }

class FilePickerWidget extends StatefulWidget {
  const FilePickerWidget({
    super.key,
    required TextEditingController fileController,
    required FilePickerService filePickerService,
    this.labelText,
    this.onPickedFile,
  })  : _fileController = fileController,
        _filePickerService = filePickerService;

  final TextEditingController _fileController;
  final FilePickerService _filePickerService;
  final void Function(Uint8List uint8List)? onPickedFile;

  final String? labelText;

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  final ValueNotifier<PickerFileState> state =
      ValueNotifier(PickerFileState.initial);

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: state,
      builder: (context, value, child) {
        late Widget icon;
        if (value == PickerFileState.initial) {
          icon = const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.upload_file),
          );
        } else if (value == PickerFileState.error) {
          icon = const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.error_outline_rounded, color: Colors.red),
          );
        } else if (value == PickerFileState.picked) {
          icon = const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.upload_file, color: Colors.green),
          );
        } else if (value == PickerFileState.picking) {
          icon = Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TweenAnimationBuilder(
              duration: const Duration(seconds: 2),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, animationValue, child) => Transform.rotate(
                angle: (pi * 2) * animationValue,
                child: const Icon(Icons.file_copy),
              ),
            ),
          );
        } else {
          icon = const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: CircularProgressIndicator.adaptive(),
          );
        }
        child = InkWell(
          onTap: _pickFile,
          child: TextFormWidget(
            labelText: widget.labelText ?? 'Upload imagem',
            textEditingController: widget._fileController,
            enabled: false,
            icon: icon,
            onChanged: (value) => widget._fileController.text = value,
            validator: Validators.isEmpty,
          ),
        );
        return child;
      },
    );
  }

  void _pickFile() async {
    try {
      state.value = PickerFileState.loading;

      final (String fileName, Uint8List fileBytes)? fileRecord =
          await widget._filePickerService();

      if (fileRecord != null) {
        final (fileName, fileBytes) = fileRecord;
        state.value = PickerFileState.picking;
        widget._fileController.text = fileName;
        if (widget.onPickedFile != null) {
          widget.onPickedFile!.call(fileBytes);
        }
        state.value = PickerFileState.picked;
      } else {
        state.value = PickerFileState.initial;
      }
    } catch (e) {
      if (mounted) {
        state.value = PickerFileState.error;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(e.toString()),
              leading: const Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
            ),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        state.value = PickerFileState.initial;
      }
    }
  }
}
