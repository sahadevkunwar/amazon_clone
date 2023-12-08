import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: List.generate(
          GlobalVariables.categoryImages.length,
          (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryDealsScreen(
                        category: GlobalVariables.categoryImages[index]
                            ['title']!,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          GlobalVariables.categoryImages[index]['image']!,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                    Text(
                      GlobalVariables.categoryImages[index]['title']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
///[Below code does not fit items inot rows]
//import 'package:amazon_clone/constants/global_variable.dart';
// import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
// import 'package:flutter/material.dart';

// class TopCategories extends StatelessWidget {
//   const TopCategories({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       width: MediaQuery.of(context).size.width * 0.9,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemExtent: 75,
//         itemCount: GlobalVariables.categoryImages.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => CategoryDealsScreen(
//                     category: GlobalVariables.categoryImages[index]['title']!,
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               width: 75, // Explicitly set the width of each item
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(50),
//                       child: Image.asset(
//                         GlobalVariables.categoryImages[index]['image']!,
//                         fit: BoxFit.cover,
//                         height: 40,
//                         width: 40,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     GlobalVariables.categoryImages[index]['title']!,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

