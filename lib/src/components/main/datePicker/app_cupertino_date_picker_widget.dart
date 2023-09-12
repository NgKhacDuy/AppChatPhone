part of 'app_date_picker_base_builder.dart';

class AppCupertinoDatePickerWidget extends AppDatePickerBaseBuilder {
  @override
  AppCupertinoDatePickerWidget setFieldKey(String fieldKey) {
    _fieldKey = fieldKey;
    return this;
  }

  @override
  AppCupertinoDatePickerWidget setInitialDate(DateTime? initialDate) {
    _initialDate = initialDate;
    return this;
  }

  @override
  AppCupertinoDatePickerWidget setOnDatePicked(
      void Function(DateTime? datePicked)? onDatePicked) {
    _onDatePicked = onDatePicked;
    return this;
  }

  @override
  AppCupertinoDatePickerWidget setAppDatePickerSize(
      AppDatePickerSize? appDatePickerSize) {
    _appDatePickerSize = appDatePickerSize;
    return this;
  }

  @override
  AppCupertinoDatePickerWidget setIsDisabled(bool? isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  @override
  AppCupertinoDatePickerWidget setHintText(String? hintText) {
    _hintText = hintText;
    return this;
  }

  @override
  AppCupertinoDatePickerWidget setValidator(
      String? Function(DateTime? value)? validator) {
    _validator = validator;
    return this;
  }

  @override
  AppCupertinoDatePickerWidget setAutovalidateMode(
      AutovalidateMode? autovalidateMode) {
    _autovalidateMode = autovalidateMode;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets contentPadding =
        EdgeInsets.only(left: AppThemeExt.of.majorScale(3));

    BoxConstraints suffixIconConstraints = BoxConstraints.expand(
      width: AppThemeExt.of.majorScale(10),
      height: AppDatePickerSize.medium.value,
    );

    double iconSize = AppThemeExt.of.majorScale(5);

    if (_appDatePickerSize == AppDatePickerSize.large) {
      contentPadding = EdgeInsets.only(left: AppThemeExt.of.majorScale(3));
      iconSize = AppThemeExt.of.majorScale(5);
      suffixIconConstraints = BoxConstraints.expand(
        width: AppThemeExt.of.majorScale(10),
        height: _appDatePickerSize!.value,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderField<DateTime?>(
          name: _fieldKey,
          initialValue: _initialDate,
          autovalidateMode: _autovalidateMode,
          validator: _validator,
          builder: (field) => InkWell(
            onTap: _isDisabled == true
                ? null
                : () async {
                    final datePicked = await open(context, field.value);
                    if (datePicked != null) {
                      field.didChange(datePicked);
                      _onDatePicked?.call(datePicked);
                    }
                  },
            borderRadius: BorderRadius.circular(AppThemeExt.of.majorScale(1)),
            child: InputDecorator(
              decoration: InputDecoration(
                isDense: true,
                errorStyle: AppTextStyleExt.of.textSubTitle1r?.copyWith(
                  color: AppColors.of.errorColor,
                  height: 0.7,
                ),
                errorText: field.errorText,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppThemeExt.of.majorScale(1),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.of.redColor[5] ?? AppColors.of.redColor,
                  ),
                ),
                focusedErrorBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppThemeExt.of.majorScale(1)),
                  borderSide: BorderSide(color: AppColors.of.grayColor[5]!),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppThemeExt.of.majorScale(1)),
                  borderSide: BorderSide(color: AppColors.of.grayColor[2]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.of.grayColor[5]!),
                ),
                contentPadding: contentPadding,
                suffixIconConstraints: suffixIconConstraints,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  size: iconSize,
                  color: _isDisabled == true
                      ? AppColors.of.grayColor[7]
                      : AppColors.of.grayColor[10],
                ),
              ),
              child: field.value == null
                  ? _hint(context)
                  : _text(context, field.value),
            ),
          ),
        ),
      ],
    );
  }

  Widget _text(BuildContext context, DateTime? initialDate) {
    final textColor = _isDisabled == true
        ? AppColors.of.grayColor[5]
        : AppColors.of.grayColor;
    if (_appDatePickerSize == AppDatePickerSize.large) {
      return AppTextBody1Widget()
          .setText(DateTimeExt.dateTimeToDisplay(dateTime: initialDate))
          .setTextStyle(
              AppTextStyleExt.of.textBody1r?.copyWith(color: textColor))
          .build(context);
    }
    return AppTextBody1Widget()
        .setText(DateTimeExt.dateTimeToDisplay(dateTime: initialDate))
        .setTextStyle(AppTextStyleExt.of.textBody1r?.copyWith(color: textColor))
        .build(context);
  }

  Widget _hint(BuildContext context) {
    if (_appDatePickerSize == AppDatePickerSize.large) {
      return AppTextBody1Widget()
          .setText(_hintText ?? R.strings.datePickerHint)
          .setTextStyle(
            AppTextStyleExt.of.textBody1r
                ?.copyWith(color: AppColors.of.grayColor[5]),
          )
          .build(context);
    }
    return AppTextBody1Widget()
        .setText(_hintText ?? R.strings.datePickerHint)
        .setTextStyle(
          AppTextStyleExt.of.textBody1r
              ?.copyWith(color: AppColors.of.grayColor[5]),
        )
        .build(context);
  }

  Future<DateTime?> open(BuildContext context, DateTime? initialDate) async {
    DateTime date = initialDate ?? DateTime.now();

    return await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: AppColors.of.grayColor[1],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextButtonWidget()
                    .setButtonText(R.strings.cancel)
                    .setOnPressed(
                  () {
                    Get.back();
                  },
                ).build(context),
                AppTextButtonWidget()
                    .setButtonText(R.strings.done)
                    .setOnPressed(
                  () {
                    Get.back(result: date);
                  },
                ).build(context),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: date,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDate) {
                  date = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
