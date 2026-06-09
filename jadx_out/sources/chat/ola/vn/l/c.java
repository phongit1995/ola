package chat.ola.vn.l;

import android.os.AsyncTask;
import chat.ola.vn.network.a.a.p;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class c extends AsyncTask<Void, Void, List<String>> {
    private p a;

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public List<String> doInBackground(Void... voidArr) {
        try {
            if (this.a != null) {
                return this.a.a(chat.ola.vn.util.http.a.f(this.a.a()));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    public void a(p pVar) {
        this.a = pVar;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(List<String> list) {
        try {
            this.a.a(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
