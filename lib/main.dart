import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'themestore.dart';
import 'settingpage.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        Provider<ThemeStore>(
            create: (_) => ThemeStore()),
      ],
      child: MobXThemeApp()));
}

class MobXThemeApp extends StatelessWidget {
  const MobXThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeStore themeStore = ThemeStore();
    return Observer(builder: (context){
      return MaterialApp(
        theme: context.watch<ThemeStore>().currentThemeData,
        home: HomePage(themeStore: themeStore),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  final ThemeStore themeStore;
  const HomePage({Key? key, required this.themeStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme'),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(context: context,
                    builder: (BuildContext context) {
                      return Observer(builder: (_){
                        final themeStore = context.read<ThemeStore>();
                        return SimpleDialog(
                          title: Text('Select Theme'),
                          children: [

                            ListTile(
                              title: Text('Light Theme'),
                              leading: Radio(
                                value: ThemeType.light,
                                groupValue: themeStore.currentThemeType,
                                onChanged: (ThemeType? value) {
                                  themeStore.changeCurrentTheme(value!);
                                },
                              ),
                            ),

                            ListTile(
                              title: Text('Dark Theme'),
                              leading: Radio(
                                value: ThemeType.dark,
                                groupValue: themeStore.currentThemeType,
                                onChanged: (ThemeType? value) {
                                  themeStore.changeCurrentTheme(value!);
                                },
                              ),
                            ),
                          ],
                        );
                      });
                    });
              },
              icon: Icon(Icons.brightness_high_outlined)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Observer(builder: (context) {
                return ListTile(
                  title: Text('The current theme is: ${context.watch<ThemeStore>().themeString} '),
                );
              }),
            ),
            MaterialButton(
                child: Text('Go to setting page'),
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                })
          ],
        ),
      ),
    );
  }
}
