import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themestore.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeStore = context.watch<ThemeStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.purple,
          textColor: Colors.white,
          onPressed: (){
            ThemeType changeTo = themeStore.currentThemeType == ThemeType.light ? ThemeType.dark : ThemeType.light;
            themeStore.changeCurrentTheme(changeTo);
          },
          child: Text('Change Theme'),
        ),
      ),
    );
  }
}
