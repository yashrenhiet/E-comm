import 'dart:io';

import 'package:e_comm_app/counter_with_getx.dart';
import 'package:e_comm_app/features/_common/app_state.dart';
import 'package:e_comm_app/features/_common/firebase_handler.dart';
import 'package:e_comm_app/features/_repo/db_helper.dart';
import 'package:e_comm_app/features/_repo/product_repo.dart';
import 'package:e_comm_app/features/home/home_page.dart';
import 'package:e_comm_app/features/login/login_page.dart';
import 'package:e_comm_app/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseHandler.init();

  Get.put(AppState());
  Get.put(ProductRepo());

  Get.put(AppStateX());
  Get.put(CounterX());

  // Get.putAsync(() async {
  //   var dbHelper = DbHelper();
  //   await dbHelper.init();
  //   return dbHelper;
  // });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "E-Comm",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: CounterXPage()
        // home: Obx(() {
        //   var curState = Get.find<AppState>().state.value;
        //
        //   if (curState == AppStateEnum.AUTHENTICATED) return HomeScreen();
        //   if (curState == AppStateEnum.NOT_AUTHENTICATED) return LoginPage();
        //
        //   return SplashScreen();
        // }),
        );
  }
}

// class Fly {
//   void startFlying() {
//     debugPrint("I am flying");
//   }
//
//   void stopFlying() {
//     debugPrint("I am done with flying");
//   }
// }
//
// class Walk {
//   void startWalking() {
//     debugPrint("I am walking");
//   }
//
//   void stopWalking() {
//     debugPrint("I am done with walking");
//   }
// }
//
// class Swim {
//   void startSwimming() {
//     debugPrint("I am swimming");
//   }
//
//   void stopSwimming() {
//     debugPrint("I am done with swimming");
//   }
// }
//
// class Eagle with Walk, Fly {}
//
// class Cat with Walk, Swim {}

class WidgetLife extends StatefulWidget {
  final String title;

  const WidgetLife({Key? key, required this.title}) : super(key: key);

  @override
  _WidgetLifeState createState() => _WidgetLifeState();
}

class _WidgetLifeState extends State<WidgetLife> with WidgetsBindingObserver {
  var _counter = 0;
  bool _flashlightState = false;
  bool _showScanView = false;
  QrReaderViewController? _controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

    debugPrint("initState called");
  }

  Future<bool> permission() async {
    // if (_openAction) return false;
    // _openAction = true;
    var status = await Permission.camera.status;
    print(status);
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
      print(status);
    }

    if (status.isRestricted) {
      await Future.delayed(Duration(seconds: 3));
      openAppSettings();
      // _openAction = false;
      return false;
    }

    if (!status.isGranted) {
      // alert("请必须授权照相机权限");
      // _openAction = false;
      return false;
    }
    // _openAction = false;
    return true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("==============================  ${state}");
    if (state == AppLifecycleState.resumed) {
      debugPrint("==================== AUTH REQUIRED =================");
    }
  }

  @override
  void didUpdateWidget(covariant WidgetLife oldWidget) {
    debugPrint("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title) {
      // reinitiate the video
    }
  }

  @override
  void didChangeDependencies() {
    debugPrint("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var eagle = Eagle();
    // var cat = Cat();
    //
    // cat.startWalking();

    debugPrint("build");

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text("Pressed me $_counter times"),
              onPressed: () {
                debugPrint("calling setState");
                setState(() {
                  ++_counter;
                });
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  openScan(context);
                },
                child: Text("Start scanning...")),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    debugPrint("deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint("desposed");
    super.dispose();
  }

  Future openScan(BuildContext context) async {
    if (false == await permission()) {
      return;
    }

    setState(() {
      _showScanView = true;
    });
  }

  Future startScan() async {
    assert(_controller != null);
    _controller?.startCamera((String result, _) async {
      await stopScan();
      debugPrint("===================== SCANNING RESULT $result");
      // showDialog(
      //   context: scaffoldKey.currentContext!,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text('扫码结果'),
      //       content: Text(result),
      //     ).build(context);
      //   },
      // );
    });
  }

  Future stopScan() async {
    assert(_controller != null);
    await _controller?.stopCamera();
    setState(() {
      _showScanView = false;
    });
  }

  Future flashlight() async {
    assert(_controller != null);
    final state = await _controller?.setFlashlight();
    setState(() {
      _flashlightState = state ?? false;
    });
  }
}
