import functions from "firebase-functions";
import admin from "firebase-admin";
import { MEMORY_TYPE } from "../models/memoryType.js";
import { retext } from "retext";
import retextPos from "retext-pos";
import retextKeywords from "retext-keywords";
import { htmlToText } from "html-to-text";
import puppeteer from "puppeteer";

export default functions
  .runWith({ timeoutSeconds: 540, memory: "2GB" })
  .region("europe-west1")
  .firestore.document("users/{userId}/memories/{memoryId}")
  .onUpdate(async ({ after }) => {
    let data = after.data();

    if (data.processed !== true || data.tags !== undefined) return;

    switch (data.type) {
      case MEMORY_TYPE.url: {
        const result = await readTagsForURL(data.value);
        data = { ...data, ...result };
        break;
      }
      default:
        break;
    }

    await after.ref.update({
      ...data,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

async function readTagsForURL(url) {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.setViewport({
    width: 1280,
    height: 800,
  });

  await page.goto(url, { waitUntil: "networkidle2" });
  const html = await page.content();
  await browser.close();

  const text = htmlToText(html, {
    wordwrap: false,
    selectors: [
      { selector: "a", options: { ignoreHref: true } },
      { selector: "img", format: "skip" },
    ],
  });

  const result = await retext()
    .use(retextPos)
    .use(retextKeywords, { maximum: 15 })
    .process(text);

  const keywords = result.data?.keywords?.map((keyword) => keyword.stem) ?? [];
  const phrases = result.data?.keyphrases?.map((phrase) => phrase.value) ?? [];
  const tags = [...keywords, ...phrases];

  return JSON.parse(
    JSON.stringify({
      tags: [...new Set(tags)],
    }),
  );
}
