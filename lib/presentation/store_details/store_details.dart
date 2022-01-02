import 'package:flutter/material.dart';
import 'package:juliaca_store0/app/dependency_injection.dart';
import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render_impl.dart';
import 'package:juliaca_store0/presentation/resources/color_manager.dart';
import 'package:juliaca_store0/presentation/resources/strings_manager.dart';
import 'package:juliaca_store0/presentation/resources/values_manager.dart';
import 'package:juliaca_store0/presentation/store_details/store_details_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final _viewModel = instance<StoreDetailsViewModel>();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          title: Text(
            AppStrings.storeDetails,
            style: Theme.of(context).textTheme.headline2,
          ).tr(),
        ),
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) =>
                snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.start();
                }) ??
                const SizedBox()));
  }

  Widget _getContentWidget() {
    return StreamBuilder<StoreDetails>(
        stream: _viewModel.outputStoreDetails,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getImage(snapshot.data!.image),
                      _getTitle(AppStrings.details.tr()),
                      _getDescription(snapshot.data!.details),
                      _getTitle(AppStrings.services.tr()),
                      _getDescription(snapshot.data!.services),
                      _getTitle(AppStrings.about.tr()),
                      _getDescription(snapshot.data!.about)
                    ],
                  ),
                )
              : const SizedBox();
        });
  }

  Widget _getImage(String image) {
    return SizedBox(
      height: AppSize.s190,
      width: double.infinity,
      child: Image.network(image, fit: BoxFit.cover),
    );
  }

  Widget _getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _getDescription(String description) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
