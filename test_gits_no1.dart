import 'dart:io';

List<int> a000124(int n) {
  if (n <= 0) return [];
  // i berjalan dari 0..n-1, suku ke-(i+1) = 1 + i*(i+1)/2
  return List<int>.generate(n, (i) => 1 + (i * (i + 1) ~/ 2));
}

void main() {
  stdout.write('Masukkan n: ');
  String? line = stdin.readLineSync();
  if (line == null) return;
  int? n = int.tryParse(line.trim());
  if (n == null || n <= 0) {
    print('Masukkan harus bilangan bulat positif.');
    return;
  }

  List<int> seq = a000124(n);
  // Gabungkan dengan tanda '-'
  String output = seq.join('-');
  print('Output : $output');
}
