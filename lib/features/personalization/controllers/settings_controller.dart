import 'package:adminpickready/data/repositories/settings/setting_repository.dart';
import 'package:adminpickready/features/media/models/image_model.dart';
import 'package:adminpickready/utils/popups/full_screen_loader.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../media/controllers/media_controller.dart';
import '../models/setting_model.dart';

class SettingsController extends GetxController{
  static SettingsController get instance => Get.find();

  // Observable variables
  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();

  // Dependencies
  final settingRepository = Get.put(SettingsRepository());

  @override
  void onInit(){
    fetchSettingDetails();
    super.onInit();
  }

    /// Fetches setting details from the repository
    Future<SettingsModel> fetchSettingDetails() async{
      try {
        loading.value = true;
        final settings = await settingRepository.getSettings();
        this.settings.value = settings;

        appNameController.text = settings.appName;

        loading.value = false;

        return settings;
      } catch (e) {
        SLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
        return SettingsModel();
      }
    }

    /// Pick Thumbnail Image from Media
    void updateAppLogo() async{
      try {
        loading.value = true;
        final controller = Get.put(MediaController());
        List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

        // Handle selected images
        if(selectedImages != null && selectedImages.isNotEmpty){
          // Set the selected image to the main image or perform any other action
          ImageModel selectedImage = selectedImages.first;

          // Update Profile in Firestore
          await settingRepository.updateSingleField({'appLogo': selectedImage.url});

          // Update the main image using the selectedImage
          settings.value.appLogo = selectedImage.url;
          settings.refresh();

          SLoaders.successSnackBar(title: 'Congratulations', message: 'App Logo has been updated.');
        }
        loading.value = false;
      } catch (e) {
        loading.value = false;
        SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      }
    }

    void updateSettingInformation() async{
      try{
        loading.value = true;

        // Check Internet connection
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          SFullScreenLoader.stopLoading();
          return;
        }
        settings.value.appName = appNameController.text.trim();

        await settingRepository.updateSettingDetails(settings.value);
        settings.refresh();
        loading.value = false;
        SLoaders.successSnackBar(title: 'Saved', message: 'App Settings has been update');
      } catch (e){
        loading.value = false;
        SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      }
    }
}