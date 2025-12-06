import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tick_it/core/di/injection.dart';
import 'package:tick_it/core/routes/my_router.dart';
import 'package:tick_it/core/routes/my_routes.dart';
import 'package:tick_it/core/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  // Setup Dependency Injection
  await setupGetIt();

  runApp(MyApp(myRouter: MyRouter()));
}

class MyApp extends StatelessWidget {
  final MyRouter myRouter;
  const MyApp({super.key, required this.myRouter});

  @override
  Widget build(BuildContext context) {
    // Check if user is already logged in
    final session = Supabase.instance.client.auth.currentSession;
    final initialRoute = session != null ? MyRoutes.home : MyRoutes.login;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: 'Supabase Auth',
          theme: MyTheme.darkTheme,
          onGenerateRoute: myRouter.generateRoute,
          initialRoute: initialRoute,
        );
      },
    );
  }
}
