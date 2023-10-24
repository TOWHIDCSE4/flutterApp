import 'package:flutter/material.dart';

class YearDropdownMenuBar extends StatefulWidget {
  YearDropdownMenuBar({this.selectedYear, required this.onSelectYear, super.key});
  int? selectedYear;
  final void Function({required int newYear}) onSelectYear;
  @override
  State<YearDropdownMenuBar> createState() => _YearDropdownMenuBarState();
}

class _YearDropdownMenuBarState extends State<YearDropdownMenuBar> {
  List<int> years =
      List<int>.generate(10, (index) => DateTime.now().year - 5 + index);
  late int selectedYear;
  @override
  void initState() {
    setState(() {
      selectedYear = widget.selectedYear ?? years.first;
    });
    super.initState();
    // Set an initial value if required
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('(đvt: triệu đồng)'),
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            menuMaxHeight: 350,
            value: selectedYear,
            onChanged: (newValue) {
              widget.onSelectYear(newYear: newValue!);
              setState(() {
                selectedYear = newValue!;
              });
            },
            items: years.map<DropdownMenuItem<int>>((int year) {
              return DropdownMenuItem<int>(
                value: year,
                child: Text(year.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
