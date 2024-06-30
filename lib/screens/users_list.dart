import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:homework/classes/user.dart';
import 'package:homework/widgets/sort_buttons.dart';
import 'package:homework/screens/detail_screen.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<User> _data = [];
  List<User> _filteredData = [];
  String _selectedSortOption = 'default';
  String _query = '';

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        final List<dynamic> jsonData = json.decode(response.body);
        _data = jsonData.map((item) => User.fromJson(item)).toList();
        _filteredData = List.from(_data);
        sortFilteredData();
      });
    }
  }

  void filterData(String query) {
    setState(() {
      _query = query.toLowerCase();
      _filteredData = _data
          .where((element) =>
      element.username.toLowerCase().contains(_query) ||
          element.email.toLowerCase().contains(_query))
          .toList();

      sortFilteredData();
    });
  }

  void sortFilteredData() {
    switch (_selectedSortOption) {
      case 'sort by name':
        _filteredData.sort((a, b) => a.username.compareTo(b.username));
        break;
      case 'sort by email':
        _filteredData.sort((a, b) => a.email.compareTo(b.email));
        break;
      case 'default':
        _filteredData.sort((a, b) => a.id.compareTo(b.id));
        break;
      default:
        break;
    }
  }

  void updateSortOption(String option) {
    setState(() {
      _selectedSortOption = option;
      sortFilteredData(); // Sort data immediately when sort option changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                onChanged: (value) {
                  filterData(value); // Update filter query and re-filter
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : _filteredData.isEmpty
          ? Center(child: Text("No results"))
          : Column(
        children: [
          SortButtonsWidget(
            data: _filteredData,
            initialSelectedOption: _selectedSortOption,
            onDataSorted: (sortedOption) {
              updateSortOption(sortedOption);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredData[index].username),
                  subtitle: Text(_filteredData[index].email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(user: _filteredData[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
