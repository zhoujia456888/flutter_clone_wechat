import 'package:flutter/material.dart';
import '../constants.dart' show Constants, AppColors,AppStyles;

import './conversation_page.dart';
import './contacts_page.dart';



enum ActionItems { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP }

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData icon, IconData activeIcon})
      : item = new BottomNavigationBarItem(
            icon: Icon(icon),
            activeIcon: Icon(activeIcon),
            title: Text(title, style: TextStyle(fontSize: 14)),
            backgroundColor: Colors.white);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;

  List<NavigationIconView> _navigationViews;
  List<Widget> _pages;

  int _currentIndex = 0;

  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
          title: '微信',
          icon: IconData(0xe608, fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe603, fontFamily: Constants.IconFontFamily)),
      NavigationIconView(
          title: '通讯录',
          icon: IconData(0xe601, fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe656, fontFamily: Constants.IconFontFamily)),
      NavigationIconView(
          title: '发现',
          icon: IconData(0xe600, fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe671, fontFamily: Constants.IconFontFamily)),
      NavigationIconView(
          title: '我',
          icon: IconData(0xe6c0, fontFamily: Constants.IconFontFamily),
          activeIcon: IconData(0xe626, fontFamily: Constants.IconFontFamily)),
    ];

    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      ConversationPage(),
      ContactsPage(),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.brown,
      )
    ];
  }

  _buildPopupMunuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(
          IconData(iconName, fontFamily: Constants.IconFontFamily),
          size: 22.0,
          color: const Color(AppColors.AppBarPopupMenuColor),
        ),
        Container(width: 12.0),
        Text(
          title,
          style: TextStyle(color: const Color(AppColors.AppBarPopupMenuColor)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive),
      items: _navigationViews.map((NavigationIconView _navigationViews) {
        return _navigationViews.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('微信',style:AppStyles.AppBarTextStyle),
        backgroundColor: Color(AppColors.DeviceInfoItemBg),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(IconData(0xe65e, fontFamily: Constants.IconFontFamily),
                  size: 22.0),
              onPressed: () {
                print("点击了搜索按钮");
              },color: Colors.black,),
          Container(
            width: 10.0,
          ),
          PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<ActionItems>>[
                  PopupMenuItem(
                    child: _buildPopupMunuItem(0xe69e, "发起群聊"),
                    value: ActionItems.GROUP_CHAT,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMunuItem(0xe638, "添加朋友"),
                    value: ActionItems.ADD_FRIEND,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMunuItem(0xe61b, "扫一扫"),
                    value: ActionItems.QR_SCAN,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMunuItem(0xe62a, "收付款"),
                    value: ActionItems.PAYMENT,
                  ),
                  PopupMenuItem(
                    child: _buildPopupMunuItem(0xe63d, "帮助于反馈"),
                    value: ActionItems.HELP,
                  ),
                ];
              },
              icon: Icon(IconData(0xe658, fontFamily: Constants.IconFontFamily),
                  size: 22.0,
                  color: Colors.black),
              onSelected: (ActionItems selected) {
                print('点击的是$selected');
              },),
          Container(width: 16.0),
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {

          print('当前显示的是第$index页');
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
