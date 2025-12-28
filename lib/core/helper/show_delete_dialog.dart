import 'package:flutter/material.dart';

/*
  REUSABLE:
    Helper function for every delete function
    Shows a dialog for confirming whether to delete an entity (event, attendee)

    Usage:
    
      onPressed: () async {
        _deleteEvent(widget.event);
      },

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


*/

Future<void> showDeleteDialog<T>({
  required BuildContext context,
  required T entity,
  required Future<void> Function(T entity) onDelete,
  String title = "Delete",
  String message = "Are you sure you want to delete this item?",
}) async {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // ✅ closes dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await onDelete(entity);

              Navigator.of(dialogContext).pop(); // ✅ close dialog
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
