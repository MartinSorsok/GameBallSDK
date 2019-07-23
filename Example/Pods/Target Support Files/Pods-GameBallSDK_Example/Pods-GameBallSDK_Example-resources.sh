#!/bin/sh
set -e
set -u
set -o pipefail

function on_error {
  echo "$(realpath -mq "${0}"):$1: error: Unexpected failure"
}
trap 'on_error $LINENO' ERR

if [ -z ${UNLOCALIZED_RESOURCES_FOLDER_PATH+x} ]; then
  # If UNLOCALIZED_RESOURCES_FOLDER_PATH is not set, then there's nowhere for us to copy
  # resources to, so exit 0 (signalling the script phase was successful).
  exit 0
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")

case "${TARGETED_DEVICE_FAMILY:-}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  4)
    TARGET_DEVICE_ARGS="--target-device watch"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\"" || true
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH" || true
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/BackArrow1.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/BackArrow3.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/backButt.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/ChallengeAchievedImage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/ChallengeAchievedImage@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/ChallengeAchievedImage@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/ChallengeInProgressImage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/ChallengeInProgressImage@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/ChallengeInProgressImage@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/ChallengeLockedImage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/ChallengeLockedImage@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/ChallengeLockedImage@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/checkmark/checkmark.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/checkmark/checkmark@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/checkmark/checkmark@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/close_new.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/iclose_new@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/copy.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/copy@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/copy@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/delete/icons8-delete-20.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/flag/flag.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/flag/flag@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/flag/flag@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameballIcon/Gameball-Grey-Icon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/gift.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/gift@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/gift@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Poppins-Black.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/frubiesIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/frubiesIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/frubiesIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/pointsIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/pointsIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/pointsIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/rankpoints.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/rankpoints@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/walletpoints.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/walletpoints@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/icons8-user-64.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/icons8-user-96.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Profile.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/profileIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/profileIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/profileIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/Achievements.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/Achievements@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/Achievements@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/Leaderboard.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/leaderboardIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/leaderboardIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/leaderboardIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/trophy.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Cairo-Bold.ttf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Cairo-Regular.ttf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Montserrat-Light.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Montserrat-SemiBold.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Localization/en.lproj/Localizable.strings"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Localization/LocalizableArabic.strings"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/AchivementHighscoreViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/ActionBasedViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/ActionBasedWithoutMilestonesViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/MilestonesTableView/MilestonesTableViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/MilestonesTableView/MilestoneTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/Container/ParentViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/CustomViews/FooterGameBallCell/FooterGameBallCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/CustomViews/HeaderCollectionReusableView/HeaderCollectionReusableView.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/CustomViews/NotificationPopUP/NotificationPopUPView.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/CustomViews/tabbarCell/TabbarCollectionViewCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/BadgesCollectionViewinCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/BadgeView/BadgeView.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/GameballViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/MainTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/ProfileHeaderView/ProfileHeaderView.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/TabIconsHeader.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/Leaderboard/LeaderboardViewController.xib"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/BackArrow1.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/BackArrow3.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/backButt.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/ChallengeAchievedImage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/ChallengeAchievedImage@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/ChallengeAchievedImage@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/ChallengeInProgressImage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/ChallengeInProgressImage@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/ChallengeInProgressImage@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/ChallengeLockedImage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/ChallengeLockedImage@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/ChallengeLockedImage@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/checkmark/checkmark.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/checkmark/checkmark@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/checkmark/checkmark@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/close_new.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/iclose_new@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/copy.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/copy@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/copy@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/delete/icons8-delete-20.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/flag/flag.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/flag/flag@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/flag/flag@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameballIcon/Gameball-Grey-Icon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/gift.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/gift@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/gift@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Poppins-Black.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/frubiesIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/frubiesIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/frubiesIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/pointsIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/pointsIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/pointsIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/rankpoints.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/rankpoints@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/walletpoints.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ProfileHeaderiCons/walletpoints@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/icons8-user-64.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/icons8-user-96.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Profile.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/profileIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/profileIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/profileIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/Achievements.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/Achievements@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/Achievements@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/Leaderboard.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/leaderboardIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/leaderboardIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/leaderboardIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/Trophy/trophy.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Cairo-Bold.ttf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Cairo-Regular.ttf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Montserrat-Light.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Montserrat-SemiBold.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Localization/en.lproj/Localizable.strings"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Localization/LocalizableArabic.strings"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/AchivementHighscoreViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/ActionBasedViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/ActionBasedWithoutMilestonesViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/MilestonesTableView/MilestonesTableViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/AchievementDetailsViewController/MilestonesTableView/MilestoneTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/Container/ParentViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/CustomViews/FooterGameBallCell/FooterGameBallCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/CustomViews/HeaderCollectionReusableView/HeaderCollectionReusableView.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/CustomViews/NotificationPopUP/NotificationPopUPView.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/CustomViews/tabbarCell/TabbarCollectionViewCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/BadgesCollectionViewinCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/BadgeView/BadgeView.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/GameballViewController.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/MainTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/ProfileHeaderView/ProfileHeaderView.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/GameballViewController/TabIconsHeader.xib"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Presentation/Leaderboard/LeaderboardViewController.xib"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "${XCASSET_FILES:-}" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  if [ -z ${ASSETCATALOG_COMPILER_APPICON_NAME+x} ]; then
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  else
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${TARGET_TEMP_DIR}/assetcatalog_generated_info_cocoapods.plist"
  fi
fi
