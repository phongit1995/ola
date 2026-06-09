package bolts;

import android.annotation.SuppressLint;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
final class a {
    private final Executor d = new ExecutorC0005a();
    private static final a c = new a();
    private static final int e = Runtime.getRuntime().availableProcessors();
    static final int a = e + 1;
    static final int b = (e * 2) + 1;

    /* JADX INFO: renamed from: bolts.a$a, reason: collision with other inner class name */
    private static class ExecutorC0005a implements Executor {
        private ExecutorC0005a() {
        }

        @Override // java.util.concurrent.Executor
        public void execute(Runnable runnable) {
            new Handler(Looper.getMainLooper()).post(runnable);
        }
    }

    private a() {
    }

    public static ExecutorService a() {
        ThreadPoolExecutor threadPoolExecutor = new ThreadPoolExecutor(a, b, 1L, TimeUnit.SECONDS, new LinkedBlockingQueue());
        a(threadPoolExecutor, true);
        return threadPoolExecutor;
    }

    @SuppressLint({"NewApi"})
    public static void a(ThreadPoolExecutor threadPoolExecutor, boolean z) {
        if (Build.VERSION.SDK_INT >= 9) {
            threadPoolExecutor.allowCoreThreadTimeOut(z);
        }
    }

    public static Executor b() {
        return c.d;
    }
}
