import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transliterator_app/provider/theme_manager.dart';
import 'package:transliterator_app/screens/history_screen.dart';
import 'package:transliterator_app/screens/translator_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key key}) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  PageController pageController;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=>ThemeNotifier(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Transliterator'),
            actions: [
              Switch(
                value: context.read<ThemeNotifier>().isDarkMode,
                onChanged: (value){
                  context.read<ThemeNotifier>().isDarkMode ? context.read<ThemeNotifier>().setLightMode()
                      : context.read<ThemeNotifier>().setDarkMode();
                },
              ),
            ],
            bottom: TabBar(
              controller: tabController,
              onTap: (index){
                setState(() {
                  currentIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              tabs: [
                Tab(icon: Icon(Icons.translate,)),
                Tab(icon: Icon(Icons.history,)),
              ],
            ),
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: (index){
              currentIndex = index;
              tabController.animateTo(index);
            },
            children: [
              TranslatorScreen(),
              HistoryTab()
            ],
          ),
        ),
      )
    );
  }
}
