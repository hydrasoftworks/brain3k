# Brain3k - your digital brain

Store information and search for them without the need for manual management.

## Dependencies

This project is using Swift Package Manager to handle code dependencies.

### swiftgen

This project is using swiftgen to generate resourse classes.
Install swiftgen via brew:

```bash
brew install swiftgen
```

Regenerate resource classes with:

```bash
./swiftgen.sh
```

### swiftformat

This project is using swiftformat to format code.
Instal swiftformat via brew:

```bash
brew install swiftformat
```

Reformat all swift files with:

```bash
./swiftformat.sh
```

### Fastlane Match

Use bundler and fastlane match to download provisioning profiles.

Install ruby gems (only once)

```bash
bundle install
```

```bash
bundle exec fastlane match development --readonly
bundle exec fastlane match adhoc --readonly
bundle exec fastlane match appstore --readonly
```
