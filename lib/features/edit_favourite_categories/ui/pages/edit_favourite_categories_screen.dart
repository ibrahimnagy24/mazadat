part of '../widgets/edit_favourite_categories_imports.dart';

class EditFavouriteCategoriesScreen extends StatelessWidget {
  const EditFavouriteCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit()..categoriesStatesHandled(),
        ),
        BlocProvider(
          create: (context) => EditFavouriteCategoriesCubit(),
        ),
      ],
      child: BlocBuilder<EditFavouriteCategoriesCubit,
          EditFavouriteCategoriesState>(
        builder: (context, state) {
          return CustomScreenTypeLayoutWidget(
            mobilePortrait: (context) =>
                const EditFavouriteCategoriesScreenMobileDesign(),
            mobileLandscape: (context) =>
                const EditFavouriteCategoriesScreenMobileDesign(),
          );
        },
      ),
    );
  }
}
