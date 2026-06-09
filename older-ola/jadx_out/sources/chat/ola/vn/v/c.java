package chat.ola.vn.v;

import android.os.AsyncTask;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class c extends AsyncTask<b, Void, b> {
    public static final String[] a = {"User-Agent", "Mozilla/5.0 (Linux; U; Android 2.2; en-us; DROID2 GLOBAL Build/S273) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1", "Accept", "*/*", "Accept-Charset", "UTF-8,*;q=0.5", "Accept-Language", "en-US,en;q=0.8,vi;q=0.6,fr-FR;q=0.4,fr;q=0.2"};
    private static List<String> b = Arrays.asList("expires", "domain", "path", "secure", "httponly");
    private static Map<String, Map<String, String>> c = new HashMap();

    public interface a {
        void a(String str);
    }

    public static class b {
        public String a;
        public String b;
        public String c;
        public String d;
        public String[] e;
        public String f;
        public a g;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* JADX WARN: Removed duplicated region for block: B:110:0x01b8 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:120:0x01aa A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:144:? A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:45:0x010a  */
    @Override // android.os.AsyncTask
    @android.annotation.SuppressLint({"DefaultLocale"})
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public chat.ola.vn.v.c.b doInBackground(chat.ola.vn.v.c.b... r15) throws java.lang.Throwable {
        /*
            Method dump skipped, instruction units count: 485
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.v.c.doInBackground(chat.ola.vn.v.c$b[]):chat.ola.vn.v.c$b");
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(b bVar) {
        if (bVar.f == null || bVar.g == null) {
            return;
        }
        bVar.g.a(bVar.f);
    }
}
