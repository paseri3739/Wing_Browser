import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_app_bar.dart';
import 'browser_app_bar_component.dart';
import 'url_field.dart';
import 'web_view_home_page.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        // Hide Floating button when keyboard appeared
        resizeToAvoidBottomInset: false,
        appBar: BrowserAppBarComponent(),
        body: Column(children: [
          UrlField(
            height: 30, //マジックナンバー
          ),
          Expanded(child: WebViewHomePage())
        ]),
        bottomNavigationBar: BrowserBottomAppBar(height: 70),
        floatingActionButton: SearchButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
