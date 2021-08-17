const admin = require("firebase-admin");

admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });

module.exports = {
  ...require("./memories/metadata.js"),
  ...require("./memories/thumbnail.js"),
};
