package chat.ola.vn.network;

import android.os.AsyncTask;
import android.util.Log;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collections;

/* JADX INFO: loaded from: classes.dex */
public class h extends AsyncTask<g, Void, g> {
    private long a = 0;

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public g doInBackground(g... gVarArr) {
        ArrayList arrayList;
        long jCurrentTimeMillis;
        long jLongValue;
        g gVar = gVarArr[0];
        try {
            arrayList = new ArrayList();
            if (chat.ola.vn.h.j == null || chat.ola.vn.h.j.size() == 0) {
                for (int i = 0; i < chat.ola.vn.f.d.e_.length; i++) {
                    arrayList.add(chat.ola.vn.f.d.e_[i]);
                }
            } else {
                arrayList.addAll(chat.ola.vn.h.j);
            }
            try {
                Collections.shuffle(arrayList);
            } catch (Throwable unused) {
            }
            arrayList.add(0, "ocs.ola.vn");
            jCurrentTimeMillis = System.currentTimeMillis();
            jLongValue = gVar.c != null ? gVar.c.longValue() : 30000L;
            this.a = jCurrentTimeMillis;
            if (OlaNetworkService.b == 0) {
                OlaNetworkService.c = 1239;
            } else if (OlaNetworkService.b == 1) {
                if (OlaNetworkService.c == 1239) {
                    OlaNetworkService.c = 80;
                } else {
                    OlaNetworkService.c = 1239;
                }
                OlaNetworkService.b = 2;
            }
        } catch (Throwable unused2) {
            return gVar;
        }
        while (true) {
            int i2 = 0;
            do {
                String str = (String) arrayList.get(i2);
                try {
                    if (System.currentTimeMillis() - jCurrentTimeMillis >= jLongValue) {
                        return gVar;
                    }
                    Log.d("OlaNetworkService", "Try with IP: " + str);
                    Socket socket = new Socket();
                    socket.connect(new InetSocketAddress(str, OlaNetworkService.c), 10000);
                    socket.setKeepAlive(true);
                    gVar.d = socket.getInputStream();
                    gVar.e = socket.getOutputStream();
                    gVar.f = socket;
                    gVar.b = str;
                    gVar.a = str;
                    return gVar;
                } catch (Throwable th) {
                    Log.e("OlaNetworkService", "Error on IP: " + str, th);
                    th.printStackTrace();
                    OlaNetworkService.c = 1239;
                    i2++;
                }
                return gVar;
            } while (i2 < arrayList.size());
            Thread.sleep(1000L);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onCancelled(g gVar) {
        try {
            if (gVar.a() != null) {
                gVar.a().f();
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(g gVar) {
        try {
            Log.d("Network", "Result: " + gVar.toString());
            if (gVar == null || System.currentTimeMillis() - this.a > 45000) {
                return;
            }
            if (gVar.d == null || gVar.e == null) {
                if (gVar.a() != null) {
                    gVar.a().f();
                }
            } else if (gVar.a() != null) {
                gVar.a().a(gVar);
            }
        } catch (Throwable unused) {
        }
    }
}
