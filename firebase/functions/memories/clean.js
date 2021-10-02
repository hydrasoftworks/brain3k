import functions from "firebase-functions";
import admin from "firebase-admin";

export default functions
  .region("europe-west1")
  .firestore.document("users/{userId}/memories/{memoryId}")
  .onDelete(async (_, context) => {
    const bucket = admin.storage().bucket();
    const [files] = await bucket.getFiles({
      prefix: `users/${context.params.userId}/memories/${context.params.memoryId}/`,
    });

    const promises = files.map((file) => file.delete());
    return Promise.all(promises);
  });
