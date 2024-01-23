import 'package:flutter/cupertino.dart';

class CertificateAndExperienceModel {
  final int? id;
  final TextEditingController titleController;
  final TextEditingController urlController;
  final TextEditingController descriptionController;
  final FocusNode titleFocus;
  final FocusNode urlFocus;
  final FocusNode descriptionFocus;

  CertificateAndExperienceModel(
      {this.id,
      required this.titleController,
      required this.urlController,
      required this.descriptionController,
      required this.titleFocus,
      required this.urlFocus,
      required this.descriptionFocus});
}
