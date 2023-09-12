import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../config/app_theme.dart';
import '../text/app_text_base_builder.dart';
import '../textField/app_text_field_base_builder.dart';
import 'app_drop_down_model.dart';

part 'app_drop_down_widget.dart';

abstract class AppDropdownBaseBuilder {
  @protected
  late final String _fieldKey;
  @protected
  String? Function(dynamic value)? _validator;
  @protected
  late List<AppDropdownModel>? _items;
  @protected
  late String _hint;
  @protected
  late TextEditingController _textEditingController;
  @protected
  String? Function(dynamic value)? _onPressed;
  @protected
  AutovalidateMode? _autoValidateMode;

  AppDropdownBaseBuilder setHint(String hint) {
    return this;
  }

  AppDropdownBaseBuilder setDropdownModel(List<AppDropdownModel>? items) {
    return this;
  }

  AppDropdownBaseBuilder setPrefixIcon(Widget? prefixIcon) {
    return this;
  }

  AppDropdownBaseBuilder setFieldKey(String fieldKey) {
    return this;
  }

  AppDropdownBaseBuilder setValidator(
      String? Function(dynamic value)? validator) {
    return this;
  }

  AppDropdownBaseBuilder setTextEditingController(
      TextEditingController textEditingController) {
    return this;
  }

  AppDropdownBaseBuilder setOnPressed(
      String? Function(dynamic value)? onPressed) {
    return this;
  }

  AppDropdownBaseBuilder setAutoValidateMode(
      AutovalidateMode? autoValidateMode) {
    return this;
  }

  Widget build(BuildContext context);
}
