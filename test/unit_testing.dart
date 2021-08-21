import 'package:e_comm_app/counter_with_getx.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter', () {
    test('When counter is initialized then default value of count should be 0',
        () {
      // ARRANGE
      CounterX counter = CounterX();

      // ACT

      // ASSERT
      expect(counter.count.value, 0);
    });

    test(
        'When counter is initialized then default value of counter2 should be 0',
        () {
      // ARRANGE
      CounterX counter = CounterX();

      // ACT

      // ASSERT
      expect(counter.counter2.value, 0);
    });

    test('When we call increment then count should be incremented', () {
      // ARRANGE
      CounterX counter = CounterX();

      // ACT
      counter.increment();

      // ASSERT
      expect(counter.count.value, 1);
      expect(counter.counter2.value, 0);
    });
  });
}
