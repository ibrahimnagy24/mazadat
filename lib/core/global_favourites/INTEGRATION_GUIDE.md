# Integration Guide - Global Favourites Module

## Quick Integration Steps

### 1. Add to your main app (app.dart or main.dart)

```dart
import 'package:mazadat/core/global_favourites/global_favourites.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalFavouritesProvider(
      child: MaterialApp(
        // your existing app configuration
      ),
    );
  }
}
```

### 2. Replace existing favourite buttons

Instead of creating `ToggleFavouriteAuctionCubit` instances, use:

```dart
// OLD WAY (your current implementation)
BlocProvider(
  create: (context) => ToggleFavouriteAuctionCubit(),
  child: BlocBuilder<ToggleFavouriteAuctionCubit, ToggleFavouriteState>(
    builder: (context, state) {
      return IconButton(
        onPressed: () {
          context.read<ToggleFavouriteAuctionCubit>().toggleFavouriteAuction(params);
        },
        icon: Icon(Icons.favorite_border),
      );
    },
  ),
)

// NEW WAY (global favourites)
BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
  bloc: GlobalFavouritesService.getCubit(),
  builder: (context, state) {
    final isFavourite = GlobalFavouritesService.isFavourite(auctionId);
    
    return IconButton(
      onPressed: () async {
        await GlobalFavouritesService.toggleFavourite(auctionId);
      },
      icon: Icon(
        isFavourite ? Icons.favorite : Icons.favorite_border,
        color: isFavourite ? Colors.red : Colors.grey,
      ),
    );
  },
)
```

### 3. Simple usage anywhere in your app

```dart
// Check if item is favourite
bool isFav = GlobalFavouritesService.isFavourite(123);

// Toggle favourite
await GlobalFavouritesService.toggleFavourite(123);

// Add to favourites
await GlobalFavouritesService.addToFavourites(123);

// Remove from favourites  
await GlobalFavouritesService.removeFromFavourites(123);
```

### 4. Example: Update your auction cards

```dart
class AuctionCard extends StatelessWidget {
  final AuctionEntity auction;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Your auction content
          
          // Favourite button
          BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
            bloc: GlobalFavouritesService.getCubit(),
            builder: (context, state) {
              final isFavourite = GlobalFavouritesService.isFavourite(auction.id!);
              
              return IconButton(
                icon: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: isFavourite ? Colors.red : Colors.grey,
                ),
                onPressed: () async {
                  await GlobalFavouritesService.toggleFavourite(auction.id!);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
```

## Benefits of the New System

✅ **No more BlocProvider creation** for each favourite button
✅ **Global state management** - changes reflect everywhere instantly  
✅ **Persistent storage** - favourites saved locally
✅ **Easy API** - simple static methods
✅ **Better performance** - single cubit instance
✅ **Type safety** - full Dart type checking
✅ **Batch operations** - check multiple items at once

## Migration Strategy

1. **Keep your original files** - don't change anything in `/features/favourites/`
2. **Add the provider** to your main app
3. **Gradually replace** favourite buttons with the new global system
4. **Test thoroughly** to ensure everything works
5. **Eventually remove** old BlocProvider instances when no longer needed

Your existing favourites module will continue to work perfectly alongside the new global system!
