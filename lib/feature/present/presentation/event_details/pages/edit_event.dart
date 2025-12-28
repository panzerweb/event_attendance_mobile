import 'package:event_attendance_mobile/core/components/empty_list_message.dart';
import 'package:event_attendance_mobile/core/components/field_label.dart';
import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:event_attendance_mobile/core/constant/priority_enums.dart';
import 'package:event_attendance_mobile/core/helper/show_delete_dialog.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:event_attendance_mobile/feature/present/presentation/event_details/widgets/build_card.dart';
import 'package:event_attendance_mobile/feature/present/presentation/event_details/widgets/build_datetime.dart';
import 'package:event_attendance_mobile/feature/present/presentation/event_details/widgets/build_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<Map<int, PriorityEnums>> priorities = [
  {1: PriorityEnums.low},
  {2: PriorityEnums.medium},
  {3: PriorityEnums.high},
];

class EditEvent extends StatefulWidget {
  final EventEntity event;
  const EditEvent({super.key, required this.event});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  // Initialize the controllers
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late DateTime _startDate;
  late DateTime _endDate;
  late int _selectedPriority;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.event.event_name);
    _descriptionController = TextEditingController(
      text: widget.event.event_description,
    );

    _startDate = widget.event.start_date!;
    _endDate = widget.event.end_date!;
    _selectedPriority = widget.event.priority_id!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(DateTime? initialDate, bool isPicked) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        if (isPicked) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  // Update the Event
  Future<void> _updateEventFields() async {
    await context.read<EventCubit>().updateEventCubit(
      widget.event.id!,
      _nameController.text,
      _startDate,
      _endDate,
      _descriptionController.text,
      _selectedPriority,
    );

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Event successfully updated!")),
    );
  }

  // DELETE AN EVENT
  Future<void> _deleteEvent(EventEntity event) async {
    await showDeleteDialog<EventEntity>(
      context: context,
      entity: event,
      title: "Delete Event",
      message: "Are you sure you want to delete this event?",
      onDelete: (event) {
        return context.read<EventCubit>().deleteEventCubit(event);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppbar(title: "Edit Event"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Edit Event",
                      style: TextStyle(
                        fontSize: 28,
                        color: Palette.darkTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: Palette.darkTextSecondary,
                        ),
                        children: [
                          const TextSpan(text: "Current Event: "),
                          TextSpan(
                            text: widget.event.event_name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.darkTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// ───────────── Event Info ─────────────
              FieldLabel(message: "Event Name"),
              BuildTextfield(
                controller: _nameController,
                label: "Event Name",
                icon: Icons.event,
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 14),

              FieldLabel(message: "Description"),
              BuildTextfield(
                controller: _descriptionController,
                label: "Description",
                icon: Icons.description,
                maxLines: 3,
              ),

              const SizedBox(height: 12),

              /// ───────────── Dates ─────────────
              FieldLabel(message: "Date range"),
              BuildDatetime(
                label: "Start Date",
                date: _startDate,
                onTap: () => _selectDate(_startDate, true),
              ),

              const SizedBox(height: 14),

              BuildDatetime(
                label: "End Date",
                date: _endDate,
                onTap: () => _selectDate(_endDate, false),
              ),

              const SizedBox(height: 12),

              /// ───────────── Priority ─────────────
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
                  setState(() => _selectedPriority = value!);
                },
                items: priorities.map((priority) {
                  final entry = priority.entries.first;
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(
                      entry.value.name,
                      style: TextStyle(color: Palette.darkTextSecondary),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              Divider(color: Palette.darkTextAccent),

              // List of Attendees Section
              // Attendees display should be scrollable
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List of Attendees",
                    style: TextStyle(
                      fontSize: 22,
                      color: Palette.darkTextPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      null;
                    }, // Point to a function to add attendees
                    icon: const Icon(Icons.person_add),
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.secondaryBackground,
                      foregroundColor: Palette.darkTextPrimary,
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // A condition will be added if there are attendees then show cards, if not, then show message
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: EmptyListMessage(
                    message: "There are no attendees",
                    subtitle: "Add one by pressing the '+' button",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ───────────── Actions ─────────────
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text("Delete Event"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          foregroundColor: Palette.textPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          _deleteEvent(widget.event);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text("Update Event"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.fieldBg,
                          foregroundColor: Palette.textPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _updateEventFields,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
