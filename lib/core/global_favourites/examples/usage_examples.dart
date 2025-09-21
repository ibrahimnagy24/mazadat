// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../global_favourites.dart';

// /// Example 1: Simple Favourite Button
// class SimpleFavouriteButton extends StatelessWidget {
//   final int itemId;
//   final String? itemTitle;

//   const SimpleFavouriteButton({
//     Key? key,
//     required this.itemId,
//     this.itemTitle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
//       bloc: GlobalFavouritesService.getCubit(),
//       builder: (context, state) {
//         final isFavourite = GlobalFavouritesService.isFavourite(itemId);
//         final isToggling = state is GlobalFavouritesToggling && 
//                           state.itemId == itemId;

//         return IconButton(
//           icon: isToggling
//               ? const SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 )
//               : Icon(
//                   isFavourite ? Icons.favorite : Icons.favorite_border,
//                   color: isFavourite ? Colors.red : Colors.grey,
//                 ),
//           onPressed: isToggling
//               ? null
//               : () async {
//                   await GlobalFavouritesService.toggleFavourite(
//                     itemId,
//                     onSuccess: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             isFavourite
//                                 ? 'Removed from favourites'
//                                 : 'Added to favourites',
//                           ),
//                           duration: const Duration(seconds: 1),
//                         ),
//                       );
//                     },
//                   );
//                 },
//         );
//       },
//     );
//   }
// }

// /// Example 2: Auction Card with Favourite
// class AuctionCardWithFavourite extends StatelessWidget {
//   final int auctionId;
//   final String title;
//   final String? imageUrl;
//   final String price;

//   const AuctionCardWithFavourite({
//     Key? key,
//     required this.auctionId,
//     required this.title,
//     this.imageUrl,
//     required this.price,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               // Image
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
//                   image: imageUrl != null
//                       ? DecorationImage(
//                           image: NetworkImage(imageUrl!),
//                           fit: BoxFit.cover,
//                         )
//                       : null,
//                   color: Colors.grey[300],
//                 ),
//                 child: imageUrl == null
//                     ? const Icon(Icons.image, size: 50, color: Colors.grey)
//                     : null,
//               ),
//               // Favourite button overlay
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                   ),
//                   child: SimpleFavouriteButton(itemId: auctionId),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   price,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Example 3: Favourites Counter Widget
// class FavouritesCounter extends StatelessWidget {
//   const FavouritesCounter({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
//       bloc: GlobalFavouritesService.getCubit(),
//       builder: (context, state) {
//         final count = GlobalFavouritesService.getFavouriteCount();
        
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(Icons.favorite, color: Colors.white, size: 16),
//               const SizedBox(width: 4),
//               Text(
//                 '$count',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// /// Example 4: Favourites List Screen
// class FavouritesListScreen extends StatelessWidget {
//   const FavouritesListScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Favourites'),
//         actions: [
//           BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
//             bloc: GlobalFavouritesService.getCubit(),
//             builder: (context, state) {
//               final hasItems = GlobalFavouritesService.getFavouriteCount() > 0;
              
//               return hasItems
//                   ? IconButton(
//                       icon: const Icon(Icons.clear_all),
//                       onPressed: () => _showClearAllDialog(context),
//                     )
//                   : const SizedBox.shrink();
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
//         bloc: GlobalFavouritesService.getCubit(),
//         builder: (context, state) {
//           if (state is GlobalFavouritesLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final favouriteIds = GlobalFavouritesService.getAllFavouriteIds();
          
//           if (favouriteIds.isEmpty) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.favorite_border, size: 64, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text(
//                     'No favourites yet',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Items you favourite will appear here',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return ListView.builder(
//             itemCount: favouriteIds.length,
//             itemBuilder: (context, index) {
//               final itemId = favouriteIds.elementAt(index);
//               return ListTile(
//                 leading: const Icon(Icons.favorite, color: Colors.red),
//                 title: Text('Item $itemId'), // Replace with actual item data
//                 trailing: IconButton(
//                   icon: const Icon(Icons.remove_circle_outline),
//                   onPressed: () async {
//                     await GlobalFavouritesService.removeFromFavourites(itemId);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showClearAllDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Clear All Favourites'),
//         content: const Text('Are you sure you want to remove all favourites?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await GlobalFavouritesService.clearAllFavourites();
//             },
//             child: const Text('Clear All'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Example 5: Batch Operations Example
// class BatchOperationsExample extends StatefulWidget {
//   const BatchOperationsExample({Key? key}) : super(key: key);

//   @override
//   State<BatchOperationsExample> createState() => _BatchOperationsExampleState();
// }

// class _BatchOperationsExampleState extends State<BatchOperationsExample> {
//   final List<int> sampleItemIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Batch Operations')),
//       body: BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
//         bloc: GlobalFavouritesService.getCubit(),
//         builder: (context, state) {
//           // Get favourite status for all items
//           final favouriteStatus = GlobalFavouritesService.checkMultipleFavourites(sampleItemIds);
//           final favouriteItems = GlobalFavouritesService.filterFavourites(sampleItemIds);
//           final nonFavouriteItems = GlobalFavouritesService.filterNonFavourites(sampleItemIds);

//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Favourite Items (${favouriteItems.length}):',
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(favouriteItems.toString()),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Non-Favourite Items (${nonFavouriteItems.length}):',
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(nonFavouriteItems.toString()),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'All Items:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: sampleItemIds.length,
//                     itemBuilder: (context, index) {
//                       final itemId = sampleItemIds[index];
//                       final isFavourite = favouriteStatus[itemId] ?? false;
                      
//                       return ListTile(
//                         leading: Icon(
//                           isFavourite ? Icons.favorite : Icons.favorite_border,
//                           color: isFavourite ? Colors.red : Colors.grey,
//                         ),
//                         title: Text('Item $itemId'),
//                         trailing: ElevatedButton(
//                           onPressed: () async {
//                             await GlobalFavouritesService.toggleFavourite(itemId);
//                           },
//                           child: Text(isFavourite ? 'Remove' : 'Add'),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
