import 'package:fingerprint_app/constant/colors.dart';
import 'package:fingerprint_app/constant/value.dart';
import 'package:fingerprint_app/mvc/success_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  bool didAuthenticate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(color: black, fontSize: fontVeryBig),
            ),
            Text(
              'Lets check fingerprint authentication',
              style: TextStyle(color: textSecondary, fontSize: fontSmall),
            ),
            if (_supportState)
              Text(
                'Biometrics Supported',
                style: TextStyle(color: green, fontSize: fontSmall),
              )
            else
              Text(
                'Biometrics not Supported',
                style: TextStyle(color: red, fontSize: fontSmall),
              ),
            GestureDetector(
              onTap: () {
                _authenticateMethod();

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10),
                height: 40,
                width: 100,
                child: const Center(
                  child: Text(
                    'Check',
                    style: TextStyle(color: white, fontSize: fontMedium),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> _getAvailableBiometrics() async {
  //   List<BiometricType> availableBiometrics =
  //       await auth.getAvailableBiometrics();
  //   print('List of Biometrics : $availableBiometrics');
  //   if (!mounted) {
  //     return;
  //   }
  // }

  Future<void> _authenticateMethod() async {
    try {
      didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true));
      if (didAuthenticate) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SuccessAuth()));
      }

      print('Authentication: $didAuthenticate');
    } on PlatformException {
      // ...
    }
  }
}
