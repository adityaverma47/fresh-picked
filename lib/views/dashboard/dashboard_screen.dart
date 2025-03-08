import 'package:shimmer/shimmer.dart';
import 'package:fresh_picked/views/dashboard/controller/dashboard_controller.dart';
import '../../core/app_export.dart';
import '../../data/models/AllFavodel/all_fav_model.dart';
import '../../data/models/HomeProductModel/home_product_model.dart';
import '../favourites/controller/favourites_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        height: 65.h,
        bgColor: Colors.transparent,
        isBackBtnVisible: false,
        title: Container(
          margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Location info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Your Location",
                        style: TextStyle(
                            color: ColorConstants.white, fontSize: 15.sp),
                      ),
                      Image.asset(
                        ImageConstants.keywordArrowDown,
                        width: 30.w,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        ImageConstants.location,
                        width: 15.w,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        controller.storage.read('address') ?? 'Unknown Location',
                        style: TextStyle(
                            color: ColorConstants.white, fontSize: 16.sp),
                      )
                    ],
                  ),
                ],
              ),
              // Right side: Favourites Icon
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {
                  // TODO: Add your favourites functionality here
                },
              )
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        color: ColorConstants.primaryColor,
        onRefresh: () async {
          controller.fetchAllHomeData();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() =>
            controller.isLoading.value ? _buildShimmerHeader() : _buildHeader()),
            SizedBox(
              height: 5.h,
            ),
            Obx(() =>
            controller.isLoading.value ? _buildShimmerTitle() : _buildTitleSection()),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
                child: Obx(() =>
                controller.isLoading.value ? _buildShimmerGrid() : _buildGridView())),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 230.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageConstants.homeHeader),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildShimmerHeader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(height: 230.h, color: Colors.white),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Find all vegetables",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.inter)),
          TextButton(
              onPressed: () => Get.toNamed(AppRoutes.allProductScreen),
              child: Text("See All",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.sp,
                      fontFamily: AppFonts.inter)))
        ],
      ),
    );
  }

  Widget _buildShimmerTitle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(height: 20, width: 150, color: Colors.white),
    );
  }

  Widget _buildGridView() {
    return Obx(() {
      if (controller.productsList.isEmpty) {
        return Center(
            child: Text("No vegetables available in your area",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey,
                    fontFamily: AppFonts.inter)));
      }
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.productsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          return _buildProductCard(controller.productsList[index]);
        },
      );
    });
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12))),
        );
      },
    );
  }

  Widget _buildProductCard(FivekMRangeProducts product) {
    return GestureDetector(
      onTap: (){
        controller.navigateToVegetableDetail(product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  child: Image.network(product.vegitableImage ?? '',
                      height: 100, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(() {
                    final favController = Get.find<FavouritesController>();
                    final bool isFav = favController.wishlist.any((item) => item.sId == product.sId);
                    return GestureDetector(
                      onTap: () {
                        favController.toggleWishlist(
                          FavouriteVegitables(sId: product.sId ?? ""),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    );
                  }),
                ),


              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name.toString(),
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 16),
                      Text("${product.distance?.toStringAsFixed(1) ?? ''} km"),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(product.cost.toString(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
