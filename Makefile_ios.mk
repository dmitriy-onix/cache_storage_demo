build_ios:
	@echo "Building"
	@flutter build ios --release  

build_ios_with_distribution: build_ios
	@cd ios && bundle exec fastlane build firebase:true test_flight:true 

build_ios_firebase_only: build_ios
	@echo "Distributing to the Firebase App Distribution"
	@cd ios && bundle exec fastlane build firebase:true 

build_ios_test_flight_only: build_ios
	@echo "Distributing to the TestFlight"
	@cd ios && bundle exec fastlane build test_flight:true
