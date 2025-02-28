import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/core/utils/app_fonts.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                 ImageConstants.capsicum, // Add correct image path
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Yellow Capcicum",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: AppFonts.inter),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "\$12,230",
                    style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Produce is X mile away from you"),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 16),
                            SizedBox(width: 5),
                            Text("20 - 30"),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Yellow capcicum is a typical vegetable from our app that is much in demand by many people, this is very recommended for you.",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CustomButtonBottom(
                      margin: EdgeInsets.symmetric(horizontal: 40.w),
                      height: 45,text: "Message Seller",shape: ButtonShape.RoundedBorder6,)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
