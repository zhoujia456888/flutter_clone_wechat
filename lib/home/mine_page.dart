import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/home/full_width_button.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static const SEPARATE_SIZE = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: SEPARATE_SIZE),
            FlatButton(
              onPressed: () {},
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 13.0, bottom: 13.0),
              color: Colors.white,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          'https://randomuser.me/api/portraits/women/17.jpg',
                          width: Constants.MainHandImgSize,
                          height: Constants.MainHandImgSize,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '小鸡炖蘑菇',
                              style: AppStyles.MineNickStyle,
                            ),
                            Text('微信号：abcd1234',style: AppStyles.MineNumberStyle,)
                          ]),
                    ]),

            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_wallet.png',
              title: '支付',
              onPressed: () {
                print('支付');
              },
            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_collections.png',
              title: '收藏',
              showDivider: true,
              onPressed: () {
                print('收藏');
              },
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_album.png',
              title: '相册',
              showDivider: true,
              onPressed: () {},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_cards_wallet.png',
              title: '卡包',
              showDivider: true,
              onPressed: () {},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_emotions.png',
              title: '表情',
              showDivider: true,
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_settings.png',
              title: '设置',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
