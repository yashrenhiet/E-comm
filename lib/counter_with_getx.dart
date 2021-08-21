import 'package:e_comm_app/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestData {
  List<String> getTestNames() => ["ABC", "PQR"];
}

class AppStateX extends GetxController {
  CounterX get counter => Get.find<CounterX>();

  var isLoggedIn = false.obs;

  loginUser() => isLoggedIn.value = true;

  logoutUser() => isLoggedIn.value = false;

  getCount1() => counter.count;

  incrementCount1() => counter.count++;
}

class CounterX extends GetxController {
  var count = 0.obs;

  var counter2 = 0.obs;

  increment() => count++;

  increment2() => counter2++;
}

class CounterXPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Counter Example"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.teal,
                child: DiplayXWidget(),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                child: Diplay2XWidget(),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     color: Colors.blue,
            //     child: DiplayNameWidget(),
            //   ),
            // ),
            Expanded(child: Container(child: IncrementerXWidget()))
          ],
        ),
      ),
    );
  }
}

class DiplayXWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint(" ================= > DiplayXWidget build called");
    return Center(child: Obx(() {
      debugPrint(" ================= > DiplayXWidget obx called");
      return Text(
        "I am count ${Get.find<AppStateX>().getCount1()}",
        key: ValueKey("increment1Value"),
      );
    }));
  }
}

class Diplay2XWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint(" ================= > Diplay2XWidget build called");

    return Center(child: Obx(() {
      debugPrint(" ================= > Diplay2XWidget obx called");
      var controller = Get.find<AppStateX>();
      return Text(
          "I am showing all|  ${controller.getCount1()} | ${Get.find<CounterX>().counter2}");
    }));
  }
}

class DiplayNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint(" ================= > DiplayNameWidget build called");
    // return Center(child: Obx(() {
    //   debugPrint(" ================= > DiplayNameWidget obx called");
    //   return Text(
    //       "Just showing names ${Get.find<TestData>().getTestNames().join(",")}");
    // }));
    return Center(
      child: Text(
          "Just showing names ${Get.find<TestData>().getTestNames().join(",")}"),
    );
  }
}

class IncrementerXWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            ElevatedButton(
              key: ValueKey("increment1"),
              onPressed: () {
                Get.find<AppStateX>().incrementCount1();
              },
              child: Text("I am going to increment"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<CounterX>().increment2();
              },
              child: Text("I am going to increment 2"),
            ),
            ElevatedButton(
                onPressed: () {
                  // This will not work for now.
                  Get.to(LoginPage());
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
