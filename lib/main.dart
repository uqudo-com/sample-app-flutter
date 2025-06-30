import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:uqudosdk_flutter/UqudoIdPlugin.dart';
import 'package:uqudosdk_flutter/uqudosdk_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _result = '';

  @override
  void initState() {
    super.initState();
    UqudoIdPlugin.init();
    // UqudoIdPlugin.setLocale("ar");
    listenNativeEvent();
  }

  static const EventChannel _eventChannel =
      EventChannel('io.uqudo.sdk.id/trace');

  void listenNativeEvent() {
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void _onEvent(Object? event) {
    if (event != null) {
      print("---TraceEvent=${event.toString()}");
    }
  }

  void _onError(Object error) {
    print('---TraceEvent error.');
  }

  Future<void> scanEmiratesId() async {
    try {
      final String token = "ACCESS_TOKEN_HERE";

      var document = DocumentBuilder()
          .setDocumentType(DocumentType.UAE_DL)
          .build();

      var enrollObject = EnrollmentBuilder()
          .setToken(token)
          .disableSecureWindow()
          .add(document)
          .setAppearanceMode(AppearanceMode.SYSTEM)
          .build();

      debugPrint('Starting Uqudo Emirates ID Enrollment...');

      final result = await UqudoIdPlugin.enroll(enrollObject);
      setState(() {
        _result = result;
      });
    } on PlatformException catch (exception) {
      debugPrint(
        'Uqudo SDK Platform Exception during Emirates ID scan: ${exception.code} - ${exception.message}',
      );
    } catch (e) {
      debugPrint('Uqudo Emirates ID Scan Error: $e');
    }
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> passportEnrollment() async {
  //   String result;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     var token = "ACCESS_TOKEN_HERE";
  //     var doc = DocumentBuilder()
  //         .setDocumentType(DocumentType.PASSPORT)
  //         .enableReading()
  //         .build();
  //
  //     var enrollObject = EnrollmentBuilder()
  //       ..setToken(token)
  //       ..enableFacialRecognition()
  //       ..setAppearanceMode(AppearanceMode.SYSTEM)
  //       ..returnDataForIncompleteSession()
  //       ..add(doc);
  //     result = await UqudoIdPlugin.enroll(enrollObject.build());
  //   } catch (error) {
  //     result = error.toString();
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _result = result;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Uqudo SDK Flutter Demo'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () => scanEmiratesId(),
                  icon: const Icon(Icons.touch_app),
                  label: const Text('Start Passport Onboarding'),
                ),
                const SizedBox(
                    height:
                        20), // Add some spacing between the button and result text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Result:\n $_result',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
