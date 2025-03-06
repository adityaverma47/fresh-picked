import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/app_export.dart';
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
        centerTitle: true,
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
          return buildShimmerGrid(); // Show shimmer effect while loading
        }

        if (controller.vegetableList.isEmpty) {
          return const Center(
            child: Text(
              "No Vegetables Found!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  Get.toNamed(AppRoutes.productDetailScreen);
                },
                child: Card(
                  color: ColorConstants.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: product.vegitableImage ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => buildShimmerEffect(),
                              errorWidget: (context, url, error) => Center(
                                child: Image.asset(ImageConstants.tomato),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name ?? 'No Name',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.inter,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "\$${product.cost ?? 'N/A'}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.inter,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            // Handle favorite toggle
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
