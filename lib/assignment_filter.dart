import 'package:flutter/material.dart';

class AssignmentFilter extends StatefulWidget {
  const AssignmentFilter({Key? key}) : super(key: key);

  @override
  State<AssignmentFilter> createState() => _AssignmentFilterState();
}

class _AssignmentFilterState extends State<AssignmentFilter> {
  final List<String> _applyFilterCourses = [];

  String _filterStatusValue = 'All';
  String _filterTypeValue = 'All';
  List<String> filterStatus = [
    'All',
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
    'All',
    'Open Assignment',
  ];

  final List<Map> _filterByCourse = [
    {'name': 'All', 'isChecked': false},
    {'name': 'Effective Communication level 1 - Section A', 'isChecked': false},
    {
      'name': 'Data Structure and Algorithm DSA - Section A',
      'isChecked': false
    },
    {'name': 'FM Proctoring Exam - Section A', 'isChecked': false},
  ];

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
                      //_radioWidget(filterDecision: 'status'),
                      Text('Filter Status Value: .$_filterStatusValue'),
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
                      //_radioWidget(filterDecision: 'type'),
                      _radioWidgetFilterType(),
                      Text('Filter Type Value: .$_filterTypeValue'),
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
                  Column(
                    children: _filterByCourse.map((courses) {
                      if (courses["isChecked"] == true) {
                        _applyFilterCourses.add(courses['name']);
                        return Column(
                          children: [
                            Text(courses['name']),
                          ],
                        );
                      }

                      return Container();
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            height: 75,
            color: Colors.grey[400],
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
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    showAlertDialog(context);

                    //_updateFilterList();
                  },
                  child: const Text('Apply'),
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
                //setting 'All' to true if all other are true;

                //Setting all true if All is checked true
                if (courses['name'] == 'All') {
                  for (var element in _filterByCourse) {
                    element['isChecked'] = newValue;
                  }
                }

                //if any value other that all is false ...all is also false
                if (newValue == false) {
                  for (var element in _filterByCourse) {
                    if (element['name'].toString() == 'All') {
                      element['isChecked'] = false;
                    }
                  }
                }

                //setting course to new value either true or false
                courses["isChecked"] = newValue;
              });
            });
      }).toList(),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("My title"),
      content: Column(
        children: [
          Text('Filter Type: .$_filterTypeValue'),
          Text('Filter Type: .$_filterStatusValue'),
          Text('Filter Courses.$_applyFilterCourses'),
        ],
      ),

      //const Text("This is my message."),
      actions: [
        TextButton(
          onPressed: () =>{
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

  // void _updateFilterList() {
  //   _applyFilter.add(_filterTypeValue);
  //   _applyFilter.add(_filterStatusValue);
  //   _filterByCourse.map((courses) {
  //     if (courses["isChecked"] == true) {
  //       _applyFilter.add(courses['name']);
  //     }
  //   }).toList();
  //   log(_applyFilter.toString());
  // }

  //Radio button for both type and status
  //Error: Only one is selectable
  // _radioWidget({required String filterDecision}) {
  //   log(filterDecision);
  //   return Column(
  //       children: ((filterDecision == 'type') ? filterType : filterStatus)
  //           .map(
  //             (filter) => ListTile(
  //               leading: Radio<String>(
  //                 groupValue: (filterDecision == 'type')
  //                     ? _filterTypeValue
  //                     : _filterStatusValue,
  //                 value: filter,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     (filterDecision == 'type')
  //                         ? _filterTypeValue
  //                         : _filterStatusValue = value!;
  //                   });
  //                 },
  //               ),
  //               title: Text(filter),
  //             ),
  //           )
  //           .toList());
  // }
}
