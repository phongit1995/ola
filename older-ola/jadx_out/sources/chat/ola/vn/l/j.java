package chat.ola.vn.l;

import android.os.AsyncTask;
import chat.ola.vn.network.a.a.ai;

/* JADX INFO: loaded from: classes.dex */
public class j extends AsyncTask<Void, Void, String> {
    private ai a;

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public String doInBackground(Void... voidArr) {
        try {
            if (this.a != null) {
                return this.a.a(chat.ola.vn.util.http.a.f(this.a.a()));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    public void a(ai aiVar) {
        this.a = aiVar;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(String str) {
        try {
            this.a.a(str);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
