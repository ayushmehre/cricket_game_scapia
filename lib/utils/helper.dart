import 'dart:math';

/// Returns a random integer between [min] and [max], inclusive.
int getRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}
