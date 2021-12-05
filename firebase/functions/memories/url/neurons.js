import { htmlToText } from "html-to-text";
import { retext } from "retext";
import retextKeywords from "retext-keywords";
import retextPos from "retext-pos";

export default async function (html) {
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
  const neurons = [...keywords, ...phrases];

  return JSON.parse(
    JSON.stringify({
      neurons: [...new Set(neurons)],
    }),
  );
}
