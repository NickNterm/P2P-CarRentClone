import 'package:flutter/material.dart';
import 'package:p2p_clone/features/main_feature/domain/entities/car.dart';
import 'package:p2p_clone/features/main_feature/presentation/pages/car_detail_page.dart';

class RentalCard extends StatelessWidget {
  const RentalCard({
    super.key,
    required this.car,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailPage(car: car),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Hero(
                tag: car.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/image/carImage.jpeg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.drive_eta,
                        size: 17,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${car.make} - ${car.model}',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 17,
                      ),
                      const SizedBox(width: 5),
                      Text(car.location),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        size: 17,
                      ),
                      const SizedBox(width: 5),
                      Text('${car.price}\$'),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
