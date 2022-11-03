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
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/back.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/back@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/innerchallengeAchieved.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/innerchallengeAchieved@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/innerchallengeInProgress.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/innerchallengeInProgress@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/innerchallengeLocked.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/innerchallengeLocked@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/close_new.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/iclose_new@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/icon_outline_14px_close.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/icon_outline_14px_close@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DefaultFriendReferal/gbReferralDefaultimage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DefaultFriendReferal/gbReferralDefaultimage@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DefaultFriendReferal/gbReferralDefaultimage@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DownArrow/dropArrow.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DownArrow/dropArrow@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DownArrow/dropArrow@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/FriendsReferal/Referral.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/FriendsReferal/Referral@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/FriendsReferal/Referral@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameballIcon/Gameball-Grey-Icon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/giftNew.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/giftNew@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/giftNew@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/CheckmarkNew.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/CheckmarkNew@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/CheckmarkNew@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/unCheckMark.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/unCheckMark@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/unCheckMark@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LeaderBoardEmptyState/gb-leaderboard-emptystate.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LeaderBoardEmptyState/gb-leaderboard-emptystate@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LeaderBoardEmptyState/gb-leaderboard-emptystate@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/MaskedImage/MaskedImage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/nextChallengeDownArrow/sequenceArrow.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/nextChallengeDownArrow/sequenceArrow@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/nextChallengeDownArrow/sequenceArrow@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/No Network/No-Internet.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/No Network/No-Internet@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/No Network/No-Internet@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/NotificationsEmpty/gb-notifications-emptystate.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/NotificationsEmpty/gb-notifications-emptystate@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/NotificationsEmpty/gb-notifications-emptystate@3x.png"
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
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Achievements.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Achievements@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Achievements@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Leaderboard.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Leaderboard@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Leaderboard@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Notification.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Notification@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Profile.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Cairo-Bold.ttf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Cairo-Regular.ttf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Montserrat-Light.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Montserrat-SemiBold.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Localization/en.lproj/GB_Localizable.strings"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Localization/GB_LocalizableArabic.strings"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ChallengeDetailsHeaderCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ChallengeDetailsViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/HighScoreTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ProgressBarTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/StatusTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/BadgesCollectionViewinCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/BadgeView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ChallengesTableViewInCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/HeaderCollectionReusableView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationPopUpFullScreenViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationPopUPView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationtSmallToast.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/TabbarCollectionViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/TabIconsHeader.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_LeaderBoardEmptyStateCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_NotificationsEmptyStateCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_ReferalFooterCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ReferalFriendTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ReferalHeaderViewTableView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_ChallengeInMissionTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_MissionsTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_WEBVIEWWIDGETViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/LeaderBoardHeaderView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/LeaderBoardTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NoInternetViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationsTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationHeaderView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ParentViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/MainTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ProfileHeaderView.nib"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/back.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/BackButton/back@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/innerchallengeAchieved.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeAchievedImage/innerchallengeAchieved@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/innerchallengeInProgress.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeInProgressImage/innerchallengeInProgress@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/innerchallengeLocked.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/ChallengeLockedImage/innerchallengeLocked@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/close_new.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/iclose_new@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/icon_outline_14px_close.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/CloseBTN/icon_outline_14px_close@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DefaultFriendReferal/gbReferralDefaultimage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DefaultFriendReferal/gbReferralDefaultimage@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DefaultFriendReferal/gbReferralDefaultimage@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DownArrow/dropArrow.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DownArrow/dropArrow@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/DownArrow/dropArrow@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/FriendsReferal/Referral.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/FriendsReferal/Referral@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/FriendsReferal/Referral@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameballIcon/Gameball-Grey-Icon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gameBallLogo/gameballIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/giftNew.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/giftNew@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/gift/giftNew@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/CheckmarkNew.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/CheckmarkNew@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/CheckmarkNew@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/unCheckMark.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/unCheckMark@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/GreenTick/unCheckMark@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LeaderBoardEmptyState/gb-leaderboard-emptystate.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LeaderBoardEmptyState/gb-leaderboard-emptystate@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LeaderBoardEmptyState/gb-leaderboard-emptystate@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIcon/LockIcon@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/LockIconLarge/LockIconLarge@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/MaskedImage/MaskedImage.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/nextChallengeDownArrow/sequenceArrow.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/nextChallengeDownArrow/sequenceArrow@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/nextChallengeDownArrow/sequenceArrow@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/No Network/No-Internet.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/No Network/No-Internet@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/No Network/No-Internet@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/NotificationsEmpty/gb-notifications-emptystate.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/NotificationsEmpty/gb-notifications-emptystate@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/NotificationsEmpty/gb-notifications-emptystate@3x.png"
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
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Achievements.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Achievements@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Achievements@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Leaderboard.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Leaderboard@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Leaderboard@3x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Notification.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Notification@2x.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Assets/Images/profilePlaceholder/Profile.png"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Cairo-Bold.ttf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Cairo-Regular.ttf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Montserrat-Light.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Fonts/Montserrat-SemiBold.otf"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Localization/en.lproj/GB_Localizable.strings"
  install_resource "${PODS_ROOT}/../../GameBallSDK/Resources/Localization/GB_LocalizableArabic.strings"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ChallengeDetailsHeaderCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ChallengeDetailsViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/HighScoreTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ProgressBarTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/StatusTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/BadgesCollectionViewinCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/BadgeView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ChallengesTableViewInCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/HeaderCollectionReusableView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationPopUpFullScreenViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationPopUPView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationtSmallToast.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/TabbarCollectionViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/TabIconsHeader.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_LeaderBoardEmptyStateCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_NotificationsEmptyStateCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_ReferalFooterCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ReferalFriendTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ReferalHeaderViewTableView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_ChallengeInMissionTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_MissionsTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/GB_WEBVIEWWIDGETViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/LeaderBoardHeaderView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/LeaderBoardTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NoInternetViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationsTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/NotificationHeaderView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ParentViewController.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/MainTableViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/GameBallSDK/GameBallSDK.framework/ProfileHeaderView.nib"
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
  OTHER_XCASSETS=$(find -L "$PWD" -iname "*.xcassets" -type d)
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
