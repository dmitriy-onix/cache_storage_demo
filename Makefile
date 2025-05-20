clean:
	@echo "Cleaning"
	@flutter clean

build_and_distribute: clean
	@make build_android_with_distribution -f Makefile_android.mk
	@make build_ios_with_distribution -f Makefile_ios.mk

release_notes:
	@git cliff --latest -c cliff_txt.toml -o release_notes.txt

changelog:
	@git cliff -c cliff_md.toml -o CHANGELOG.md

codegen:
	@echo "Running codegen"
	@dart run build_runner build --delete-conflicting-outputs