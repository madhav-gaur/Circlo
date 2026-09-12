import 'dart:math';

String generateCircleInvite() {
  final random = Random();

  const letters = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  return List.generate(6, (index) {
    return letters[random.nextInt(letters.length)];
  }).join();
}
