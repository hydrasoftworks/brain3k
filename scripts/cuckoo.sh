#!/usr/bin/env bash

INPUT_DIR="Shared"
OUTPUT_DIR="Tests/Helpers/Generated"
echo "Mocks Input Directory = ${INPUT_DIR}"

"./scripts/cuckoorunner.sh" --download generate --testable "Brain3k" \
    --output "${OUTPUT_DIR}/AccountServiceMock.swift" "${INPUT_DIR}/Services/AccountService.swift"

"./scripts/cuckoorunner.sh" --download generate --testable "Brain3k" \
    --output "${OUTPUT_DIR}/UserServiceMock.swift" "${INPUT_DIR}/Services/UserService.swift"

"./scripts/cuckoorunner.sh" --download generate --testable "Brain3k" \
    --output "${OUTPUT_DIR}/MemoriesServiceMock.swift" "${INPUT_DIR}/Services/MemoriesService.swift"
    
"./scripts/cuckoorunner.sh" --download generate --testable "Brain3k" \
    --output "${OUTPUT_DIR}/StorageServiceMock.swift" "${INPUT_DIR}/Services/StorageService.swift"
