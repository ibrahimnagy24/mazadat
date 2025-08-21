# Preview Auction Module

## Overview
The `preview_auction` module is a consolidated auction feature that combines functionality from the original six auction modules into a single, clean, and maintainable module. It integrates with the reusable `pusher_service` for real-time bidding updates.

## Architecture

### Data Layer
- **Repository**: `PreviewAuctionRepository` - Consolidated API methods from all auction repositories
- **Models**: 
  - `AuctionDetailsModel` - Main auction data model
  - `AuctionPolicyModel` - Auction policy information
  - `AuctionPusherModel` - Real-time bid update model
- **Params**: `AuctionDetailsRouteParams` - Route parameters for navigation

### Logic Layer
- **Cubit**: `PreviewAuctionCubit` - Main business logic controller
- **State**: `PreviewAuctionState` - Comprehensive state management

### UI Layer
- **Main Screen**: `PreviewAuctionScreen` - Entry point with BLoC providers
- **Mobile Design**: `PreviewAuctionMobileDesign` - Responsive mobile layout
- **Widgets**:
  - `PreviewAuctionContent` - Main content container
  - `BiddingSection` - Real-time bidding interface
  - `AuctionInfoSection` - Auction details display
  - `AuctionActionsSection` - Action buttons (join, withdraw, etc.)
  - `PreviewAuctionHeroImage` - Image carousel
  - `PreviewAuctionDraggableSheet` - Bottom sheet container
  - `PreviewAuctionAppBar` - Custom app bar

## Key Features

### Real-time Integration
- Integrates with `PusherCubit` for live bid updates
- Automatic UI updates when new bids are received
- Visual feedback for real-time events

### Comprehensive Auction Management
- Fetch auction details
- Join/leave auctions
- Place bids (manual and first bid)
- Switch bidding methods
- Withdraw from auctions
- Validation handling

### State Management
- Loading states for all operations
- Error handling with user feedback
- Success states with appropriate messages
- Real-time update states

## Usage

### Navigation
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PreviewAuctionScreen(
      routeParams: AuctionDetailsRouteParams(
        auctionId: auctionId,
        primaryImage: imageUrl,
      ),
    ),
  ),
);
```

### BLoC Integration
The screen automatically provides both `PusherCubit` and `PreviewAuctionCubit`:

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => PusherCubit()),
    BlocProvider(
      create: (context) => PreviewAuctionCubit(
        pusherCubit: context.read<PusherCubit>(),
      )..fetchAuctionDetails(routeParams.auctionId),
    ),
  ],
  child: // UI widgets
)
```

### State Listening
```dart
BlocListener<PreviewAuctionCubit, PreviewAuctionState>(
  listener: (context, state) {
    if (state is PreviewAuctionError) {
      // Handle error
    } else if (state is PreviewAuctionBidUpdate) {
      // Handle real-time bid update
    }
  },
  child: // UI
)
```

## API Methods

### Auction Details
- `fetchAuctionDetails(int auctionId)`
- `validateJoiningAuction(AuctionDetailsRouteParams params)`
- `validateJoiningAuctionById(int auctionId)`

### Auction Participation
- `submitJoining(Map<String, dynamic> data)`
- `checkOnJoining(Map<String, dynamic> data)`

### Bidding
- `placeBid(Map<String, dynamic> data, {bool isFirstBid = false})`
- `switchBiddingMethod(Map<String, dynamic> data)`

### Withdrawal
- `withdrawFromAuction(Map<String, dynamic> data)`

## Real-time Updates

The module automatically handles real-time bid updates through Pusher integration:

1. When auction details are fetched, Pusher connection is established
2. Subscribes to the bidding channel for the specific auction
3. Listens for `PLACE_BID_[auctionId]` events
4. Updates UI automatically when new bids are received
5. Provides visual feedback for real-time updates

## Error Handling

- Network errors are handled gracefully
- User-friendly error messages
- Retry mechanisms for failed operations
- Validation errors with specific feedback

## Dependencies

- `flutter_bloc` - State management
- `pusher_channels_flutter` - Real-time updates
- `dartz` - Functional programming (Either type)
- `dio` - HTTP client
- `responsive_builder` - Responsive design
- Custom core utilities and widgets
