import 'package:flutter/material.dart';

class AssignmentFilter extends StatefulWidget {
  const AssignmentFilter({Key? key}) : super(key: key);

  @override
  State<AssignmentFilter> createState() => _AssignmentFilterState();
}

class _AssignmentFilterState extends State<AssignmentFilter> {
  String _filterStatusValue = 'All';
  String _filterTypeValue = 'All';
  List<String> filterStatus = [
    //'All',
    'Submitted',
    'Not Submitted',
    'Over Due',
    'Graded',
    'Checked',
    'Returned',
    'Re-sbimmted',
    'Late Submitted',
  ];

  List<String> filterType = [
    //'All',
    'Open Assignment',
  ];

  //final List<String> _checkedFilterCourse = [];
  final List<Map> _filterByCourse = [
    {'name': 'Effective Communication level 1 - Section A', 'isChecked': false},
    {
      'name': 'Data Structure and Algorithm DSA - Section A',
      'isChecked': false
    },
    {'name': 'FM Proctoring Exam - Section A', 'isChecked': false},
  ];

  @override
  void initState() {
    _filterByCourse.insert(0, {'name': 'All', 'isChecked': false});
    filterType.insert(0, 'All');
    filterStatus.insert(0, 'All');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        centerTitle: false,
        title: const Text(
          'Filters',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.grey[400],
                        child: const Text(
                          'Status',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      _radioWidgetFilterStatus(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.grey[400],
                        child: const Text(
                          'Type',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      _radioWidgetFilterType(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.grey[400],
                        child: const Text(
                          'Courses',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  _checkBoxWidgetCourse(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            height: 65,
            color: const Color.fromARGB(255, 247, 233, 233),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _clearAll();
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    showAlertDialog(context);

                    //_updateFilterList();
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Radio Button for Type
  _radioWidgetFilterType() {
    return Column(
        children: filterType
            .map(
              (filter) => ListTile(
                leading: Radio<String>(
                  groupValue: _filterTypeValue,
                  value: filter,
                  onChanged: (value) {
                    setState(() {
                      _filterTypeValue = value!;
                    });
                  },
                ),
                title: Text(filter),
              ),
            )
            .toList());
  }

//Radio Button for Status
  _radioWidgetFilterStatus() {
    return Column(
        children: filterStatus
            .map(
              (filter) => ListTile(
                leading: Radio<String>(
                  groupValue: _filterStatusValue,
                  value: filter,
                  onChanged: (value) {
                    setState(() {
                      _filterStatusValue = value!;
                    });
                  },
                ),
                title: Text(filter),
              ),
            )
            .toList());
  }

  _checkBoxWidgetCourse() {
    return Column(
      children: _filterByCourse.map((courses) {
        return CheckboxListTile(
            value: courses["isChecked"],
            title: Text(courses["name"]),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (newValue) {
              setState(() {
                courses['isChecked'] = newValue;

                for (int i = 1; i < _filterByCourse.length; i++) {
                  if (_filterByCourse[i]['isChecked'] == false) {
                    _filterByCourse[0]['isChecked'] = false;

                    break;
                  } else {
                    _filterByCourse[0]['isChecked'] = true;
                  }
                }
              });

              //Setting all true if All is checked true
              if (courses['name'] == 'All') {
                for (var element in _filterByCourse) {
                  element['isChecked'] = newValue;
                }
              }
              //
            });
      }).toList(),
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("My Filters"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Filter Status: \n$_filterStatusValue'),
        Text('Filter Type: \n' + _filterTypeValue),
        const Text('Filter Course:'),
        Column(
          children: _filterByCourse.map((courses) {
            if (courses['isChecked'] == true) {
              return Text(courses['name']);
            }
            return Container();
          }).toList(),
        )
      ]),

      //const Text("This is my message."),
      actions: [
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'OK'),
            _clearAll(),
          },
          child: const Text('Ok'),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _clearAll() {
    setState(() {
      _filterStatusValue = 'All';
      _filterTypeValue = 'All';

      for (var element in _filterByCourse) {
        element['isChecked'] = false;
      }
    });
  }
}
