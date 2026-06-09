package bolts;

import com.facebook.accountkit.internal.AccountKitGraphConstants;
import java.util.Locale;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

/* JADX INFO: loaded from: classes.dex */
final class d {
    private static final d a = new d();
    private final ExecutorService b;
    private final ScheduledExecutorService c;
    private final Executor d;

    private static class a implements Executor {
        private ThreadLocal<Integer> a;

        private a() {
            this.a = new ThreadLocal<>();
        }

        private int a() {
            Integer num = this.a.get();
            if (num == null) {
                num = 0;
            }
            int iIntValue = num.intValue() + 1;
            this.a.set(Integer.valueOf(iIntValue));
            return iIntValue;
        }

        private int b() {
            Integer num = this.a.get();
            if (num == null) {
                num = 0;
            }
            int iIntValue = num.intValue() - 1;
            if (iIntValue == 0) {
                this.a.remove();
                return iIntValue;
            }
            this.a.set(Integer.valueOf(iIntValue));
            return iIntValue;
        }

        @Override // java.util.concurrent.Executor
        public void execute(Runnable runnable) {
            try {
                if (a() <= 15) {
                    runnable.run();
                } else {
                    d.a().execute(runnable);
                }
                b();
            } catch (Throwable th) {
                b();
                throw th;
            }
        }
    }

    private d() {
        this.b = !c() ? Executors.newCachedThreadPool() : bolts.a.a();
        this.c = Executors.newSingleThreadScheduledExecutor();
        this.d = new a();
    }

    public static ExecutorService a() {
        return a.b;
    }

    static Executor b() {
        return a.d;
    }

    private static boolean c() {
        String property = System.getProperty("java.runtime.name");
        if (property == null) {
            return false;
        }
        return property.toLowerCase(Locale.US).contains(AccountKitGraphConstants.SDK_TYPE_ANDROID);
    }
}
