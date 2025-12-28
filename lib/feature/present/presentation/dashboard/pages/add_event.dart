import 'package:event_attendance_mobile/core/components/field_label.dart';
import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:event_attendance_mobile/core/constant/priority_enums.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:event_attendance_mobile/feature/present/presentation/event_details/widgets/build_card.dart';
import 'package:event_attendance_mobile/feature/present/presentation/event_details/widgets/build_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*
  Widget screen for adding an event
*/

const List<Map<int, PriorityEnums>> priorities = [
  {1: PriorityEnums.low},
  {2: PriorityEnums.medium},
  {3: PriorityEnums.high},
];

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int? _selectedPriority = 1;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? initialDate,
    required Function(DateTime) onSelected,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      onSelected(picked);
      setState(() {});
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_nameController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Maybe you have forgotten the Event's name?"),
        ),
      );
    }

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have forgotten the date range!")),
      );
      return;
    }

    context.read<EventCubit>().addEventCubit(
      _nameController.text,
      _startDate!,
      _endDate!,
      _descriptionController.text,
      _selectedPriority!,
    );

    Navigator.pop(context); // or context.pop() if using GoRouter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navbar
      appBar: ScaffoldAppbar(title: "Add Event"),
      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Add an Event",
                        style: TextStyle(
                          fontSize: 28,
                          color: Palette.darkTextPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Fill the details below",
                        style: TextStyle(
                          color: Palette.darkTextSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // ----------- EVENT NAME AND DESCRIPTION --------------
                FieldLabel(message: "Event Name"),
                BuildTextfield(
                  controller: _nameController,
                  label: "Event Name",
                  icon: Icons.event,
                  validator: (value) => value == null || value.isEmpty
                      ? "Event name is required"
                      : null,
                ),

                const SizedBox(height: 18),

                FieldLabel(message: "Description"),
                BuildTextfield(
                  controller: _descriptionController,
                  label: "Description",
                  icon: Icons.description,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                // ------------- START DATE AND END DATE ----------------
                FieldLabel(message: "Start date"),
                ListTile(
                  tileColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Palette.darkTextSecondary),
                  ),
                  leading: const Icon(
                    Icons.calendar_today,
                    color: Palette.darkTextSecondary,
                  ),
                  title: Text(
                    _startDate == null
                        ? "Select Start Date"
                        : "Start: ${_startDate!.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(color: Palette.darkTextSecondary),
                  ),

                  onTap: () => _pickDate(
                    initialDate: _startDate,
                    onSelected: (date) => _startDate = date,
                  ),
                ),

                const SizedBox(height: 12),

                FieldLabel(message: "End date"),
                ListTile(
                  tileColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Palette.darkTextSecondary),
                  ),
                  leading: const Icon(
                    Icons.calendar_month,
                    color: Palette.darkTextSecondary,
                  ),
                  title: Text(
                    _endDate == null
                        ? "Select End Date"
                        : "End: ${_endDate!.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(color: Palette.darkTextSecondary),
                  ),
                  onTap: () => _pickDate(
                    initialDate: _endDate,
                    onSelected: (date) => _endDate = date,
                  ),
                ),
                const SizedBox(height: 20),

                // -------------------- PRIORITIES -----------------------
                FieldLabel(message: "Priority"),
                DropdownButtonFormField<int>(
                  initialValue: _selectedPriority,
                  dropdownColor: Palette.textSecondary,
                  icon: const Icon(Icons.expand_more, color: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    labelText: "Priority",
                    labelStyle: TextStyle(color: Palette.darkTextSecondary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Palette.darkTextSecondary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Palette.darkTextSecondary),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                  items: priorities.map((priority) {
                    final entry = priority.entries.first;

                    return DropdownMenuItem<int>(
                      value: entry.key,
                      child: Text(
                        entry.value.name,
                        style: const TextStyle(
                          color: Palette.darkTextSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text("Create Event"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.fieldBg,
                      foregroundColor: Palette.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
