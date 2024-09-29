import 'package:nicu_help/features/dose_dosage_screen/view/view.dart';
import 'package:nicu_help/features/nicu_detail_screen/view/view.dart';
import 'package:nicu_help/features/nicu_main_screen_new/view/view.dart';
import 'package:nicu_help/features/nicu_ventilation_screen/nicu_ventilation_screen.dart';

final routes = {
        '/': (context) => const NicuHelpMainScreenNew(),
        '/detail': (context) => const NicuHelpDetailScreen(),
        '/drug_doses': (context) => const DrugDosageScreen(),
        '/ventilation_screen': (context) => const VentilationScreen(),
      };