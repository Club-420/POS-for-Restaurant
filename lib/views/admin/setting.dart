import 'package:flutter/material.dart';

class SettingAll extends StatefulWidget {
  const SettingAll({Key? key}) : super(key: key);

  @override
  State<SettingAll> createState() => _SettingAllState();
}

class _SettingAllState extends State<SettingAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,

      ),
    );
  }
}
