// // ignore_for_file:  prefer_asserts_with_message
//
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/components/custom_text.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({
    required this.imageType,
    this.imageUrl,
    super.key,
    this.height = 50,
    this.width = 50,
    this.fontSize = 15,
    this.placeHolderColor = AppColors.kPrimaryColor,
    this.editImage = false,
    this.onEditImageTap,
    this.onDeleteImageTap,
    this.showBorder = false,
  }) : assert(
          !(editImage == true &&
              onEditImageTap == null &&
              onDeleteImageTap == null),
        );

  final double height;
  final double width;
  final String? imageUrl;
  final double? fontSize;
  final ProfileImageType imageType;
  final Color placeHolderColor;
  final bool editImage;
  final void Function()? onEditImageTap;
  final void Function()? onDeleteImageTap;
  final bool showBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var profileProvider = ref.watch(profileViewModel);
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: showBorder ? Border.all() : null,
          ),
          child: imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: height,
                    width: width,
                    imageUrl: imageUrl ?? '',
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, DownloadProgress progress) {
                      return SizedBox.fromSize(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                          backgroundColor: AppColors.kWhite,
                        ),
                      );
                    },
                    errorWidget: (context, url, __) => Image.asset(
                      (imageType == ProfileImageType.user)
                          ? AppImages.account
                          : AppImages.account,
                      // ignore: deprecated_member_use
                      color: placeHolderColor, scale: 2.5,
                    ),
                    // placeholder: (context, url) => SvgPicture.asset(
                    //   (imageType == ProfileImageType.organization)
                    //       ? AppAsset.organizationIcon
                    //       : AppAsset.personIcon,
                    //   // ignore: deprecated_member_use
                    //   color: placeHolderColor,
                    // ),
                  ),
                )
              : DummyData.firstName!.isNotEmpty ||
                      DummyData.lastName!.isNotEmpty
                  ? Container(
                      height: height,
                      width: width,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.kPrimary1),
                      child: Center(
                          child: TextView(
                        text: profileProvider.getInitials(
                            '${DummyData.firstName} ${DummyData.lastName}'),
                        color: Colors.white,
                        fontSize: fontSize,
                      )),
                    )
                  : Container(
                      width: width,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.kGrey300,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.person_outlined,
                        color: AppColors.kGrey600,
                      )),
                    ),
        ),
        Visibility(
          visible: editImage,
          child: Positioned(
            right: 5.w,
            bottom: 0.h,
            child: GestureDetector(
              onTap: onEditImageTap,
              child: Container(
                height: 25.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: AppColors.kGrey600,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.kWhite),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.photo_camera,
                  size: 15.r,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
