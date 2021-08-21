import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterWithProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    debugPrint("=========> increment called $_count");
    notifyListeners();
  }
}

class CounterProviderPage extends StatelessWidget {
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
                child: DiplayWidget(),
              ),
            ),
            Expanded(child: Container(child: IncrementerWidget()))
          ],
        ),
      ),
    );
  }
}

class DiplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text("I am showing ${context.watch<CounterWithProvider>().count}"));
  }
}

class IncrementerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ElevatedButton(
          onPressed: () {
            context.read<CounterWithProvider>().increment();
          },
          child: Text("I am going to increment"),
        ),
      ),
    );
  }
}
