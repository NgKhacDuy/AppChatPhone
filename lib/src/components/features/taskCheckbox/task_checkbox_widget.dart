import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../config/app_theme.dart';
import '../../main/text/app_text_base_builder.dart';

class TaskCheckboxWidget {
  late final String _fieldKey;
  String? _label;
  bool? _value;
  bool? _isDisabled;
  void Function(dynamic value)? _onValueChanged;

  Widget build(BuildContext context) {
    return FormBuilderField<bool?>(
      name: _fieldKey,
      initialValue: _value,
      builder: (field) => InkWell(
        onTap: _isDisabled == true
            ? null
            : () {
                if (field.value != null) {
                  field.didChange(!field.value!);
                  _onValueChanged?.call(!field.value!);
                }
              },
        child: Container(
          margin: EdgeInsets.only(top: AppThemeExt.of.majorMarginScale(3)),
          padding: EdgeInsets.symmetric(
              vertical: AppThemeExt.of.majorPaddingScale(1)),
          child: Row(
            children: [
              if (_label != null)
                Expanded(
                  child: AppTextBody1Widget()
                      .setText(_label)
                      .setTextStyle(
                        AppTextStyleExt.of.textBody1r?.copyWith(
                          color: _labelColor,
                          decoration: field.value == true
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      )
                      .build(context),
                ),
              SizedBox(
                width: AppThemeExt.of.majorScale(4),
                height: AppThemeExt.of.majorScale(4),
                child: Checkbox(
                  value: field.value ?? false,
                  activeColor: _activeColor,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) => AppColors.of.grayColor[3],
                  ),
                  side: BorderSide(color: _sideColor),
                  onChanged: _isDisabled == true
                      ? null
                      : (value) {
                          field.didChange(value);
                          _onValueChanged?.call(value);
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? get _activeColor => _isDisabled == true
      ? AppColors.of.grayColor[4]
      : AppColors.of.primaryColor;

  Color get _sideColor => _isDisabled == true
      ? AppColors.of.grayColor[3]!
      : AppColors.of.grayColor[5]!;

  Color? get _labelColor =>
      _isDisabled == true ? AppColors.of.grayColor[5] : AppColors.of.grayColor;

  TaskCheckboxWidget setLabel(String? label) {
    _label = label;
    return this;
  }

  TaskCheckboxWidget setFieldKey(String fieldKey) {
    _fieldKey = fieldKey;
    return this;
  }

  TaskCheckboxWidget setValue(bool? value) {
    _value = value;
    return this;
  }

  TaskCheckboxWidget setIsDisabled(bool? isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  TaskCheckboxWidget setOnValueChanged(
      void Function(dynamic value)? onValueChanged) {
    _onValueChanged = onValueChanged;
    return this;
  }
}
