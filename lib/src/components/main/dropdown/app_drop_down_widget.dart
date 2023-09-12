part of 'app_dropdown_base_builder.dart';

class AppDropdownWidget extends AppDropdownBaseBuilder {
  @override
  AppDropdownBaseBuilder setDropdownModel (List<AppDropdownModel>? items){
    _items = items;
    return super.setDropdownModel(items);
  }

  @override
  AppDropdownBaseBuilder setFieldKey(String fieldKey) {
    _fieldKey = fieldKey;
    return super.setFieldKey(fieldKey);
  }

  @override
  AppDropdownBaseBuilder setValidator(
      String? Function(dynamic value)? validator) {
    _validator = validator;
    return super.setValidator(validator);
  }

  @override
  AppDropdownBaseBuilder setHint(String hint) {
    _hint = hint;
    return super.setHint(hint);
  }

  @override
  AppDropdownBaseBuilder setTextEditingController(
      TextEditingController textEditingController) {
    _textEditingController = textEditingController;
    return super.setTextEditingController(textEditingController);
  }

  @override
  AppDropdownBaseBuilder setOnPressed (String? Function(dynamic value)? onPressed) {
    _onPressed = onPressed;
    return super.setOnPressed(onPressed);
  }

  @override
  AppDropdownBaseBuilder setAutoValidateMode(
      AutovalidateMode? autoValidateMode) {
    _autoValidateMode = autoValidateMode;
    return super.setAutoValidateMode(autoValidateMode);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: _fieldKey,
      builder: (field) =>
          DropdownButtonHideUnderline(
              child: DropdownButtonFormField2(
                validator: _validator,
                decoration: InputDecoration(
                  filled: false,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.of.grayColor[5]!
                      )
                  ),
                  errorMaxLines: 1,
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.only(top: 0,bottom: 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.of.grayColor[5]!
                      )
                  ),
                  focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.of.primaryColor[5]!
                      )
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.of.errorColor
                      )
                  ),
                ),
                autovalidateMode: _autoValidateMode,
                hint: AppTextBody1Widget().setText(_hint).build(context),
                isExpanded: true,
                value: _items!.any((element) => element.id == field.value)
                    == true ? field.value.toString()
                    : (field.value != null ? _items!.last.id : null),
                items: _items!
                    .map(
                      (e) =>
                      DropdownMenuItem<String>(
                          value: e.id,
                          child: AppTextBody1Widget().setText(e.name).build(
                                context)
                      ),
                )
                    .toList(),
                buttonStyleData: ButtonStyleData(
                    height: AppThemeExt.of.majorScale(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.of.grayColor[5]!),
                      borderRadius: BorderRadius.all(Radius.circular(AppThemeExt.of.majorScale(1))),
                    )),
                menuItemStyleData: const MenuItemStyleData(),
                dropdownSearchData: DropdownSearchData(
                    searchController: _textEditingController,
                    searchInnerWidgetHeight: AppThemeExt.of.majorScale(50/4),
                    searchMatchFn: (item, searchValue) {
                      final result = _items?.where((element) => element.name.toLowerCase().startsWith(searchValue.toLowerCase())).toList();
                      return searchValue.isNotEmpty ?  result?.firstWhereOrNull((element) => element.id == item.value) != null : true;
                    },
                    searchInnerWidget: AppTextFieldWidget()
                        .setHintText(_hint)
                        .setFieldKey(_fieldKey)
                        .setOnChanged((value) {
                      _textEditingController.value = TextEditingValue(text: value ?? '');
                    })
                    .build(context)
                ),
                onChanged: (value) {
                  if (value == field.value) return;
                  field.didChange(value);
                  _onPressed?.call(value);
                },
              )
          ),
    );
  }
}
