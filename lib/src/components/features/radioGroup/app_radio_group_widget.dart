import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:resources/resources.dart';
import '../../../config/app_theme.dart';
import '../../main/text/app_text_base_builder.dart';
import 'app_radio_group_model.dart';

enum AppRadioGroupDisplayDirection {
  horizontal(type: 'horizontal', spacing: 16),
  vertical(type: 'vertical', spacing: 8);

  const AppRadioGroupDisplayDirection(
      {required this.type, required this.spacing});

  final String type;
  final int spacing;
}

class AppRadioGroupWidget {
  late final String _fieldKey;
  late final List<AppRadioGroupModel> _options;
  bool? _otherOption = false;
  String? _otherOptionText;
  dynamic _otherOptionValue;
  void Function()? _onPressed;
  void Function()? _onPressedOtherOption;
  bool? _otherFirstPosition;
  List<Widget>? _listOtherTextField;
  bool? _isDisabled;
  AppRadioGroupDisplayDirection? _appRadioGroupDisplayDirection;

  AppRadioGroupWidget setFieldKey(String fieldKey) {
    _fieldKey = fieldKey;
    return this;
  }

  AppRadioGroupWidget setOptions(List<AppRadioGroupModel> options) {
    _options = options;
    return this;
  }

  AppRadioGroupWidget setListOtherTextField(List<Widget> listOtherTextField) {
    _listOtherTextField = listOtherTextField;
    return this;
  }

  AppRadioGroupWidget setOtherOption(bool otherOption) {
    _otherOption = otherOption;
    return this;
  }

  AppRadioGroupWidget setOtherOptionText(String otherOptionText) {
    _otherOptionText = otherOptionText;
    return this;
  }

  AppRadioGroupWidget setOnPressed(void Function()? onPressed) {
    _onPressed = onPressed;
    return this;
  }

  AppRadioGroupWidget setOnPressedOtherOption(
      void Function()? onPressedOtherOption) {
    _onPressedOtherOption = onPressedOtherOption;
    return this;
  }

  AppRadioGroupWidget setDisplayDirection(
      AppRadioGroupDisplayDirection? appRadioGroupDisplayDirection) {
    _appRadioGroupDisplayDirection = appRadioGroupDisplayDirection;
    return this;
  }

  AppRadioGroupWidget setIsDisabled(bool? isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  AppRadioGroupWidget setOtherOptionValue(String otherOptionValue) {
    _otherOptionValue = otherOptionValue;
    return this;
  }

  AppRadioGroupWidget setOtherFirstPosition(bool? otherFirstPosition) {
    _otherFirstPosition = otherFirstPosition;
    return this;
  }

  void onPress(FormFieldState field, String value) {
    field.didChange(value);
  }

  void onPressOther(FormFieldState<String> field) {
    field.didChange('');
  }

  bool containsOptionWithId(List<AppRadioGroupModel> options, String id) {
    return options.any((option) => option.optionId.contains(id));
  }

  Widget build(BuildContext context) {
    bool simplestDisplay = _appRadioGroupDisplayDirection ==
        AppRadioGroupDisplayDirection.horizontal;

    bool showOther = false;
    return FormBuilderField(
        name: _fieldKey,
        // initialValue: _options.isNotEmpty ? _options.first.optionId : null,
        builder: (FormFieldState<dynamic> field) {
          if (field.value != null) {
            showOther = !containsOptionWithId(_options, field.value!);
          }
          return simplestDisplay && _options.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _radioList(context, field, _options, showOther),
                        ]),
                    if (showOther)
                      SizedBox(
                        height: AppThemeExt.of.majorMarginScale(3),
                      ),
                    if (showOther) _otherTextField(context, field)
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      _radioList(context, field, _options, showOther),
                      if (showOther)
                        SizedBox(
                          height: AppThemeExt.of.majorMarginScale(3),
                        ),
                      if (showOther) _otherTextField(context, field)
                    ]);
        });
  }

  Widget _otherTextField(BuildContext context, FormFieldState<dynamic> field) {
    return Column(
      children: _listOtherTextField ?? [],
    );
  }

  Widget _radioList(BuildContext context, FormFieldState<dynamic> field,
      List<AppRadioGroupModel> options, bool showOther) {
    List<Widget> listRadios = [];
    bool simplestDisplay = _appRadioGroupDisplayDirection ==
        AppRadioGroupDisplayDirection.horizontal;

    for (int i = 0; i < options.length; i++) {
      listRadios.add(_radioOption(context, field, options[i]));
    }

    if (_otherOption == true) {
      listRadios.add(_otherRadioOption(context, field, showOther));
      if (_otherFirstPosition!) {
        final lastWidget = listRadios.removeLast();
        listRadios.insert(0, lastWidget);
      }
    }

    return simplestDisplay
        ? StaggeredGrid.count(
            crossAxisCount: 2,
            children: listRadios,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listRadios,
          );
  }

  Widget _otherRadioOption(
    BuildContext context,
    FormFieldState<dynamic> field,
    bool showOther,
  ) {
    AppRadioGroupModel? otherOption = AppRadioGroupModel(
        _otherOptionValue!, _otherOptionText ?? R.strings.other);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppThemeExt.of.majorScale(5),
          child: Radio<String>(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) => AppColors.of.grayColor[3],
            ),
            fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.of.tealColor[5];
                }
                if (states.contains(MaterialState.disabled)) {
                  return AppColors.of.grayColor[3];
                }
                return AppColors.of.grayColor[5];
              },
            ),
            activeColor: AppColors.of.tealColor[5],
            splashRadius: AppThemeExt.of.majorScale(1),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: otherOption.optionId,
            groupValue: field.value,
            onChanged: _isDisabled == true
                ? null
                : (value) {
                    onPress(field, value!);
                    _onPressedOtherOption?.call();
                  },
          ),
        ),
        SizedBox(
          width: AppThemeExt.of.majorScale(2),
        ),
        Flexible(
          child: AppTextBody1Widget()
              .setText(_otherOptionText ?? R.strings.other)
              .setTextStyle(
                AppTextStyleExt.of.textBody1r?.copyWith(color: _labelColor),
              )
              .build(context),
        ),
      ],
    );
  }

  Widget _radioOption(
    BuildContext context,
    FormFieldState<dynamic> field,
    AppRadioGroupModel option,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppThemeExt.of.majorScale(5),
          child: Radio<dynamic>(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) => AppColors.of.grayColor[3],
              ),
              fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.of.tealColor[5];
                  }
                  if (states.contains(MaterialState.disabled)) {
                    return AppColors.of.grayColor[3];
                  }
                  return AppColors.of.grayColor[5];
                },
              ),
              splashRadius: AppThemeExt.of.majorScale(1),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: option.optionId,
              groupValue: field.value,
              onChanged: _isDisabled == true
                  ? null
                  : (value) {
                      onPress(field, value!);
                      _onPressed?.call();
                    }),
        ),
        SizedBox(
          width: AppThemeExt.of.majorScale(2),
        ),
        Flexible(
          child: AppTextBody1Widget()
              .setText(option.optionName)
              .setTextStyle(
                AppTextStyleExt.of.textBody1r?.copyWith(color: _labelColor),
              )
              .build(context),
        ),
      ],
    );
  }

  Color? get _labelColor => _isDisabled == true
      ? AppColors.of.grayColor[5]
      : AppColors.of.grayColor[10];
}
