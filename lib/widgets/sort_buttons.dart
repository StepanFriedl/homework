import 'package:flutter/material.dart';
import 'package:homework/classes/user.dart';

class SortButtonsWidget extends StatefulWidget {
  final List<User> data;
  final String initialSelectedOption;
  final Function(String) onDataSorted;

  SortButtonsWidget({
    required this.data,
    required this.initialSelectedOption,
    required this.onDataSorted,
  });

  @override
  _SortButtonsWidgetState createState() => _SortButtonsWidgetState();
}

class _SortButtonsWidgetState extends State<SortButtonsWidget> {
  late String _selectedOption;

  @override
  void initState() {
    _selectedOption = widget.initialSelectedOption;
    super.initState();
  }

  void _sortData(String option) {
    setState(() {
      _selectedOption = option;
      widget.onDataSorted(option); // Pass the selected option back
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: _buildSortButton('default')
        ),
        Expanded(
            child: _buildSortButton('sort by name')
        ),
        Expanded(
            child: _buildSortButton('sort by email')
        ),
      ],
    );
  }

  Widget _buildSortButton(String option) {
    bool isSelected = _selectedOption == option;
    return ElevatedButton(
      onPressed: () => _sortData(option),
      child: Text(
        option,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white38
        ),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
            isSelected ? Color(0xff333333) : Color(0xff222222)),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.zero,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
