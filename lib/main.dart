import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transliterator_app/provider/theme_manager.dart';
import 'package:transliterator_app/screens/index.dart';

void main() => runApp(
    ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => new ThemeNotifier(),
        child: MyApp()
    )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
    builder: (context, theme, _) => MaterialApp(
      title: 'Transliterator',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: IndexScreen(),
    )
    );
  }
}








