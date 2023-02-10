import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/navigation/router_navigation.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      ),
      initialRoute: 'homeScreen',
      supportedLocales: const [Locale('en'), Locale('es')],
      getPages: getPages!,
      debugShowCheckedModeBanner: false,
    );
  }
}
