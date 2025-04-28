class Player {
  int runs;
  bool isOut;

  Player({this.runs = 0, this.isOut = false});

  void addRuns(int value) {
    runs += value;
  }

  void markOut() {
    isOut = true;
  }

  void reset() {
    runs = 0;
    isOut = false;
  }
}
