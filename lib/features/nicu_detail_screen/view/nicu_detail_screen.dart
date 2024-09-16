import 'package:flutter/material.dart';

class NicuHelpDetailScreen extends StatefulWidget {
  const NicuHelpDetailScreen({super.key});

  @override
  State<NicuHelpDetailScreen> createState() => _NicuHelpDetailScreenState();
}

class _NicuHelpDetailScreenState extends State<NicuHelpDetailScreen> {
String? titleName;

@override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null) {
      print("NULL");
      return;
    }
    if (args is! String) {
      print("NULL");
      return;
    }
    setState(() {});
    titleName = args as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleName ?? '...')),
    );
  }
}