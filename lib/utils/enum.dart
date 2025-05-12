enum Tourny {
  upcoming('Upcoming'),
  inProgress('In Progress'),
  completed('Completed'),
  seasons('Ladder');
  // other('Upcoming');

  final String value;

  const Tourny(this.value);
}

enum TournyType {
  squad('Tournaments'),
  solo('Ladders');

  final String value;

  const TournyType(this.value);
}
