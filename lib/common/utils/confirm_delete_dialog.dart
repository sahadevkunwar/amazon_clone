import 'package:amazon_clone/features/admin/cubit/delete_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> confirmDelete(BuildContext context, String id) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Confirm Deletion',
          style: TextStyle(fontSize: 18), // Adjust the font size
        ),
        content: const Text(
          'Are you sure you want to delete?',
          style: TextStyle(fontSize: 16), // Adjust the font size
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 14), // Adjust the font size
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 14), // Adjust the font size
            ),
            child: const Text('Yes'),
            onPressed: () {
              context.read<DeleteCubit>().deleteProduct(
                    id: id.toString(),
                  );
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
