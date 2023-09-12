import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:resources/resources.dart';
import '../../../config/app_theme.dart';
import '../../main/text/app_text_base_builder.dart';

class AppCheckBoxGroupWidget {
  late final String _fieldKey;
  late final List<String> _options;
  bool? _isDisabled;
  String? _checkAllLabel;
  bool? _hasCheckAll;
  AutovalidateMode? _checkBoxAutoValidateMode;
  String? Function(Object?)? _checkBoxValidator;
  bool? _isGridView;

  AppCheckBoxGroupWidget setFieldKey(String fieldKey) {
    _fieldKey = fieldKey;
    return this;
  }

  AppCheckBoxGroupWidget setOptions(List<String> options) {
    _options = options;
    return this;
  }

  AppCheckBoxGroupWidget setDisabled(bool? isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  AppCheckBoxGroupWidget setCheckAllLabel(String? checkAllLabel) {
    _checkAllLabel = checkAllLabel;
    return this;
  }

  AppCheckBoxGroupWidget setHasCheckAll(bool? hasCheckAll) {
    _hasCheckAll = hasCheckAll;
    return this;
  }

  AppCheckBoxGroupWidget setIsGridView(bool? isGridView) {
    _isGridView = isGridView;
    return this;
  }

  AppCheckBoxGroupWidget setAutoValidateMode(
      AutovalidateMode? checkBoxAutoValidateMode) {
    _checkBoxAutoValidateMode = checkBoxAutoValidateMode;
    return this;
  }

  AppCheckBoxGroupWidget setValidator(
      String? Function(Object? p1)? checkBoxValidator) {
    _checkBoxValidator = checkBoxValidator;
    return this;
  }

  void onChanged(FormFieldState field, List<String> value) {
    field.didChange(value);
  }

  Widget build(BuildContext context) {
    bool isAllSelected = false;
    List<String> selectedOptions = [];
    return FormBuilderField(
        name: _fieldKey,
        autovalidateMode: _checkBoxAutoValidateMode,
        validator: _checkBoxValidator,
        builder: (field) {
          return Wrap(
              spacing: AppThemeExt.of.majorScale(10),
              runSpacing: AppThemeExt.of.majorScale(4),
              children: [
                if (_hasCheckAll ?? true)
                  Row(
                      mainAxisSize: _isGridView ?? true
                          ? MainAxisSize.min
                          : MainAxisSize.max,
                      children: [
                        Checkbox(
                          value: isAllSelected,
                          activeColor: _activeColor,
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) =>
                                AppColors.of.grayColor[3],
                          ),
                          side: BorderSide(color: _sideColor),
                          onChanged: (value) {
                            isAllSelected = value ?? false;
                            if (isAllSelected) {
                              selectedOptions = List<String>.from(_options);
                            } else {
                              selectedOptions.clear();
                            }
                            onChanged(field, selectedOptions);
                          },
                        ),
                        Flexible(
                          child: AppTextBody1Widget()
                              .setText(_checkAllLabel ?? R.strings.checkAll)
                              .setTextStyle(AppTextStyleExt.of.textBody1r
                                  ?.copyWith(color: _labelColor))
                              .build(context),
                        ),
                      ]),
                ...List<Widget>.generate(_options.length, (index) {
                  final option = _options[index];
                  return _checkBoxItem(
                      context, field, selectedOptions, option, isAllSelected);
                }),
              ]);
        });
  }

  Widget _checkBoxItem(BuildContext context, FormFieldState field,
      List<String> selectedOptions, String option, bool isAllSelected) {
    return Row(
      mainAxisSize: _isGridView ?? true ? MainAxisSize.min : MainAxisSize.max,
      children: [
        Checkbox(
          value: selectedOptions.contains(option),
          activeColor: _activeColor,
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) => AppColors.of.grayColor[3],
          ),
          side: BorderSide(color: _sideColor),
          onChanged: _isDisabled == true
              ? null
              : (value) {
                  if (value == true) {
                    selectedOptions.add(option);
                  } else {
                    selectedOptions.remove(option);
                  }
                  if (selectedOptions.length == _options.length) {
                    isAllSelected = true;
                  } else {
                    isAllSelected = false;
                  }
                  onChanged(field, selectedOptions);
                },
        ),
        Flexible(
          child: AppTextBody1Widget()
              .setText(option)
              .setTextStyle(
                  AppTextStyleExt.of.textBody1r?.copyWith(color: _labelColor))
              .build(context),
        ),
      ],
    );
  }

  Color? get _activeColor => _isDisabled == true
      ? AppColors.of.grayColor[4]
      : AppColors.of.tealColor[5];

  Color get _sideColor => _isDisabled == true
      ? AppColors.of.grayColor[3]!
      : AppColors.of.grayColor[5]!;
  Color? get _labelColor => _isDisabled == true
      ? AppColors.of.grayColor[5]
      : AppColors.of.grayColor[10];
}
