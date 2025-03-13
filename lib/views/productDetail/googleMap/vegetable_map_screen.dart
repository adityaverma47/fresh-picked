import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/views/productDetail/googleMap/controller/vegetable_map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VegetableMapScreen extends GetView<VegetableMapController> {
  const VegetableMapScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(
        height: 55,
        title: const Text(
          "Map Screen",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.abhayaLibre,
          ),
        ),
        centerTitle: false,
        isBackBtnVisible: true,
        onTap: () => Get.offAllNamed(AppRoutes.bottomBar),
      ),
      body: Obx(() {
        if (controller.currentPosition.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(controller.currentPosition.value!.latitude,
                controller.currentPosition.value!.longitude),
            zoom: 14,
          ),
          markers: controller.markers.toSet(),
          polylines: controller.polylines.toSet(),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController mapController) {
            controller.mapController.complete(mapController);
          },
        );
      }),
    );
  }
}
