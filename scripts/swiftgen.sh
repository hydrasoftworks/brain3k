#!/usr/bin/env bash
# Install mint via brew first with `brew install mint`

mint run swiftgen run strings -t structured-swift5 --output Shared/Resources/StringsGen.swift Shared/en.lproj/Localizable.strings
mint run swiftgen run xcassets -t swift5 --output Shared/Resources/ImagesGen.swift Shared/Assets.xcassets
