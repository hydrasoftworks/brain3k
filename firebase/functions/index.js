const admin = require("firebase-admin");

module.exports = {
  ...require("./memories/metadata.js"),
  ...require("./memories/thumbnail.js"),
};

// This must be called at the end when all functions are exported
admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });
