import ogs from "open-graph-scraper";

export default async function (url, html) {
  let response;
  try {
    response = await ogs({ html });
  } catch (error) {
    console.error(
      `Open Graph Scrapper error for URL ${url}. Description: ${
        error ?? "unavailable"
      }`,
    );
    return {};
  }

  const result = response.result;
  if (response.error || result.success !== true) return {};
  return JSON.parse(
    JSON.stringify({
      title: result.ogTitle,
      description: result.ogDescription,
      thumbnail: result.ogImage?.url,
      additionalInfo: result,
    }),
  );
}
