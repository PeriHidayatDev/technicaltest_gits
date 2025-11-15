import 'dart:io';

/// Mengubah string menjadi list char (tanpa loop)
List<String> toCharList(String s, [int index = 0]) {
  if (index == s.length) return [];
  return [s[index], ...toCharList(s, index + 1)];
}

/// Tahap 1: Membuat palindrome menggunakan rekursi

List<dynamic>? makePalindrome(List<String> s, int left, int right, int k) {
  if (left >= right) return [s, 0]; // selesai

  if (s[left] == s[right]) {
    return makePalindrome(s, left + 1, right - 1, k);
  }

  if (k <= 0) return null;

  // clone list
  List<String> copy = [...s];
  // paksa jadi sama dengan memilih yang terbesar agar lebih optimal
  String maxDigit = (copy[left].compareTo(copy[right]) > 0)
      ? copy[left]
      : copy[right];

  copy[left] = maxDigit;
  copy[right] = maxDigit;

  var result = makePalindrome(copy, left + 1, right - 1, k - 1);
  if (result == null) return null;

  return [result[0], result[1] + 1]; // jumlah perubahan bertambah
}

/// Tahap 2: Maksimalkan palindrome menjadi angka terbesar (rekursif)
///
/// Mengubah sisi menjadi '9' jika masih ada k tersisa
List<String> maximizePalindrome(List<String> s, int left, int right, int k) {
  if (left > right) return s;

  if (left == right) {
    // posisi tengah pada string ganjil
    if (k > 0 && s[left] != '9') {
      s[left] = '9';
    }
    return s;
  }

  List<String> copy = [...s];

  bool leftIs9 = copy[left] == '9';
  bool rightIs9 = copy[right] == '9';

  if (!leftIs9 || !rightIs9) {
    if (k >= 2) {
      copy[left] = '9';
      copy[right] = '9';
      return maximizePalindrome(copy, left + 1, right - 1, k - 2);
    }
  }

  return maximizePalindrome(copy, left + 1, right - 1, k);
}

/// Wrapper utama
String highestPalindrome(String s, int k) {
  List<String> chars = toCharList(s);

  var result = makePalindrome(chars, 0, chars.length - 1, k);

  if (result == null) return "-1";

  List<String> minimalPalindrome = result[0];
  int used = result[1];
  int remaining = k - used;

  List<String> finalPalindrome = maximizePalindrome(
    minimalPalindrome,
    0,
    minimalPalindrome.length - 1,
    remaining,
  );

  return finalPalindrome.join();
}

void main() {
  print("Masukkan string angka:");
  String s = stdin.readLineSync()!;

  print("Masukkan nilai k:");
  int k = int.parse(stdin.readLineSync()!);

  String result = highestPalindrome(s, k);
  print("\nOutput:");
  print(result);
}
