import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_points/routes/routes.dart';
import 'package:task_points/service/auth_provider.dart';
import 'package:task_points/service/tarefa_provider.dart';
import 'package:task_points/views/cadastro_view.dart';
import 'package:task_points/views/dashboard_view.dart';
import 'package:task_points/views/form_tarefa_view.dart';
import 'package:task_points/views/home_view.dart';
import 'package:task_points/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_points/views/tarefa_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return MultiProvider(
      providers: [ChangeNotifierProvider(
        create: (context) => AuthProviderFB(),
      ),
      ChangeNotifierProvider(
      create: (context) => TarefaProvider())
      ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70),
        scaffoldBackgroundColor: Color.fromRGBO(255, 252, 232, 1),
        fontFamily: 'OpenDyslexic3',
        useMaterial3: true,
      ),
      routes: {
        Routes.CADASTRO_VIEW : (context) => CadastroView(),
        Routes.HOME_VIEW : (context) => HomeView(),
        Routes.FORM_TAREFA_VIEW : (context) => FormTarefaView(),
        Routes.TAREFA_VIEW : (context) => TarefaView(),
        Routes.DASHBOARD_VIEW : (context) => DashboardView()
      },
      home: user != null ? HomeView() : LoginView(),
    ),);
  }
}