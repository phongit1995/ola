package chat.ola.vn.util;

import android.text.SpannableString;
import android.text.style.ImageSpan;
import chat.ola.vn.OlaApplication;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes.dex */
public class g {
    private static g c;
    private String a;
    private Pattern b;
    private Map<Integer, Integer> d;

    private g() {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        StringBuilder sbAppendCodePoint = sb.appendCodePoint(8192);
        sbAppendCodePoint.append("-");
        StringBuilder sbAppendCodePoint2 = sbAppendCodePoint.appendCodePoint(11093).appendCodePoint(126976);
        sbAppendCodePoint2.append("-");
        StringBuilder sbAppendCodePoint3 = sbAppendCodePoint2.appendCodePoint(128767);
        sbAppendCodePoint3.append("]");
        this.a = sbAppendCodePoint3.toString();
        this.b = Pattern.compile(this.a);
        b();
    }

    private int a(Map<Integer, Integer> map, chat.ola.vn.entry.h[] hVarArr) {
        int i;
        try {
            int length = hVarArr.length;
            int i2 = 0;
            i = 0;
            while (i2 < length) {
                try {
                    chat.ola.vn.entry.h hVar = hVarArr[i2];
                    int i3 = i;
                    for (int i4 : hVar.a()) {
                        try {
                            map.put(Integer.valueOf(i4), Integer.valueOf(hVar.d));
                            i3++;
                        } catch (Throwable th) {
                            th = th;
                            i = i3;
                            th.printStackTrace();
                            return i;
                        }
                    }
                    i2++;
                    i = i3;
                } catch (Throwable th2) {
                    th = th2;
                }
            }
        } catch (Throwable th3) {
            th = th3;
            i = 0;
        }
        return i;
    }

    public static g a() {
        if (c == null) {
            c = new g();
        }
        return c;
    }

    private void b() {
        this.d = new TreeMap();
        a(this.d, chat.ola.vn.r.c.c);
        a(this.d, chat.ola.vn.r.c.d);
        a(this.d, chat.ola.vn.r.c.b);
        a(this.d, chat.ola.vn.r.c.e);
    }

    public CharSequence a(CharSequence charSequence) {
        if (charSequence == null) {
            return "";
        }
        SpannableString spannableString = charSequence instanceof SpannableString ? (SpannableString) charSequence : new SpannableString(charSequence);
        Matcher matcher = this.b.matcher(charSequence);
        while (matcher.find()) {
            Integer num = this.d.get(Integer.valueOf(matcher.group(0).codePointAt(0)));
            if (num != null) {
                spannableString.setSpan(new ImageSpan(OlaApplication.a(), num.intValue(), 0), matcher.start(), matcher.end(), 33);
            }
        }
        return spannableString;
    }

    public Integer a(int i) {
        try {
            return this.d.get(Integer.valueOf(i));
        } catch (Throwable unused) {
            return null;
        }
    }
}
