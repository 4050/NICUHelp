import 'package:flutter/material.dart';

class NicuListTile extends StatelessWidget {
  const NicuListTile({
    super.key,
    required this.rowName,
  });

  final String rowName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
    title: Text(
      rowName,
      style: theme.textTheme.bodyMedium,
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.of(context).pushNamed(
        '/detail',
        arguments: rowName,
        );
      },
    );
  }
}
