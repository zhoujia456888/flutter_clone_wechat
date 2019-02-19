import 'package:flutter/material.dart';

import '../constants.dart' show Constants,AppColors,AppStyles;

class FullWidthButton extends StatelessWidget {
  static const HORIZONTAL_PADDING = 20.0;
  static const VERTICAL_PADDING = 13.0;

  const FullWidthButton({
    @required this.title,
    @required this.iconPath,
    @required this.onPressed,
    this.showDivider: false,
  })
      : assert(iconPath != null),
        assert(title != null),
        assert(onPressed != null);

  final String title;
  final String iconPath;
  final VoidCallback onPressed;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final pureButton = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            iconPath,
            width: Constants.FullWidthIconButtonIconSize,
            height: Constants.FullWidthIconButtonIconSize,
          ),
          SizedBox(width: HORIZONTAL_PADDING,),
          Text(title)
        ]
    );

    final borderedButton=Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: const Color(AppColors.DividerColor),
              width: Constants.Dividerwidth)
        )
      ),
      padding: const EdgeInsets.only(bottom: VERTICAL_PADDING),
      child: pureButton,
    );


    return FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.only(left: HORIZONTAL_PADDING,right:
      HORIZONTAL_PADDING,
      top: VERTICAL_PADDING,bottom: this.showDivider?0.0:VERTICAL_PADDING),
      color: Colors.white,
      child: this.showDivider?borderedButton:pureButton,
    );
  }
}
