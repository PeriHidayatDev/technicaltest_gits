import 'dart:io';

List<int> denseRanking(List<int> scores, List<int> gitsScores) {
  List<int> uniqueScores = scores.toSet().toList()
    ..sort((a, b) => b.compareTo(a));

  List<int> result = [];

  for (int score in gitsScores) {
    int rank = 1;
    for (int s in uniqueScores) {
      if (score >= s) break;
      rank++;
    }
    result.add(rank);
  }

  return result;
}

void main() {
  // input jumlah pemain
  print("Masukkan jumlah pemain:");
  int n = int.parse(stdin.readLineSync()!);

  print("Masukkan skor pemain (dipisahkan spasi):");
  List<int> scores = stdin.readLineSync()!.split(' ').map(int.parse).toList();

  // Validasi jumlah skor pemain
  if (scores.length != n) {
    print("Input tidak sesuai! Jumlah skor pemain harus $n.");
    return;
  }

  print("Masukkan jumlah permainan GITS:");
  int m = int.parse(stdin.readLineSync()!);

  print("Masukkan skor GITS (dipisahkan spasi):");
  List<int> gitsScores = stdin
      .readLineSync()!
      .split(' ')
      .map(int.parse)
      .toList();

  // Validasi jumlah skor GITS
  if (gitsScores.length != m) {
    print("Input tidak sesuai! Jumlah skor GITS harus $m.");
    return;
  }

  // hasil
  List<int> result = denseRanking(scores, gitsScores);

  print("\nOutput:");
  print(result.join(' '));
}
