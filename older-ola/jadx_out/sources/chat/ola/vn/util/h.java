package chat.ola.vn.util;

import android.content.Context;
import android.text.Editable;
import android.text.SpannableString;
import android.text.style.ImageSpan;
import chat.ola.vn.OlaApplication;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes.dex */
public class h {
    private static h a;
    private final Context b;
    private final HashMap<String, Integer> d = b();
    private final Pattern c = c();

    private h(Context context) {
        this.b = context;
    }

    public static h a() {
        if (a == null) {
            a = new h(OlaApplication.a());
        }
        return a;
    }

    private HashMap<String, Integer> b() {
        HashMap<String, Integer> map = new HashMap<>();
        for (chat.ola.vn.entry.h hVar : chat.ola.vn.r.c.a) {
            for (String str : hVar.b) {
                map.put(str, Integer.valueOf(hVar.d));
            }
        }
        return map;
    }

    private Pattern c() {
        StringBuilder sb = new StringBuilder(this.d.size() * 3);
        sb.append("(");
        ArrayList<String> arrayList = new ArrayList(this.d.keySet());
        Collections.sort(arrayList, new Comparator<String>() { // from class: chat.ola.vn.util.h.1
            @Override // java.util.Comparator
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public int compare(String str, String str2) {
                return str2.length() - str.length();
            }
        });
        for (String str : arrayList) {
            sb.append(Character.isLetterOrDigit(str.charAt(0)) ? "\\b" : "\\B");
            sb.append(Pattern.quote(str));
            sb.append('|');
        }
        sb.replace(sb.length() - 1, sb.length(), ")");
        return Pattern.compile(sb.toString());
    }

    public CharSequence a(CharSequence charSequence) {
        if (charSequence == null) {
            return "";
        }
        SpannableString spannableString = charSequence instanceof SpannableString ? (SpannableString) charSequence : new SpannableString(charSequence);
        Matcher matcher = this.c.matcher(charSequence);
        while (matcher.find()) {
            try {
                spannableString.setSpan(new ImageSpan(this.b, this.d.get(matcher.group()).intValue(), 0), matcher.start(), matcher.end(), 33);
            } catch (Throwable unused) {
            }
        }
        return spannableString;
    }

    public Integer a(String str) {
        try {
            return this.d.get(str);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(Editable editable) {
        if (editable == null || editable.length() == 0) {
            return;
        }
        Matcher matcher = this.c.matcher(editable);
        while (matcher.find()) {
            int iIntValue = this.d.get(matcher.group()).intValue();
            if (((ImageSpan[]) editable.getSpans(matcher.start(), matcher.end(), ImageSpan.class)).length <= 0) {
                editable.setSpan(new ImageSpan(this.b, iIntValue), matcher.start(), matcher.end(), 33);
            }
        }
    }
}
