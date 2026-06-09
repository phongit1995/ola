package chat.ola.vn.util;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;

/* JADX INFO: loaded from: classes.dex */
public class a {
    public static boolean a = true;
    public static boolean b = true;
    public static boolean c = true;
    private static int d = 2;

    public static AdView a(View view, LayoutInflater layoutInflater) {
        int i = (chat.ola.vn.e.a * 80) / 100;
        if (i > 1100) {
            i = 1100;
        }
        int i2 = (i * 170) / 360;
        if (i2 > 600) {
            i = 1270;
            i2 = 600;
        }
        if (i2 < 170) {
            i2 = 170;
        }
        AdSize adSize = new AdSize(i, i2);
        FrameLayout frameLayout = (FrameLayout) view.findViewById(R.id.adMobNativeView);
        AdView adView = new AdView(layoutInflater.getContext());
        adView.setAdSize(adSize);
        adView.setAdUnitId(a(0));
        adView.setLayoutParams(new ViewGroup.LayoutParams(-2, -2));
        frameLayout.addView(adView);
        view.setTag(adView);
        adView.setAdListener(new AdListener() { // from class: chat.ola.vn.util.a.1
            @Override // com.google.android.gms.ads.AdListener
            public void onAdClosed() {
                super.onAdClosed();
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdFailedToLoad(int i3) {
                super.onAdFailedToLoad(i3);
                a.a = false;
                try {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.a.1.1
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                chat.ola.vn.h.t.f();
                            } catch (Throwable unused) {
                            }
                        }
                    });
                } catch (Throwable unused) {
                }
                f.a().a(i3);
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdLeftApplication() {
                super.onAdLeftApplication();
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdLoaded() {
                super.onAdLoaded();
                a.a = true;
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdOpened() {
                super.onAdOpened();
                a.a = true;
            }
        });
        return adView;
    }

    public static String a(int i) {
        if (d == 0) {
            switch (i) {
                case 0:
                case 1:
                case 2:
                    return "ca-app-pub-8198619867953749/7386968413";
                case 3:
                    return "ca-app-pub-8198619867953749/5058742112";
                default:
                    return "ca-app-pub-8198619867953749/7386968413";
            }
        }
        if (d == 1) {
            switch (i) {
                case 0:
                case 1:
                case 2:
                    return "ca-app-pub-8198619867953749/9662596202";
                case 3:
                    return "ca-app-pub-8198619867953749/5969519935";
                default:
                    return "ca-app-pub-8198619867953749/9662596202";
            }
        }
        switch (i) {
            case 0:
            case 1:
            case 2:
                return "ca-app-pub-2526638984888811/3737166318";
            case 3:
                return "ca-app-pub-2526638984888811/7784222537";
            default:
                return "ca-app-pub-2526638984888811/3737166318";
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public static void a() {
        int i;
        int iCurrentTimeMillis = (int) (System.currentTimeMillis() % 20);
        if (iCurrentTimeMillis == 0) {
            i = 0;
        } else {
            if (iCurrentTimeMillis == 1) {
                d = 1;
                return;
            }
            i = 2;
        }
        d = i;
    }

    public static AdView b(View view, LayoutInflater layoutInflater) {
        int i = (chat.ola.vn.e.a * 80) / 100;
        int i2 = 1100;
        if (i > 1100) {
            i = 1100;
        }
        int i3 = (i * 170) / 360;
        if (i3 > 1100) {
            i = 2329;
        } else {
            i2 = i3;
        }
        if (i2 < 170) {
            i2 = 170;
        }
        AdSize adSize = new AdSize(i, i2);
        FrameLayout frameLayout = (FrameLayout) view.findViewById(R.id.adMobNativeView);
        AdView adView = new AdView(layoutInflater.getContext());
        adView.setAdSize(adSize);
        adView.setAdUnitId(a(1));
        adView.setLayoutParams(new ViewGroup.LayoutParams(-2, -2));
        frameLayout.addView(adView);
        view.setTag(adView);
        adView.setAdListener(new AdListener() { // from class: chat.ola.vn.util.a.2
            @Override // com.google.android.gms.ads.AdListener
            public void onAdClosed() {
                super.onAdClosed();
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdFailedToLoad(int i4) {
                super.onAdFailedToLoad(i4);
                a.b = false;
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdLeftApplication() {
                super.onAdLeftApplication();
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdLoaded() {
                super.onAdLoaded();
                a.b = true;
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdOpened() {
                super.onAdOpened();
                a.b = true;
            }
        });
        return adView;
    }

    public static String b() {
        return d == 0 ? "ca-app-pub-8198619867953749~1182874111" : d == 1 ? "ca-app-pub-8198619867953749~6192759835" : "ca-app-pub-2526638984888811~8989492996";
    }

    public static AdView c(View view, LayoutInflater layoutInflater) {
        int i = (chat.ola.vn.e.a * 85) / 100;
        int i2 = 1100;
        if (i > 1100) {
            i = 1100;
        }
        int i3 = (i * 330) / 360;
        if (i3 > 1100) {
            i = 1200;
        } else {
            i2 = i3;
        }
        if (i2 < 330) {
            i2 = 330;
        }
        AdSize adSize = new AdSize(i, i2);
        FrameLayout frameLayout = (FrameLayout) view.findViewById(R.id.adMobNativeView);
        AdView adView = new AdView(layoutInflater.getContext());
        adView.setAdSize(adSize);
        adView.setAdUnitId(a(2));
        adView.setLayoutParams(new ViewGroup.LayoutParams(-1, -2));
        frameLayout.addView(adView);
        view.setTag(adView);
        adView.setAdListener(new AdListener() { // from class: chat.ola.vn.util.a.3
            @Override // com.google.android.gms.ads.AdListener
            public void onAdClosed() {
                super.onAdClosed();
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdFailedToLoad(int i4) {
                super.onAdFailedToLoad(i4);
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdLeftApplication() {
                super.onAdLeftApplication();
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdLoaded() {
                super.onAdLoaded();
                a.c = true;
            }

            @Override // com.google.android.gms.ads.AdListener
            public void onAdOpened() {
                super.onAdOpened();
                a.c = true;
            }
        });
        return adView;
    }
}
