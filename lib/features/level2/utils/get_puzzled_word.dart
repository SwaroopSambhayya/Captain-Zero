List<String> getPuzzledWord(String answer) {
  List<String> words = answer.split("");
  words.shuffle();
  return words;
}
