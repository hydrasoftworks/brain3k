import admin from "firebase-admin";

import metadata from "./memories/metadata.js";
import thumbnail from "./memories/thumbnail.js";

export {
  metadata,
  thumbnail,
};

// This must be called at the end when all functions are exported
admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });
