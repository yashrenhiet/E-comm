import 'package:e_comm_app/features/_common/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _height = 0;
  double _width = 0;

  double _opacity = 0;

  late AnimationController _controller;

  late ColorTween _colorTween;

  double newVal = 0;

  @override
  void initState() {
    super.initState();

    //.then((value) => Get.off(LoginPage()));

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        _width = 150;
        _height = 200;
        _opacity = 1;
      });

      // Get.find<AppState>().initializeData();
    });

    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _colorTween = ColorTween(begin: Colors.limeAccent, end: Colors.red)
      ..animate(_controller);

    _controller.addListener(() {
      setState(() {
        newVal = _controller.value;
        debugPrint('=========================> ${_controller.value}');
      });
    });

    _controller.addStatusListener((status) {
      debugPrint('${status}');
      if (status == AnimationStatus.completed) {
        // _controller.reverse();
        Get.find<AppState>().initializeData();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.repeat();
          }
        },
        child: Container(
          color: _colorTween.evaluate(_controller),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedLogo(
                  animation: _controller,
                ),
                // AnimatedContainer(
                //   width: _width,
                //   height: _height,
                //   curve: Curves.easeInOut,
                //   duration: Duration(milliseconds: 500),
                //   child: FlutterLogo(),
                //   onEnd: () {
                //     // setState(() {
                //     //   _width = _width == 125 ? 150 : 125;
                //     // });
                //     // Get.find<AppState>().initializeData();
                //   },
                // ),
                // AnimatedOpacity(
                //   opacity: _opacity,
                //   curve: Curves.fastOutSlowIn,
                //   duration: Duration(milliseconds: 350),
                //   child: Text(
                //     "E-Comm App",
                //     style: Get.textTheme.headline4,
                //   ),
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       setState(() {
                //         // if (_width == 0) {
                //         //   _width = 70;
                //         // } else if (_width == 70) {
                //         //   _width = 150;
                //         // } else {
                //         //   _width = 0;
                //         // }
                //         //
                //         // if (_height == 0) {
                //         //   _height = 90;
                //         // } else if (_height == 90) {
                //         //   _height = 200;
                //         // } else {
                //         //   _height = 0;
                //         // }
                //
                //         _width = _width == 0 ? 150 : 00;
                //         _height = _height == 0 ? 200 : 00;
                //         _opacity = _opacity == 1 ? 0 : 1;
                //       });
                //     },
                //     child: Text("Change"))
              ],
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("E-Comm App", style: Get.textTheme.headline3),
            //     SizedBox(height: 16),
            //     CircularProgressIndicator(),
            //   ],
            // ),
            // child: ElevatedButton(
            //   child: Text("Hello"),
            //   onPressed: () async {
            //     await Get.find<ProductRepo>().fetchProducts();
            //
            //     // debugPrint("going to login");
            //     // await Navigator.pushReplacement(
            //     //     context, MaterialPageRoute(builder: (_) => LoginPage()));
            //     // debugPrint("returned form  login");
            //
            //     // debugPrint("going to forgot pass");
            //     // dynamic res = await Navigator.of(context)
            //     //     .push(MaterialPageRoute(builder: (_) => ForgotPassword()));
            //     // if (res == true) {
            //     //   debugPrint("success");
            //     // } else {
            //     //   debugPrint("failed");
            //     // }
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({required Animation<double> animation})
      : super(listenable: animation);

  final _sizeTween = SizeTween(begin: Size(50, 50), end: Size(150, 200));
  final _colorTween = ColorTween(begin: Colors.amberAccent, end: Colors.indigo);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Opacity(
      opacity: animation.value,
      child: Column(
        children: [
          Container(
            height: _sizeTween.evaluate(animation)!.height,
            width: _sizeTween.evaluate(animation)!.width,
            //color: _colorTween.evaluate(animation),
            child: FlutterLogo(),
          ),
          Text(
            "E-Comm App",
            style: Get.textTheme.headline3!
                .copyWith(color: _colorTween.evaluate(animation)),
          )
        ],
      ),
    );
  }
}
