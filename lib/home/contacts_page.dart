import 'package:flutter/material.dart';

import '../constants.dart' show Constants, AppColors, AppStyles;
import '../modal/contacts.dart' show Contact, ContactsPageData;

class _ContactItem extends StatelessWidget {
  _ContactItem(
      {@required this.avatar,
      @required this.title,
      this.groupTitle,
      this.onpress});

  final Contact _contact = ContactsPageData.mock().contacts[0];

  final String avatar;
  final String title;
  final String groupTitle;
  final VoidCallback onpress;

  static double MARGIN_VERTIAL = 10.0;
  final double BUTTON_HEIGHT = 48.0;
  static double GROUP_TITLE_HEIGHT = 24.0;

  bool get _isAvatarFromNet {
    return this.avatar.startsWith('http') || this.avatar.startsWith('https');
  }

  static _height(bool hasGroupTitle) {
    final _buttonHeight = MARGIN_VERTIAL * 2 +
        Constants.ContactAvatarSize +
        Constants.Dividerwidth;
    if (hasGroupTitle) {
      return _buttonHeight + GROUP_TITLE_HEIGHT;
    }
    return _buttonHeight;
  }

  @override
  Widget build(BuildContext context) {
    //左边的图标
    Widget _avatarIcon;
    if (_isAvatarFromNet) {
      _avatarIcon = Image.network(
        avatar,
        width: Constants.ContactAvatarSize,
        height: Constants.ContactAvatarSize,
      );
    } else {
      _avatarIcon = Image.asset(
        avatar,
        width: Constants.ContactAvatarSize,
        height: Constants.ContactAvatarSize,
      );
    }

    //列表项主体部分
    Widget _button = Container(
      padding: EdgeInsets.symmetric(vertical: MARGIN_VERTIAL),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: Constants.Dividerwidth,
                  color: Color(AppColors.DividerColor)))),
      child: Row(
        children: <Widget>[
          _avatarIcon,
          SizedBox(
            width: 10.0,
          ),
          Text(
            title,
          )
        ],
      ),
    );

    //分组标签
    Widget _itemBody;
    if (this.groupTitle != null) {
      _itemBody = Column(
        children: <Widget>[
          Container(
            height: GROUP_TITLE_HEIGHT,
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            color: Color(AppColors.ContactGroupTitleBg),
            alignment: Alignment.centerLeft,
            child: Text(
              this.groupTitle,
              style: AppStyles.GroupTitleItemTextStyle,
            ),
          ),
          _button,
        ],
      );
    } else {
      _itemBody = _button;
    }

    return _itemBody;
  }
}

const INDEX_BAR_WORDS = [
  "↑",
  "☆",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
];

class ContactsPage extends StatefulWidget {
  Color _indexBarBg = Colors.transparent;

  //

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ScrollController _scrollController;
  final ContactsPageData data = ContactsPageData.mock();
  final List<Contact> _contacts = [];

  final List<_ContactItem> _functionbuttons = [
    _ContactItem(
      avatar: 'assets/images/ic_new_friend.png',
      title: '新的朋友',
      onpress: () {
        print('添加新朋友');
      },
    ),
    _ContactItem(
      avatar: 'assets/images/ic_group_chat.png',
      title: '群聊',
      onpress: () {
        print('群聊');
      },
    ),
    _ContactItem(
      avatar: 'assets/images/ic_tag.png',
      title: '标签',
      onpress: () {
        print('标签');
      },
    ),
    _ContactItem(
      avatar: 'assets/images/ic_public_account.png',
      title: '公众号',
      onpress: () {
        print('添加公众号');
      },
    ),
  ];

  final Map _letterPosMap = {INDEX_BAR_WORDS[0]: 0.0};

  var mockConversation = ContactsPageData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contacts
      ..addAll(data.contacts)
      ..addAll(data.contacts)
      ..addAll(data.contacts);

    _contacts
        .sort((Contact a, Contact b) => a.nameIndex.compareTo(b.nameIndex));

    _scrollController = new ScrollController();

    //计算用于IndexBar 进行定位的关键通讯录列表项的位置
    var _totalPos = _functionbuttons.length * _ContactItem._height(false);

    for (int i = 0; i < _contacts.length; i++) {
      bool _hasGroupTitle = true;
      if (i>0&&_contacts[i].nameIndex.compareTo(_contacts[i - 1].nameIndex) == 0) {
        _hasGroupTitle = false;
      }
      if(_hasGroupTitle){
        _letterPosMap[_contacts[i].nameIndex]=_totalPos;
      }
      _totalPos+=_ContactItem._height(_hasGroupTitle);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _letters = INDEX_BAR_WORDS.map((String word) {
      return Expanded(child: Text(word));
    }).toList();

    return Stack(
      children: <Widget>[
        ListView.builder(
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            if (index < _functionbuttons.length) {
              return _functionbuttons[index];
            }
            int _cotactIndex = index - _functionbuttons.length;
            Contact _contact = _contacts[_cotactIndex];

            bool _isGroupTitle = true;
            if (_cotactIndex >= 1 &&
                _contact.nameIndex == _contacts[_cotactIndex - 1].nameIndex) {
              _isGroupTitle = false;
            }

            return _ContactItem(
              avatar: _contact.avatar,
              title: _contact.name,
              groupTitle: _isGroupTitle ? _contact.nameIndex : null,
            );
          },
          itemCount: _contacts.length + _functionbuttons.length,
        ),
        Positioned(
            width: Constants.IndexBarWidth,
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Container(
                color: widget._indexBarBg,
                child: GestureDetector(
                  child: Column(
                    children: _letters,
                  ),
                  onVerticalDragDown: (DragDownDetails) {
                    print('onVerticalDragDown');
                    setState(() {
                      widget._indexBarBg = Colors.black26;
                    });
                    _scrollController.animateTo(_letterPosMap['M'],
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  },
                  onVerticalDragEnd: (DragEndDetails) {
                    print('onVerticalDragEnd===');
                    setState(() {
                      widget._indexBarBg = Colors.transparent;
                    });
                  },
                  onHorizontalDragCancel: () {
                    print('onHorizontalDragCancelxxxx');
                    setState(() {
                      widget._indexBarBg = Colors.transparent;
                    });
                  },
                )))
      ],
    );
  }
}
