class PieChartSectionData {
  String title;
  int color;

  PieChartSectionData({required this.title, required this.color});
}

List<PieChartSectionData> data = [
  PieChartSectionData(title: 'Expense', color: 0xffFF0000),
  PieChartSectionData(title: 'Income', color: 0xff00FF00),
];
