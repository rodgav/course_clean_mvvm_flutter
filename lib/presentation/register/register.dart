import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:juliaca_store0/app/app_prefs.dart';
import 'package:juliaca_store0/app/dependency_injection.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render_impl.dart';
import 'package:juliaca_store0/presentation/register/register_viewmodel.dart';
import 'package:juliaca_store0/presentation/resources/assets_manager.dart';
import 'package:juliaca_store0/presentation/resources/color_manager.dart';
import 'package:juliaca_store0/presentation/resources/routes_manager.dart';
import 'package:juliaca_store0/presentation/resources/strings_manager.dart';
import 'package:juliaca_store0/presentation/resources/values_manager.dart';import 'package:easy_localization/easy_localization.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _viewModel = instance<RegisterViewModel>();
  final _picker = instance<ImagePicker>();
  final _appPreferences = instance<AppPreferences>();
  final _usernameCtrl = TextEditingController();
  final _mobileNumberCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _usernameCtrl.addListener(() {
      _viewModel.setUsername(_usernameCtrl.text.trim());
    });
    _mobileNumberCtrl.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberCtrl.text.trim());
    });
    _emailCtrl.addListener(() {
      _viewModel.setEmail(_emailCtrl.text.trim());
    });
    _passwordCtrl.addListener(() {
      _viewModel.setPassword(_passwordCtrl.text.trim());
    });
    _viewModel.isUserLoggedInSuccesStreCtrl.stream
        .listen((isSuccessLogin) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _usernameCtrl.dispose();
    _mobileNumberCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.register;
              }) ??
              _getContentWidget()),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p30),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(ImageAssets.splashLogo),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorUsername,
                  builder: (_, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _usernameCtrl,
                      decoration: InputDecoration(
                          hintText: AppStrings.username.tr(),
                          labelText: AppStrings.username.tr(),
                          errorText: snapshot.data),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CountryCodePicker(
                        onChanged: (country) {
                          _viewModel.setCountryCode(
                              country.dialCode ?? AppStrings.empty);
                        },
                        hideMainText: true,
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        favorite: const ['+51'],
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: StreamBuilder<String?>(
                          stream: _viewModel.outputErrorMobileNumber,
                          builder: (_, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _mobileNumberCtrl,
                              decoration: InputDecoration(
                                  hintText: AppStrings.mobileNumber.tr(),
                                  labelText: AppStrings.mobileNumber.tr(),
                                  errorText: snapshot.data),
                            );
                          },
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorEmail,
                  builder: (_, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailCtrl,
                      decoration: InputDecoration(
                          hintText: AppStrings.emailHint.tr(),
                          labelText: AppStrings.emailHint.tr(),
                          errorText: snapshot.data),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (_, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordCtrl,
                      decoration: InputDecoration(
                          hintText: AppStrings.password.tr(),
                          labelText: AppStrings.password.tr(),
                          errorText: snapshot.data),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.lightGrey)),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                        _showPicker(context);
                      },
                    ),
                  )),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputValid,
                    builder: (_, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? _viewModel.register
                                : null,
                            child: const Text(AppStrings.register).tr()),
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    right: AppPadding.p28,
                    left: AppPadding.p28),
                child:  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      AppStrings.haveAccount,
                      style: Theme.of(context).textTheme.subtitle2,
                    ).tr()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePicture).tr()),
          Flexible(
              child: StreamBuilder<File>(
                  stream: _viewModel.outputProfilePicture,
                  builder: (context, snapshot) =>
                      _imagePickedUser(snapshot.data))),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
        ],
      ),
    );
  }

  Widget _imagePickedUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
                child: Wrap(
              children: [
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.camera),
                  title: Text(AppStrings.photoGalley).tr(),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text(AppStrings.photoCamera).tr(),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            )));
  }

  void _imageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ''));
  }

  void _imageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ''));
  }
}
