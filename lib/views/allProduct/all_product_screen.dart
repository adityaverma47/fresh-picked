import 'package:cached_network_image/cached_network_image.dart';
import 'package:fresh_picked/core/utils/app_fonts.dart';

import '../../core/app_export.dart';


class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for wishlist data
    final List<Map<String, dynamic>> wishlist = [
      {
        "title": "Product 1",
        "price": "100",
        "images": [ImageConstants.greenCauliflower],
      },
      {
        "title": "Product 2",
        "price": "200",
        "images": ["https://example.com/image2.jpg"],
      },
      {
        "title": "Product 1",
        "price": "100",
        "images": [ImageConstants.greenCauliflower],
      },
      {
        "title": "Product 2",
        "price": "200",
        "images": ["https://example.com/image2.jpg"],
      },
      {
        "title": "Product 1",
        "price": "100",
        "images": [ImageConstants.greenCauliflower],
      },
      {
        "title": "Product 2",
        "price": "200",
        "images": ["https://example.com/image2.jpg"],
      },
      // Add more products as needed
    ];

    return Scaffold(
      backgroundColor: ColorConstants.homeBackGroundColor,
      appBar: CustomAppBar(
        height: 55,
        title:  const Text(
          "Vegetables",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: AppFonts.abhayaLibre),
        ),
        centerTitle: true,
        isBackBtnVisible: true,
        onTap: () => Get.offAllNamed(AppRoutes.bottomBar),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 25),
              child: const Icon(Icons.search,size: 35,))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: ColorConstants.homeBackGroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: wishlist.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.favorite_border,
                size: 70,
                color: ColorConstants.lightTextColor,
              ),
              SizedBox(height: 8.h),
               const Text(
                "No Saved Items!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.lightTextColor,
                    fontFamily: AppFonts.abhayaLibre
                ),
              ),
              SizedBox(height: 4.h),
              const Text(
                "You don’t have any saved items.\nGo to home and add some.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.lightTextColor,
                    fontFamily: AppFonts.abhayaLibre
                ),
              ),
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: wishlist.length,
            itemBuilder: (context, index) {
              final product = wishlist[index];
              return GestureDetector(
                onTap: (){
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
                            child: product["images"] != null &&
                                product["images"]!.isNotEmpty
                                ? CachedNetworkImage(
                              imageUrl: product["images"]!.first,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Center(
                                    child: Image.asset(
                                      ImageConstants.tomato,
                                    ),
                                  ),
                            )
                                : Center(
                              child: Image.asset(
                                ImageConstants.greenCauliflower,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product["title"] ?? 'No Title',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.inter
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "\$${product["price"] ?? 'N/A'}", // Updated to use dollar sign
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.inter
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
                            // Handle removal from wishlist
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
        ),
      ),
    );
  }
}