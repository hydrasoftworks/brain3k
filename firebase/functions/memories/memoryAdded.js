const functions = require("firebase-functions");
const { MEMORY_TYPE } = require("../models/memoryType");

exports.memoryAdded = functions
  .runWith({ timeoutSeconds: 540, memory: "2GB" })
  .region("europe-west1")
  .firestore.document("users/{userId}/memories/{memoryId}")
  .onCreate(async (snapshot) => {
    let data = snapshot.data();

    switch (data.type) {
      case MEMORY_TYPE.url: {
        const result = await readMetadataForURL(data.value);
        data = { ...data, ...result };
        break;
      }
      default:
        break;
    }

    await snapshot.ref.set({ ...data, processed: true });
  });

async function readMetadataForURL(url) {
  const ogs = require("open-graph-scraper");

  const response = await ogs({ url });
  const result = response.result;
  if (result.success !== true) return {};
  return {
    title: result.ogTitle,
    description: result.ogDescription,
    thumbnail: result.ogImage.url,
    additionalInfo: result,
  };
}
