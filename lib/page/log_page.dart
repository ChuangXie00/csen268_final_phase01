import 'package:flutter/material.dart';
import '../component/log_calendar_legend.dart';
import 'package:intl/intl.dart';

class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime currentMonth = DateTime(now.year, now.month);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workout Dates',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.add, color: Colors.transparent), // 空按钮
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const LogCalendarLegend(), // 👈 这是 Legend 插入的位置
            const SizedBox(height: 12),
            ...List.generate(14, (i) {
              final now = DateTime.now();
              final reversedMonth = DateTime(now.year, now.month - i);
              return _buildMonthCalendar(reversedMonth);
            }),
          ],
        ),
      ),
    );
  }

  /// 构建一整个月的日历
  Widget _buildMonthCalendar(DateTime month) {
    final String monthLabel = DateFormat.yMMMM().format(
      month,
    ); // 例如 August 2025
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final firstWeekday = firstDay.weekday % 7; // 使周日为0，周一为1…

    final List<TableRow> rows = [];

    // 星期标题行
    rows.add(
      const TableRow(
        children: [
          Center(child: Text('S')),
          Center(child: Text('M')),
          Center(child: Text('T')),
          Center(child: Text('W')),
          Center(child: Text('T')),
          Center(child: Text('F')),
          Center(child: Text('S')),
        ],
      ),
    );

    // 构建日期格子
    List<Widget> currentRow = List.generate(7, (_) => const SizedBox.shrink());
    int dayCounter = 1;

    for (int i = 0; i < firstWeekday; i++) {
      currentRow[i] = const SizedBox.shrink();
    }

    for (int i = firstWeekday; i < 7; i++) {
      currentRow[i] = _buildCalendarCell(dayCounter, _fakeStatus(dayCounter));
      dayCounter++;
    }
    rows.add(TableRow(children: currentRow));

    while (dayCounter <= daysInMonth) {
      currentRow = List.generate(7, (_) => const SizedBox.shrink());
      for (int i = 0; i < 7 && dayCounter <= daysInMonth; i++) {
        currentRow[i] = _buildCalendarCell(dayCounter, _fakeStatus(dayCounter));
        dayCounter++;
      }
      rows.add(TableRow(children: currentRow));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          monthLabel,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: rows,
        ),
      ],
    );
  }

  /// 模拟获取某天的状态（真实项目中从 Hive/Cubit 获取）
  /// 这里只是举例说明不同样式
  String _fakeStatus(int day) {
    if (day == 4) return 'complete';
    if (day == 7) return 'complete';
    if (day == 9) return 'complete';
    if (day == 14) return 'complete';
    if (day == 18) return 'complete';
    if (day == 22) return 'complete';
    if (day == 3) return 'incomplete';
    if (day == 19) return 'incomplete';
    return 'none';
  }

  /// 构建单个日期格子（根据状态显示不同样式）
  Widget _buildCalendarCell(int day, String status) {
    Color bgColor = Colors.transparent;
    Color borderColor = Colors.transparent;
    Color textColor = Colors.white;

    switch (status) {
      case 'none':
        bgColor = Colors.transparent;
        textColor = Colors.white;
        break;
      case 'incomplete':
        borderColor = Colors.orange;
        textColor = Colors.orange;
        break;
      case 'complete':
        bgColor = Colors.orange;
        textColor = Colors.white;
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border:
              borderColor != Colors.transparent
                  ? Border.all(color: borderColor, width: 2)
                  : null,
        ),
        alignment: Alignment.center,
        child: Text(
          '$day',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
