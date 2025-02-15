import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/asset_manager.dart';

void showAvatarBottomSheet(BuildContext context, Function(int) onAvatarSelected,
    int selectedAvatarId) {
  List<String> avatarList = [
    AssetsManager.avatar1,
    AssetsManager.avatar2,
    AssetsManager.avatar3,
    AssetsManager.avatar4,
    AssetsManager.avatar5,
    AssetsManager.avatar6,
    AssetsManager.avatar7,
    AssetsManager.avatar8,
    AssetsManager.avatar9,
  ];
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      var width = MediaQuery.of(context).size.width;
      return Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.darkGreyColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: width * 0.02,
            crossAxisSpacing: width * 0.02,
          ),
          itemCount: avatarList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            bool isSelected = index == selectedAvatarId;
            return GestureDetector(
              onTap: () {
                onAvatarSelected(index);
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppColors.yellowColor.withAlpha(130) : null,
                  border: Border.all(color: AppColors.yellowColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    avatarList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

