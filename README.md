# Brain3k - your digital brain

[![Maintainability](https://api.codeclimate.com/v1/badges/6cdd7e8c029042453390/maintainability)](https://codeclimate.com/repos/60ec87f682e01601b700c48c/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/6cdd7e8c029042453390/test_coverage)](https://codeclimate.com/repos/60ec87f682e01601b700c48c/test_coverage)

Store information and search for them without the need for manual management.

## Dependencies

This project is using Swift Package Manager to handle code dependencies.

### Mint

This project is using Mint to manage Swift code generator dependencies.
Instal mint via brew:

```bash
brew install mint
```

### swiftformat

This project is using swiftformat to format code.
Reformat all swift files with:

```bash
./scripts/swiftformat.sh
```

### SwiftGen

This project is using SwiftGen to generate resource code.
Reformat all swift files with:

```bash
./scripts/swiftgen.sh
```

### Mocks

Test mocks are generated using Cuckoo library. To generate them call.

```bash
./scripts/cuckoo.sh
```

you can update Cuckoo runner script by calling

```bash
./scripts/updatecuckoo.sh
```

### Fastlane Match

Use bundler and fastlane match to download provisioning profiles.

Install ruby gems (only once)

```bash
bundle install
```

```bash
bundle exec fastlane match_get
```

To refresh certificates and provisioning profiles call

```bash
bundle exec fastlane match_refresh
```

## Git setup

We are using [conventional commits](https://h.daily-dev-tips.com/git-basics-conventional-commits) to keep commits well organized.
[Git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) are used to ensure that the commit message have proper syntax.

Please run following commands from root of this repository to set it up:

```bash
git config core.hooksPath .githooks/  # To change default .git hooks directory
chmod ug+x .githooks/commit-msg  # To allow execution in commit-msg file
```

