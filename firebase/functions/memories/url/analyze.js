import { MEMORY_TYPE } from "../../models/memoryType.js";
import admin from "firebase-admin";
import axios from "axios";
import functions from "firebase-functions";
import getMetadata from "./metadata.js";
import getNeurons from "./neurons.js";
import getThumbnail from "./thumbnail.js";

export default functions
  .runWith({ timeoutSeconds: 540, memory: "2GB" })
  .region("europe-west1")
  .firestore.document("users/{userId}/memories/{memoryId}")
  .onWrite(async ({ after }) => {
    if (!after.exists) return;

    let data = after.data();
    if (data.type !== MEMORY_TYPE.url || data.processed === true) return;

    const url = data.value;
    const html = await readHTMLFromURL(url);
    const metadata = await getMetadata(url, html);
    const neurons = await getNeurons(html);

    let thumbnail = {};
    if (metadata.thumbnail === undefined) {
      thumbnail = await getThumbnail(after.ref, url, html);
    }

    data = {
      ...data,
      ...metadata,
      ...neurons,
      ...thumbnail,
    };

    await after.ref.update({
      ...data,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      processed: true,
    });
  });

async function readHTMLFromURL(url) {
  const apiKey = functions.config().scrapingrobot.apikey;

  try {
    const { data } = await axios.post(
      "https://api.scrapingrobot.com",
      scrapingRobotConfig(url),
      {
        headers: { "Content-Type": "application/json" },
        params: { token: apiKey },
        maxContentLength: 1024 * 1024 * 10,
      },
    );
    if (data.status === "SUCCESS") {
      return data.result;
    } else {
      throw new Error(data.error);
    }
  } catch (error) {
    const errorText = error ?? "unavailable";
    console.error(`Scraping Robot error: ${errorText}`);
    return defaultHTML(errorText);
  }
}

function scrapingRobotConfig(url) {
  return {
    url,
    module: "HtmlChromeScraper",
    render: true,
    waitUntil: "networkiddle2",
    noImages: false,
    noFonts: false,
    noCss: false,
  };
}

function defaultHTML(message) {
  return `
    <!doctype html>
    <html lang="en">
        <head>
            <meta charset="utf-8">
            <title>${message}</title>
            <meta property="og:title" content="${message}" />
            <meta property="og:image" content="https://brain3k.com/assets/error.png" />
        </head>
        <body>
        <h1>${message}</h1>
        </body>
    </html>
    `;
}
