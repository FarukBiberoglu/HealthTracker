import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:untitled31/Porivder.dart';
import 'package:untitled31/desing.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Map<String, int> makroDegerler = {
    'Protein': 0,
    'Karbonhidrat': 0,
    'Yağ': 0,
  };

  String selectedMakro = 'Protein';
  TextEditingController degerController = TextEditingController();

  bool get tumDegerlerGirildiMi =>
      makroDegerler.values.every((value) => value > 0);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProivder>();

    Map<String, double> pieChartDataCalculatePage = {
      'Protein': userProvider.protein.toDouble(),
      'Karbonhidrat': userProvider.karbonhidrat.toDouble(),
      'Yağ': userProvider.yag.toDouble(),
    };

    Map<String, double> pieChartDataUserInput = {
      'Protein': makroDegerler['Protein']!.toDouble(),
      'Karbonhidrat': makroDegerler['Karbonhidrat']!.toDouble(),
      'Yağ': makroDegerler['Yağ']!.toDouble(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health Tracker',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo[300],
        elevation: 6,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: makroDegerler.entries.map((entry) {
                  return BesinDeger(makro: entry.key, deger: entry.value);
                }).toList(),
              ),
              const SizedBox(height: 30),
              if (tumDegerlerGirildiMi) ...[
                Text(
                  "Günlük Alınan Makro Değerler",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    dataMap: pieChartDataUserInput,
                    chartType: ChartType.disc,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3,
                    colorList: [Colors.blue, Colors.amber, Colors.pink],
                    legendOptions: LegendOptions(
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 1,
                      chartValueStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Günlük Almanız Gereken Makro Değerler ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    dataMap: pieChartDataCalculatePage,
                    chartType: ChartType.disc,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3,
                    colorList: [Colors.blue, Colors.amber, Colors.pink],
                    legendOptions: LegendOptions(
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 1,
                      chartValueStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ] else
                const Center(

                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    title: const Text("Makro Giriniz"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: selectedMakro,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setDialogState(() {
                                selectedMakro = newValue;
                              });
                            }
                          },
                          items: ['Protein', 'Karbonhidrat', 'Yağ']
                              .map<DropdownMenuItem<String>>((String oge) {
                            return DropdownMenuItem<String>(
                              value: oge,
                              child: Text(
                                oge,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }).toList(),
                          style: TextStyle(color: Colors.black),
                          iconEnabledColor: Colors.purple,
                          dropdownColor: Colors.white,
                          underline: Container(
                            height: 2,
                            color: Colors.indigo,
                          ),
                        ),
                        TextField(
                          controller: degerController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Değer giriniz",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (degerController.text.isNotEmpty) {
                            setState(() {
                              makroDegerler[selectedMakro] =
                                  int.parse(degerController.text);
                            });
                          }
                          degerController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Ekle"),
                      ),
                      TextButton(
                        onPressed: () {
                          degerController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("İptal"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.purple),
      ),
    );
  }
}
