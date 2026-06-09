package chat.ola.vn.c;

import android.annotation.TargetApi;
import chat.ola.vn.OlaApplication;
import java.util.concurrent.Executor;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
@TargetApi(11)
public class e {
    public static int a;
    public static Executor b;
    private static long c;

    public void a(f... fVarArr) {
        try {
            int i = 0;
            if (com.mg.ola.common.d.g.c()) {
                if (b == null) {
                    try {
                        int iAvailableProcessors = Runtime.getRuntime().availableProcessors() - 1;
                        if (iAvailableProcessors >= 0) {
                            i = iAvailableProcessors;
                        }
                    } catch (Throwable unused) {
                    }
                    int i2 = i + 1;
                    b = new ThreadPoolExecutor(i2, i2, 10000L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue(20), new ThreadFactory() { // from class: chat.ola.vn.c.e.1
                        @Override // java.util.concurrent.ThreadFactory
                        public Thread newThread(Runnable runnable) {
                            Thread thread = new Thread(runnable);
                            thread.setName(OlaApplication.a + " MediaLoaderTask-" + e.a);
                            e.a = e.a + 1;
                            return thread;
                        }
                    });
                }
                new d().executeOnExecutor(b, fVarArr);
                return;
            }
            if (d.a.intValue() < 15) {
                c = 0L;
                new d().execute(fVarArr);
            } else if (c == 0) {
                c = System.currentTimeMillis();
            } else if (System.currentTimeMillis() - c > 60000) {
                c = 0L;
                d.a = 0;
            }
        } catch (Throwable unused2) {
        }
    }
}
