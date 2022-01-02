import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:juliaca_store0/app/dependency_injection.dart';
import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render_impl.dart';
import 'package:juliaca_store0/presentation/main/home/home_viewmodel.dart';
import 'package:juliaca_store0/presentation/resources/color_manager.dart';
import 'package:juliaca_store0/presentation/resources/routes_manager.dart';
import 'package:juliaca_store0/presentation/resources/strings_manager.dart';
import 'package:juliaca_store0/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
class HomePafe extends StatefulWidget {
  const HomePafe({Key? key}) : super(key: key);

  @override
  _HomePafeState createState() => _HomePafeState();
}

class _HomePafeState extends State<HomePafe> {
  final _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.getHome();
              }) ??
              const SizedBox()),
    ));
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services.tr()),
        _getServices(),
        _getSection(AppStrings.stores.tr()),
        _getStores()
      ],
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<Data>(
        stream: _viewModel.outputData,
        builder: (context, snapshot) => _getBanner(snapshot.data?.banners));
  }

  Widget _getBanner(List<BannerData>? banners) {
    return banners != null
        ? CarouselSlider(
            items: banners
                .map((banner) => SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: AppSize.s1_5,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorManager.white,
                                width: AppSize.s1_5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(banner.image, fit: BoxFit.cover),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                height: AppSize.s190,
                autoPlay: true,
                enableInfiniteScroll: true,
                enlargeCenterPage: true))
        : const SizedBox();
  }

  Widget _getSection(String title) {
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

  Widget _getServices() {
    return StreamBuilder<Data>(
        stream: _viewModel.outputData,
        builder: (context, snapshot) =>
            _getServicesWidget(snapshot.data?.services));
  }

  Widget _getServicesWidget(List<BannerData>? services) {
    return services != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: Container(
              height: AppSize.s140,
              margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: services
                    .map((service) => Card(
                          elevation: AppSize.s4,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorManager.white,
                                  width: AppSize.s1_5),
                              borderRadius: BorderRadius.circular(AppSize.s12)),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12),
                                child: Image.network(
                                  service.image,
                                  fit: BoxFit.cover,
                                  width: AppSize.s120,
                                  height: AppSize.s100,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: AppPadding.p8),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(service.title,
                                      textAlign: TextAlign.center),
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _getStores() {
    return StreamBuilder<Data>(
        stream: _viewModel.outputData,
        builder: (context, snapshot) =>
            _getStoresWidget(snapshot.data?.stores));
  }

  Widget _getStoresWidget(List<BannerData>? stores) {
    return stores != null
        ? Padding(
            padding: const EdgeInsets.only(
                left: AppPadding.p12,
                right: AppPadding.p12,
                top: AppPadding.p12),
            child: Flex(
              direction: Axis.vertical,
              children: [
                GridView.count(
                  crossAxisSpacing: AppSize.s8,
                  mainAxisSpacing: AppSize.s8,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                      stores.length,
                      (index) => InkWell(
                            onTap: () => Navigator.of(context).pushNamed( Routes.storeDetailsRoute),
                            child: Card(
                              elevation: AppSize.s4,
                              child: Image.network(
                                stores[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
