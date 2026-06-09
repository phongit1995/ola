package chat.ola.vn.v;

import android.annotation.SuppressLint;
import android.os.AsyncTask;
import chat.ola.vn.h;
import com.mg.ola.common.d.g;

/* JADX INFO: loaded from: classes.dex */
public class e extends AsyncTask<String, Void, Void> {
    @SuppressLint({"NewApi"})
    public static void a() {
        try {
            if (g.c()) {
                new e().executeOnExecutor(h.R, new String[0]);
            } else {
                new e().execute(new String[0]);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* JADX WARN: Removed duplicated region for block: B:20:0x00c4 A[Catch: Throwable -> 0x0104, TryCatch #1 {Throwable -> 0x0104, blocks: (B:3:0x0001, B:5:0x0031, B:6:0x0034, B:11:0x009f, B:14:0x00a8, B:16:0x00b6, B:18:0x00be, B:20:0x00c4, B:22:0x00e9, B:23:0x00ec), top: B:28:0x0001 }] */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public java.lang.Void doInBackground(java.lang.String... r8) {
        /*
            Method dump skipped, instruction units count: 261
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.v.e.doInBackground(java.lang.String[]):java.lang.Void");
    }
}
