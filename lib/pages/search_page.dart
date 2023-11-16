import "package:bus_reservation_udemy/utils/constants.dart";
import "package:bus_reservation_udemy/utils/helper_functions.dart";
import "package:flutter/material.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search page"),
      ),
      body: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: [
                DropdownButtonFormField<String>(
                    value: fromCity,
                    isExpanded: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.white)),
                    hint: const Text("From"),
                    items: cities
                        .map((city) => DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            ))
                        .toList(),
                    onChanged: (value) {
                      fromCity = value;
                    }),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                    value: fromCity,
                    isExpanded: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.white)),
                    hint: const Text("To"),
                    items: cities
                        .map((city) => DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            ))
                        .toList(),
                    onChanged: (value) {
                      fromCity = value;
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: _selectDate,
                          child: const Text("Select Departure Date")),
                      Text(departureDate == null
                          ? "No date chosen"
                          : getFormattedDate(departureDate!))
                    ],
                  ),
                ),
                Center(
                    child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: _search, child: const Text("Search")),
                ))
              ],
            ),
          )),
    );
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7)));
    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() {
    if (departureDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a departure date")));
      return;
    }
    if (_formKey.currentState!.validate()) {}
  }
}
