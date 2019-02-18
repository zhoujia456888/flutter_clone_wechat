import 'package:flutter/material.dart';

import '../constants.dart' show AppColors, AppStyles, Constants;
import '../modal/conversation.dart'
    show ConversationPageData, Conversation, Device;

class _ConversationItem extends StatelessWidget {
  const _ConversationItem({Key key, this.conversation})
      : assert(conversation != null),
        super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    //根据图片的获取方式初始化头像组件
    Widget avatarChild;
    if (conversation.isAvatarFromNet()) {
      avatarChild = Image.network(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    } else {
      avatarChild = Image.asset(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    }
    Widget avatar = new ClipRRect(
        borderRadius: BorderRadius.circular(6.0), child: avatarChild);

    Widget avtarContainer;

    if (conversation.unreadMsgCount > 0) {
      //未读消息角标
      Widget unreadMsgCountText = Container(
        width: Constants.UnReadMsgNotifyDotSize,
        height: Constants.UnReadMsgNotifyDotSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Constants.UnReadMsgNotifyDotSize / 2.0),
          color: Color(AppColors.NotifDotBg),
        ),
        child: Text(conversation.unreadMsgCount.toString(),
            style: AppStyles.UnReadMsgCountDotStyle),
      );

      avtarContainer = Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(
            child: unreadMsgCountText,
            right: -6.0,
            top: -6.0,
          )
        ],
      );
    } else {
      avtarContainer = avatar;
    }

    //勿扰模式图标
    Widget muteIcon;
    if (conversation.isMute) {
      muteIcon = Icon(
        IconData(0xe755, fontFamily: Constants.IconFontFamily),
        color: Color(AppColors.ConversationMuteIcon),
        size: Constants.ConversationMuteSize,
      );
    } else {
      muteIcon = Icon(
        IconData(0xe755, fontFamily: Constants.IconFontFamily),
        color: Colors.transparent,
        size: Constants.ConversationMuteSize,
      );
    }

    //右侧更新时间和勿扰图标
    var _rightArea = <Widget>[
      Text(
        conversation.updateAt,
        style: AppStyles.Destyle,
      ),
      Container(
        height: 10.0,
      ),
      muteIcon,
    ];

    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Color(AppColors.ConversationItemBg),
          border: Border(
              bottom: BorderSide(
                  color: Color(AppColors.DividerColor),
                  width: Constants.Dividerwidth))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avtarContainer,
          Container(width: 10.0),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                conversation.title,
                style: AppStyles.titleStyle,
              ),
              Text(
                conversation.des,
                style: AppStyles.Destyle,
              ),
            ],
          )),
          Container(width: 10.0),
          Column(
            children: _rightArea,
          )
        ],
      ),
    );
  }
}

class _DeviceInfoItem extends StatelessWidget {
  const _DeviceInfoItem({this.device: Device.WIN}) : assert(device != null);

  final Device device;

  int get IconName {
    return device == Device.WIN ? 0xe75e : 0xe640;
  }

  String get deviceName {
    return device == Device.WIN ? "Windows" : "Mac";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 24.0, top: 10.0, right: 24.0, bottom: 10.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: Constants.Dividerwidth,
                  color: Color(AppColors.DividerColor))),
          color: Color(AppColors.DeviceInfoItemBg)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            IconData(this.IconName, fontFamily: Constants.IconFontFamily),
            size: 24.0,
            color: Color(AppColors.DeviceInfoItemIcon),
          ),
          SizedBox(width: 16.0),
          Text('$deviceName 微信已登录，手机通知已关闭',
              style: AppStyles.DeviceInfoItemTextStyle),
        ],
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final ConversationPageData data = ConversationPageData.mock();

  @override
  Widget build(BuildContext context) {
    var mockConversation = data.conversations;

    // TODO: implement build
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (data.device != null) {
          //需要显示其他设备的登录信息
          if (index == 0) {
            return _DeviceInfoItem(
              device: data.device,
            );
          }
          return _ConversationItem(conversation: mockConversation[index - 1]);
        } else {
          //不需要显示其他设备的登录信息
          return _ConversationItem(conversation: mockConversation[index]);
        }
      },
      itemCount: data.device != null
          ? mockConversation.length + 1
          : mockConversation.length,
    );
  }
}
