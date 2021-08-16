const admin = require("firebase-admin");

admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });

module.exports = {
  ...require("./memories/memoryAdded.js"),
  ...require("./memories/memoryUpdated.js"),
};
