package topup

import (
	"strings"
	"testing"

	"ola-chat-server/internal/models"
)

type fakeUserFinder map[string]*models.User

func (f fakeUserFinder) FindUserByUsernameCI(username string) (*models.User, error) {
	return f[strings.ToLower(username)], nil
}

func TestBuildMemoRegexCapture(t *testing.T) {
	cases := []struct {
		name        string
		template    string
		description string
		want        string
	}{
		{"default template", "@{username}", "NGUYEN VAN B CHUYEN TIEN @test1 - Ma GD ACSP", "test1"},
		{"donate template", "DONATE {username}", "Giao dich thu nghiem DONATE admin", "admin"},
		{"glued marker rejected", "DONATE {username}", "CT DONATEadmin", ""},
		{"marker prefix of another word", "DONATE {username}", "DONATED 500k cho shop", ""},
		{"anchored template refuses extra word", "DONATE @{username}", "DONATE cho @test1", ""},
		{"anchored template normal", "DONATE @{username}", "Giao dich DONATE @test1 CT", "test1"},
		{"donate uppercase input", "DONATE {username}", "ck donate Test_User1 noi dung", "Test_User1"},
		{"vietnamese diacritics", "NAP {username}", "Nạp nguyen.van.a", "nguyen.van.a"},
		{"extra word breaks capture", "NAP {username}", "Nap cho nguyen.van.a", "cho"},
		{"trailing bank noise", "DONATE {username}", "DONATE test1 CT tu 970422", "test1"},
		{"hyphen marker", "NAP-{username}", "NAP-test1", "test1"},
		{"hyphen marker with bank noise", "NAP-{username}", "CK NAP-test1 CT tu 970422", "test1"},
		{"hyphen marker extra word refused", "NAP-{username}", "NAP cho test1", ""},
		{"hyphen marker glued suffix", "NAP-{username}", "NAP-test1-FT25123456", "test1-FT25123456"},
		{"hyphen marker lowercase", "NAP-{username}", "nap-Test_User1 chuyen tien", "Test_User1"},
		{"no match", "DONATE {username}", "chuyen khoan khong ro noi dung", ""},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			re, ok := buildMemoRegex(tc.template)
			if !ok {
				t.Fatalf("buildMemoRegex(%q) not ok", tc.template)
			}
			match := re.FindStringSubmatch(normalizeMemoText(tc.description))
			got := ""
			if len(match) >= 2 {
				got = match[1]
			}
			if got != tc.want {
				t.Errorf("template %q description %q: got capture %q, want %q (pattern %s)",
					tc.template, tc.description, got, tc.want, re.String())
			}
		})
	}
}

func TestCaptureUsernameStripsBankNoise(t *testing.T) {
	vcb := "GD: MBVCB.15976744208.725882.DONATE november.CT tu 1069112032 VU NGOC ANH toi 12878297 NGU"
	cases := []struct {
		name        string
		template    string
		description string
		want        string
	}{
		{"vcb wrapper without marker", "DONATE {username}", vcb, "november"},
		{"vcb wrapper marker required", "DONATE @{username}", vcb, ""},
		{"vcb wrapper dotted username", "DONATE @{username}", "GD: MBVCB.111.222.DONATE @nguyen.van_a.CT tu 1069 VU NGOC ANH toi 1287 NGU", "nguyen.van_a"},
		{"vcb wrapper username ending ct", "DONATE @{username}", "MBVCB.111.222.DONATE @john.ct.CT tu 1069 VU NGOC ANH toi 1287 NGU", "john.ct"},
		{"vcb suffix without prefix", "DONATE {username}", "DONATE november.CT tu 1069112032 VU NGOC ANH", "november"},
		{"vcb suffix uppercase", "DONATE {username}", "DONATE november.CT TU 1069112032 VU NGOC ANH", "november"},
		{"vcb suffix extra spaces", "DONATE {username}", "DONATE november.CT  tu   1069112032", "november"},
		{"vcb prefix lowercase", "DONATE @{username}", "gd: mbvcb.111.222.DONATE @john.ct.ct tu 1069 VU NGOC ANH", "john.ct"},
		{"mb suffix glued hyphen", "@{username}", "DONATE @nguyen.van_a- Ma GD ACSP/ hE123", "nguyen.van_a"},
		{"mb suffix spaced", "@{username}", "NGUYEN VAN B CHUYEN TIEN @test1 - Ma GD ACSP", "test1"},
		{"mb suffix uppercase", "@{username}", "DONATE @nguyen.van_a-MA GD ACSP hE123", "nguyen.van_a"},
		{"acb suffix", "DONATE @{username}", "DONATE @a_b.c-d GD 123456-100926 10:00:00", "a_b.c-d"},
		{"vietinbank prefix", "DONATE @{username}", "SHGD:100.DD:260910.BO:VU NGOC ANH.DONATE @a_b.c-d", "a_b.c-d"},
		{"typo suffix is not guessed", "DONATE @{username}", "DONATE @alice.typo", "alice.typo"},
		{"leading punctuation trimmed", "DONATE @{username}", "DONATE @.john", "john"},
		{"only punctuation is empty", "DONATE @{username}", "DONATE @-", ""},
		{"trailing punctuation trimmed", "NAP-{username}", "NAP-test1- chuyen tien", "test1"},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			got, ok := captureUsername(tc.template, tc.description)
			if !ok {
				t.Fatalf("template %q has no placeholder", tc.template)
			}
			if got != tc.want {
				t.Errorf("template %q description %q: got %q, want %q", tc.template, tc.description, got, tc.want)
			}
		})
	}

	if _, ok := captureUsername("DONATE", "DONATE @test1"); ok {
		t.Fatal("template without placeholder must report not ok")
	}
}

func TestResolveUserNeverPicksDottedLookalike(t *testing.T) {
	november := &models.User{Username: "november"}
	lookalike := &models.User{Username: "november.ct"}
	abc := &models.User{Username: "abc"}
	abcCt := &models.User{Username: "abc.ct"}

	cases := []struct {
		name        string
		finder      fakeUserFinder
		template    string
		description string
		wantCapture string
		wantUser    *models.User
	}{
		{"truncated vcb resolves real user", fakeUserFinder{"november": november, "november.ct": lookalike}, "DONATE {username}", "DONATE november.CT tu 1069112032 VU NGOC ANH", "november", november},
		{"truncated vcb without real user stays unmatched", fakeUserFinder{"november.ct": lookalike}, "DONATE {username}", "DONATE november.CT tu 1069112032 VU NGOC ANH", "november", nil},
		{"full vcb resolves real user", fakeUserFinder{"november": november, "november.ct": lookalike}, "DONATE {username}", "GD: MBVCB.15976744208.725882.DONATE november.CT tu 1069112032 VU NGOC ANH toi 12878297 NGU", "november", november},
		{"dotted username still resolves itself", fakeUserFinder{"abc": abc, "abc.ct": abcCt}, "DONATE @{username}", "MBVCB.1.2.DONATE @abc.ct.CT tu 1069112032 A toi 12878297 B", "abc.ct", abcCt},
		{"typo never falls back to prefix", fakeUserFinder{"abc": abc}, "DONATE @{username}", "DONATE @abc.typo", "abc.typo", nil},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			capture, u, ok, err := resolveUser(tc.finder, tc.template, tc.description)
			if err != nil || !ok {
				t.Fatalf("unexpected err=%v ok=%v", err, ok)
			}
			if capture != tc.wantCapture {
				t.Errorf("capture: got %q, want %q", capture, tc.wantCapture)
			}
			if u != tc.wantUser {
				t.Errorf("user: got %v, want %v", u, tc.wantUser)
			}
		})
	}
}
