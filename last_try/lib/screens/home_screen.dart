import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:last_try/bottom_screen/generate_otp_bottom.dart';
import 'package:last_try/home_screen_widgets/banner_widget.dart';
import 'package:last_try/home_screen_widgets/brand_widget.dart';
import 'package:last_try/home_screen_widgets/faq_widget.dart';
import 'package:last_try/home_screen_widgets/filter_widget.dart';
import 'package:last_try/home_screen_widgets/product_widget.dart';
import 'package:last_try/home_screen_widgets/row1_widget.dart';
import 'package:last_try/home_screen_widgets/row2_widget.dart';
import 'package:last_try/home_screen_widgets/search_box_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key, this.userName});

  final String? userName;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Remove SharedPreferences and directly make the API call
    final response = await http.get(
      Uri.parse('http://40.90.224.241:5000/isLoggedIn'),
    );

    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: Drawer(
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                      child: Container(
                        width: 115.95,
                        height: 58.5,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/image 7.png',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: IconButton(
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 24,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Container(
                        width: 50,
                        height: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/Logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'chetan',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '15th Feb, 2025',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFBD00),
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        textStyle: Theme.of(context).textTheme.titleSmall,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text('Sell Your Phone'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: IconButton(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(
                        'Logout',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),

              // Drawer Bottom Buttons
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDrawerButton(
                            Icons.shopping_cart_checkout_rounded, 'How to Buy'),
                        _buildDrawerButton(
                            Icons.attach_money_sharp, 'How to Sell'),
                        _buildDrawerButton(
                            Icons.menu_book_rounded, 'Oru Guide'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDrawerButton(Icons.info_sharp, 'About Us'),
                        _buildDrawerButton(
                            Icons.private_connectivity_sharp, 'Privacy Policy'),
                        _buildDrawerButton(Icons.forum, 'FAQ\'s'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            automaticallyImplyLeading: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  height: 54.84,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/Logo.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    'India',
                    style: TextStyle(fontFamily: 'Inter', letterSpacing: 0.0),
                  ),
                ),
                const Icon(Icons.location_pin, color: Colors.black, size: 24),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
                child: ElevatedButton(
                  onPressed: () => print('Button pressed ...'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBC00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'Inter Tight',
                        color: Colors.black,
                        letterSpacing: 0.0),
                  ),
                ),
              ),
            ],
            centerTitle: true,
            toolbarHeight: 130,
            elevation: 0,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Scrollable Text Row
              const SizedBox(
                height: 60, // Set a fixed height for the scrollable text row
                child: SearchBoxExample(),
              ),
              const SizedBox(height: 2),

              const SizedBox(height: 2),
              // Scrollable Text Row
              const SizedBox(
                height: 60, // Set a fixed height for the scrollable text row
                child: ScrollableTextRow1(),
              ),
              const SizedBox(height: 20),
              // Banner Carousel
              SizedBox(
                height: 200, // Set a fixed height for the banner carousel
                child: BannerCarouselPage(),
              ),
              const SizedBox(height: 2),
              // Add spacing

              Text(
                'Whats on your mind?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 2),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCategoryCard(context, 'Buy Used Phones',
                          'assets/images/Mobile/image.png'),
                      _buildCategoryCard(context, 'Sell Used Phones',
                          'assets/images/Mobile 2/image.png'),
                      _buildCategoryCard(context, 'My Listings',
                          'assets/images/Mobile 5/image.png'),
                      _buildCategoryCard(context, 'Compare Prices',
                          'assets/images/Mobile 3/image.png'),
                      _buildCategoryCard(context, 'My Profile',
                          'assets/images/Mobile 4/image.png'),
                      _buildCategoryCard(context, 'Open Store',
                          'assets/images/Mobile 6/image.png'),
                      _buildCategoryCard(context, 'Services',
                          'assets/images/Mobile 7/image.png'),
                      _buildCategoryCard(context, 'Device Health Check',
                          'assets/images/Mobile 8/Device Health.png'),
                      _buildCategoryCard(context, 'Refurbished Phones',
                          'assets/images/Mobile 16/Refurbished Phones.png'),
                      _buildCategoryCard(context, 'Like New Phones',
                          'assets/images/Mobile 15/image.png'),
                      _buildCategoryCard(context, 'My Favorites',
                          'assets/images/Mobile 19/image.png'),
                      _buildCategoryCard(context, 'My Negotiations',
                          'assets/images/Mobile 18/image.png'),
                      _buildCategoryCard(context, 'Under Warranty',
                          'assets/images/Mobile 13/image.png'),
                      _buildCategoryCard(context, 'IMEI Verification',
                          'assets/images/Mobile 10/IMEI Check.png'),
                      _buildCategoryCard(context, 'Battery Health',
                          'assets/images/Mobile 9/Battery Health.png'),
                      _buildCategoryCard(context, 'Data Wipe',
                          'assets/images/Mobile 12/image.png'),
                      _buildCategoryCard(context, 'Premium Phones',
                          'assets/images/Mobile 14/image.png'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5), // Add spacing
              Text(
                'Top Brands',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              // Add spacing
              const SizedBox(height: 10),
              // Scrollable Text Row
              SizedBox(
                height: 60,

                // Set a fixed height for the scrollable text row
                child: FilterButtonExample(),
              ),
              const SizedBox(height: 20),
              // Brands Display
              const SizedBox(
                height: 100, // Set a fixed height for the brands display
                child: BrandsDisplayPage(),
              ),
              const SizedBox(height: 10), // Add spacing
              Text(
                'Best Deals Near You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              // Scrollable Text Row
              const SizedBox(
                height: 60, // Set a fixed height for the scrollable text row
                child: ScrollableTextRow(),
              ),
              const SizedBox(height: 20), // Add spacing
              const SizedBox(height: 10),
              // Scrollable Text Row
              SizedBox(
                height: 400, // Set a fixed height for the scrollable text row
                child: ProductListScreen(),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 10),
              // Scrollable Text Row
              SizedBox(
                height: 60, // Set a fixed height for the scrollable text row
                child: FaqWidget(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ), // Add more widgets here if needed
    );
  }

  Widget _buildDrawerButton(IconData icon, String label) {
    return Container(
      width: 90,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

Widget _buildCategoryCard(
    BuildContext context, String title, String imagePath) {
  return GestureDetector(
    onTap: () => showOtpBottomSheet(context),
    child: Container(
      width: 99.7,
      height: 141.56, // Default height, can be adjusted per item
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 200,
                height: 78.7,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              letterSpacing: 0.0,
              fontSize: 14,
              color: Colors.black, // Ensuring visibility
            ),
          ),
        ],
      ),
    ),
  );
}

// Banner Carousel Widget (from your code)
// class BannerCarouselPage extends StatelessWidget {
//   final List<String> bannerImages = [
//     'assets/images/Property 1=Banner 1.png',
//     'assets/images/Property 1=Banner 2.png',
//     'assets/images/Property 1=Banner 3.png',
//     'assets/images/Property 1=Banner 4.png',
//     'assets/images/Property 1=Banner 5.png',
//   ];

//   BannerCarouselPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: bannerImages.length,
//       itemBuilder: (context, index) {
//         return _buildBanner(bannerImages[index]);
//       },
//     );
//   }

//   Widget _buildBanner(String imagePath) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Center(
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.5),
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//       ),
//     );
//   }

// // Update your category card widget
//   // Widget _buildCategoryCard(String title, String imagePath) {
//   //   return GestureDetector(
//   //     onTap: () => showOtpBottomSheet(context),
//   //     child: Container(
//   //       width: 99.7,
//   //       height: 141.56,
//   //       decoration: BoxDecoration(
//   //         color: Colors.white,
//   //         borderRadius: BorderRadius.circular(10),
//   //       ),
//   //       child: Column(
//   //         mainAxisSize: MainAxisSize.max,
//   //         children: [
//   //           Padding(
//   //             padding: const EdgeInsets.all(8),
//   //             child: ClipRRect(
//   //               borderRadius: BorderRadius.circular(8),
//   //               child: Image.asset(
//   //                 imagePath,
//   //                 width: 200,
//   //                 height: 78.7,
//   //                 fit: BoxFit.fill,
//   //               ),
//   //             ),
//   //           ),
//   //           Text(
//   //             title,
//   //             textAlign: TextAlign.center,
//   //             style: const TextStyle(
//   //               fontFamily: 'Inter',
//   //               fontSize: 14,
//   //               color: Colors.black,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
// // Brands Display Widget (from your code)

// class BrandsDisplayPage extends StatefulWidget {
//   const BrandsDisplayPage({super.key});

//   @override
//   State<BrandsDisplayPage> createState() => _BrandsDisplayPageState();
// }

// class _BrandsDisplayPageState extends State<BrandsDisplayPage> {
//   List<dynamic> _brands = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBrands();
//   }

//   Future<void> _fetchBrands() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'http://40.90.224.241:5000/makeWithImages')); // Replace with your actual API endpoint

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'SUCCESS') {
//           setState(() {
//             _brands = data['dataObject'];
//             _isLoading = false;
//           });
//         } else {
//           setState(() {
//             _isLoading = false;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Failed to fetch brands')),
//           );
//         }
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to load data')),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator()) // Show loading indicator
//           : _buildBrandsList(), // Show the list of brands
//     );
//   }

//   Widget _buildBrandsList() {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal, // Horizontal scrolling
//       padding: const EdgeInsets.all(16),
//       itemCount: _brands.length,
//       itemBuilder: (context, index) {
//         final brand = _brands[index];
//         return _buildBrandCard(brand);
//       },
//     );
//   }

//   Widget _buildBrandCard(Map<String, dynamic> brand) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(right: 16),
//       child: Container(
//         color: const Color.fromARGB(255, 237, 237, 237),
//         width: 120,
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(
//               brand['imagePath'],
//               width: 23,
//               height: 23,
//               fit: BoxFit.contain,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Icon(Icons.broken_image, size: 23);
//               },
//             ),
//             const SizedBox(height: 8),
//             Text(
//               brand['make'],
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Scrollable Text Row Widget (from your code)
// class ScrollableTextRow1 extends StatelessWidget {
//   const ScrollableTextRow1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // List of custom text for each container
//     final List<String> customTexts = [
//       'Sell used Phones',
//       'But used Phones',
//       'Compare Prices',
//       'My Profile',
//       'My Listings',
//       'Services',
//       'Register your store',
//     ];

//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: customTexts.length,
//       itemBuilder: (context, index) {
//         return _buildContainer(customTexts[index]);
//       },
//     );
//   }

//   Widget _buildContainer(String text) {
//     return Container(
//       width: 100, // Width of each container
//       height: 40, // Height of each container
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.black, width: 1),
//           borderRadius: BorderRadius.circular(4),
//           color: const Color.fromARGB(255, 244, 243, 243)),
//       child: Center(
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.normal,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ScrollableTextRow extends StatelessWidget {
//   const ScrollableTextRow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // List of custom text for each container
//     final List<String> customTexts = [
//       'Nearby Deals',
//       'Deals in 250 km',
//       'Verified Deals',
//       'Deals in 50 km',
//       'Apple',
//       'Samsung',
//       'Under Waranty',
//       'Refurbished',
//       'Like New',
//     ];

//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: customTexts.length,
//       itemBuilder: (context, index) {
//         return _buildContainer(customTexts[index]);
//       },
//     );
//   }

//   Widget _buildContainer(String text) {
//     return Container(
//       width: 100, // Width of each container
//       height: 40, // Height of each container
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.black, width: 1),
//           borderRadius: BorderRadius.circular(4),
//           color: const Color.fromARGB(255, 240, 240, 240)),
//       child: Center(
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.normal,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SearchBoxExample extends StatelessWidget {
//   const SearchBoxExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SizedBox(
//           height: 50,
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'Search phones with make, model, company', // Hint text
//               prefixIcon: const Icon(Icons.search), // Search icon
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0), // Rounded corners
//               ),
//               filled: true, // Enable filling the background
//               fillColor: const Color.fromARGB(
//                   255, 255, 255, 255), // Light grey background
//               contentPadding: const EdgeInsets.symmetric(
//                   vertical: 5.0, horizontal: 16.0), // Padding inside the box
//             ),
//             onChanged: (value) {
//               // Handle search input changes
//               print('Search query: $value');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FilterButtonExample extends StatefulWidget {
//   const FilterButtonExample({super.key});

//   @override
//   State<FilterButtonExample> createState() => _FilterButtonExampleState();
// }

// class _FilterButtonExampleState extends State<FilterButtonExample> {
//   Map<String, dynamic>? filters;
//   bool isLoading = false;

//   // Track selected filters
//   Map<String, List<String>> selectedFilters = {
//     'Brand': [],
//     'Ram': [],
//     'Storage': [],
//     'Conditions': [],
//     'Warranty': [],
//   };

//   Future<void> fetchFilters() async {
//     setState(() {
//       isLoading = true;
//     });

//     final response = await http
//         .get(Uri.parse('http://40.90.224.241:5000/showSearchFilters'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         filters = data['dataObject'];
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       throw Exception('Failed to load filters');
//     }
//   }

//   void _showFilterDialog() {
//     if (filters == null) return;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.white, // Set dialog background to white
//           title: const Text('Filter Options'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildFilterSection('Brand', filters!['Brand']),
//                 _buildFilterSection('Ram', filters!['Ram']),
//                 _buildFilterSection('Storage', filters!['Storage']),
//                 _buildFilterSection('Conditions', filters!['Conditions']),
//                 _buildFilterSection('Warranty', filters!['Warranty']),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 _resetFilters(); // Reset all selected filters
//                 Navigator.pop(context);
//               },
//               child: const Text('Reset'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _applyFilters(); // Apply selected filters
//                 Navigator.pop(context);
//               },
//               child: const Text('Apply'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildFilterSection(String title, List<dynamic> options) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: options.map((option) {
//             return FilterChip(
//               label: Text(option.toString()),
//               selected: selectedFilters[title]!.contains(option.toString()),
//               onSelected: (selected) {
//                 setState(() {
//                   if (selected) {
//                     selectedFilters[title]!.add(option.toString());
//                   } else {
//                     selectedFilters[title]!.remove(option.toString());
//                   }
//                 });
//               },
//               backgroundColor:
//                   Colors.white, // Set unselected chip background to white
//               selectedColor: Colors
//                   .blue[100], // Set selected chip background to light blue
//               checkmarkColor: Colors.blue, // Set checkmark color to blue
//               labelStyle: TextStyle(
//                 color: selectedFilters[title]!.contains(option.toString())
//                     ? Colors.blue // Selected text color
//                     : Colors.black, // Unselected text color
//               ),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   void _applyFilters() {
//     // Logic to apply selected filters
//     print('Applied Filters: $selectedFilters');
//     // You can pass the selected filters to another function or update the UI
//   }

//   void _resetFilters() {
//     // Reset all selected filters
//     setState(() {
//       selectedFilters.forEach((key, value) {
//         selectedFilters[key]!.clear();
//       });
//     });
//     print('Filters Reset');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await fetchFilters();
//             _showFilterDialog();
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor:
//                 const Color.fromARGB(255, 224, 229, 229), // Background color
//             foregroundColor: const Color.fromARGB(255, 0, 0, 0), // Text color
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12), // Rounded corners
//             ),
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 16, vertical: 12), // Padding
//           ),
//           child: const Text('Show Filters'),
//         ),
//       ),
//     );
//   }
// }

// class Product {
//   final String id;
//   final String make;
//   final String marketingName;
//   final String listingPrice;
//   final String deviceCondition;
//   final String deviceStorage;
//   final String imagePath;
//   final bool verified;

//   Product({
//     required this.id,
//     required this.make,
//     required this.marketingName,
//     required this.listingPrice,
//     required this.deviceCondition,
//     required this.deviceStorage,
//     required this.imagePath,
//     required this.verified,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['_id'] ?? '',
//       make: json['make'] ?? 'Unknown Brand',
//       marketingName: json['marketingName'] ?? 'Unnamed Product',
//       listingPrice: json['listingPrice']?.toString() ?? '0',
//       deviceCondition: json['deviceCondition'] ?? 'Condition Unknown',
//       deviceStorage: json['deviceStorage'] ?? 'Storage Unknown',
//       imagePath: json['imagePath'] ?? 'https://via.placeholder.com/150',
//       verified: json['verified'] ?? false,
//     );
//   }
// }

// class ProductService {
//   static Future<List<Product>> fetchProducts(
//       Map<String, dynamic> filters) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://40.90.224.241:5000/filter'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'filter': filters}),
//       );

//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['data'] != null && data['data']['data'] != null) {
//           List products = data['data']['data'];
//           return products.map((json) => Product.fromJson(json)).toList();
//         }
//         return [];
//       } else {
//         throw Exception('Failed to load products: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching products: $e');
//       throw Exception('Failed to load products');
//     }
//   }
// }

// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({super.key});

//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   List<Product> products = [];
//   bool isLoading = true;
//   Map<String, dynamic> filters = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadProducts();
//   }

//   Future<void> _loadProducts() async {
//     setState(() => isLoading = true);
//     try {
//       final result = await ProductService.fetchProducts(filters);
//       setState(() => products = result);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error loading products: $e'),
//           duration: Duration(seconds: 5),
//         ),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Widget _buildFilterControls() {
//     return Column(
//       children: [
//         // Keep your existing filter controls
//         // ...
//       ],
//     );
//   }

//   Widget _buildProductGrid() {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (products.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 50, color: Colors.grey),
//             SizedBox(height: 100),
//             Text(
//               'No Products Found',
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: _loadProducts,
//               child: Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.8,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return Card(
//           child: Column(
//             children: [
//               Expanded(
//                 child: Image.network(
//                   product.imagePath,
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                                 loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) =>
//                       Icon(Icons.broken_image, size: 50),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(product.marketingName,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                     SizedBox(height: 4),
//                     Text('₹${product.listingPrice}',
//                         style: TextStyle(color: Colors.green[800])),
//                     SizedBox(height: 4),
//                     Text('Condition: ${product.deviceCondition}',
//                         style: TextStyle(fontSize: 12)),
//                     Text('Storage: ${product.deviceStorage}',
//                         style: TextStyle(fontSize: 12)),
//                     if (product.verified)
//                       Padding(
//                         padding: EdgeInsets.only(top: 4),
//                         child: Row(
//                           children: [
//                             Icon(Icons.verified, color: Colors.blue, size: 16),
//                             SizedBox(width: 4),
//                             Text('Verified',
//                                 style: TextStyle(
//                                     color: Colors.blue, fontSize: 12)),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         height: 1000,
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: _buildFilterControls(),
//             ),
//             Expanded(child: _buildProductGrid()),
//           ],
//         ),
//       ),
//     );
//   }
// }
