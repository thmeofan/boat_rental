import 'package:boat/views/app/widgets/chosen_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../blocs/rental_cubit/rental_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../data/model/rental.dart';
import '../../app/widgets/output_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class TransportInfoScreen extends StatelessWidget {
  final Rental rental;

  const TransportInfoScreen({
    Key? key,
    required this.rental,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.greenColor,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            color: AppColors.peachColor,
          ),
        ),
        backgroundColor: AppColors.brownColor,
        title: const Text(
          'Back',
          style: SettingsTextStyle.back,
        ),
      ),
      body: Container(
        color: AppColors.brownColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New transport',
                style: SettingsTextStyle.title,
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.lightBrownColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      OutputWidget(
                        text: 'Type',
                        leading: SvgPicture.asset('assets/icons/type.svg'),
                        actions: [
                          Text(
                            rental.type,
                            style: HomeScreenTextStyle.info,
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.005),
                      OutputWidget(
                        text: 'Rental cost',
                        leading:
                            SvgPicture.asset('assets/icons/rental_cost.svg'),
                        actions: [
                          Text(
                            '${rental.cost.toStringAsFixed(2)}',
                            style: HomeScreenTextStyle.info,
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.005),
                      OutputWidget(
                        text: 'Payment type ',
                        leading:
                            SvgPicture.asset('assets/icons/payment_type.svg'),
                        actions: [
                          Text(
                            '${rental.rentalPeriod.name}',
                            style: HomeScreenTextStyle.info,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.015),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.lightBrownColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      OutputWidget(
                        text: 'Comment: ${rental.comment}',
                        leading: SvgPicture.asset('assets/icons/state.svg'),
                        actions: [
                          Wrap(
                            spacing: 8,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.brownColor,
                                ),
                                child: Text(
                                  rental.state.name,
                                  style: _getTextStyleBasedOnRentalState(
                                      rental.state.name),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.005),
                      OutputWidget(
                        text: 'Who rent ',
                        leading: SvgPicture.asset('assets/icons/who_rents.svg'),
                        actions: [
                          Text(
                            ' ${rental.owner}',
                            style: HomeScreenTextStyle.info,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.015),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comment',
                    style: ConstructorTextStyle.lable,
                  ),
                  SizedBox(height: size.height * 0.005),
                  Container(
                    height: size.height * 0.2,
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightBrownColor,
                    ),
                    child: Text(
                      rental.comment,
                      style: ConstructorTextStyle.inputText,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.005),
              ChosenActionButton(
                  text: 'Delete rental',
                  onTap: () {
                    context.read<RentalCubit>().deleteRental(rental);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _getTextStyleBasedOnRentalState(String rentalState) {
    switch (rentalState.toLowerCase()) {
      case 'perfect':
        return HomeScreenTextStyle.typePerfect;
      case 'average':
        return HomeScreenTextStyle.typeAverage;
      case 'bad':
        return HomeScreenTextStyle.typeBad;
      default:
        return HomeScreenTextStyle.typeAverage;
    }
  }
}
