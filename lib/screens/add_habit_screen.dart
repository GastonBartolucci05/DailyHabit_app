import 'package:flutter/material.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _habitController = TextEditingController();
  Color selectedColor = Colors.amber; // Color predeterminado
  Map<String, String> selectedHabitsMap = {};
  Map<String, String> completedHabitsMap = {};
  final Map<String, Color> _habitColors = {
    'Amber': Colors.amber,
    'Red Accent': Colors.redAccent,
    'Light Blue': Colors.lightBlue,
    'Light Green': Colors.lightGreen,
    'Purple Accent': Colors.purpleAccent,
    'Orange': Colors.orange,
    'Teal': Colors.teal,
    'Deep Purple': Colors.deepPurple,
  };
  String selectedColorName = 'Amber'; // Nombre del color predeterminado

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    setState(() {
      // Hábitos codificados para demostración
      selectedHabitsMap = {
        'Workout': 'FF5733', // Color en hex (por ejemplo, Amber)
        'Meditate': 'FF33A1',
        'Read a Book': '33FFA1',
        'Drink Water': '3380FF',
        'Practice Gratitude': 'FFC300',
      };
      completedHabitsMap = {'Wake Up Early': 'FF5733', 'Journal': 'DAF7A6'};
    });
  }

  Future<void> _saveHabits() async {
    // Esta función se deja intencionalmente vacía ya que no se necesita guardar
  }

  @override
  Widget build(BuildContext context) {
    // Combina ambos mapas para mostrar, asegurando que no haya duplicados
    Map<String, String> allHabitsMap = {
      ...selectedHabitsMap,
      ...completedHabitsMap,
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF5909BA),
        title: Text('Configure Habits', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _habitController,
              decoration: const InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Color:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                value: selectedColorName,
                isExpanded: true,
                underline: const SizedBox(),
                items: _habitColors.keys.map((String colorName) {
                  return DropdownMenuItem<String>(
                    value: colorName,
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _habitColors[colorName],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        colorName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedColorName = newValue!;
                    selectedColor = _habitColors[selectedColorName]!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_habitController.text.isNotEmpty) {
                  setState(() {
                    // Agrega el nuevo hábito al selectedHabitsMap con el color elegido
                    selectedHabitsMap[_habitController.text] = selectedColor
                        .value
                        .toRadixString(16);
                    _habitController.clear();
                    selectedColorName = 'Amber'; // Restablecer a predeterminado
                    selectedColor = _habitColors[selectedColorName]!;
                  });
                }
              },
              child: Text(
                'Add Habit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5909BA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: allHabitsMap.entries.map((entry) {
                  final habitName = entry.key;
                  final habitColor = _getColorFromHex(entry.value);
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: habitColor),
                    title: Text(habitName),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          // Eliminar hábito de ambos mapas si existe
                          selectedHabitsMap.remove(habitName);
                          completedHabitsMap.remove(habitName);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Agregar opacidad si no está incluida.
    }
    return Color(int.parse('0x$hexColor'));
  }
}
