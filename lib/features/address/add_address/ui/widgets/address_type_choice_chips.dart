// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../../core/assets/app_svg.dart';
// import '../../../../../core/theme/colors/styles.dart';
// import '../../../../../core/theme/text_styles/text_styles.dart';
// import '../../../../../core/utils/constant/app_strings.dart';
// import '../../../../../core/utils/extensions/extensions.dart';
// import '../../../../../core/utils/widgets/text/main_text.dart';
// import '../../data/enum/address_type_enum.dart';
// import '../../logic/add_address_cubit.dart';

// class AddressTypeChoiceChips extends StatelessWidget {
//   const AddressTypeChoiceChips({
//     super.key,
//     this.initialValue,
//     this.validator,
//     this.onSelect,
//   });

//   final AddressTypeEnum? initialValue;
//   final String? Function(AddressTypeEnum?)? validator;
//   final void Function(AddressTypeEnum?)? onSelect;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: context.read<AddAddressCubit>().entityStream,
//       builder: (context, snapshot) {
//         final cubit = context.read<AddAddressCubit>();
//         final selectedType = cubit.getSelectedType();

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             MainText(
//               text: AppStrings.addressType.tr,
//               style: AppTextStyles.textLgMedium,
//             ),
//             const SizedBox(height: 8),
//             Row(
//               spacing: 8,
//               children: AddressTypeEnum.values.map((type) {
//                 final isSelected = selectedType == type;

//                 return GestureDetector(
//                   onTap: () {
//                     cubit.updateSelectedType(type);
//                     onSelect?.call(type);
//                   },
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? const Color.fromRGBO(81, 94, 50, 0.1)
//                           : AppColors.kWhite,
//                       border: Border.all(
//                         color: isSelected
//                             ? const Color.fromRGBO(81, 94, 50, 1)
//                             : const Color.fromRGBO(209, 209, 209, 1),
//                         width: 1,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         MainText(
//                           text: type.displayName,
//                           style: AppTextStyles.textMdRegular.copyWith(
//                             color: isSelected
//                                 ? const Color.fromRGBO(81, 94, 50, 1)
//                                 : AppColors.textSecondaryParagraph,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         SvgPicture.asset(
//                           type == AddressTypeEnum.home
//                               ? AppSvg.homeIcon
//                               : AppSvg.officePlaza,
//                           color: isSelected
//                               ? const Color.fromRGBO(81, 94, 50, 1)
//                               : AppColors.textSecondaryParagraph,
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             if (validator != null)
//               Builder(
//                 builder: (context) {
//                   final error = validator?.call(selectedType);
//                   if (error != null) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text(
//                         error,
//                         style: AppTextStyles.textSmRegular.copyWith(
//                           color: Colors.red,
//                         ),
//                       ),
//                     );
//                   }
//                   return const SizedBox.shrink();
//                 },
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
