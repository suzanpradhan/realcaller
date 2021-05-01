extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String getInitials() =>
      this.trim().split(' ').map((l) => l[0]).take(2).join();
}
