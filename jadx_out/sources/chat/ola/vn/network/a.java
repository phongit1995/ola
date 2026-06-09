package chat.ola.vn.network;

import android.os.AsyncTask;

/* JADX INFO: loaded from: classes.dex */
public class a extends AsyncTask<b, Void, Void> {
    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public Void doInBackground(b... bVarArr) {
        if (bVarArr != null) {
            try {
                if (bVarArr.length > 0) {
                    b bVar = bVarArr[0];
                    try {
                        bVar.a.close();
                    } catch (Throwable unused) {
                    }
                    bVar.a = null;
                }
            } catch (Throwable unused2) {
            }
        }
        return null;
    }
}
