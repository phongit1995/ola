package chat.ola.vn;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Point;
import android.net.ConnectivityManager;
import android.os.Handler;
import android.os.Looper;
import android.telephony.TelephonyManager;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.WindowManager;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.balloon.OlaBalloonService;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import com.facebook.FacebookSdk;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.appevents.AppEventsLogger;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.firebase.iid.FirebaseInstanceId;
import java.util.Iterator;
import java.util.Locale;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale", "NewApi"})
public class OlaApplication extends Application implements chat.ola.vn.f.a {
    public static String a = "Ola";
    public static OlaNetworkService b = null;
    public static OlaBalloonService c = null;
    public static boolean d = false;
    private static Context e = null;
    private static Handler f = null;
    private static Runnable g = null;
    private static long h = 0;
    private static boolean i = false;

    public static Context a() {
        return e;
    }

    public static String a(int i2) {
        try {
            c cVarC = c.c();
            if (cVarC != null) {
                return cVarC.getString(i2);
            }
            c();
            return e.getString(i2);
        } catch (Throwable unused) {
            return "";
        }
    }

    public static String a(int i2, Object... objArr) {
        try {
            c cVarC = c.c();
            if (cVarC != null) {
                return cVarC.getString(i2, objArr);
            }
            c();
            return e.getString(i2, objArr);
        } catch (Throwable unused) {
            return "";
        }
    }

    public static void a(Activity activity) {
        if (h == 0) {
            h = System.currentTimeMillis();
        }
        i = true;
        try {
            if (g != null) {
                g().removeCallbacks(g);
            }
        } catch (Throwable unused) {
        }
        try {
            Iterator<chat.ola.vn.message.f> it2 = h.t.p().iterator();
            while (it2.hasNext()) {
                it2.next().A();
            }
        } catch (Throwable unused2) {
        }
    }

    public static void a(Context context) {
        try {
            String language = Locale.getDefault().getLanguage();
            String strI = x.i();
            if (m.b(strI, language)) {
                return;
            }
            Resources resources = context.getResources();
            DisplayMetrics displayMetrics = resources.getDisplayMetrics();
            Configuration configuration = resources.getConfiguration();
            if (m.b(strI, configuration.locale.getLanguage())) {
                return;
            }
            configuration.locale = new Locale(strI);
            resources.updateConfiguration(configuration, displayMetrics);
        } catch (Throwable unused) {
        }
    }

    public static void a(Runnable runnable) {
        g().post(runnable);
    }

    public static void a(Runnable runnable, long j) {
        try {
            g().postDelayed(runnable, j);
        } catch (Throwable unused) {
        }
    }

    public static Resources b() {
        return e.getResources();
    }

    private String b(Context context) {
        String strP = e.a().p();
        return m.a(strP) ? FirebaseInstanceId.getInstance().getToken() : strP;
    }

    public static ScheduledFuture<?> b(Runnable runnable, long j) {
        try {
            return h.P.schedule(runnable, j, TimeUnit.MILLISECONDS);
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void b(int i2) {
        try {
            chat.ola.vn.util.c.b.b(a(), i2);
        } catch (Throwable unused) {
        }
    }

    public static void b(Activity activity) {
        i = false;
        try {
            if (g != null) {
                g().removeCallbacks(g);
            } else {
                g = new Runnable() { // from class: chat.ola.vn.OlaApplication.1
                    @Override // java.lang.Runnable
                    public void run() {
                        OlaApplication.d();
                    }
                };
            }
            g().postDelayed(g, 2000L);
        } catch (Throwable unused) {
        }
    }

    public static void b(Runnable runnable) {
        try {
            h.a(runnable);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void c() {
        try {
            String language = Locale.getDefault().getLanguage();
            String strI = x.i();
            if (m.b(strI, language)) {
                return;
            }
            Resources resources = e.getResources();
            DisplayMetrics displayMetrics = resources.getDisplayMetrics();
            Configuration configuration = resources.getConfiguration();
            if (m.b(strI, configuration.locale.getLanguage())) {
                return;
            }
            configuration.locale = new Locale(strI);
            resources.updateConfiguration(configuration, displayMetrics);
        } catch (Throwable unused) {
        }
    }

    public static void c(Runnable runnable) {
        try {
            g().removeCallbacks(runnable);
        } catch (Throwable unused) {
        }
    }

    public static void d() {
        int iQ;
        try {
            long jCurrentTimeMillis = System.currentTimeMillis();
            h = 0L;
            c.d_ = Long.valueOf(jCurrentTimeMillis);
            e.a().c(jCurrentTimeMillis);
            chat.ola.vn.v.b bVar = new chat.ola.vn.v.b();
            bVar.a(h.a());
            bVar.a(h.r);
            bVar.b(h.G);
            try {
                new chat.ola.vn.v.a().execute(bVar);
            } catch (Throwable unused) {
            }
            try {
                iQ = h.t.q();
            } catch (Throwable unused2) {
                iQ = 0;
            }
            b(iQ);
            if (iQ == 0) {
                chat.ola.vn.util.c.b.a(a());
            }
        } catch (Throwable unused3) {
        }
    }

    public static boolean e() {
        return !i;
    }

    public static String f() {
        return "chat.ola.vn";
    }

    public static Handler g() {
        if (f == null) {
            f = new Handler(Looper.getMainLooper());
        }
        return f;
    }

    private int h() {
        try {
            Resources resources = getResources();
            try {
                int identifier = resources.getIdentifier("status_bar_height", "dimen", AccountKitGraphConstants.SDK_TYPE_ANDROID);
                return identifier > 0 ? resources.getDimensionPixelSize(identifier) : (int) Math.ceil(resources.getDisplayMetrics().density * 25.0f);
            } catch (Throwable unused) {
                int i2 = resources.getDisplayMetrics().densityDpi;
                if (i2 == 120) {
                    return 19;
                }
                if (i2 == 160) {
                    return 25;
                }
                if (i2 == 240) {
                    return 38;
                }
                if (i2 == 320 || i2 == 480) {
                    return 50;
                }
                return h.z;
            }
        } catch (Throwable unused2) {
            return 75;
        }
    }

    private void i() {
        try {
            GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();
            int iIsGooglePlayServicesAvailable = googleApiAvailability.isGooglePlayServicesAvailable(this);
            if (iIsGooglePlayServicesAvailable == 0) {
                h.f = b(this);
            } else if (googleApiAvailability.isUserResolvableError(iIsGooglePlayServicesAvailable)) {
                googleApiAvailability.showErrorNotification(this, iIsGooglePlayServicesAvailable);
            } else {
                chat.ola.vn.i.i.a(this);
            }
        } catch (Throwable unused) {
        }
    }

    private void j() {
        try {
            t.a().b();
            t.a().c();
            OlaBottomTabActivity.E();
        } catch (Throwable unused) {
        }
    }

    @Override // android.app.Application, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        c();
    }

    @Override // android.app.Application
    @SuppressLint({"NewApi"})
    public void onCreate() {
        int i2;
        super.onCreate();
        chat.ola.vn.util.a.a();
        try {
            f.a(this);
            try {
                System.setProperty("http.keepAlive", "true");
                System.setProperty("http.maxConnections", "12");
            } catch (Throwable unused) {
            }
            try {
                String string = getString(R.string.app_name);
                if (!m.a(string)) {
                    a = string;
                }
            } catch (Throwable unused2) {
            }
            chat.ola.vn.util.j.a(10000L);
            e = this;
            h.g = n.f(this);
            c();
            if (n.c(this)) {
                h.F = true;
                try {
                    if (((ConnectivityManager) getSystemService("connectivity")).getActiveNetworkInfo().getType() == 1) {
                        h.I = true;
                    } else {
                        h.I = false;
                    }
                } catch (Throwable unused3) {
                }
            } else {
                h.F = false;
            }
            i();
            startService(new Intent(this, (Class<?>) OlaNetworkService.class));
            startService(new Intent(this, (Class<?>) OlaBalloonService.class));
            try {
                Display defaultDisplay = ((WindowManager) getSystemService("window")).getDefaultDisplay();
                DisplayMetrics displayMetrics = new DisplayMetrics();
                defaultDisplay.getMetrics(displayMetrics);
                TelephonyManager telephonyManager = (TelephonyManager) getSystemService("phone");
                try {
                    h.S = telephonyManager.getLine1Number();
                } catch (Throwable unused4) {
                }
                if (com.mg.ola.common.d.g.e()) {
                    Point point = new Point();
                    defaultDisplay.getSize(point);
                    e.c = point.x;
                    e.a = (int) (e.c / displayMetrics.density);
                    e.d = point.y;
                    i2 = e.d;
                } else {
                    e.c = defaultDisplay.getWidth();
                    e.a = (int) (e.c / displayMetrics.density);
                    e.d = defaultDisplay.getHeight();
                    i2 = e.d;
                }
                e.b = (int) (i2 / displayMetrics.density);
                try {
                    if (!h.I) {
                        h.J = true;
                        if (telephonyManager.getNetworkType() == 1 || telephonyManager.getNetworkType() == 2) {
                            h.J = false;
                        }
                    }
                } catch (Throwable unused5) {
                }
                if (com.mg.ola.common.d.g.c()) {
                    h.A = getResources().getDimensionPixelSize(android.R.dimen.notification_large_icon_width);
                    h.z = getResources().getDimensionPixelSize(android.R.dimen.notification_large_icon_height);
                }
                e.e = h();
            } catch (Throwable unused6) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        chat.ola.vn.util.c.b.f(a());
        try {
            FacebookSdk.sdkInitialize(getApplicationContext());
            AppEventsLogger.activateApp((Application) this);
            chat.ola.vn.util.f.a().a(AppEventsLogger.newLogger(this));
        } catch (Throwable unused7) {
        }
    }

    @Override // android.app.Application, android.content.ComponentCallbacks
    public void onLowMemory() {
        super.onLowMemory();
        t.a().b();
        t.a().c();
    }

    @Override // android.app.Application, android.content.ComponentCallbacks2
    public void onTrimMemory(int i2) {
        super.onTrimMemory(i2);
        if (i2 != 10) {
            if (i2 == 15 || i2 == 20) {
                return;
            }
            if (i2 != 40) {
                if (i2 == 60 || i2 == 80) {
                    j();
                    return;
                }
                return;
            }
        }
        t.a().b();
        t.a().c();
    }
}
