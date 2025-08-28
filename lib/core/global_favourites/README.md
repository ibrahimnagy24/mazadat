# Global Favourites Module

A comprehensive global favourites management system for Flutter apps that provides easy access to favourites functionality from anywhere in your application without needing to create instances for each element.

## Features

- ✅ **Global Access**: Access favourites from anywhere in your app
- ✅ **Singleton Pattern**: Single instance manages all favourites
- ✅ **Local Storage**: Persistent storage using SharedPreferences
- ✅ **Easy API**: Simple methods for checking and managing favourites
- ✅ **State Management**: Built with BLoC pattern
- ✅ **Type Safety**: Full type safety with Dart
- ✅ **Performance**: Efficient Set-based storage for fast lookups

## Quick Start

### 1. Setup Provider (in your main.dart or app.dart)

```dart
import 'package:your_app/core/global_favourites/global_favourites.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalFavouritesProvider(
      child: MaterialApp(
        // your app configuration
      ),
    );
  }
}
```

### 2. Basic Usage

```dart
import 'package:your_app/core/global_favourites/global_favourites.dart';

// Check if item is favourite
bool isFav = GlobalFavouritesService.isFavourite(123);

// Toggle favourite status
await GlobalFavouritesService.toggleFavourite(123);

// Add to favourites
await GlobalFavouritesService.addToFavourites(123);

// Remove from favourites
await GlobalFavouritesService.removeFromFavourites(123);

// Get all favourite IDs
Set<int> allFavs = GlobalFavouritesService.getAllFavouriteIds();

// Get favourite count
int count = GlobalFavouritesService.getFavouriteCount();
```

## Usage Examples

### In a Widget (with BlocBuilder for reactive UI)

```dart
class FavouriteButton extends StatelessWidget {
  final int itemId;
  
  const FavouriteButton({required this.itemId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
      bloc: GlobalFavouritesService.getCubit(),
      builder: (context, state) {
        final isFavourite = GlobalFavouritesService.isFavourite(itemId);
        
        return IconButton(
          icon: Icon(
            isFavourite ? Icons.favorite : Icons.favorite_border,
            color: isFavourite ? Colors.red : Colors.grey,
          ),
          onPressed: () async {
            await GlobalFavouritesService.toggleFavourite(
              itemId,
              onSuccess: () {
                // Optional success callback
                print('Favourite toggled successfully!');
              },
            );
          },
        );
      },
    );
  }
}
```

### In a List Widget

```dart
class AuctionCard extends StatelessWidget {
  final AuctionEntity auction;
  
  const AuctionCard({required this.auction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(auction.title),
        trailing: BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
          bloc: GlobalFavouritesService.getCubit(),
          builder: (context, state) {
            final isFavourite = GlobalFavouritesService.isFavourite(auction.id);
            
            return IconButton(
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: isFavourite ? Colors.red : Colors.grey,
              ),
              onPressed: () => GlobalFavouritesService.toggleFavourite(auction.id),
            );
          },
        ),
      ),
    );
  }
}
```

### Batch Operations

```dart
// Check multiple items at once
List<int> itemIds = [1, 2, 3, 4, 5];
Map<int, bool> favouriteStatus = GlobalFavouritesService.checkMultipleFavourites(itemIds);

// Filter only favourite items
List<int> favouriteItems = GlobalFavouritesService.filterFavourites(itemIds);

// Filter non-favourite items
List<int> nonFavouriteItems = GlobalFavouritesService.filterNonFavourites(itemIds);
```

### Using with Context Extension

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalFavouritesCubit, GlobalFavouritesState>(
      bloc: context.globalFavourites, // Using extension
      builder: (context, state) {
        return Text('Favourites: ${GlobalFavouritesService.getFavouriteCount()}');
      },
    );
  }
}
```

## API Reference

### GlobalFavouritesService

| Method | Description | Returns |
|--------|-------------|---------|
| `isFavourite(int itemId)` | Check if item is favourite | `bool` |
| `toggleFavourite(int itemId, {Function()? onSuccess})` | Toggle favourite status | `Future<void>` |
| `addToFavourites(int itemId, {Function()? onSuccess})` | Add item to favourites | `Future<void>` |
| `removeFromFavourites(int itemId, {Function()? onSuccess})` | Remove item from favourites | `Future<void>` |
| `getAllFavouriteIds()` | Get all favourite IDs | `Set<int>` |
| `getFavouriteCount()` | Get favourite count | `int` |
| `checkMultipleFavourites(List<int> itemIds)` | Check multiple items | `Map<int, bool>` |
| `filterFavourites(List<int> itemIds)` | Filter favourite items | `List<int>` |
| `filterNonFavourites(List<int> itemIds)` | Filter non-favourite items | `List<int>` |
| `clearAllFavourites()` | Clear all favourites (local) | `Future<void>` |
| `refreshFavourites()` | Refresh from server | `Future<void>` |
| `syncFavouriteIds(Set<int> serverIds)` | Sync with server IDs | `Future<void>` |

### States

- `GlobalFavouritesInitial`: Initial state
- `GlobalFavouritesLoading`: Loading favourites
- `GlobalFavouritesLoaded`: Favourites loaded successfully
- `GlobalFavouritesError`: Error occurred
- `GlobalFavouritesToggling`: Currently toggling an item

## Integration with Existing Code

The global favourites module is designed to work alongside your existing favourites implementation. It uses the same API endpoints and parameters, so you can gradually migrate to using the global system while keeping your original files intact.

## Best Practices

1. **Wrap your app** with `GlobalFavouritesProvider` at the root level
2. **Use BlocBuilder** for reactive UI updates
3. **Use the service methods** for simple operations
4. **Handle loading states** when toggling favourites
5. **Use batch operations** for better performance with multiple items

## Dependencies

Make sure you have these dependencies in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  shared_preferences: ^2.2.2
  equatable: ^2.0.5
  dartz: ^0.10.1
```
