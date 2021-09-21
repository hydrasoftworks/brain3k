import functions from "firebase-functions";
import admin from "firebase-admin";
import { MEMORY_TYPE } from "../models/memoryType.js";
import ogs from "open-graph-scraper";

export default functions
  .runWith({ timeoutSeconds: 540, memory: "2GB" })
  .region("europe-west1")
  .firestore.document("users/{userId}/memories/{memoryId}")
  .onWrite(async ({ after }) => {
    if (after === undefined) return;

    let data = after.data();
    if (data.processed === true) return;

    switch (data.type) {
      case MEMORY_TYPE.url: {
        const result = await readMetadataForURL(data.value);
        data = { ...data, ...result };
        break;
      }
      default:
        break;
    }

    await after.ref.update({
      ...data,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      processed: true,
    });
  });

async function readMetadataForURL(url) {
  const response = await ogs({ url });
  const result = response.result;
  if (result.success !== true) return {};
  return JSON.parse(
    JSON.stringify({
      title: result.ogTitle,
      description: result.ogDescription,
      thumbnail: result.ogImage.url,
      additionalInfo: result,
    }),
  );
}
