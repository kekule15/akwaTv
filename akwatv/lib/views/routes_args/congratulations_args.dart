class CongratulationsArgs {
  final String name;
  final String title;
  final String? subtitle;
  final String? date;
  final bool payLater;

  CongratulationsArgs(
      {required this.name, required this.title, this.subtitle, this.date, required this.payLater});
}
