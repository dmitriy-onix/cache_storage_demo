build_android_apk:
	@echo "Build Android APK"
	@flutter build apk --release  

build_android_aab:
	@echo "Build Android AAB"
	@flutter build appbundle --release  

build_android_with_distribution: build_android_firebase_only build_android_store_only

build_android_firebase_only: build_android_apk
	@echo "Distributing"
	@cd android && bundle exec fastlane build firebase:true artifact_type:apk 

build_android_store_only: build_android_aab
	@echo "Distributing"
	@cd android && bundle exec fastlane build store:true artifact_type:aab 
