import admin from "firebase-admin";
import functions from "firebase-functions";

export default functions
  .region("europe-west1")
  .firestore.document("users/{userId}/memories/{memoryId}")
  .onCreate((_, context) => {
    const userId = context.params.userId;
    const data = {
      counter: admin.firestore.FieldValue.increment(1),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    return admin.firestore().collection("users").doc(userId).update(data);
  });
