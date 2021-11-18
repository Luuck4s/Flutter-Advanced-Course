import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_course/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_course/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() {
    return [
      SliderObject(
        AppStrings.onBoardingTitle1,
        AppStrings.onBoardingSubTitle1,
        ImagesAssets.onboardingLogo1,
      ),
      SliderObject(
        AppStrings.onBoardingTitle2,
        AppStrings.onBoardingSubTitle2,
        ImagesAssets.onboardingLogo2,
      ),
      SliderObject(
        AppStrings.onBoardingTitle3,
        AppStrings.onBoardingSubTitle3,
        ImagesAssets.onboardingLogo3,
      ),
      SliderObject(
        AppStrings.onBoardingTitle4,
        AppStrings.onBoardingSubTitle4,
        ImagesAssets.onboardingLogo4,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex:
            index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            _getBottomSheetWidget()
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImagesAssets.leftArrowIc),
              ),
              onTap: () {
                _pageController.animateToPage(
                  _getPreviousIndex(),
                  duration: const Duration(milliseconds: DurationConstrant.d300),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < _list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImagesAssets.rightArrowIc),
              ),
              onTap: () {
                _pageController.animateToPage(
                  _getNextIndex(),
                  duration: const Duration(milliseconds: DurationConstrant.d300),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  int _getPreviousIndex() {
    int previousIndex = _currentIndex--;
    
    if (previousIndex == 0) {
      _currentIndex = _list.length - 1;
    }

    return _currentIndex;
  }

  int _getNextIndex() {
    int nextIndex = _currentIndex++;

    if (nextIndex == _list.length - 1) {
      _currentIndex = 0;
    }

    return _currentIndex;
  }

  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImagesAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImagesAssets.solidCircleIc);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;

  OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}
