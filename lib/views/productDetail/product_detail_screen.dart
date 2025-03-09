import 'package:cached_network_image/cached_network_image.dart';
import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/core/utils/app_fonts.dart';
import 'package:fresh_picked/views/productDetail/controller/product_detail_controller.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: CustomAppBar(
        height: 55.h,
        title: Text(
          "Detail Screen",
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.abhayaLibre),
        ),
        isBackBtnVisible: true,
        onTap: Get.back,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Obx(() => CachedNetworkImage(
                      imageUrl: controller.image.value.isNotEmpty
                          ? controller.image.value
                          : ImageConstants.capsicum, // Fallback image
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey[300], // Or any placeholder color/image you prefer
                  ),
                      errorWidget: (context, url, error) => Image.asset(
                        ImageConstants.capsicum, // Local fallback image
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    )),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: IconButton(
                    icon:
                        const Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {
                      // Implement wishlist toggle
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        controller.title.value,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.inter),
                      )),
                  const SizedBox(height: 5),
                  Obx(() => Text(
                        controller.price.value,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Produce is X miles away from you",style: TextStyle(fontSize: 14.sp,fontFamily: AppFonts.inter,fontWeight: FontWeight.w400),),
                        Row(
                          children: [
                            SizedBox(width: 5.w),
                            Text("${controller.distance.toStringAsFixed(1) ?? ''} km"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                   Text(
                    "Description",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900,fontFamily: AppFonts.inter),
                  ),
                  const SizedBox(height: 5),
                  Obx(() => Text(
                        controller.description.value,
                        style: TextStyle(
                            fontSize: 14.sp, color: Colors.grey.shade700,fontFamily: AppFonts.inter,fontWeight: FontWeight.w300),
                      )),
                  const SizedBox(height: 20),
                  Center(
                    child: CustomButtonBottom(

                      margin: EdgeInsets.symmetric(horizontal: 40.w,vertical: 40.h),
                      height: 45,
                      text: "Message Seller",
                      shape: ButtonShape.RoundedBorder6,
                      onTap: () {
                        // Implement chat feature with sellerId
                        // print("Chat with seller: ${controller.sellerId.value}");
                      },
                    ),
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
