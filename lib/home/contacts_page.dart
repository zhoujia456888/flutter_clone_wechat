import 'package:flutter/material.dart';

import '../constants.dart' show Constants,AppColors;
import '../modal/contacts.dart' show Contact, ContactsPageData;

class _ContactItem extends StatelessWidget {
  _ContactItem({@required this.avater, @required this.title, this.groupTitle});

  final Contact _contact = ContactsPageData.mock().contacts[0];

  final String avater;
  final String title;
  final String groupTitle;




  @override
  Widget build(BuildContext context) {

    Widget _avatarIcon=Image.network(
      avater,
      width: Constants.ContactAvatarSize,
      height: Constants.ContactAvatarSize,
    );

    return Container(
      padding:
          EdgeInsets.only(left: 16.0,right: 16.0 ),

      child: Container(
        padding: EdgeInsets.only(bottom: 10.0,top: 10.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: Constants.Dividerwidth,color:Color(AppColors.DividerColor) )
            )
        ),
        child: Row(
          children: <Widget>[
            _avatarIcon,
            SizedBox(
              width: 10.0,
            ),
            Text(title)
          ],
        ),
      )
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<Contact> _contacts = ContactsPageData.mock().contacts;

  var mockConversation = ContactsPageData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Contact _contact = _contacts[index];
        return _ContactItem(
          avater: _contact.avatar,
          title: _contact.name,
          groupTitle: _contact.nameIndex,
        );
      },
      itemCount: _contacts.length,
    );
  }
}
