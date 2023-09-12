part of 'app_avatar_base_builder.dart';

class AppAvatarDefaultWidget extends AppAvatarBaseBuilder {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onPressed,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(AppThemeExt.of.majorScale(1)),
        child: Container(
          width: _size?.value,
          height: _size?.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.of.grayColor[3]!),
          ),
          child: ClipOval(child: R.svgs.icAvatar.svg()),
        ),
      ),
    );
  }

  @override
  AppAvatarBaseBuilder setSize(AppAvatarSize? size) {
    _size = size;
    return super.setSize(size);
  }

}