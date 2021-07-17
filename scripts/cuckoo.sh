#!/usr/bin/env bash

OUTPUT_FILE="Tests/Helpers/GeneratedMocks.swift"

INPUT_DIR="Shared"
echo "Mocks Input Directory = ${INPUT_DIR}"

"./scripts/cuckoorunner.sh" --download generate --testable "Brain3k" \
--output "${OUTPUT_FILE}" \
"${INPUT_DIR}/Services/AccountService.swift" \
"${INPUT_DIR}/Services/MemoriesService.swift"

echo "Generated Mocks File = ${OUTPUT_FILE}"
