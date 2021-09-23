import admin from "firebase-admin";

import metadata from "./memories/metadata.js";
import thumbnail from "./memories/thumbnail.js";
import tags from "./memories/tags.js";

export { metadata, thumbnail, tags };

// This must be called at the end when all functions are exported
admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });
