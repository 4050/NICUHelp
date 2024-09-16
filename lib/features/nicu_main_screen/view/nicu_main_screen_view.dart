import 'package:flutter/material.dart';
import 'package:nicu_help/features/nicu_detail_screen/view/nicu_detail_screen.dart';

class NicuHelpMainScreen extends StatefulWidget {
  const NicuHelpMainScreen({super.key});

  @override
  State<NicuHelpMainScreen> createState() => _NicuHelpMainScreenState();
}

class _NicuHelpMainScreenState extends State<NicuHelpMainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('NICU Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NicuHelpDetailScreen()),
                  );
                },
                child: const Text('Калькулятор парентерального питания'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/drug_doses');
                },
                child: const Text('Калькулятор инотропов'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                    Navigator.pushNamed(context, '/drug_doses');
                },
                child: const Text('Калькулятор наркоза'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}