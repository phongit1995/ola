import argparse
import html
import http.client
import json
import math
import re
import sys
import time
import unicodedata
import urllib.error
import urllib.request
from datetime import datetime, timezone
from html.parser import HTMLParser
from pathlib import Path

SITE = "https://dembuon.vn"
USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0 Safari/537.36"
SECTIONS = {
    206: ("truyen-cua-toi", "ongoing"),
    213: ("hoan-thanh", "completed"),
    244: ("truyen-hay", "unknown"),
    210: ("truyen-ngan", "unknown"),
    211: ("cho-duyet", "unknown"),
}
DEFAULT_SECTIONS = [206, 213, 244]
SHORT_SECTION_ID = 210
STATUS_LABEL = "full"
MIN_CHAPTER_CHARS = 1500
MIN_SHORT_STORY_CHARS = 1500
MAX_TITLE_CHARS = 200
INTRO_WORDS = 55
CHECKPOINT_EVERY = 20
DEFAULT_LIMIT = 100
CHALLENGE_MARKERS = ("cf-chl-", "<title>Just a moment")
LOGGED_IN_MARKER = 'data-logged-in="true"'
DECORATION = re.compile(r"^[\s_\-–—=*.~•·]+$")
ZERO_WIDTH = re.compile("[​‌‍⁠﻿]")
BBCODE = re.compile(
    r"\[/?(?:color|size|font|b|i|u|s|center|left|right|justify|indent|url|img|spoiler|quote|hide\w*|ispoiler|protect|chu-thich)(?:=[^\]]*)?\s*\]",
    re.I,
)
NUMBERED_HEADING = (
    r"(?:chương|chuong|chap|chapter|phần|hồi|tập|quyển)\s*[:.]?\s*"
    r"(?:\d+|[ivxlcdm]+\b|một|hai|ba|bốn|năm|sáu|bảy|tám|chín|mười|cuối|kết|đặc biệt)"
)
NAMED_HEADING = (
    r"(?:tự chương|ngoại truyện|phiên ngoại|vĩ thanh|lời mở đầu|mở đầu|khai từ|lời kết|kết thúc|đoạn kết|prologue|epilogue)"
    r"(?=\s*(?:$|[\d:.(\-–—]))"
)
CHAPTER_HEADING = re.compile(rf"^(?:{NUMBERED_HEADING}|{NAMED_HEADING}|\d+\s*[.:)\-–])", re.I)
EMBEDDED_HEADING = re.compile(rf"[\-–—:|]\s*((?:{NUMBERED_HEADING}|{NAMED_HEADING}).*)$", re.I)
TITLE_WRAPPERS = "#\"“” "
SENTENCE_END = (".", ":", ",", ";", "!", "?", "…")
MAX_PLAIN_TITLE_CHARS = 80
META_LINE = re.compile(r"^(?:truyện|tên truyện|tác giả|thể loại|tình trạng|số chương|độ dài|nguồn|rating|cảnh báo)\s*:", re.I)
INTRO_LABEL = re.compile(r"^(?:văn án|giới thiệu|tóm tắt|mục lục)\s*:?\s*", re.I)
POST_START = re.compile(r'<article class="message message--post')


class Client:
    def __init__(self, gap_seconds: float, cookie: str | None = None):
        self.gap = gap_seconds
        self.last = 0.0
        self.count = 0
        self.headers = {"User-Agent": USER_AGENT}
        if cookie:
            self.headers["Cookie"] = cookie

    def text(self, url: str) -> str:
        for attempt in range(4):
            wait = self.last + self.gap - time.time()
            if wait > 0:
                time.sleep(wait)
            self.last = time.time()
            self.count += 1
            try:
                with urllib.request.urlopen(urllib.request.Request(url, headers=self.headers), timeout=40) as response:
                    page = response.read().decode("utf-8", "replace")
            except urllib.error.HTTPError as error:
                if error.code in (403, 429, 503):
                    if attempt == 3:
                        sys.exit(f"Bị chặn ({error.code}) ở {url}, dừng lại.")
                    time.sleep(15 * (attempt + 1))
                    continue
                if error.code >= 500:
                    time.sleep(10 * (attempt + 1))
                    continue
                raise
            except (urllib.error.URLError, TimeoutError, ConnectionError, http.client.HTTPException):
                time.sleep(5 * (attempt + 1))
                continue
            if any(marker in page[:20000] for marker in CHALLENGE_MARKERS):
                sys.exit(f"Gặp trang challenge của Cloudflare ở {url}, dừng lại.")
            if "Cookie" in self.headers and LOGGED_IN_MARKER not in page[:5000]:
                sys.exit(f"Cookie không còn đăng nhập ở {url}, lấy cookie mới rồi chạy lại.")
            return page
        raise RuntimeError(f"Không tải được {url}")


class ParagraphParser(HTMLParser):
    BLOCKS = {"p", "div", "h1", "h2", "h3", "h4", "h5", "h6", "li", "blockquote", "tr"}
    SKIP = {"script", "style", "ins", "iframe", "noscript", "button"}

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.paragraphs: list[str] = []
        self.buffer: list[str] = []
        self.skip_depth = 0

    def flush(self):
        text = "".join(self.buffer).replace("\xa0", " ")
        text = re.sub(r"\s+", " ", BBCODE.sub("", ZERO_WIDTH.sub("", text))).strip()
        self.buffer = []
        if text and not DECORATION.match(text):
            self.paragraphs.append(text)

    def handle_starttag(self, tag, attrs):
        if tag in self.SKIP:
            self.skip_depth += 1
        elif tag == "br" or tag in self.BLOCKS:
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


def utc(timestamp: int) -> str:
    return datetime.fromtimestamp(timestamp, timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def iso_utc(value: str) -> str:
    return datetime.fromisoformat(value).astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def fold(text: str) -> str:
    text = unicodedata.normalize("NFD", text.lower().replace("đ", "d"))
    return re.sub(r"\s+", "", "".join(ch for ch in text if unicodedata.category(ch) != "Mn"))


def word_count(paragraphs: list[str]) -> int:
    return sum(len(paragraph.split()) for paragraph in paragraphs)


def thread_url(slug: str, thread_id: int) -> str:
    return f"{SITE}/threads/{slug}.{thread_id}/"


def json_ld(page: str) -> dict:
    match = re.search(r'<script type="application/ld\+json">(.*?)</script>', page, re.S)
    if not match:
        return {}
    data = json.loads(match.group(1))
    return data.get("mainEntity", data)


def last_page(page: str) -> int:
    pages = re.findall(r'<li class="pageNav-page[^"]*"><a href="[^"]*/page-(\d+)"', page)
    return max((int(number) for number in pages), default=1)


def section_id(page: str) -> int | None:
    crumbs = re.findall(r'<a href="/forums/[^"/]*\.(\d+)/" itemprop="item"', page)
    return int(crumbs[-1]) if crumbs else None


def prefix_label(page: str, headline: str) -> str:
    match = re.search(r'<meta property="og:title" content="([^"]*)"', page)
    if not match:
        return ""
    og_title = html.unescape(match.group(1))
    suffix = " - " + headline
    return og_title[: -len(suffix)].strip() if og_title.endswith(suffix) else ""


def reaction_count(post_block: str) -> int:
    bar = re.search(r'class="reactionsBar-link"[^>]*>(.*?)</a>', post_block, re.S)
    if not bar:
        return 0
    others = re.search(r"và\s+([\d.]+)\s+người khác", bar.group(1))
    return len(re.findall(r"<bdi>", bar.group(1))) + (int(others.group(1).replace(".", "")) if others else 0)


def parse_posts(page: str) -> list[dict]:
    starts = [match.start() for match in POST_START.finditer(page)]
    posts = []
    for index, start in enumerate(starts):
        block = page[start: starts[index + 1] if index + 1 < len(starts) else len(page)]
        post_id = re.search(r'data-content="post-(\d+)"', block)
        author = re.search(r'data-author="([^"]*)"', block)
        user_id = re.search(r'data-user-id="(\d+)"', block)
        posted = re.search(r'<time\s+class="u-dt"[^>]*data-timestamp="(\d+)"', block)
        body = element_inner(block, 'class="bbWrapper"')
        posts.append({
            "id": post_id.group(1) if post_id else "",
            "author": author.group(1) if author else "",
            "userId": user_id.group(1) if user_id else None,
            "timestamp": int(posted.group(1)) if posted else None,
            "quote": body.lstrip().startswith("<blockquote"),
            "locked": "hideBlock--hidden" in body,
            "hasImage": "bbImage" in body,
            "body": body,
            "paragraphs": html_paragraphs(body),
            "block": block,
        })
    return posts


def is_author(post: dict, starter_id: str | None, names: set[str]) -> bool:
    return (bool(starter_id) and post["userId"] == starter_id) or fold(post["author"]) in names


def heading_text(paragraph: str) -> str | None:
    text = paragraph.strip(TITLE_WRAPPERS)
    if len(text) > MAX_TITLE_CHARS:
        return None
    if CHAPTER_HEADING.match(text):
        return text
    embedded = EMBEDDED_HEADING.search(text)
    return embedded.group(1).strip() if embedded else None


def is_heading(paragraph: str) -> bool:
    return heading_text(paragraph) is not None


def drop_repeated(paragraphs: list[str], title: str) -> list[str]:
    if paragraphs and fold(paragraphs[0].strip(TITLE_WRAPPERS)) == fold(title):
        paragraphs = paragraphs[1:]
    while paragraphs and META_LINE.match(paragraphs[0]):
        paragraphs = paragraphs[1:]
    return paragraphs


def split_chapter(paragraphs: list[str]) -> tuple[str | None, list[str]]:
    for index in range(min(2, len(paragraphs))):
        heading = heading_text(paragraphs[index])
        if heading and (index == 0 or len(paragraphs[0]) <= MAX_PLAIN_TITLE_CHARS):
            return heading, drop_repeated(paragraphs[index + 1:], heading)
    if len(paragraphs) > 1:
        first = paragraphs[0].strip(TITLE_WRAPPERS)
        if (0 < len(first) <= MAX_PLAIN_TITLE_CHARS and not first.endswith(SENTENCE_END)
                and first[0] not in "-–—" and not any(mark in first for mark in ",;")):
            return first, drop_repeated(paragraphs[1:], first)
    return None, paragraphs


def is_chapter(post: dict) -> bool:
    if post["quote"]:
        return False
    if post["locked"]:
        return True
    paragraphs = post["paragraphs"]
    return bool(paragraphs) and (is_heading(paragraphs[0]) or sum(len(p) for p in paragraphs) >= MIN_CHAPTER_CHARS)


def meta_value(paragraphs: list[str], label: str) -> str:
    for paragraph in paragraphs:
        match = re.match(rf"^{label}\s*:\s*(.+)$", paragraph, re.I)
        if match:
            return match.group(1).strip()
    return ""


def split_headline(headline: str) -> tuple[str, str]:
    for separator in (" - ", " – ", " — "):
        if separator in headline:
            title, suffix = headline.rsplit(separator, 1)
            return title.strip(), suffix.strip()
    return headline.strip(), ""


def intro_paragraphs(paragraphs: list[str], title: str) -> list[str]:
    out = []
    for paragraph in paragraphs:
        if META_LINE.match(paragraph) or is_heading(paragraph) or fold(paragraph) == fold(title):
            continue
        paragraph = INTRO_LABEL.sub("", paragraph).strip()
        if paragraph:
            out.append(paragraph)
    return out


def excerpt(paragraphs: list[str]) -> str:
    words = " ".join(paragraphs).split()
    return " ".join(words[:INTRO_WORDS]) + ("…" if len(words) > INTRO_WORDS else "")


def load_thread(client: Client, thread_id: int) -> tuple[str, str, list[dict]]:
    first = client.text(f"{SITE}/threads/{thread_id}/")
    info = json_ld(first)
    slug_match = re.search(r"/threads/([^/]+)\.\d+/", info.get("url", ""))
    slug = slug_match.group(1) if slug_match else str(thread_id)
    posts = parse_posts(first)
    seen = {post["id"] for post in posts}
    for number in range(2, last_page(first) + 1):
        fresh = [post for post in parse_posts(client.text(f"{thread_url(slug, thread_id)}page-{number}")) if post["id"] not in seen]
        if not fresh:
            break
        seen.update(post["id"] for post in fresh)
        posts.extend(fresh)
    return first, slug, posts


def export_thread(client: Client, thread_id: int, args, out: Path, stats: dict) -> tuple[dict, list[dict]] | None:
    first, slug, posts = load_thread(client, thread_id)
    info = json_ld(first)
    if not info or not posts:
        print(f"  bỏ qua {thread_id}: không đọc được thread", flush=True)
        return None
    headline = info.get("headline", "")
    replies = next((item.get("userInteractionCount") for item in info.get("interactionStatistic", [])
                    if item.get("interactionType", "").endswith("CommentAction")), None)
    if replies is not None and replies + 1 != len(posts):
        print(f"  cảnh báo {thread_id}: đọc được {len(posts)} post, thread báo {replies + 1}", flush=True)
        stats["postMismatch"] += 1

    opener = posts[0]
    author_url = (info.get("author") or {}).get("@id", "")
    author_id = re.search(r"\.(\d+)/?$", author_url)
    starter_id = author_id.group(1) if author_id else opener["userId"]
    starter_name = (info.get("author") or {}).get("name", opener["author"])
    section = section_id(first)
    label = prefix_label(first, headline)
    title, headline_author = split_headline(headline)
    author_name = meta_value(opener["paragraphs"], "tác giả") or headline_author or starter_name
    if headline_author and fold(headline_author) not in (fold(author_name), fold(starter_name)):
        stats["authorMismatch"].append(f"{thread_id}: tên thread '{headline_author}' / dòng Tác giả '{author_name}' / người mở '{starter_name}'")
    names = {fold(name) for name in (starter_name, author_name, headline_author) if name}

    chapter_posts = []
    for post in posts[1:]:
        by_author = is_author(post, starter_id, names)
        if by_author and is_chapter(post):
            chapter_posts.append(post)
            continue
        stats["skippedPosts"] += 1
        if by_author or (post["paragraphs"] and is_heading(post["paragraphs"][0]) and not post["quote"]):
            first_line = post["paragraphs"][0][:60] if post["paragraphs"] else "(không có chữ)"
            stats["skippedLog"].append(f"{thread_id} post {post['id']} của {post['author']}: {first_line}")

    locked_at = next((index for index, post in enumerate(chapter_posts) if post["locked"]), None)
    if locked_at is not None:
        stats["lockedStories"] += 1
        if args.locked == "skip":
            print(f"  bỏ qua {thread_id} {headline}: có chương khoá", flush=True)
            return None
        stats["lockedChapters"] += len(chapter_posts) - locked_at
        print(f"  {thread_id}: khoá từ chương {locked_at + 1}, chỉ lấy {locked_at}/{len(chapter_posts)} chương", flush=True)
        chapter_posts = chapter_posts[:locked_at]

    source_url = thread_url(slug, thread_id)

    contents: dict[str, str] = {}
    summaries: list[dict] = []
    if chapter_posts:
        kind = "long"
        for position, post in enumerate(chapter_posts, start=1):
            paragraphs = post["paragraphs"]
            chapter_title, body = split_chapter(paragraphs)
            if chapter_title is None:
                chapter_title = f"Chương {position}"
                stats["untitledChapters"] += 1
                stats["untitledLog"].append(f"{thread_id} #{position}: {paragraphs[0][:80] if paragraphs else '(không có chữ)'}")
            if not body:
                stats["emptyChapters"].append(f"{thread_id} #{position} {chapter_title} (ảnh: {post['hasImage']})")
            contents[post["id"]] = "\n\n".join(body)
            summaries.append({
                "id": post["id"],
                "storyId": str(thread_id),
                "position": position,
                "title": chapter_title[:500],
                "url": f"{source_url}post-{post['id']}",
                "wordCount": word_count(body),
                "publishedAt": utc(post["timestamp"]) if post["timestamp"] else None,
            })
        intro = "\n\n".join(intro_paragraphs(opener["paragraphs"], title))
    else:
        body = [paragraph for paragraph in opener["paragraphs"] if not META_LINE.match(paragraph)]
        if body and fold(body[0]) == fold(title):
            body = body[1:]
        if opener["locked"]:
            print(f"  bỏ qua {thread_id} {headline}: post đầu bị khoá", flush=True)
            return None
        if section != SHORT_SECTION_ID and sum(len(p) for p in body) < MIN_SHORT_STORY_CHARS:
            print(f"  bỏ qua {thread_id} {headline}: chưa có chương", flush=True)
            return None
        kind = "short"
        contents[opener["id"]] = "\n\n".join(body)
        summaries.append({
            "id": opener["id"],
            "storyId": str(thread_id),
            "position": 1,
            "title": title,
            "url": source_url,
            "wordCount": word_count(body),
            "publishedAt": utc(opener["timestamp"]) if opener["timestamp"] else None,
        })
        intro = excerpt(body)

    status = SECTIONS.get(section, ("", "unknown"))[1]
    if fold(label) == STATUS_LABEL:
        status = "completed"
    cover = info.get("image")
    story = {
        "id": str(thread_id),
        "slug": slug,
        "title": title,
        "authorName": author_name,
        "sourceAuthorId": starter_id,
        "kind": kind,
        "genres": [label] if label and fold(label) != STATUS_LABEL else [],
        "tags": [tag.strip() for tag in (info.get("keywords") or "").split(",") if tag.strip()],
        "intro": intro,
        "coverUrl": cover if cover and cover in opener["body"] else None,
        "status": status,
        "chapterCount": len(summaries),
        "wordCount": sum(item["wordCount"] for item in summaries),
        "likeCount": reaction_count(opener["block"]),
        "ageRating": "",
        "sourceLabel": info.get("articleSection", ""),
        "sourceUrl": source_url,
        "publishedAt": iso_utc(info["datePublished"]),
        "updatedAt": utc(max(post["timestamp"] for post in posts if post["timestamp"])),
        "lastChapterAt": max((s["publishedAt"] for s in summaries if s["publishedAt"]), default=None),
    }
    (out / "chapters" / f"{thread_id}.json").write_text(json.dumps(contents, ensure_ascii=False), encoding="utf-8")
    return story, summaries


def section_threads(client: Client, section: int):
    slug = SECTIONS[section][0]
    page_number = total_pages = 1
    while page_number <= total_pages:
        suffix = f"page-{page_number}" if page_number > 1 else ""
        page = client.text(f"{SITE}/forums/{slug}.{section}/{suffix}")
        pages = re.findall(rf"/forums/{re.escape(slug)}\.{section}/page-(\d+)", page)
        total_pages = max([total_pages, *(int(number) for number in pages)])
        rows = page.split('class="structItem structItem--thread')[1:]
        for row in rows:
            thread_id = re.search(r"js-threadListItem-(\d+)", row)
            if not thread_id:
                continue
            if "structItem-status--sticky" in row and 'class="label label' not in row:
                continue
            yield int(thread_id.group(1))
        page_number += 1


def save_index(out: Path, stories: list[dict], chapter_index: dict[str, list[dict]]):
    index = {
        "source": "dembuon.vn",
        "generatedAt": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "stories": stories,
        "chapters": {story["id"]: chapter_index[story["id"]] for story in stories},
    }
    path = out / "index.json"
    temp = path.with_name("index.json.tmp")
    temp.write_text(json.dumps(index, ensure_ascii=False), encoding="utf-8")
    temp.replace(path)


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    parser = argparse.ArgumentParser(description="Xuất truyện Dembuon ra JSON để nạp vào database")
    parser.add_argument("--limit", type=int, help="số truyện cần lấy, mặc định 100 (hết các mục khi có --all)")
    parser.add_argument("--all", action="store_true", help="lấy hết truyện của các mục đã chọn")
    parser.add_argument("--sections", default=",".join(map(str, DEFAULT_SECTIONS)), help=f"ID mục, cách nhau dấu phẩy. Có: {', '.join(f'{k} ({v[0]})' for k, v in SECTIONS.items())}")
    parser.add_argument("--threads", help="chỉ lấy các thread này (ID, cách nhau dấu phẩy), bỏ qua --sections")
    parser.add_argument("--locked", choices=["stop", "skip"], default="stop", help="stop: chỉ lấy tới trước chương khoá đầu tiên; skip: bỏ cả truyện có chương khoá")
    parser.add_argument("--gap", type=float, default=1.2, help="giây giữa 2 request")
    parser.add_argument("--out", default="scripts/dembuon/data")
    parser.add_argument("--resume", action="store_true", help="giữ truyện đã có trong index.json, chỉ lấy thêm cho đủ --limit")
    parser.add_argument("--cookie-file", help="file chứa header Cookie (xf_user, xf_session, xf_csrf) của tài khoản đã bấm Thích, để đọc chương khoá; đặt ngoài repo")
    args = parser.parse_args()

    out = Path(args.out)
    (out / "chapters").mkdir(parents=True, exist_ok=True)
    cookie = Path(args.cookie_file).read_text(encoding="utf-8").strip() if args.cookie_file else None
    client = Client(args.gap, cookie)
    limit = args.limit if args.limit is not None else (math.inf if args.all else DEFAULT_LIMIT)
    stats = {"postMismatch": 0, "skippedPosts": 0, "lockedStories": 0, "lockedChapters": 0, "untitledChapters": 0,
             "emptyChapters": [], "authorMismatch": [], "skippedLog": [], "untitledLog": []}

    stories: list[dict] = []
    chapter_index: dict[str, list[dict]] = {}
    index_path = out / "index.json"
    if args.resume and index_path.exists():
        existing = json.loads(index_path.read_text(encoding="utf-8"))
        for story in existing["stories"]:
            stories.append(story)
            chapter_index[story["id"]] = existing["chapters"][story["id"]]
        print(f"Giữ lại {len(stories)} truyện có sẵn", flush=True)
    seen = {story["id"] for story in stories}

    if args.threads:
        candidates = (int(item) for item in args.threads.split(",") if item.strip())
    else:
        sections = [int(item) for item in args.sections.split(",") if item.strip()]
        unknown = [section for section in sections if section not in SECTIONS]
        if unknown:
            sys.exit(f"Không biết mục {unknown}")
        candidates = (thread_id for section in sections for thread_id in section_threads(client, section))

    unsaved = 0
    try:
        for thread_id in candidates:
            if len(stories) >= limit:
                break
            if str(thread_id) in seen:
                continue
            seen.add(str(thread_id))
            exported = export_thread(client, thread_id, args, out, stats)
            if not exported:
                continue
            story, summaries = exported
            stories.append(story)
            chapter_index[story["id"]] = summaries
            print(f"{len(stories):>4} {story['kind']:5} {len(summaries):>4} chương  {story['title']}  (đã gọi {client.count} request)", flush=True)
            unsaved += 1
            if unsaved >= CHECKPOINT_EVERY:
                save_index(out, stories, chapter_index)
                unsaved = 0
    except BaseException:
        save_index(out, stories, chapter_index)
        print(f"Dừng giữa chừng, đã lưu {len(stories)} truyện vào {index_path}. Chạy lại kèm --resume để lấy tiếp.", file=sys.stderr, flush=True)
        raise

    save_index(out, stories, chapter_index)
    total_chapters = sum(len(chapter_index[story["id"]]) for story in stories)
    print(f"Xong: {len(stories)} truyện, {total_chapters} chương, {client.count} request -> {out}", flush=True)
    print(f"Post bị bỏ (không phải chương): {stats['skippedPosts']}; chương không có dòng tiêu đề: {stats['untitledChapters']}; "
          f"lệch số post: {stats['postMismatch']}; truyện có chương khoá: {stats['lockedStories']} ({stats['lockedChapters']} chương bỏ)", flush=True)
    for line in stats["emptyChapters"]:
        print(f"  chương rỗng: {line}", flush=True)
    for line in stats["authorMismatch"]:
        print(f"  tên tác giả lệch: {line}", flush=True)
    for line in stats["skippedLog"]:
        print(f"  post bị bỏ: {line}", flush=True)
    for line in stats["untitledLog"]:
        print(f"  chương không có tiêu đề: {line}", flush=True)


if __name__ == "__main__":
    main()
