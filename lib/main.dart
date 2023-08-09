import 'package:chatapp/Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/layout_cubit.dart';
import 'Core/constants.dart';


import 'Screens/home_screen.dart';
import 'Screens/register_screen.dart';
import 'auth/auth_cubit.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  Constants.userID = sharedPref.getString('userID');
  debugPrint("User ID is : ${Constants.userID} ....");
  await Firebase.initializeApp(

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LayoutCubit()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            primaryColor: Colors.deepPurple,
          ),
          debugShowCheckedModeBanner: false,
          home: Constants.userID != null ? HomeScreen() : LoginScreen()
      ),
    );
  }
}
