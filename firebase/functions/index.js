import admin from "firebase-admin";
import analyzeURL from "./memories/url/analyze.js";
import clean from "./memories/clean.js";
import decrementCounter from "./users/decrement.js";
import incrementCounter from "./users/increment.js";
import setupUser from "./users/setup.js";
import subscriptions from "./users/subscriptions.js";

export {
  analyzeURL,
  clean,
  setupUser,
  incrementCounter,
  decrementCounter,
  subscriptions,
};

// This must be called at the end when all functions are exported
admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });
