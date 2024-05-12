// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_player/views/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
            child: Icon(
              Icons.music_note,
              size: 40,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          )),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25),
            child: ListTile(
              title: Text('H O M E',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              leading: Icon(Icons.home,
                  color: Theme.of(context).colorScheme.inversePrimary),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 25),
            child: ListTile(
              title: Text('S E T T I N G S',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              leading: Icon(Icons.settings,
                  color: Theme.of(context).colorScheme.inversePrimary),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsView()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
