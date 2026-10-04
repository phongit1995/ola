import argparse
import html
import json
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime, timedelta, timezone
from html.parser import HTMLParser
from pathlib import Path

SITE = "https://vnkings.com"
REST = f"{SITE}/?rest_route="
AJAX = f"{SITE}/wp-admin/admin-ajax.php"
USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0 Safari/537.36"
STORY_CATEGORY_IDS = [
    1, 3, 126, 137, 21, 132, 319, 131, 5, 127, 258, 110, 2, 112, 2639, 267, 129, 111, 22008, 130, 1776,
    844, 1549, 1548, 4037, 17770, 17774, 17826, 209,
]
SHORT_STORY_CATEGORY_ID = 3
SKIP_GENRE_IDS = {1}
CHAPTERS_PER_AJAX_PAGE = 10
MIN_SHORT_STORY_CHARS = 1500
VIETNAM_TZ = timezone(timedelta(hours=7))
DECORATION = re.compile(r"^[\s_\-–—=*.~•·]+$")


class Client:
    def __init__(self, gap_seconds: float):
        self.gap = gap_seconds
        self.last = 0.0
        self.count = 0

    def request(self, url: str, data: dict | None = None) -> bytes:
        for attempt in range(4):
            wait = self.last + self.gap - time.time()
            if wait > 0:
                time.sleep(wait)
            self.last = time.time()
            self.count += 1
            body = urllib.parse.urlencode(data).encode() if data else None
            headers = {"User-Agent": USER_AGENT}
            if body:
                headers["Content-Type"] = "application/x-www-form-urlencoded"
            try:
                with urllib.request.urlopen(urllib.request.Request(url, data=body, headers=headers), timeout=40) as response:
                    return response.read()
            except urllib.error.HTTPError as error:
                if error.code in (403, 429, 503):
                    if attempt == 3:
                        sys.exit(f"Bị chặn ({error.code}) ở {url}, dừng lại.")
                    time.sleep(15 * (attempt + 1))
                    continue
                raise
            except (urllib.error.URLError, TimeoutError):
                time.sleep(5 * (attempt + 1))
        raise RuntimeError(f"Không tải được {url}")

    def json(self, url: str, data: dict | None = None):
        return json.loads(self.request(url, data))

    def text(self, url: str) -> str:
        return self.request(url).decode("utf-8", "replace")


class ParagraphParser(HTMLParser):
    BLOCKS = {"p", "div", "h1", "h2", "h3", "h4", "h5", "h6", "li", "blockquote", "tr"}
    SKIP = {"script", "style", "ins", "iframe", "noscript"}

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.paragraphs: list[str] = []
        self.buffer: list[str] = []
        self.skip_depth = 0

    def flush(self):
        text = re.sub(r"\s+", " ", "".join(self.buffer).replace("\xa0", " ")).strip()
        self.buffer = []
        if text and not DECORATION.match(text):
            self.paragraphs.append(text)

    def handle_starttag(self, tag, attrs):
        if tag in self.SKIP:
            self.skip_depth += 1
        elif tag == "br":
            self.flush()
        elif tag in self.BLOCKS:
            self.flush()

    def handle_endtag(self, tag):
        if tag in self.SKIP:
            self.skip_depth = max(0, self.skip_depth - 1)
        elif tag in self.BLOCKS:
            self.flush()

    def handle_data(self, data):
        if self.skip_depth == 0:
            self.buffer.append(data)


def html_paragraphs(fragment: str) -> list[str]:
    parser = ParagraphParser()
    parser.feed(fragment)
    parser.flush()
    return parser.paragraphs


def plain(fragment: str) -> str:
    return re.sub(r"\s+", " ", html.unescape(re.sub(r"<[^>]+>", " ", fragment))).strip()


def element_inner(page: str, marker: str) -> str:
    start = page.find(marker)
    if start < 0:
        return ""
    open_at = page.rfind("<div", 0, start)
    depth = 0
    for match in re.finditer(r"<(/?)div\b", page[open_at:]):
        depth += -1 if match.group(1) else 1
        if depth == 0:
            inner = page[open_at:open_at + match.start()]
            return inner[inner.find(">") + 1:]
    return page[open_at:]


def info_value(page: str, label: str) -> str:
    match = re.search(r"<span>" + re.escape(label) + r"</span>\s*:(.*?)</li>", page, re.S)
    return plain(match.group(1)) if match else ""


def to_int(text: str) -> int:
    digits = re.sub(r"[^\d]", "", text)
    return int(digits) if digits else 0


def iso_utc(gmt: str) -> str:
    return gmt + "Z" if gmt and not gmt.endswith("Z") else gmt


def chapter_date(label: str) -> str | None:
    match = re.match(r"(\d{1,2})/(\d{1,2})/(\d{4})", label.strip())
    if not match:
        return None
    day, month, year = (int(part) for part in match.groups())
    return datetime(year, month, day, tzinfo=VIETNAM_TZ).astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def meta_time(page: str, name: str) -> str | None:
    match = re.search(r'<meta property="' + name + r'" content="([^"]+)"', page)
    if not match:
        return None
    return datetime.fromisoformat(match.group(1)).astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def parse_story_page(page: str) -> dict:
    status_text = info_value(page, "Tình trạng").lower()
    if "chưa" in status_text:
        status = "ongoing"
    elif "hoàn thành" in status_text or "full" in status_text:
        status = "completed"
    else:
        status = "unknown"
    cover = re.search(r'<img class="lazyload" data-original="([^"]+)"', page)
    og_image = re.search(r'<meta property="og:image" content="([^"]+)"', page)
    nonce = re.search(r'data-story-id="\d+" data-nonce="([0-9a-f]+)"', page)
    likes = re.search(r"Lượt thích</span><strong>:\s*([\d.]+)", page)
    return {
        "authorName": info_value(page, "Tác giả"),
        "status": status,
        "statusText": info_value(page, "Tình trạng"),
        "viewCount": to_int(info_value(page, "Lượt xem").split("·")[0]),
        "commentCount": to_int(info_value(page, "Bình luận").split("·")[0]),
        "likeCount": to_int(likes.group(1)) if likes else 0,
        "ageRating": info_value(page, "Rating"),
        "source": info_value(page, "Nguồn"),
        "coverUrl": cover.group(1) if cover else (og_image.group(1) if og_image else None),
        "nonce": nonce.group(1) if nonce else None,
    }


def chapter_links(client: Client, story_id: int, nonce: str) -> list[dict] | None:
    chapters: list[dict] = []
    page = 1
    while True:
        result = client.json(AJAX, {"action": "vnk_single_chapters", "story_id": story_id, "page": page, "chapter_nonce": nonce})
        if not result.get("success"):
            return None if page == 1 else chapters
        items = result["data"]["items"]
        for href, title, date_label in re.findall(
            r'<a href="([^"]+)">(.*?)</a>\s*<i class="pull-right">(.*?)</i>', items, re.S
        ):
            chapter_id = re.search(r"-p(\d+)\.html", href)
            chapters.append({
                "sourceId": chapter_id.group(1) if chapter_id else href,
                "url": href,
                "title": plain(title),
                "dateLabel": plain(date_label),
            })
        total_pages = int(result["data"].get("totalPages") or 1)
        if page >= total_pages:
            return chapters
        page += 1


def word_count(paragraphs: list[str]) -> int:
    return sum(len(paragraph.split()) for paragraph in paragraphs)


def drop_repeated_title(paragraphs: list[str], title: str) -> list[str]:
    if paragraphs and plain(paragraphs[0]).lower() == title.lower():
        return paragraphs[1:]
    return paragraphs


def main():
    parser = argparse.ArgumentParser(description="Xuất truyện Vnkings ra JSON cho UI đọc truyện")
    parser.add_argument("--limit", type=int, default=100)
    parser.add_argument("--max-chapters", type=int, default=0, help="0 = lấy hết chương")
    parser.add_argument("--gap", type=float, default=0.5, help="giây giữa 2 request")
    parser.add_argument("--out", default="web/public/story-data")
    parser.add_argument("--resume", action="store_true", help="giữ truyện đã có trong index.json, chỉ lấy thêm cho đủ --limit")
    args = parser.parse_args()

    out = Path(args.out)
    (out / "chapters").mkdir(parents=True, exist_ok=True)
    client = Client(args.gap)

    categories = {item["id"]: html.unescape(item["name"]) for item in client.json(
        f"{REST}/wp/v2/categories&per_page=100&_fields=id,name"
    )}

    stories: list[dict] = []
    chapter_index: dict[str, list[dict]] = {}
    index_path = out / "index.json"
    if args.resume and index_path.exists():
        existing = json.loads(index_path.read_text(encoding="utf-8"))
        for story in existing["stories"]:
            if story["id"] in chapter_index:
                continue
            stories.append(story)
            chapter_index[story["id"]] = existing["chapters"][story["id"]]
        stories = stories[: args.limit]
        print(f"Giữ lại {len(stories)} truyện có sẵn", flush=True)
    seen = {story["id"] for story in stories}
    rest_page = 1
    while len(stories) < args.limit:
        posts = client.json(
            f"{REST}/wp/v2/posts&categories={','.join(map(str, STORY_CATEGORY_IDS))}"
            f"&orderby=modified&order=desc&per_page=50&page={rest_page}"
            "&_fields=id,slug,link,title,content,excerpt,date_gmt,modified_gmt,categories,tags"
        )
        if not posts:
            break
        rest_page += 1
        for post in posts:
            if len(stories) >= args.limit:
                break
            story_id = post["id"]
            if str(story_id) in seen:
                continue
            seen.add(str(story_id))
            title = plain(post["title"]["rendered"])
            info = parse_story_page(client.text(post["link"]))
            links = chapter_links(client, story_id, info["nonce"]) if info["nonce"] else None
            post_paragraphs = html_paragraphs(post["content"]["rendered"])
            is_short_category = SHORT_STORY_CATEGORY_ID in post["categories"]

            if links:
                kind = "long"
                selected = links[: args.max_chapters] if args.max_chapters else links
                contents: dict[str, str] = {}
                summaries: list[dict] = []
                for position, link in enumerate(selected, start=1):
                    page = client.text(link["url"])
                    paragraphs = drop_repeated_title(html_paragraphs(element_inner(page, 'id="content"')), link["title"])
                    contents[str(position)] = "\n\n".join(paragraphs)
                    summaries.append({
                        "id": link["sourceId"],
                        "storyId": str(story_id),
                        "position": position,
                        "title": link["title"],
                        "wordCount": word_count(paragraphs),
                        "publishedAt": meta_time(page, "article:published_time") or chapter_date(link["dateLabel"]),
                    })
                intro = "\n\n".join(post_paragraphs)
            elif is_short_category or sum(len(p) for p in post_paragraphs) >= MIN_SHORT_STORY_CHARS:
                kind = "short"
                contents = {"1": "\n\n".join(post_paragraphs)}
                summaries = [{
                    "id": str(story_id),
                    "storyId": str(story_id),
                    "position": 1,
                    "title": title,
                    "wordCount": word_count(post_paragraphs),
                    "publishedAt": iso_utc(post["date_gmt"]),
                }]
                intro = plain(post["excerpt"]["rendered"]).replace("[…]", "…")
            else:
                print(f"  bỏ qua {story_id} {title}: chưa có chương", flush=True)
                continue

            genres = [categories[cid] for cid in post["categories"] if cid in categories and cid not in SKIP_GENRE_IDS]
            stories.append({
                "id": str(story_id),
                "slug": post["slug"],
                "title": title,
                "authorName": info["authorName"],
                "kind": kind,
                "genres": genres,
                "tags": [],
                "tagIds": post["tags"],
                "intro": intro,
                "coverUrl": info["coverUrl"],
                "status": info["status"],
                "chapterCount": len(summaries),
                "wordCount": sum(item["wordCount"] for item in summaries),
                "viewCount": info["viewCount"],
                "commentCount": info["commentCount"],
                "likeCount": info["likeCount"],
                "ageRating": info["ageRating"],
                "sourceLabel": info["source"],
                "sourceUrl": post["link"],
                "publishedAt": iso_utc(post["date_gmt"]),
                "updatedAt": iso_utc(post["modified_gmt"]),
                "lastChapterAt": max((s["publishedAt"] for s in summaries if s["publishedAt"]), default=None),
            })
            chapter_index[str(story_id)] = summaries
            (out / "chapters" / f"{story_id}.json").write_text(json.dumps(contents, ensure_ascii=False), encoding="utf-8")
            print(f"{len(stories):>3}/{args.limit} {kind:5} {len(summaries):>4} chương  {title}  (đã gọi {client.count} request)", flush=True)

    tag_ids = sorted({tag for story in stories for tag in story.get("tagIds", [])})
    tag_names: dict[int, str] = {}
    for start in range(0, len(tag_ids), 100):
        batch = tag_ids[start:start + 100]
        for tag in client.json(f"{REST}/wp/v2/tags&include={','.join(map(str, batch))}&per_page=100&_fields=id,name"):
            tag_names[tag["id"]] = html.unescape(tag["name"])
    for story in stories:
        if "tagIds" in story:
            story["tags"] = [tag_names[tag] for tag in story.pop("tagIds") if tag in tag_names]

    index = {
        "source": "vnkings.com",
        "generatedAt": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "stories": stories,
        "chapters": {story["id"]: chapter_index[story["id"]] for story in stories},
    }
    (out / "index.json").write_text(json.dumps(index, ensure_ascii=False), encoding="utf-8")
    total_chapters = sum(len(index["chapters"][story["id"]]) for story in stories)
    print(f"Xong: {len(stories)} truyện, {total_chapters} chương, {client.count} request -> {out}", flush=True)


if __name__ == "__main__":
    main()
