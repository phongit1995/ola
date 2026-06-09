package chat.ola.vn.util;

import com.facebook.appevents.AppEventsLogger;

/* JADX INFO: loaded from: classes.dex */
public class f {
    private static f a;
    private AppEventsLogger b = null;

    private f() {
    }

    public static f a() {
        if (a == null) {
            a = new f();
        }
        return a;
    }

    public void a(int i) {
        try {
            this.b.logEvent("FAIL_ADMOB_REASON: " + i);
        } catch (Throwable unused) {
        }
    }

    public void a(AppEventsLogger appEventsLogger) {
        this.b = appEventsLogger;
    }

    public void a(String str) {
        try {
            this.b.logEvent("LINK_CLICKED");
        } catch (Throwable unused) {
        }
    }

    public void a(String str, long j) {
        try {
            this.b.logEvent(str, j);
        } catch (Throwable unused) {
        }
    }

    public void b() {
        try {
            this.b.logEvent("FB_PROFILE_PICTURE");
        } catch (Throwable unused) {
        }
    }

    public void b(String str) {
        try {
            this.b.logEvent("LINK_APPROVED");
        } catch (Throwable unused) {
        }
    }

    public void c() {
        try {
            this.b.logEvent("FB_COVER_PICTURE");
        } catch (Throwable unused) {
        }
    }

    public void c(String str) {
        try {
            this.b.logEvent(str);
        } catch (Throwable unused) {
        }
    }
}
