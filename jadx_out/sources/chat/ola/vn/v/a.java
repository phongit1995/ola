package chat.ola.vn.v;

import android.os.AsyncTask;
import chat.ola.vn.h;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class a extends AsyncTask<b, Void, b> {
    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public b doInBackground(b... bVarArr) {
        if (bVarArr == null) {
            return null;
        }
        try {
            if (bVarArr.length <= 0) {
                return null;
            }
            b bVar = bVarArr[0];
            if (bVar != null && !m.a(bVar.a)) {
                chat.ola.vn.h.b.a(bVar.c);
            }
            chat.ola.vn.h.b.a(h.a(), h.t.e(), 0);
            chat.ola.vn.h.b.b(h.a(), h.t.p());
            return bVar;
        } catch (Throwable unused) {
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(b bVar) {
        if (bVar != null) {
            bVar.a();
        }
    }
}
