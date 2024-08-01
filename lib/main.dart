import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide AuthProvider
    hide
        EmailAuthProvider; // EmailProvider hided for conflicts from 2 imports. Documented solution!
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:fire_app2/generated/firebase_options.dart';
import 'package:fire_app2/constants/client_ids.dart';
import 'package:fire_app2/services/firestore_service.dart';
import 'package:fire_app2/views/home_page.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Firebase initialization
  await Firebase.initializeApp(
    name: "FlutterFireSample2",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static List<AuthProvider> signInProvider = [
    EmailAuthProvider(),
    GoogleProvider(clientId: ClientIds.googleClientId),
    FacebookProvider(clientId: ClientIds.facebookClientId),
  ];

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          builder: (context, child) => ResponsiveWrapper.builder(
            child,
            maxWidth: 4020,
            minWidth: 480,
            defaultScale: true,
            breakpoints: const [
              ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
          ),
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute:
              FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
          routes: {
            '/sign-in': (context) {
              return SignInScreen(
                providers: signInProvider,
                actions: [
                  AuthStateChangeAction<SignedIn>((context, state) {
                    Navigator.pushReplacementNamed(context, '/');
                  }),
                  AuthStateChangeAction<UserCreated>((context, state) {
                    Navigator.pushReplacementNamed(context, '/');
                    FirestoreService()
                        .addUser(FirebaseAuth.instance.currentUser!.email!);
                  }),
                ],
              );
            },
            '/': (context) => const HomePage(),
          },
        );
      },
    );
  }
}
