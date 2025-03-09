import 'package:shimmer/shimmer.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_vegetable.dart';
import 'controller/all_product_controller.dart';

class AllProductScreen extends GetView<AllProductController> {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackGroundColor,
      appBar: CustomAppBar(
        height: 55,
        title: const Text(
          "Vegetables",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.abhayaLibre,
          ),
        ),
        centerTitle: false,
        isBackBtnVisible: true,
        onTap: () => Get.offAllNamed(AppRoutes.bottomBar),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 25),
            child: const Icon(Icons.search, size: 35),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return buildShimmerGrid();
        }

        if (controller.vegetableList.isEmpty) {
          return const Center(
            child: Text(
              "No Vegetables Found!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return RefreshIndicator(
          color: ColorConstants.primaryColor,
          onRefresh: () async {
            controller.fetchAllVegetables();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: controller.vegetableList.length,
              itemBuilder: (context, index) {
                final product = controller.vegetableList[index];
                return GestureDetector(
                  onTap: () {
                    controller.navigateToDetailScreen(product);
                  },
                  child: CustomVegetable(product: product),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  /// **Function to Build a Grid of Shimmer Effect**
  Widget buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: 6, // Show shimmer for 6 items
      itemBuilder: (context, index) {
        return buildShimmerEffect();
      },
    );
  }

  /// **Function to Build a Single Shimmer Effect**
  Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}