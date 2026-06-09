package chat.ola.vn.util;

import android.graphics.Bitmap;
import android.text.Layout;
import android.text.SpannableString;
import android.text.style.AlignmentSpan;
import android.text.style.ImageSpan;
import android.view.View;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import com.mg.ola.common.widget.OlaTextView;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes.dex */
public class i {
    public static String a = "((rss|Rss|RSS)://((?:[a-z0-9]+[a-zA-Z0-9\\-_/\\.]+))(\\b|\\s))";
    public static String b = "\\b(file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    public static String c = "(?:(?:ht|f)tp(?:s?)://)(?:(?:[-\\w]+\\.)+(?:[-\\w]+))(?::[\\d]{1,5})?(?:(?:(?:/(?:[-\\w~!$+|.,=]|%[a-f\\d]{2})+)+|/)+|\\?|#)?(?:(\\S)*)";
    public static String d = "(\\B#((?:[a-zA-Z0-9][a-zA-Z0-9_.]*[a-zA-Z0-9])))";
    public static String e = "(\\B@((?:[a-zA-Z][a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]*[a-zA-Z0-9])))";
    private static chat.ola.vn.entry.f f;
    private static chat.ola.vn.entry.f g;

    private static chat.ola.vn.entry.f a() {
        if (f == null) {
            f = new chat.ola.vn.entry.f() { // from class: chat.ola.vn.util.i.8
                @Override // chat.ola.vn.entry.f
                public CharSequence a(View view, OlaTextView.b bVar, CharSequence charSequence) {
                    return i.b(null, i.d(view, i.a(view, i.c(view, h.a().a(g.a().a(charSequence)), bVar, chat.ola.vn.f.a, false), bVar, chat.ola.vn.f.a, false), bVar, chat.ola.vn.f.a, false), bVar, chat.ola.vn.f.a, false);
                }
            };
        }
        return f;
    }

    public static CharSequence a(View view, OlaTextView.b bVar, String str) {
        try {
            return a().a(view, bVar, str);
        } catch (Throwable th) {
            th.printStackTrace();
            return str;
        }
    }

    public static CharSequence a(final View view, CharSequence charSequence, final OlaTextView.b bVar, int i, boolean z) {
        SpannableString spannableString = charSequence instanceof SpannableString ? (SpannableString) charSequence : new SpannableString(charSequence);
        Matcher matcher = Pattern.compile(a, 2).matcher(charSequence);
        while (matcher.find()) {
            final String strGroup = matcher.group();
            spannableString.setSpan(bVar == null ? new com.mg.ola.common.d.a.a(i, z) : new com.mg.ola.common.d.a.a(i, z) { // from class: chat.ola.vn.util.i.1
                @Override // com.mg.ola.common.d.a.a, android.text.style.ClickableSpan
                public void onClick(View view2) {
                    bVar.a(view, null, strGroup);
                }
            }, matcher.start(), matcher.end(), 33);
        }
        return spannableString;
    }

    public static CharSequence a(View view, String str) {
        return a(view, chat.ola.vn.q.a.a(), str);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public static CharSequence a(CharSequence charSequence, int i, int i2) {
        try {
            SpannableString spannableString = charSequence instanceof SpannableString ? (SpannableString) charSequence : new SpannableString(charSequence);
            Matcher matcher = Pattern.compile("\\B#[#|\u001b]((?:[0-9][PSVAO][a-z0-9][a-zA-Z0-9]{3}[u0-9]?[a-zA-Z0-9]{7,}))#").matcher(spannableString);
            while (matcher.find()) {
                final String strSubstring = matcher.group().substring(2, matcher.group().length() - 1);
                int[] iArrB = chat.ola.vn.entity.i.b(strSubstring);
                int i3 = 0;
                Object[] objArr = 0;
                if (iArrB[0] > 0 && iArrB[1] > 0) {
                    i = Math.min(iArrB[0], i);
                    i2 = Math.min(iArrB[1], i2);
                }
                if (i >= chat.ola.vn.e.c) {
                    float f2 = i / i2;
                    int i4 = chat.ola.vn.e.c;
                    i2 = (int) (i4 / f2);
                    i = i4;
                }
                chat.ola.vn.view.a aVar = new chat.ola.vn.view.a(i, i2);
                aVar.a(strSubstring);
                ImageSpan imageSpan = new ImageSpan(aVar, 0);
                com.mg.ola.common.d.a.a aVar2 = new com.mg.ola.common.d.a.a(i3, objArr == true ? 1 : 0) { // from class: chat.ola.vn.util.i.5
                    @Override // com.mg.ola.common.d.a.a, android.text.style.ClickableSpan
                    public void onClick(View view) {
                        OlaImageViewerActivity.a(chat.ola.vn.c.c(), view, (Bitmap) null, 0, new OlaMediaEntity(strSubstring, 1, (short) 1));
                    }
                };
                int iStart = matcher.start();
                int iEnd = matcher.end();
                spannableString.setSpan(new AlignmentSpan.Standard(Layout.Alignment.ALIGN_NORMAL), iStart, iEnd, 33);
                spannableString.setSpan(imageSpan, iStart, iEnd, 33);
                spannableString.setSpan(aVar2, iStart, iEnd - 1, 33);
            }
            return spannableString;
        } catch (Throwable unused) {
            return charSequence;
        }
    }

    public static CharSequence a(String str, OlaTextView.b bVar) {
        return a((View) null, bVar, str);
    }

    public static String a(CharSequence charSequence) {
        return c(charSequence, null);
    }

    public static ArrayList<String> a(String str) {
        try {
            ArrayList<String> arrayList = new ArrayList<>();
            Matcher matcher = Pattern.compile("<([^>]+)>").matcher(str);
            while (matcher.find()) {
                arrayList.add(matcher.group(1));
            }
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static ArrayList<String> a(String str, char c2, char c3) {
        try {
            ArrayList<String> arrayList = new ArrayList<>();
            int length = str.length();
            boolean z = false;
            int i = -1;
            for (int i2 = 0; i2 < length; i2++) {
                if (z) {
                    if (str.charAt(i2) == c3 && i > 0) {
                        if (i2 > i) {
                            arrayList.add(str.substring(i, i2));
                        }
                        z = false;
                        i = -1;
                    }
                } else if (str.charAt(i2) == c2) {
                    i = i2 + 1;
                    z = true;
                }
            }
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:23:0x003c A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:25:0x000f A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static java.util.List<java.lang.String> a(java.lang.CharSequence r5, java.lang.String r6, java.lang.StringBuffer r7) {
        /*
            r0 = 0
            if (r5 != 0) goto L4
            return r0
        L4:
            java.lang.String r1 = "\\B#[#|\u001b]((?:[0-9][PSVAO][a-z0-9][a-zA-Z0-9]{3}[u0-9]?[a-zA-Z0-9]{7,}))#"
            java.util.regex.Pattern r1 = java.util.regex.Pattern.compile(r1)     // Catch: java.lang.Throwable -> L44
            java.util.regex.Matcher r5 = r1.matcher(r5)     // Catch: java.lang.Throwable -> L44
            r1 = r0
        Lf:
            boolean r2 = r5.find()     // Catch: java.lang.Throwable -> L44
            if (r2 == 0) goto L40
            java.lang.String r2 = r5.group()     // Catch: java.lang.Throwable -> L44
            r3 = 2
            java.lang.String r4 = r5.group()     // Catch: java.lang.Throwable -> L44
            int r4 = r4.length()     // Catch: java.lang.Throwable -> L44
            int r4 = r4 + (-1)
            java.lang.String r2 = r2.substring(r3, r4)     // Catch: java.lang.Throwable -> L44
            if (r1 != 0) goto L33
            java.util.ArrayList r1 = new java.util.ArrayList     // Catch: java.lang.Throwable -> L44
            r1.<init>()     // Catch: java.lang.Throwable -> L44
        L2f:
            r1.add(r2)     // Catch: java.lang.Throwable -> L44
            goto L3a
        L33:
            boolean r3 = r1.contains(r2)     // Catch: java.lang.Throwable -> L44
            if (r3 != 0) goto L3a
            goto L2f
        L3a:
            if (r6 == 0) goto Lf
            r5.appendReplacement(r7, r6)     // Catch: java.lang.Throwable -> L44
            goto Lf
        L40:
            r5.appendTail(r7)     // Catch: java.lang.Throwable -> L44
            return r1
        L44:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.util.i.a(java.lang.CharSequence, java.lang.String, java.lang.StringBuffer):java.util.List");
    }

    public static List<String> a(CharSequence charSequence, boolean z) {
        ArrayList arrayList = null;
        if (charSequence == null) {
            return null;
        }
        try {
            Matcher matcher = Pattern.compile(c, 2).matcher(charSequence);
            while (matcher.find()) {
                String strGroup = matcher.group();
                if (!m.a(strGroup)) {
                    try {
                        String strE = m.e(strGroup);
                        if (!m.a(strE)) {
                            if (arrayList == null) {
                                arrayList = new ArrayList();
                            }
                            arrayList.add(strE);
                        }
                    } catch (Throwable unused) {
                    }
                }
            }
            if (z) {
                matcher.replaceAll("");
            }
        } catch (Throwable unused2) {
        }
        return arrayList;
    }

    public static boolean a(CharSequence charSequence, String str) {
        try {
            StringBuilder sb = new StringBuilder();
            sb.append("(\\B@");
            sb.append(str);
            sb.append(")");
            return Pattern.compile(sb.toString(), 2).matcher(charSequence).find();
        } catch (Throwable unused) {
            return false;
        }
    }

    public static CharSequence b(final View view, CharSequence charSequence, final OlaTextView.b bVar, int i, boolean z) {
        SpannableString spannableString = charSequence instanceof SpannableString ? (SpannableString) charSequence : new SpannableString(charSequence);
        Matcher matcher = Pattern.compile(c, 2).matcher(charSequence);
        while (matcher.find()) {
            try {
                final String strGroup = matcher.group();
                spannableString.setSpan(bVar == null ? new com.mg.ola.common.d.a.a(i, z) : new com.mg.ola.common.d.a.a(i, z) { // from class: chat.ola.vn.util.i.2
                    @Override // com.mg.ola.common.d.a.a, android.text.style.ClickableSpan
                    public void onClick(View view2) {
                        bVar.a(view, null, strGroup);
                    }
                }, matcher.start(), matcher.end(), 33);
            } catch (Throwable unused) {
            }
        }
        return spannableString;
    }

    /* JADX WARN: Multi-variable type inference failed */
    public static CharSequence b(CharSequence charSequence, int i, int i2) throws UnsupportedEncodingException {
        try {
            SpannableString spannableString = charSequence instanceof SpannableString ? (SpannableString) charSequence : new SpannableString(charSequence);
            Matcher matcher = Pattern.compile(b).matcher(spannableString);
            while (matcher.find()) {
                String strGroup = matcher.group();
                final String strDecode = null;
                try {
                    strDecode = URLDecoder.decode(strGroup.substring("file:\\".length(), strGroup.length()), "UTF-8");
                } catch (Throwable unused) {
                }
                if (m.a(strDecode)) {
                    return charSequence;
                }
                int[] iArrA = com.mg.ola.common.d.f.a(strDecode);
                int i3 = 0;
                Object[] objArr = 0;
                if (iArrA[0] > 0 && iArrA[1] > 0) {
                    i = Math.min(iArrA[0], i);
                    i2 = Math.min(iArrA[1], i2);
                }
                if (i >= chat.ola.vn.e.c) {
                    float f2 = i / i2;
                    int i4 = chat.ola.vn.e.c;
                    i2 = (int) (i4 / f2);
                    i = i4;
                }
                chat.ola.vn.view.a aVar = new chat.ola.vn.view.a(i, i2);
                aVar.b(strGroup);
                ImageSpan imageSpan = new ImageSpan(aVar, 0);
                com.mg.ola.common.d.a.a aVar2 = new com.mg.ola.common.d.a.a(i3, objArr == true ? 1 : 0) { // from class: chat.ola.vn.util.i.6
                    @Override // com.mg.ola.common.d.a.a, android.text.style.ClickableSpan
                    public void onClick(View view) {
                        OlaImageViewerActivity.a(chat.ola.vn.c.c(), view, (Bitmap) null, 0, new OlaMediaEntity(strDecode, 2, (short) 1));
                    }
                };
                int iStart = matcher.start();
                int iEnd = matcher.end();
                spannableString.setSpan(new AlignmentSpan.Standard(Layout.Alignment.ALIGN_NORMAL), iStart, iEnd, 33);
                spannableString.setSpan(imageSpan, iStart, iEnd, 33);
                spannableString.setSpan(aVar2, iStart, iEnd - 1, 33);
            }
            return spannableString;
        } catch (Throwable unused2) {
            return charSequence;
        }
    }

    public static CharSequence b(String str) {
        try {
            if (g == null) {
                g = new chat.ola.vn.entry.f() { // from class: chat.ola.vn.util.i.7
                    @Override // chat.ola.vn.entry.f
                    public CharSequence a(View view, OlaTextView.b bVar, CharSequence charSequence) {
                        return i.b(view, i.d(view, i.a(view, i.c(view, h.a().a(g.a().a(charSequence)), bVar, chat.ola.vn.f.g, false), bVar, chat.ola.vn.f.g, false), bVar, chat.ola.vn.f.g, false), bVar, chat.ola.vn.f.g, false);
                    }
                };
            }
            return g.a(null, chat.ola.vn.q.a.a(), str);
        } catch (Throwable th) {
            th.printStackTrace();
            return str;
        }
    }

    public static String b(CharSequence charSequence, String str) {
        StringBuilder sb = new StringBuilder();
        Matcher matcher = Pattern.compile(e, 2).matcher(charSequence);
        while (matcher.find()) {
            if (str == null || !matcher.group().equalsIgnoreCase(str)) {
                sb.append(matcher.group());
                sb.append(" ");
            }
        }
        return sb.toString().trim();
    }

    public static ArrayList<String> b(CharSequence charSequence) {
        ArrayList<String> arrayList = new ArrayList<>();
        Matcher matcher = Pattern.compile("\\B#[#|\u001b]((?:[0-9][PSVAO][a-z0-9][a-zA-Z0-9]{3}[u0-9]?[a-zA-Z0-9]{7,}))#").matcher(charSequence);
        while (matcher.find()) {
            String strSubstring = matcher.group().substring(2, matcher.group().length() - 1);
            if (!arrayList.contains(strSubstring)) {
                arrayList.add(strSubstring);
            }
        }
        return arrayList;
    }

    public static List<String> b(CharSequence charSequence, boolean z) {
        ArrayList arrayList = null;
        if (charSequence == null) {
            return null;
        }
        try {
            Matcher matcher = Pattern.compile(c, 2).matcher(charSequence);
            while (matcher.find()) {
                String strGroup = matcher.group();
                if (!m.a(strGroup)) {
                    try {
                        String strG = m.g(strGroup);
                        if (!m.a(strG)) {
                            if (arrayList == null) {
                                arrayList = new ArrayList();
                            }
                            arrayList.add(strG);
                        }
                    } catch (Throwable unused) {
                    }
                }
            }
            if (z) {
                matcher.replaceAll("");
            }
        } catch (Throwable unused2) {
        }
        return arrayList;
    }

    public static CharSequence c(final View view, CharSequence charSequence, final OlaTextView.b bVar, int i, boolean z) {
        SpannableString spannableString = charSequence instanceof SpannableString ? (SpannableString) charSequence : new SpannableString(charSequence);
        Matcher matcher = Pattern.compile(e, 2).matcher(charSequence);
        while (matcher.find()) {
            try {
                final String strGroup = matcher.group();
                spannableString.setSpan(bVar == null ? new com.mg.ola.common.d.a.a(i, z) : new com.mg.ola.common.d.a.a(i, z) { // from class: chat.ola.vn.util.i.3
                    @Override // com.mg.ola.common.d.a.a, android.text.style.ClickableSpan
                    public void onClick(View view2) {
                        bVar.a(view, null, strGroup);
                    }
                }, matcher.start(), matcher.end(), 33);
            } catch (Throwable unused) {
            }
        }
        return spannableString;
    }

    public static CharSequence c(String str) {
        return a((View) null, chat.ola.vn.q.a.a(), str);
    }

    public static String c(CharSequence charSequence, String str) {
        StringBuilder sb = new StringBuilder();
        Matcher matcher = Pattern.compile(d, 2).matcher(charSequence);
        while (matcher.find()) {
            if (str == null || !matcher.group().equalsIgnoreCase(str)) {
                sb.append(matcher.group());
                sb.append(" ");
            }
        }
        return sb.toString().trim();
    }

    public static ArrayList<String> c(CharSequence charSequence) {
        try {
            ArrayList<String> arrayList = new ArrayList<>();
            Matcher matcher = Pattern.compile(b, 2).matcher(charSequence);
            while (matcher.find()) {
                String strGroup = matcher.group();
                if (!arrayList.contains(strGroup)) {
                    arrayList.add(strGroup);
                }
            }
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static CharSequence d(final View view, CharSequence charSequence, final OlaTextView.b bVar, int i, boolean z) {
        SpannableString spannableString = charSequence instanceof SpannableString ? (SpannableString) charSequence : new SpannableString(charSequence);
        Matcher matcher = Pattern.compile(d, 2).matcher(charSequence);
        while (matcher.find()) {
            try {
                final String strGroup = matcher.group();
                spannableString.setSpan(bVar == null ? new com.mg.ola.common.d.a.a(i, z) : new com.mg.ola.common.d.a.a(i, z) { // from class: chat.ola.vn.util.i.4
                    @Override // com.mg.ola.common.d.a.a, android.text.style.ClickableSpan
                    public void onClick(View view2) {
                        bVar.a(view, null, strGroup);
                    }
                }, matcher.start(), matcher.end(), 33);
            } catch (Throwable unused) {
            }
        }
        return spannableString;
    }

    public static String d(CharSequence charSequence) {
        if (charSequence == null) {
            return null;
        }
        try {
            Matcher matcher = Pattern.compile(c, 2).matcher(charSequence);
            while (matcher.find()) {
                String strGroup = matcher.group();
                if (!m.a(strGroup)) {
                    try {
                        String strE = m.e(strGroup);
                        if (!m.a(strE)) {
                            return strE;
                        }
                    } catch (Throwable unused) {
                        continue;
                    }
                }
            }
        } catch (Throwable unused2) {
        }
        return null;
    }

    public static String d(CharSequence charSequence, String str) {
        return (charSequence == null || charSequence.length() == 0) ? "" : Pattern.compile("\\B#[#|\u001b]((?:[0-9][PSVAO][a-z0-9][a-zA-Z0-9]{3}[u0-9]?[a-zA-Z0-9]{7,}))#").matcher(charSequence).replaceAll(str);
    }

    public static String e(CharSequence charSequence) {
        if (charSequence == null) {
            return null;
        }
        try {
            Matcher matcher = Pattern.compile(a, 2).matcher(charSequence);
            if (matcher.find()) {
                return matcher.group();
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static String f(CharSequence charSequence) {
        if (charSequence == null) {
            return null;
        }
        try {
            Matcher matcher = Pattern.compile(c, 2).matcher(charSequence);
            if (matcher.find()) {
                return matcher.group();
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static String g(CharSequence charSequence) {
        if (charSequence == null) {
            return null;
        }
        try {
            Matcher matcher = Pattern.compile(c, 2).matcher(charSequence);
            while (matcher.find()) {
                String strGroup = matcher.group();
                if (!m.a(strGroup)) {
                    try {
                        String strG = m.g(strGroup);
                        if (!m.a(strG)) {
                            return strG;
                        }
                    } catch (Throwable unused) {
                        continue;
                    }
                }
            }
        } catch (Throwable unused2) {
        }
        return null;
    }
}
