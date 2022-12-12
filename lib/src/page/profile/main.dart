import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:capstone_design_flutter/src/page/profile/page/profile_page.dart';
import 'package:capstone_design_flutter/src/page/profile/theme.dart';
import 'package:capstone_design_flutter/src/page/profile/util/user_preferences.dart';

Future main_profile() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Profile());
}

class Profile extends StatelessWidget {
  static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
          title: title,
          home: ProfilePage(),
        ),
      ),
    );
  }
}
