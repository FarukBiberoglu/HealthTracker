import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled31/HomePage.dart';
import 'package:untitled31/Porivder.dart';

class CalculatePage extends StatefulWidget {
  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  String? selectedPerson = 'Kadın';
  bool hesaplaButonPressed = false;
  double? protein;
  double? karbonhidrat;
  double? yag;
  double? totalKalori;

  final kiloController = TextEditingController();
  final boyController = TextEditingController();
  final yasController = TextEditingController();

  final List<String> cinsiyet = ['Erkek', 'Kadın'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Makro Hesaplayıcı',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade200, Colors.purple.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: selectedPerson,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedPerson = newValue;
                      });
                    }
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  dropdownColor: Colors.purple.shade200,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  items: cinsiyet.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),

            _buildTextField(
              controller: kiloController,
              hintText: 'Kilonuzu Giriniz (kg)',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            _buildTextField(
              controller: boyController,
              hintText: 'Boyunuzu Giriniz (cm)',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            _buildTextField(
              controller: yasController,
              hintText: 'Yaşınızı Giriniz',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  hesaplaa();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[300],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Hesapla',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            if (hesaplaButonPressed)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade200, Colors.purple.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.purple.withOpacity(0.2),
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Günlük Almanız Gerken Makrolar ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),

                        _buildMacroCard(
                            'Protein', protein, 'g', Icons.fitness_center),
                        _buildMacroCard(
                            'Karbonhidrat', karbonhidrat, 'g', Icons.fastfood),
                        _buildMacroCard('Yağ', yag, 'g', Icons.local_dining),

                        SizedBox(height: 20),

                        // Günlük Kalori
                        Text(
                          'Günlük Alınması Gereken Kalori !',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${totalKalori?.toStringAsFixed(0)} kcal',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 20),
                        // İlerle Butonu
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Homepage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo[500],
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'İlerle',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void hesaplaa() {
    setState(() {
      hesaplaButonPressed = true;

      double kilo = double.tryParse(kiloController.text) ?? 0.0;
      double boy = double.tryParse(boyController.text) ?? 0.0;
      int yas = int.tryParse(yasController.text) ?? 25;

      if (kilo <= 0 || boy <= 0 || yas <= 0) {
        return;
      }

      double bmr = (selectedPerson == 'Erkek')
          ? 10 * kilo + 6.25 * boy - 5 * yas + 5
          : 10 * kilo + 6.25 * boy - 5 * yas - 161;

      double activityMultiplier = 1.2;
      double totalKalori = bmr * activityMultiplier;

      protein = totalKalori * 0.25 / 3.5;
      karbonhidrat = totalKalori * 0.5 / 4.8;
      yag = totalKalori * 0.25 / 8;

      this.totalKalori = totalKalori;

      context.read<UserProivder>().alinanMakrolar(protein!, karbonhidrat!, yag!);
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.purple.shade200,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMacroCard(
      String name, double? value, String unit, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              '$name: ${value?.toStringAsFixed(0)} $unit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
