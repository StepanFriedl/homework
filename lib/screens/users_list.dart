import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:homework/classes/user.dart';
import 'package:homework/widgets/sort_buttons.dart';
import 'package:homework/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    super.initState();
    _loadSortOption();
    fetchData();
  }

  Future<void> _loadSortOption() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSortOption = prefs.getString('selectedSortOption') ?? 'default';
    });
  }

  Future<void> _saveSortOption(String option) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSortOption', option);
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
    } else {
      showErrorDialog();
    }
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          backgroundColor: Colors.white70,
          content: Text(
              "Sorry, we couldn't retrieve the data you requested. Please try again later."),
          actions: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(16)),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  fetchData();
                },
                child: Text('Try again'),
              ),
            ),
          ],
        );
      },
    );
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
      sortFilteredData();
      _saveSortOption(option);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Color(0xFF090809),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                onChanged: (value) {
                  filterData(value); // Update filter query and re-filter
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Color(0xFFD6D6D6),
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
      backgroundColor: Color(0xFF060606),
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : _filteredData.isEmpty
              ? Center(
                  child: Text(
                  "No results",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ))
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
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  _filteredData[index].username,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(_filteredData[index].email,
                                    style: TextStyle(color: Colors.white60)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          user: _filteredData[index]),
                                    ),
                                  );
                                },
                              ),
                              Divider(
                                color: Colors.white60,
                                indent: 16,
                                endIndent: 32,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
