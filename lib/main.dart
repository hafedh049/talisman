import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tesla/authentification/signin.dart';
import 'package:tesla/error.dart';
import 'package:tesla/screens.dart';
import 'package:tesla/waiting.dart';

Future<void> handler(RemoteMessage message) async {
  print(message.data);
}

Future<void> main() async {
  ErrorWidget.builder = (details) {
    return Material(
      child: Container(
        color: Colors.greenAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Flexible(
                  child: Text(
                    details.exception.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  };

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(handler);

  runApp(const Tesla());
}

class Tesla extends StatefulWidget {
  const Tesla({Key? key}) : super(key: key);

  @override
  State<Tesla> createState() => _TeslaState();
}

class _TeslaState extends State<Tesla> {
  final Future<FirebaseApp> appInitializer = Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyC5_gjHguWle8jyzINJg13-ULhwRHkVWOk",
        appId: "com.example.tesla",
        messagingSenderId: "325584005893",
        projectId: "neutrino-e1e27"),
  );
  //final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appInitializer,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Waiting(),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Error(error: snapshot.error.toString()),
              );
            },
          );
        }
        return Sizer(builder: (context, orientation, deviceType) {
          return const MaterialApp(
            showPerformanceOverlay: false,
            debugShowCheckedModeBanner: false,
            //navigatorKey: navigatorKey,
            home: /*const*/ NewContinue(),
          );
        });
      },
    );
  }
}

class NewContinue extends StatelessWidget {
  const NewContinue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Waiting();
          } else if (snapshot.hasError) {
            return Error(error: snapshot.error.toString());
          } else if (snapshot.hasData) {
            return const Screens();
          } else {
            return const SignIn();
          }
        },
      ),
    );
  }
}
