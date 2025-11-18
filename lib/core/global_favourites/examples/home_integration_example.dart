// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../global_favourites.dart';

// /// Example showing how to integrate global favourites in your home auction cards
// class HomeAuctionCardExample extends StatelessWidget {
//   final int auctionId;
//   final String? image;
//   final String title;
//   final String price;

//   const HomeAuctionCardExample({
//     Key? key,
//     required this.auctionId,
//     this.image,
//     required this.title,
//     required this.price,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
//       bloc: GlobalFavouritesService.getCubit(),
//       builder: (context, state) {
//         // Check if this auction is in favourites
//         final isFavourite = GlobalFavouritesService.isFavourite(auctionId);
//         final isToggling = state is GlobalFavouritesToggling &&
//                           state.itemId == auctionId;

//         return Card(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image with favourite button overlay
//               Stack(
//                 children: [
//                   Container(
//                     height: 150,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
//                       image: image != null
//                           ? DecorationImage(
//                               image: NetworkImage(image!),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                       color: Colors.grey[300],
//                     ),
//                     child: image == null
//                         ? const Icon(Icons.image, size: 50, color: Colors.grey)
//                         : null,
//                   ),
//                   // Favourite button
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.9),
//                         shape: BoxShape.circle,
//                       ),
//                       child: IconButton(
//                         icon: isToggling
//                             ? const SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(strokeWidth: 2),
//                               )
//                             : Icon(
//                                 isFavourite ? Icons.favorite : Icons.favorite_border,
//                                 color: isFavourite ? Colors.red : Colors.grey,
//                               ),
//                         onPressed: isToggling
//                             ? null
//                             : () async {
//                                 await GlobalFavouritesService.toggleFavourite(
//                                   auctionId,
//                                   onSuccess: () {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text(
//                                           isFavourite
//                                               ? 'Removed from favourites'
//                                               : 'Added to favourites',
//                                         ),
//                                         duration: const Duration(seconds: 1),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // Content
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       price,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// /// Example of batch checking favourites for multiple auctions
// class BatchFavouriteChecker extends StatelessWidget {
//   final List<int> auctionIds;

//   const BatchFavouriteChecker({
//     Key? key,
//     required this.auctionIds,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
//       bloc: GlobalFavouritesService.getCubit(),
//       builder: (context, state) {
//         // Check multiple auctions at once
//         final favouriteStatus = GlobalFavouritesService.checkMultipleFavourites(auctionIds);
//         final favouriteCount = GlobalFavouritesService.filterFavourites(auctionIds).length;

//         return Column(
//           children: [
//             Text('Favourite auctions: $favouriteCount/${auctionIds.length}'),
//             ...auctionIds.map((id) => ListTile(
//               title: Text('Auction $id'),
//               trailing: Icon(
//                 favouriteStatus[id] == true ? Icons.favorite : Icons.favorite_border,
//                 color: favouriteStatus[id] == true ? Colors.red : Colors.grey,
//               ),
//             )),
//           ],
//         );
//       },
//     );
//   }
// }
