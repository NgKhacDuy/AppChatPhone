part of 'app_text_field_base_builder.dart';

class AppTextFieldReadOnlyWidget extends AppTextFieldBaseBuilder {
  @override
  AppTextFieldReadOnlyWidget setFieldKey(String fieldKey) {
    _fieldKey = fieldKey;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setHintText(String? hintText) {
    _hintText = hintText;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setObscureText(bool? obscureText) {
    _obscureText = obscureText;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setIsReadOnly(bool? isReadOnly) {
    _isReadOnly = isReadOnly;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setSize(AppTextFieldSize? size) {
    _size = size;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setIsDisabled(bool? isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setAutoValidateMode(
      AutovalidateMode autoValidateMode) {
    _autoValidateMode = autoValidateMode;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setSuffixIcon(Widget? suffixIcon) {
    _suffixIcon = suffixIcon;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setTextInputAction(
      TextInputAction? textInputAction) {
    _textInputAction = textInputAction;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setValidator(
      String? Function(String? value)? validator) {
    _validator = validator;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setOnChanged(
      void Function(String? value)? onChanged) {
    _onChanged = onChanged;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setMaxLine(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setMinLine(int? minLines) {
    _minLines = minLines;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setInputType(TextInputType? inputType) {
    _inputType = inputType;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setFocusNode(FocusNode? focusNode) {
    _focusNode = focusNode;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setOnSubmitted(
      Function(String? value)? onSubmitted) {
    _onSubmitted = onSubmitted;
    return this;
  }

  @override
  AppTextFieldReadOnlyWidget setOnTap(Function()? ontap) {
    _ontap = ontap;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets contentPadding = EdgeInsets.zero;

    BoxConstraints suffixIconConstraints = BoxConstraints.expand(
      width: AppThemeExt.of.majorScale(10),
      height: AppTextFieldSize.large.value,
    );

    if (_size == AppTextFieldSize.large) {
      suffixIconConstraints = BoxConstraints.expand(
        width: AppThemeExt.of.majorScale(10),
        height: _size!.value,
      );
    }

    return FormBuilderTextField(
      key: _textFieldKey,
      name: _fieldKey,
      initialValue: _textFieldKey.currentState?.value,
      readOnly: _isReadOnly ?? false,
      enabled: true,
      obscureText: _obscureText ?? false,
      style: _contentTextStyle(context),
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.only(
            left: AppThemeExt.of.majorScale(3),
          ),
        ),
        isDense: true,
        hintText: _hintText,
        contentPadding: contentPadding,
        hintStyle: _hintTextStyle(context),
        border: _inputBorder(context, AppTextFieldState.normal),
        focusedBorder: _inputBorder(context, AppTextFieldState.focused),
        disabledBorder: _inputBorder(context, AppTextFieldState.disabled),
        enabledBorder: _inputBorder(context, AppTextFieldState.enabled),
        errorBorder: _inputBorder(context, AppTextFieldState.error),
        errorStyle: AppTextStyleExt.of.textSubTitle1r?.copyWith(
          color: AppColors.of.errorColor,
          height: 0.6,
        ),
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: _suffixIcon ??
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _textFieldKey.currentState?.didChange(null);
              },
            ),
      ),
      textInputAction: _textInputAction ?? TextInputAction.next,
      autovalidateMode: _autoValidateMode,
      onChanged: _onChanged,
      maxLines: _maxLines,
      validator: _validator,
      minLines: _minLines,
      keyboardType: _inputType ?? TextInputType.text,
      focusNode: _focusNode,
      onTap: _ontap,
      onSubmitted: _onSubmitted,
    );
  }

  InputBorder _inputBorder(
    BuildContext context,
    AppTextFieldState appTextFieldState,
  ) {
    Color borderColor = AppColors.of.grayColor[5] ?? AppColors.of.grayColor;

    switch (appTextFieldState) {
      case AppTextFieldState.normal:
        borderColor = AppColors.of.grayColor[5] ?? AppColors.of.grayColor;
        break;
      case AppTextFieldState.focused:
        borderColor = AppColors.of.primaryColor;
        break;
      case AppTextFieldState.error:
        borderColor = AppColors.of.redColor[5] ?? AppColors.of.redColor;
        break;
      case AppTextFieldState.enabled:
        borderColor = AppColors.of.grayColor[5] ?? AppColors.of.grayColor;
        break;
      case AppTextFieldState.disabled:
        borderColor = AppColors.of.grayColor[3] ?? AppColors.of.grayColor;
        break;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppThemeExt.of.majorScale(1),
      ),
      borderSide: BorderSide(
        color: borderColor,
      ),
    );
  }

  TextStyle? _contentTextStyle(BuildContext context) =>
      AppTextStyleExt.of.textBody1r?.copyWith(
        color: AppColors.of.grayColor[10],
      );

  TextStyle? _hintTextStyle(BuildContext context) =>
      AppTextStyleExt.of.textBody1r?.copyWith(
        color: AppColors.of.grayColor[5],
      );
}
