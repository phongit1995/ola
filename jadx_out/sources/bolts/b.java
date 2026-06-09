package bolts;

import android.net.Uri;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b {
    private Uri a;
    private List<a> b;
    private Uri c;

    public static class a {
        private final Uri a;
        private final String b;
        private final String c;
        private final String d;

        public a(String str, String str2, Uri uri, String str3) {
            this.b = str;
            this.c = str2;
            this.a = uri;
            this.d = str3;
        }
    }

    public b(Uri uri, List<a> list, Uri uri2) {
        this.a = uri;
        this.b = list == null ? Collections.emptyList() : list;
        this.c = uri2;
    }
}
