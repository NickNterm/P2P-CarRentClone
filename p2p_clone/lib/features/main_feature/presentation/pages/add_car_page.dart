import 'package:flutter/material.dart';
import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/main_feature/domain/entities/car.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/cars/cars_bloc.dart';
import 'package:p2p_clone/features/main_feature/presentation/pages/car_detail_page.dart';

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
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (makeController.text.isEmpty ||
                    modelController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    locationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields'),
                    ),
                  );
                  return;
                }
                try {
                  double.parse(priceController.text);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid price'),
                    ),
                  );
                  return;
                }
                Car car = Car(
                  id: 0,
                  make: makeController.text,
                  model: modelController.text,
                  price: double.parse(priceController.text),
                  location: locationController.text,
                  availability: availablility,
                );
                sl<CarsBloc>().add(
                  AddCar(car: car),
                );
                // TODO add a listener to the bloc to show a snackbar if there is an error
                // if there is no error show the data in the detail screen
                makeController.clear();
                modelController.clear();
                priceController.clear();
                locationController.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailPage(car: car),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
    this.password = false,
  });

  final TextEditingController makeController;
  final TextInputType keyboardType;
  final IconData icon;
  final String hintText;
  final bool password;

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
        obscureText: password,
        decoration: InputDecoration(
          icon: Icon(icon),
          labelText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
