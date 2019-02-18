import 'package:flutter/material.dart';

class AppColors {
  static const AppBarColor = 0xff303030;
  static const AppBarBgColor = 0xffEEEEEE;
  static const TabIconActive = 0xff46c11b;
  static const TabIconNormal = 0xff999999;
  static const AppBarPopupMenuColor = 0xffffffff;
  static const TitleColor = 0xff353535;
  static const ConversationItemBg = 0xffffffff;
  static const DesTextColor = 0xff9e9e9e;
  static const DividerColor = 0xffd9d9d9;
  static const NotifDotBg = 0xffff3e3e;
  static const NotifDotText = 0xffffffff;
  static const ConversationMuteIcon = 0xffd8d8d8;
  static const DeviceInfoItemBg = 0xfff5f5f5;
  static const DeviceInfoItemText = 0xff606062;
  static const DeviceInfoItemIcon=0xff606062;
  static const ContactGroupTitleBg=0xffebebeb;
  static const ContactGroupTitleText=0xff888888;
}

class AppStyles {

  static const AppBarTextStyle =
  TextStyle(color: Color(AppColors.TitleColor));

  static const titleStyle =
      TextStyle(fontSize: 14.0, color: Color(AppColors.TitleColor));

  static const Destyle =
      TextStyle(fontSize: 12.0, color: Color(AppColors.DesTextColor));

  static const UnReadMsgCountDotStyle =
      TextStyle(fontSize: 12.0, color: Color(AppColors.NotifDotText));

  static const DeviceInfoItemTextStyle =
      TextStyle(fontSize: 13.0, color: Color(AppColors.DeviceInfoItemText));

  static const GroupTitleItemTextStyle=TextStyle(
    fontSize: 14.0,
    color: Color(AppColors.ContactGroupTitleText),
  );
}

class Constants {
  static const IconFontFamily = "appIconFont";
  static const ConversationAvatarSize = 48.0;
  static const Dividerwidth = 1.0;
  static const UnReadMsgNotifyDotSize = 20.0;
  static const ConversationMuteSize = 18.0;
  static const DeviceInfoItemHeight = 32.0;
  static const ContactAvatarSize=36.0;
  static const IndexBarWidth=24.0;
}
