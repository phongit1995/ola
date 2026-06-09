package chat.ola.vn.x;

import android.annotation.SuppressLint;
import android.os.AsyncTask;
import chat.ola.vn.e.m;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class a extends AsyncTask<String, Integer, List<c>> {
    d a;
    String b = null;

    public a a(d dVar) {
        this.a = dVar;
        return this;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public List<c> doInBackground(String... strArr) throws Throwable {
        this.b = strArr[0];
        try {
            List<c> listA = e.a(this.b);
            Collections.sort(listA, new m());
            return listA;
        } catch (Exception unused) {
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(List<c> list) {
        try {
            if (this.a != null) {
                if (list == null) {
                    this.a.a(this.b);
                } else {
                    this.a.a(this.b, list);
                }
            }
        } catch (Throwable unused) {
        }
    }
}
