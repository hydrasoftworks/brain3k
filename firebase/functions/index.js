import admin from "firebase-admin";
import analyzeURL from "./memories/url/analyze.js";
import clean from "./memories/clean.js";

export { analyzeURL, clean };

// This must be called at the end when all functions are exported
admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });
