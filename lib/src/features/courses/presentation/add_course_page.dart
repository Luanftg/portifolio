import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/core/validators/validators.dart';
import 'package:portifolio/src/core/widgets/date_picker_widget.dart';
import 'package:portifolio/src/core/widgets/text_form_widget.dart';
import 'package:portifolio/src/core/widgets/picker_file_widget.dart';
import 'package:portifolio/src/features/courses/bloc/course_bloc.dart';
import 'package:portifolio/src/features/courses/bloc/event/course_event.dart';
import 'package:portifolio/src/features/courses/bloc/state/course_satate.dart';
import 'package:portifolio/src/features/courses/domain/course_model.dart';

enum UploadCourseState { initial, loading, uploading, uploaded, error }

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({super.key});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ministerController = TextEditingController();
  final _workloadController = TextEditingController();
  final _institutionController = TextEditingController();
  final _fileController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _titlePathController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isFormValid = ValueNotifier(false);
  Uint8List? titleFile;
  Uint8List? certificateFile;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CourseBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Curso'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            final bool isValid = _formKey.currentState?.validate() ?? false;
            isFormValid.value = isValid;
          },
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormWidget(
                    labelText: 'Nome do Curso',
                    textEditingController: _nameController,
                    validator: Validators.isEmpty),
                const SizedBox(height: 20),
                TextFormWidget(
                  labelText: 'Descrição do Curso',
                  textEditingController: _descriptionController,
                  validator: Validators.isEmpty,
                ),
                const SizedBox(height: 20),
                FilePickerWidget(
                  fileController: _titlePathController,
                  filePickerService: bloc.filePickerService,
                  labelText: 'Upload Título do Curso',
                  onPickedFile: setTitleFile,
                ),
                const SizedBox(height: 20),
                TextFormWidget(
                    labelText: 'Instrutor',
                    textEditingController: _ministerController,
                    validator: Validators.isEmpty),
                const SizedBox(height: 20),
                TextFormWidget(
                    labelText: 'Nome da Instituição',
                    textEditingController: _institutionController,
                    validator: Validators.isEmpty),
                const SizedBox(height: 20),
                TextFormWidget(
                    labelText: 'Carga Horária em horas',
                    textEditingController: _workloadController,
                    validator: Validators.isEmpty),
                const SizedBox(height: 20),
                DatePickerWidget(
                  label: 'Data de início',
                  validator: Validators.isEmpty,
                  controller: _startDateController,
                ),
                const SizedBox(height: 20),
                DatePickerWidget(
                  label: 'Data de término',
                  validator: Validators.isEmpty,
                  controller: _endDateController,
                ),
                const SizedBox(height: 20),
                FilePickerWidget(
                  fileController: _fileController,
                  filePickerService: bloc.filePickerService,
                  labelText: 'Upload do Certificado do Curso',
                  onPickedFile: setCertificateFile,
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: isFormValid,
                  builder: (context, value, child) => Visibility(
                    visible: value,
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: saveCourse,
                        child: BlocConsumer(
                          listener: (context, state) {
                            if (state is ErrorCourseState) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: ListTile(
                                    title: Text(state.message),
                                    leading: const Icon(Icons.error),
                                  ),
                                ),
                              );
                            }
                          },
                          bloc: bloc,
                          builder: (context, state) {
                            Widget child = const Offstage();
                            if (state is LoadingCourseState) {
                              child = const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              child = const Text('Salvar');
                            }

                            return child;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setTitleFile(Uint8List uint8list) => titleFile = uint8list;
  void setCertificateFile(Uint8List uint8list) => certificateFile = uint8list;

  void saveCourse() {
    final CourseModel course = CourseModel(
      title: _nameController.text,
      titlePath: _titlePathController.text,
      description: _descriptionController.text,
      minister: _ministerController.text,
      institution: _institutionController.text,
      workload: _workloadController.text,
      imagePath: _fileController.text,
      startDate: DateTime.parse(_startDateController.text),
      endDate: DateTime.parse(_endDateController.text),
    );
    final bloc = context.read<CourseBloc>();
    bloc.add(SaveCourse(
      course: course,
      certificateFile: certificateFile,
      titleFile: titleFile,
    ));
  }
}
