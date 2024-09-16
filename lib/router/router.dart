import 'package:nicu_help/features/dose_dosage_screen/view/view.dart';
import 'package:nicu_help/features/nicu_detail_screen/view/view.dart';
import 'package:nicu_help/features/nicu_main_screen/view/view.dart';

final routes = {
        '/': (context) => const NicuHelpMainScreen(),
        '/detail': (context) => const NicuHelpDetailScreen(),
        '/drug_doses': (context) => const DrugDosageScreen(),
      };