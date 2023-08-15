import 'package:flutter/Material.dart';

class HistoricComponent extends StatefulWidget {
  final int month;
  const HistoricComponent({super.key, required this.month});

  @override
  State<HistoricComponent> createState() => _HistoricComponentState();
}

class _HistoricComponentState extends State<HistoricComponent> {
  int getNumberOfDaysInMonth(int year, int month) {
    if (month < 1 || month > 12) {
      throw ArgumentError("Le numéro de mois doit être compris entre 1 et 12.");
    }

    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: List.generate(getNumberOfDaysInMonth(DateTime.now().year, widget.month), (index) {
        // Generate widgets
        return LimitedBox(
          maxWidth: MediaQuery.of(context).size.width - 40 / 5,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF1E1E1E).withOpacity(0.7),
                  Color(0xFF1E1E1E).withOpacity(0),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(3)),
            height: 60,
            width: 60,
          ),
        );
      }),
    );
  }
}
