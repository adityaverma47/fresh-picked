import 'package:fresh_picked/views/dashboard/controller/dashboard_controller.dart';

import '../../core/app_export.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        height: 65,
        bgColor: Colors.transparent,
        isBackBtnVisible: false,
        title: Container(
          margin: EdgeInsets.symmetric(vertical: 12.h,horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Your Location",
                    style: TextStyle(color: ColorConstants.white,fontSize: 15.sp),
                  ),
                 Image.asset(ImageConstants.keywordArrowDown,width: 30.w,)
                ],
              ),
              Row(
                children: [
                  Image.asset(ImageConstants.location,width: 15.w,color: Colors.red,),
                  SizedBox(width: 8.w,),
                  Text(
                    controller.storage.read('address'),
                    style: TextStyle(color: ColorConstants.white,fontSize: 16.sp),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildTitleSection(),
          Expanded(child: _buildGridView()), // Product Grid
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 230.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.homeHeader), // Background Image
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
               Text(
                "Shop Local\nHarvest",
                style: TextStyle(color: Colors.white, fontSize: 28.sp,fontFamily: AppFonts.abhayaLibre,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            "Find all vegetables",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,fontFamily: AppFonts.inter),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.allProductScreen);
            },
            child: const Text(
              "See All",
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    List<Map<String, dynamic>> products = [
      {
        "name": "Brocalli",
        "image": ImageConstants.greenCauliflower,
        "price": "17,230"
      },
      {
        "name": "Tomato",
        "image":ImageConstants.tomato,
        "price": "17,230"
      },
      {
        "name": "Yellow Capcicum",
        "image": ImageConstants.capsicum,
        "price": "17,230"
      },
      {
        "name": "Green Spanich",
        "image": ImageConstants.greenCauliflower,
        "price": "17,230"
      },
      {
        "name": "Brocalli",
        "image": ImageConstants.greenCauliflower,
        "price": "17,230"
      },
      {
        "name": "Tomato",
        "image":ImageConstants.tomato,
        "price": "17,230"
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return _buildProductCard(products[index]);
        },
      ),
    );
  }


  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutes.productDetailScreen);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product["image"],
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: Icon(Icons.favorite_border, color: Colors.red),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // const Icon(Icons.star, color: Colors.green, size: 16),
                      // const SizedBox(width: 5),
                       Text("Distance",style: TextStyle(fontSize: 16.sp),),
                      const SizedBox(width: 10),
                      const Icon(Icons.location_on,
                          color: Colors.green, size: 16),
                      const Text("190m"),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$ ${product["price"]}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
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
