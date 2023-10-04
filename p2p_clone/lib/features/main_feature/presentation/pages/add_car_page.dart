import 'package:flutter/material.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  bool availablility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Expanded(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    InputWidget(
                      hintText: 'Make',
                      icon: Icons.car_rental,
                      makeController: makeController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    InputWidget(
                      hintText: 'Model',
                      icon: Icons.model_training,
                      makeController: modelController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    InputWidget(
                      hintText: 'Price',
                      icon: Icons.attach_money,
                      makeController: priceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    InputWidget(
                      hintText: 'Location',
                      icon: Icons.location_on,
                      makeController: locationController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      value: availablility,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      tileColor: Colors.grey[200],
                      onChanged: (value) {
                        setState(() {
                          availablility = value!;
                        });
                      },
                      title: const Text('Available'),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  //TODO make the on tap to call the add car function
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.makeController,
    required this.keyboardType,
    required this.icon,
    required this.hintText,
  });

  final TextEditingController makeController;
  final TextInputType keyboardType;
  final IconData icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: makeController,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(icon),
          labelText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
