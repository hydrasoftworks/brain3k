import admin from "firebase-admin";
import functions from "firebase-functions";

export default functions
  .region("europe-west1")
  .auth.user()
  .onCreate((user) => {
    const userId = user.uid;
    const data = {
      counter: 0,
      limit: 100,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    return admin.firestore().collection("users").doc(userId).create(data);
  });
