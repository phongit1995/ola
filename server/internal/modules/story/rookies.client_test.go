package story

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"html"
	"net/http"
	"net/http/httptest"
	"reflect"
	"strings"
	"sync"
	"testing"
	"time"
)

func testRookiesClient(site string) *rookiesClient {
	client := newRookiesClient(5*time.Second, 0)
	client.site = site
	client.retryWait = time.Millisecond
	return client
}

func rookiesHome(version string) string {
	page := html.EscapeString(fmt.Sprintf(`{"component":"Home/Home","props":{},"version":%q}`, version))
	return `<!DOCTYPE html><html><body><div id="app" data-page="` + page + `"></div></body></html>`
}

func TestRookiesTime(t *testing.T) {
	local, ok := rookiesTime("2026-10-13 16:15:30")
	if !ok || !local.Equal(time.Date(2026, 10, 13, 9, 15, 30, 0, time.UTC)) {
		t.Fatalf("time without zone must be Vietnam time, got %v %v", local, ok)
	}
	utc, ok := rookiesTime("2026-10-14T07:48:49.000000Z")
	if !ok || !utc.Equal(time.Date(2026, 10, 14, 7, 48, 49, 0, time.UTC)) {
		t.Fatalf("time with Z must be UTC, got %v %v", utc, ok)
	}
	if _, ok := rookiesTime(""); ok {
		t.Fatal("empty time must not parse")
	}
}

func TestRookiesNumber(t *testing.T) {
	var got struct {
		A, B, C, D, E rookiesNumber
	}
	if err := json.Unmarshal([]byte(`{"A":71,"B":"2","C":null,"D":true,"E":"0.00"}`), &got); err != nil {
		t.Fatal(err)
	}
	if got.A != 71 || got.B != 2 || got.C != 0 || got.D != 1 || got.E != 0 {
		t.Fatalf("unexpected numbers %+v", got)
	}
}

// Struct đọc truyện rookies không được có trường nào chứa thông tin cá nhân của tác giả.
func TestRookiesStoryHasNoPersonalFields(t *testing.T) {
	banned := []string{"email", "phone", "birthday", "address", "login_token", "token_login", "session", "pass_reset", "password"}
	var walk func(typ reflect.Type)
	walk = func(typ reflect.Type) {
		for i := 0; i < typ.NumField(); i++ {
			field := typ.Field(i)
			tag := strings.Split(field.Tag.Get("json"), ",")[0]
			for _, word := range banned {
				if strings.Contains(tag, word) {
					t.Fatalf("%s.%s reads %q", typ.Name(), field.Name, tag)
				}
			}
			inner := field.Type
			for inner.Kind() == reflect.Pointer || inner.Kind() == reflect.Slice {
				inner = inner.Elem()
			}
			if inner.Kind() == reflect.Struct && inner.PkgPath() == typ.PkgPath() {
				walk(inner)
			}
		}
	}
	walk(reflect.TypeOf(rookiesStory{}))
	walk(reflect.TypeOf(rookiesChapterText{}))
}

func TestRookiesClientRefreshesInertiaVersion(t *testing.T) {
	var mu sync.Mutex
	version := "v1"
	homeHits := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		mu.Lock()
		defer mu.Unlock()
		if r.URL.Path == "/" {
			homeHits++
			if r.Header.Get("X-Inertia") != "" {
				t.Errorf("home must be read as plain HTML")
			}
			_, _ = w.Write([]byte(rookiesHome(version)))
			version = "v2"
			return
		}
		if r.Header.Get("X-Inertia") != "true" || r.Header.Get("X-Requested-With") != "XMLHttpRequest" {
			t.Errorf("missing inertia headers %v", r.Header)
		}
		if r.Header.Get("X-Inertia-Version") != version {
			w.WriteHeader(http.StatusConflict)
			return
		}
		if r.URL.RequestURI() != StoryRookiesLatestPath ||
			r.Header.Get("X-Inertia-Partial-Component") != StoryRookiesListComponent ||
			r.Header.Get("X-Inertia-Partial-Data") != StoryRookiesPartialData {
			t.Errorf("unexpected request %s %v", r.URL.RequestURI(), r.Header)
		}
		_, _ = w.Write([]byte(`{"component":"Filter/Hot_Full_Free_Paid","props":{"novels":{"list_novels":{"per_page":10,"data":[
			{"id":7,"friendly_link":"truyen-7","title":"Truyện 7","published_at":"2026-10-13 16:15:30","is_vip":71,
			 "user":{"username":"tacgia","email":"a@b.c","phone":"0900"}}]}}}}`))
	}))
	defer server.Close()

	listing, err := testRookiesClient(server.URL).Latest(context.Background())
	if err != nil {
		t.Fatal(err)
	}
	if len(listing.Items) != 1 || listing.Items[0].Slug != "truyen-7" || listing.PerPage != 10 {
		t.Fatalf("unexpected listing %+v", listing)
	}
	if homeHits != 2 {
		t.Fatalf("stale version must be read again once, home hits %d", homeHits)
	}
}

func TestRookiesClientCookieLogin(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Header.Get("X-Inertia") == "" {
			_, _ = w.Write([]byte(rookiesHome("v1")))
			return
		}
		user := "null"
		if r.Header.Get("Cookie") == "rookies_session=live" {
			user = `{"id":9,"email":"a@b.c","phone":"0900"}`
		}
		switch r.Header.Get("X-Inertia-Partial-Data") {
		case StoryRookiesAuthData:
			_, _ = w.Write([]byte(`{"props":{"errors":{},"auth":{"user":` + user + `}}}`))
		case StoryRookiesPartialData + "," + StoryRookiesAuthData:
			_, _ = w.Write([]byte(`{"props":{"auth":{"user":` + user + `},"novels":{"novels_detail":{"id":7,"friendly_link":"truyen-7"}}}}`))
		default:
			t.Errorf("unexpected partial data %q", r.Header.Get("X-Inertia-Partial-Data"))
		}
	}))
	defer server.Close()

	client := testRookiesClient(server.URL)
	for _, tc := range []struct {
		cookie string
		want   bool
	}{{"", false}, {"rookies_session=dead", false}, {"rookies_session=live", true}} {
		client.SetCookie(tc.cookie)
		loggedIn, err := client.CheckLogin(context.Background())
		if err != nil || loggedIn != tc.want {
			t.Fatalf("cookie %q: logged in %v, err %v", tc.cookie, loggedIn, err)
		}
		story, err := client.Story(context.Background(), "truyen-7")
		if err != nil || story.LoggedIn != tc.want || story.ID != 7 {
			t.Fatalf("cookie %q: story %+v, err %v", tc.cookie, story, err)
		}
	}
}

func TestRookiesClientStatusErrors(t *testing.T) {
	cases := []struct {
		status int
		header string
		want   error
	}{
		{http.StatusNotFound, "", errStoryGone},
		{http.StatusForbidden, "", errSourceBlocked},
		{http.StatusServiceUnavailable, "", errSourceBlocked},
		{http.StatusTooManyRequests, "600", errSourceBlocked},
	}
	for _, tc := range cases {
		hits := 0
		server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			if r.URL.Path == "/" {
				_, _ = w.Write([]byte(rookiesHome("v1")))
				return
			}
			hits++
			if tc.header != "" {
				w.Header().Set("Retry-After", tc.header)
			}
			w.WriteHeader(tc.status)
		}))
		_, err := testRookiesClient(server.URL).Story(context.Background(), "truyen-7")
		server.Close()
		if !errors.Is(err, tc.want) {
			t.Fatalf("status %d: got %v, want %v", tc.status, err, tc.want)
		}
		if hits != 1 {
			t.Fatalf("status %d must not be retried, hits %d", tc.status, hits)
		}
	}
}

func TestRookiesClientRejectsOddSlug(t *testing.T) {
	client := testRookiesClient("http://127.0.0.1:1")
	for _, slug := range []string{"", "../admin", "truyen?x=1", "Truyen"} {
		if _, err := client.Story(context.Background(), slug); !errors.Is(err, errUnsupportedSource) {
			t.Fatalf("slug %q: got %v", slug, err)
		}
	}
	if client.Requests() != 0 {
		t.Fatalf("odd slugs must not reach rookies, requests %d", client.Requests())
	}
}

func TestRookiesParagraphs(t *testing.T) {
	escaped := "&lt;p id=&quot;a&quot;&gt;&lt;strong&gt;Chương 1&lt;/strong&gt;&lt;/p&gt;\n&lt;p&gt;Trời m&amp;ugrave;a&nbsp;thu.&lt;/p&gt;"
	got, err := rookiesParagraphs(escaped)
	if err != nil || len(got) != 2 || got[0] != "Chương 1" || got[1] != "Trời mùa thu." {
		t.Fatalf("escaped html: %q %v", got, err)
	}
	plain, err := rookiesParagraphs("Dòng một\r\n\r\n  Dòng   hai ")
	if err != nil || len(plain) != 2 || plain[1] != "Dòng hai" {
		t.Fatalf("plain text: %q %v", plain, err)
	}
}
