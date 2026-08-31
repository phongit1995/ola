package topup

import "testing"

func TestBuildMemoRegexCapture(t *testing.T) {
	cases := []struct {
		name        string
		template    string
		description string
		want        string
	}{
		{"default template", "@{username}", "NGUYEN VAN B CHUYEN TIEN @test1 - Ma GD ACSP", "test1"},
		{"donate template", "DONATE {username}", "Giao dich thu nghiem DONATE admin", "admin"},
		{"donate no space", "DONATE {username}", "CT DONATEadmin", "admin"},
		{"donate uppercase input", "DONATE {username}", "ck donate Test_User1 noi dung", "Test_User1"},
		{"vietnamese diacritics", "NAP {username}", "Nạp nguyen.van.a", "nguyen.van.a"},
		{"extra word breaks capture", "NAP {username}", "Nap cho nguyen.van.a", "cho"},
		{"trailing bank noise", "DONATE {username}", "DONATE test1 CT tu 970422", "test1"},
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
