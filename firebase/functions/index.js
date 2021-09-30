import admin from "firebase-admin";

import metadata from "./memories/metadata.js";
import thumbnail from "./memories/thumbnail.js";
import tags from "./memories/tags.js";
import clean from "./memories/clean.js";

export { metadata, thumbnail, tags, clean };

// This must be called at the end when all functions are exported
admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });
