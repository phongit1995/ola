import argparse
import html
import http.client
import json
import math
import re
import sys
import time
import urllib.error
import urllib.request
from datetime import datetime, timedelta, timezone
from pathlib import Path

SITE = "https://rookies.vn"
COVER_BASE = f"{SITE}/uploads/"
USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0 Safari/537.36"
VIETNAM_TZ = timezone(timedelta(hours=7))
LISTING = "/truyen/mien-phi"
HOME_COMPONENT = "Home/Home"
NEW_STORIES_KEY = "list_novels_reading"
GROUP_KIND = 1
GROUP_FORM = 2
GROUP_GENRE = 3
TRANSLATED_LABEL = "Truyện dịch"
SHORT_FORMS = {"Truyện ngắn", "Oneshot"}
MATURE_RATING = "18+"
CHECKPOINT_EVERY = 20
DEFAULT_LIMIT = 100
MAX_TITLE_CHARS = 500


class Client:
    def __init__(self, gap_seconds: float):
        self.gap = gap_seconds
        self.last = 0.0
        self.count = 0
        self.version = None

    def fetch(self, path: str, inertia: bool = True, partial: tuple[str, str] | None = None) -> str:
        for attempt in range(4):
            wait = self.last + self.gap - time.time()
            if wait > 0:
                time.sleep(wait)
            self.last = time.time()
            self.count += 1
            headers = {"User-Agent": USER_AGENT}
            if inertia:
                headers.update({"X-Inertia": "true", "X-Inertia-Version": self.inertia_version(), "X-Requested-With": "XMLHttpRequest"})
            if partial:
                headers.update({"X-Inertia-Partial-Component": partial[0], "X-Inertia-Partial-Data": partial[1]})
            try:
                with urllib.request.urlopen(urllib.request.Request(SITE + path, headers=headers), timeout=40) as response:
                    return response.read().decode("utf-8", "replace")
            except urllib.error.HTTPError as error:
                if error.code == 409 and inertia:
                    self.version = None
                    continue
                if error.code == 429:
                    time.sleep(int(error.headers.get("Retry-After") or 60))
                    continue
                if error.code in (403, 503):
                    if attempt == 3:
                        sys.exit(f"Bị chặn ({error.code}) ở {path}, dừng lại.")
                    time.sleep(15 * (attempt + 1))
                    continue
                if error.code >= 500:
                    time.sleep(10 * (attempt + 1))
                    continue
                raise
            except (urllib.error.URLError, TimeoutError, ConnectionError, http.client.HTTPException):
                time.sleep(5 * (attempt + 1))
        raise RuntimeError(f"Không tải được {path}")

    def inertia_version(self) -> str:
        if self.version is None:
            page = self.fetch("/", inertia=False)
            match = re.search(r'data-page="([^"]+)"', page)
            if not match:
                sys.exit("Không đọc được data-page ở trang chủ, rookies có thể đã đổi giao diện.")
            self.version = json.loads(html.unescape(match.group(1)))["version"]
        return self.version

    def props(self, path: str, partial: tuple[str, str] | None = None) -> dict:
        return json.loads(self.fetch(path, partial=partial))["props"]


def vietnam_time(value: str | None) -> str | None:
    if not value:
        return None
    moment = datetime.fromisoformat(value)
    if moment.tzinfo is None:
        moment = moment.replace(tzinfo=VIETNAM_TZ)
    return moment.astimezone(VIETNAM_TZ).isoformat(timespec="seconds")


def plain_paragraphs(fragment: str) -> list[str]:
    text = re.sub(r"<br\s*/?>|</p>|</div>", "\n", fragment or "", flags=re.I)
    text = html.unescape(re.sub(r"<[^>]+>", " ", text)).replace("\xa0", " ")
    return [line for line in (re.sub(r"\s+", " ", raw).strip() for raw in text.splitlines()) if line]


def labels(detail: dict, groups: set[int], include: bool) -> list[str]:
    return [item["title"].strip() for item in detail.get("novels_filter") or []
            if (item.get("group_id") in groups) == include and item.get("title")]


def is_paid(chapter: dict) -> bool:
    return bool(chapter.get("is_vip") or chapter.get("is_preview")
                or (chapter.get("price_coin_1") or 0) > 0 or (chapter.get("price_coin_2") or 0) > 0)


def author_name(detail: dict) -> str:
    user = detail.get("user") or {}
    return (user.get("full_name") or user.get("username") or "").strip()


def export_story(client: Client, slug: str, args, stats: dict) -> tuple[dict, list[dict]] | None:
    try:
        detail = client.props(f"/truyen/{slug}").get("novels", {}).get("novels_detail")
    except urllib.error.HTTPError as error:
        print(f"  bỏ qua {slug}: HTTP {error.code}", flush=True)
        return None
    if not detail or detail.get("is_ban") or not detail.get("is_show", 1):
        print(f"  bỏ qua {slug}: không đọc được truyện hoặc truyện bị ẩn", flush=True)
        return None
    story_id = str(detail["id"])
    title = (detail.get("title") or "").strip()
    if not args.include_translated and TRANSLATED_LABEL in labels(detail, {GROUP_KIND}, True):
        stats["translated"] += 1
        print(f"  bỏ qua {story_id} {title}: truyện dịch", flush=True)
        return None

    now = datetime.now(VIETNAM_TZ)
    chapters = sorted(detail.get("novels_chapters_detail") or [], key=lambda item: (item.get("show_order") or 0, item["id"]))
    chapters = [item for item in chapters if not item.get("is_ban")
                and not (item.get("published_at") and datetime.fromisoformat(vietnam_time(item["published_at"])) > now)]
    paid_at = next((index for index, item in enumerate(chapters) if is_paid(item)), None)
    if paid_at is not None:
        stats["paidStories"] += 1
        if args.paid == "skip":
            print(f"  bỏ qua {story_id} {title}: có chương trả phí", flush=True)
            return None
        stats["paidChapters"] += len(chapters) - paid_at
        print(f"  {story_id}: trả phí từ chương {paid_at + 1}, chỉ lấy {paid_at}/{len(chapters)} chương", flush=True)
        chapters = chapters[:paid_at]
    if not chapters:
        stats["empty"] += 1
        print(f"  bỏ qua {story_id} {title}: chưa có chương đọc miễn phí", flush=True)
        return None

    # published_at của truyện rookies là giờ ra chương mới nhất, còn updated_at đổi cả khi có lượt xem,
    # nên giờ đăng lấy theo chương đầu và giờ cập nhật theo chương miễn phí mới nhất (giống crawler Go).
    chapter_times = [vietnam_time(item.get("published_at")) for item in chapters if item.get("published_at")]
    published_at = (vietnam_time(chapters[0].get("published_at")) or vietnam_time(detail.get("created_at"))
                    or vietnam_time(detail.get("published_at")))
    if not published_at:
        print(f"  bỏ qua {story_id} {title}: không có ngày đăng", flush=True)
        return None
    updated_at = max([published_at, *chapter_times], key=datetime.fromisoformat)

    source_url = f"{SITE}/truyen/{slug}"
    summaries = [{
        "id": str(item["id"]),
        "storyId": story_id,
        "position": position,
        "title": (item.get("title") or f"Chương {position}").strip()[:MAX_TITLE_CHARS],
        "url": f"{source_url}/{item['id']}",
        "wordCount": 0,
        "publishedAt": vietnam_time(item.get("published_at")),
    } for position, item in enumerate(chapters, start=1)]

    intro = plain_paragraphs(detail.get("content")) or plain_paragraphs(detail.get("short"))
    if detail.get("is_mature"):
        stats["mature"] += 1
    story = {
        "id": story_id,
        "slug": slug,
        "title": title,
        "authorName": author_name(detail),
        "sourceAuthorId": str(detail["user_id"]) if detail.get("user_id") else None,
        "kind": "short" if len(summaries) == 1 and SHORT_FORMS & set(labels(detail, {GROUP_FORM}, True)) else "long",
        "genres": labels(detail, {GROUP_FORM, GROUP_GENRE}, True),
        "tags": labels(detail, {GROUP_KIND, GROUP_FORM, GROUP_GENRE}, False),
        "intro": "\n\n".join(intro),
        "coverUrl": COVER_BASE + detail["picture"] if detail.get("picture") else None,
        "status": "completed" if detail.get("is_complete") else "ongoing",
        "chapterCount": len(summaries),
        "wordCount": 0,
        "likeCount": detail.get("novels_like_count") or 0,
        "ageRating": MATURE_RATING if detail.get("is_mature") else "",
        "sourceLabel": ", ".join(labels(detail, {GROUP_KIND}, True)),
        "sourceUrl": source_url,
        "publishedAt": published_at,
        "updatedAt": updated_at,
        "lastChapterAt": max((item["publishedAt"] for item in summaries if item["publishedAt"]), default=None),
    }
    return story, summaries


def listing_slugs(client: Client):
    page_number = total_pages = 1
    while page_number <= total_pages:
        listing = client.props(f"{LISTING}?page={page_number}")["novels"]["list_novels"]
        total_pages = listing.get("last_page") or total_pages
        if page_number == 1:
            print(f"Danh sách truyện miễn phí: {listing.get('total')} truyện, {total_pages} trang", flush=True)
        for item in listing.get("data") or []:
            if item.get("friendly_link"):
                yield item["friendly_link"]
        page_number += 1


def newest_slugs(client: Client) -> list[str]:
    home = client.props("/", partial=(HOME_COMPONENT, "home"))["home"]
    return [item["friendly_link"] for item in home.get(NEW_STORIES_KEY) or [] if item.get("friendly_link")]


def merge_new_stories(client: Client, args, stats: dict, stories: list[dict], chapter_index: dict[str, list[dict]]):
    for slug in newest_slugs(client):
        exported = export_story(client, slug, args, stats)
        if not exported:
            continue
        story, summaries = exported
        existing_at = next((index for index, item in enumerate(stories) if item["id"] == story["id"]), None)
        if existing_at is None:
            stories.append(story)
            label = "mới"
        else:
            stories[existing_at] = story
            label = "làm mới"
        chapter_index[story["id"]] = summaries
        print(f"{label:8} {story['kind']:5} {len(summaries):>4} chương  {story['title']}  (đăng {story['publishedAt']})", flush=True)


def save_index(out: Path, stories: list[dict], chapter_index: dict[str, list[dict]]):
    index = {
        "source": "rookies.vn",
        "generatedAt": datetime.now(VIETNAM_TZ).isoformat(timespec="seconds"),
        "stories": stories,
        "chapters": {story["id"]: chapter_index[story["id"]] for story in stories},
    }
    path = out / "index.json"
    temp = path.with_name("index.json.tmp")
    temp.write_text(json.dumps(index, ensure_ascii=False), encoding="utf-8")
    temp.replace(path)


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    parser = argparse.ArgumentParser(description="Xuất thông tin truyện và danh sách chương Rookies ra JSON để nạp vào database (không tải nội dung chương)")
    parser.add_argument("--limit", type=int, help="số truyện cần lấy, mặc định 100 (hết danh sách khi có --all)")
    parser.add_argument("--all", action="store_true", help="lấy hết truyện trong danh sách truyện miễn phí")
    parser.add_argument("--slugs", help="chỉ lấy các truyện này (friendly_link, cách nhau dấu phẩy)")
    parser.add_argument("--paid", choices=["stop", "skip"], default="stop", help="stop: chỉ lấy tới trước chương trả phí đầu tiên; skip: bỏ cả truyện có chương trả phí")
    parser.add_argument("--include-translated", action="store_true", help="lấy cả truyện dịch (mặc định chỉ lấy truyện sáng tác)")
    parser.add_argument("--gap", type=float, default=1.0, help="giây giữa 2 request (rookies giới hạn 80 request/phút)")
    parser.add_argument("--out", default="scripts/rookies/data")
    parser.add_argument("--resume", action="store_true", help="giữ truyện đã có trong index.json, chỉ lấy thêm cho đủ --limit")
    parser.add_argument("--new", action="store_true", help="chỉ lấy các truyện ở khối 'Truyện mới đăng' trên trang chủ, gộp vào index.json có sẵn (truyện đã có thì làm mới)")
    args = parser.parse_args()

    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    client = Client(args.gap)
    limit = args.limit if args.limit is not None else (math.inf if args.all else DEFAULT_LIMIT)
    stats = {"translated": 0, "paidStories": 0, "paidChapters": 0, "empty": 0, "mature": 0}

    stories: list[dict] = []
    chapter_index: dict[str, list[dict]] = {}
    index_path = out / "index.json"
    if (args.resume or args.new) and index_path.exists():
        existing = json.loads(index_path.read_text(encoding="utf-8"))
        for story in existing["stories"]:
            stories.append(story)
            chapter_index[story["id"]] = existing["chapters"][story["id"]]
        print(f"Giữ lại {len(stories)} truyện có sẵn", flush=True)

    if args.new:
        merge_new_stories(client, args, stats, stories, chapter_index)
        save_index(out, stories, chapter_index)
        print(f"Xong: {len(stories)} truyện trong {index_path}, {client.count} request", flush=True)
        return

    seen_slugs = {story["slug"] for story in stories}
    seen_ids = {story["id"] for story in stories}

    candidates = (item.strip() for item in args.slugs.split(",") if item.strip()) if args.slugs else listing_slugs(client)
    unsaved = 0
    try:
        for slug in candidates:
            if len(stories) >= limit:
                break
            if slug in seen_slugs:
                continue
            seen_slugs.add(slug)
            exported = export_story(client, slug, args, stats)
            if not exported or exported[0]["id"] in seen_ids:
                continue
            story, summaries = exported
            seen_ids.add(story["id"])
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
    print(f"Bỏ truyện dịch: {stats['translated']}; truyện chưa có chương miễn phí: {stats['empty']}; "
          f"truyện có chương trả phí: {stats['paidStories']} ({stats['paidChapters']} chương bỏ); truyện 18+: {stats['mature']}", flush=True)


if __name__ == "__main__":
    main()
