import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeDrawerItem extends StatelessWidget {

  const HomeDrawerItem({
    @required this.title,
    @required this.icon,
    this.onTap,
    @required this.isSelected,
  });

  final String title;

  final IconData icon;

  final GestureTapCallback onTap;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(title,
        style: new TextStyle(
          fontFamily: 'Delius',
        ),
      ),
      leading: new Icon(icon),
      onTap: onTap,
      selected: isSelected,
    );
  }

}