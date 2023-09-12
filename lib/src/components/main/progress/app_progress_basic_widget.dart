part of 'app_progress_base_builder.dart';

class AppProgressBasicWidget extends AppProgressBaseBuilder {
  @override
  AppProgressBaseBuilder setAppProgressSize(AppProgressSize? appProgressSize) {
    _appProgressSize = appProgressSize;
    return super.setAppProgressSize(appProgressSize);
  }

  @override
  AppProgressBaseBuilder setAppProgressType(AppProgressType? appProgressType) {
    _appProgressType = appProgressType;
    return super.setAppProgressType(appProgressType);
  }

  @override
  AppProgressBaseBuilder setMaxProgress(double? maxProgress) {
    _maxProgress = maxProgress;
    return super.setMaxProgress(maxProgress);
  }

  @override
  AppProgressBaseBuilder setProgress(double? progress) {
    _progress = progress;
    return super.setProgress(progress);
  }

  @override
  AppProgressBaseBuilder setIsWithNumber(bool? isWithNumber) {
    _isWithNumber = isWithNumber;
    return super.setIsWithNumber(isWithNumber);
  }

  @override
  AppProgressBaseBuilder setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return super.setBackgroundColor(backgroundColor);
  }

  @override
  AppProgressBaseBuilder setProgressColor(Color? progressColor) {
    _progressColor = progressColor;
    return super.setProgressColor(progressColor);
  }

  @override
  Widget build(BuildContext context) {
    double lineHeight = _appProgressSize?.value ?? AppThemeExt.of.majorScale(2);
    Widget? trailing = AppTextBody1Widget()
        .setText('${(_progress ?? 0) * 100}%')
        .setTextStyle(AppTextStyleExt.of.textBody1r)
        .build(context);
    if (_appProgressSize == AppProgressSize.basicSmall) {
      trailing = AppTextBody1Widget()
          .setText('${(_progress ?? 0) * 100}%')
          .setTextStyle(AppTextStyleExt.of.textBody1r)
          .build(context);
    }
    if (_appProgressSize == AppProgressSize.basicMedium) {
      trailing = AppTextBody1Widget()
          .setText('${(_progress ?? 0) * 100}%')
          .setTextStyle(AppTextStyleExt.of.textBody1r)
          .build(context);
    }

    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      width: _maxProgress,
      lineHeight: lineHeight,
      percent: _progress ?? 0,
      barRadius: Radius.circular(AppThemeExt.of.majorScale(25)),
      backgroundColor: _backgroundColor ?? AppColors.of.grayColor[3],
      progressColor: _progressColor ?? AppColors.of.processInformColor,
      trailing: _isWithNumber == true ? trailing : null,
    );
  }
}
