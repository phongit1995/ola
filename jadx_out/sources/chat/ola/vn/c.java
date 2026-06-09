package chat.ola.vn;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.KeyEvent;
import android.view.View;
import android.view.Window;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.inputmethod.InputMethodManager;
import android.widget.FrameLayout;
import android.widget.ImageView;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaLoginActivity;
import chat.ola.vn.activity.OlaPhoneVerificationActivity;
import chat.ola.vn.activity.OlaReleaseAppActivity;
import chat.ola.vn.activity.OlaVipStoreActivity;
import chat.ola.vn.balloon.OlaBalloonService;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.ac;
import chat.ola.vn.entity.af;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entity.ah;
import chat.ola.vn.entity.l;
import chat.ola.vn.entity.s;
import chat.ola.vn.lock.OlaLockScreenActivity;
import chat.ola.vn.me.OlaMeCommentActivity;
import chat.ola.vn.me.OlaUserMePageActivity;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import com.facebook.GraphRequest;
import com.google.android.gms.ads.MobileAds;
import com.google.android.gms.common.util.CrashUtils;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale", "NewApi", "RtlHardcoded"})
public abstract class c extends FragmentActivity implements chat.ola.vn.network.f {
    protected static c b_ = null;
    public static boolean c_ = true;
    public static Long d_ = null;
    private static long f = 0;
    private static String g = null;
    private static int h = 0;
    private static boolean i = false;
    private static boolean j = false;
    Dialog a_;
    private chat.ola.vn.i.b e = null;

    private class a extends AsyncTask<String, Void, String> {
        private a() {
        }

        private String b(String str) {
            HashMap map = new HashMap();
            map.put(GraphRequest.FIELDS_PARAM, "ip,ms,acckit,facebook,peighttexst,peightcarsd");
            return chat.ola.vn.util.http.a.a((String) null, "id/pubinfo", (Map<String, String>) map, false);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public String doInBackground(String... strArr) {
            try {
                String strE = chat.ola.vn.util.http.a.e(b(h.g));
                if (m.a(strE)) {
                    return null;
                }
                JSONObject jSONObject = new JSONObject(strE);
                if (jSONObject.has("country")) {
                    String unused = c.g = jSONObject.getString("country");
                    String unused2 = c.g = c.g.toUpperCase(Locale.US);
                }
                if (jSONObject.has("peighttexst")) {
                    h.a = jSONObject.getBoolean("peighttexst");
                }
                if (!jSONObject.has("peightcarsd")) {
                    return null;
                }
                h.b = jSONObject.getBoolean("peightcarsd");
                return null;
            } catch (Throwable th) {
                th.printStackTrace();
                return null;
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public void onPostExecute(String str) {
        }
    }

    private void B() {
        if (isTaskRoot()) {
            if (this instanceof OlaChatViewActivity) {
                chat.ola.vn.m.e.b(this);
            } else if ((this instanceof OlaMeCommentActivity) || (this instanceof OlaUserMePageActivity)) {
                OlaBottomTabActivity.a(this, 1);
            }
            finish();
            return;
        }
        super.onBackPressed();
    }

    private void C() {
        try {
            if (System.currentTimeMillis() - f >= 60000) {
                f = System.currentTimeMillis();
                OlaApplication.b.w();
            }
        } catch (Throwable unused) {
        }
    }

    private void D() {
        try {
            if (d_ != null) {
                if (System.currentTimeMillis() - d_.longValue() > OlaLockScreenActivity.r) {
                    c_ = true;
                }
                d_ = null;
            }
            if (c_) {
                OlaLockScreenActivity.a(this);
            }
        } catch (Throwable unused) {
        }
    }

    private boolean E() {
        try {
            if (OlaApplication.b != null) {
                OlaApplication.b.d();
            } else {
                startService(new Intent(this, (Class<?>) OlaNetworkService.class));
            }
            if (OlaApplication.c == null) {
                startService(new Intent(this, (Class<?>) OlaBalloonService.class));
            }
            if (!b() || h.g()) {
                return true;
            }
            h();
            return false;
        } catch (Throwable unused) {
            return true;
        }
    }

    public static c c() {
        return b_;
    }

    public static boolean x() {
        try {
            return m.b(g, "vn");
        } catch (Throwable unused) {
            return false;
        }
    }

    public static String y() {
        return g;
    }

    protected abstract void a();

    @Override // chat.ola.vn.network.f
    public void a(int i2) {
        try {
            chat.ola.vn.entry.e eVarB = h.v.b(R.string.general_tab_notify);
            if (eVarB == null) {
                eVarB = chat.ola.vn.entry.e.a(R.string.general_tab_notify, R.drawable.ic_tab_notify, R.string.general_tab_notify);
                h.v.a(eVarB, 2);
            }
            if (i2 != 0) {
                eVarB.c("" + i2);
                eVarB.b(2);
            } else {
                eVarB.b(1);
                eVarB.c((String) null);
            }
            h.v.g();
            ((OlaBottomTabActivity) b_).I();
        } catch (Throwable unused) {
        }
    }

    public void a(int i2, int i3, FrameLayout frameLayout) {
        try {
            a(i2, i3, frameLayout, R.drawable.sticker_kiss, 1000L, 2000L);
        } catch (Throwable unused) {
        }
    }

    public void a(int i2, int i3, final FrameLayout frameLayout, int i4, long j2, long j3) {
        try {
            if (h == 0) {
                h = (int) getResources().getDimension(R.dimen.metric_96dp);
            }
            FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(-2, h, 51);
            layoutParams.setMargins(i2 - (h / 2), i3 - (h / 2), 0, 0);
            final ImageView imageView = new ImageView(this);
            imageView.setLayoutParams(layoutParams);
            imageView.setClickable(false);
            imageView.setAdjustViewBounds(true);
            imageView.setImageResource(i4);
            frameLayout.addView(imageView, layoutParams);
            Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.kiss_flying_top_animation);
            if (j3 > 0) {
                j2 += Math.abs(new Random().nextLong()) % j3;
            }
            animationLoadAnimation.setDuration(j2);
            animationLoadAnimation.setAnimationListener(new Animation.AnimationListener() { // from class: chat.ola.vn.c.7
                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationEnd(Animation animation) {
                    try {
                        imageView.setVisibility(8);
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.c.7.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    frameLayout.removeView(imageView);
                                } catch (Throwable th) {
                                    th.printStackTrace();
                                }
                            }
                        });
                    } catch (Throwable unused) {
                    }
                }

                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationRepeat(Animation animation) {
                }

                @Override // android.view.animation.Animation.AnimationListener
                public void onAnimationStart(Animation animation) {
                }
            });
            imageView.startAnimation(animationLoadAnimation);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(int i2, FrameLayout frameLayout) {
        if (i2 > 14) {
            i2 = 14;
        }
        for (int i3 = 0; i3 < i2; i3++) {
            try {
                int iNextInt = new Random().nextInt(e.c / 5);
                if (System.currentTimeMillis() % 2 == 0) {
                    iNextInt = -iNextInt;
                }
                a((e.c / 2) + iNextInt, (e.d / 2) + (-new Random().nextInt(e.d / 4)), frameLayout);
            } catch (Throwable unused) {
                return;
            }
        }
    }

    public void a(int i2, String str, byte[] bArr) {
        h();
    }

    public void a(int i2, final String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        Runnable runnable;
        long j2;
        if (s == 59 && i2 == 1) {
            chat.ola.vn.util.j.d(this, R.string.message_connection_lost_network_title);
            return;
        }
        if (i2 != 0) {
            if (i2 != 23) {
                return;
            }
            b(false);
            runnable = new Runnable() { // from class: chat.ola.vn.c.2
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        String string = str;
                        if (m.c(string)) {
                            string = c.this.getString(R.string.message_account_is_locked);
                        }
                        chat.ola.vn.i.i.b(c.c(), c.this.getString(R.string.dialog_title_inform), string);
                    } catch (Throwable unused) {
                    }
                }
            };
            j2 = 1000;
        } else {
            if (m.a(str)) {
                return;
            }
            if (str.indexOf("Thông tin cá nhân thay đổi. Bạn cần đăng nhập lại.") < 0) {
                if (str.indexOf("verified to join room") >= 0 || str.indexOf("xác thực nick mới được vào phòng") >= 0) {
                    chat.ola.vn.i.i.b(this, getString(R.string.dialog_title_inform), str, getString(R.string.string_verify), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.c.4
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i3) {
                            if (i3 == 0) {
                                try {
                                    OlaPhoneVerificationActivity.a(c.this);
                                } catch (Throwable unused) {
                                    return;
                                }
                            }
                            dialogInterface.dismiss();
                        }
                    });
                    return;
                } else {
                    if (s == 0) {
                        chat.ola.vn.util.j.c(this, str);
                        return;
                    }
                    return;
                }
            }
            b(true);
            runnable = new Runnable() { // from class: chat.ola.vn.c.3
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        chat.ola.vn.i.i.b(c.c(), c.this.getString(R.string.dialog_title_inform), str);
                    } catch (Throwable unused) {
                    }
                }
            };
            j2 = 600;
        }
        OlaApplication.a(runnable, j2);
    }

    @Override // chat.ola.vn.network.f
    public void a(int i2, List<chat.ola.vn.message.f> list) {
    }

    @Override // chat.ola.vn.network.f
    public void a(long j2, int i2, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(long j2, String str) {
    }

    public void a(long j2, String str, String str2, List<chat.ola.vn.message.f> list, List<chat.ola.vn.message.f> list2, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(long j2, String str, String[] strArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(long j2, short s) {
    }

    public void a(View view, FrameLayout frameLayout) {
        if (frameLayout != null) {
            try {
                int[] iArr = new int[2];
                view.getLocationInWindow(iArr);
                a(iArr[0], iArr[1], frameLayout, R.drawable.sticker_kiss, 1500L, 0L);
            } catch (Throwable unused) {
            }
        }
    }

    public void a(ag agVar, short s) {
    }

    public void a(chat.ola.vn.entity.b bVar, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(chat.ola.vn.entity.g gVar, List<chat.ola.vn.entity.g> list, short s) {
    }

    public void a(Class<?> cls) {
        a(cls, false);
    }

    public void a(Class<?> cls, Bundle bundle) {
        a(cls, false, bundle);
    }

    public void a(Class<?> cls, boolean z) {
        a(cls, z, (Bundle) null);
    }

    public void a(Class<?> cls, boolean z, Bundle bundle) {
        try {
            Intent intent = new Intent(this, cls);
            if (bundle != null) {
                intent.putExtras(bundle);
            }
            startActivity(intent);
        } catch (Throwable unused) {
            Intent intent2 = new Intent(this, cls);
            intent2.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
            if (bundle != null) {
                intent2.putExtras(bundle);
            }
            startActivity(intent2);
        }
        if (z) {
            finish();
        }
    }

    public void a(Short sh, int i2) {
        try {
            h.t.a(sh, i2);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.network.f
    public void a(String str) {
    }

    public void a(String str, int i2) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, int i2, short s, String str2, long j2, List<ah> list, short s2) {
    }

    public void a(String str, int i2, int[] iArr, int[] iArr2) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, long j2, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, chat.ola.vn.entity.i iVar, l lVar, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2) {
        try {
            chat.ola.vn.util.f.a().b(str2);
        } catch (Throwable unused) {
        }
        try {
            if (x.x) {
                chat.ola.vn.m.m.a(this, str2, " ");
            } else {
                startActivity(new Intent("android.intent.action.VIEW", Uri.parse(chat.ola.vn.util.http.c.h(str2))));
                overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
            }
        } catch (Throwable unused2) {
        }
    }

    public void a(String str, String str2, String str3, String str4, String str5, String str6) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2, String str3, String str4, String str5, String str6, String str7, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2, String str3, String str4, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2, String str3, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2, List<chat.ola.vn.entity.i> list, String str3, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2, List<ac> list, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2, chat.ola.vn.entity.g[] gVarArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String str2, String[] strArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, List<chat.ola.vn.entity.i> list, String str2, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, List<chat.ola.vn.message.f> list, short s) {
    }

    public void a(String str, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, short s, int i2) {
        String strD = "" + ((int) s);
        ah ahVarB = j.a().b(s);
        if (ahVarB != null) {
            strD = ahVarB.d();
        }
        chat.ola.vn.i.i.b(this, getString(R.string.dialog_title_confirm), getString(R.string.message_receive_vip_transfering_ok, new Object[]{m.a(i2), strD, "@" + str}), getString(R.string.string_view_vip_store), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.c.6
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i3) {
                if (i3 == 0) {
                    OlaVipStoreActivity.a(c.this, h.a());
                }
                dialogInterface.dismiss();
            }
        });
    }

    public void a(String str, short s, int i2, long j2, short s2) {
    }

    public void a(String str, short s, int i2, short s2) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, short s, String str2, List<chat.ola.vn.message.d> list, short s2) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, short s, List<chat.ola.vn.entity.g> list, short s2) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, short s, short s2) {
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, byte[] bArr) {
        try {
            Bitmap bitmapDecodeByteArray = BitmapFactory.decodeByteArray(bArr, 0, bArr.length);
            if (m.a(str)) {
                str = getString(R.string.string_require_captcha_dialog_message);
            }
            try {
                if (this.e != null) {
                    this.e.dismiss();
                }
            } catch (Throwable unused) {
            }
            this.e = new chat.ola.vn.i.b(this, getString(R.string.string_require_captcha_dialog_title), str, bitmapDecodeByteArray);
            this.e.setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.c.5
                @Override // android.content.DialogInterface.OnDismissListener
                public void onDismiss(DialogInterface dialogInterface) {
                    c.this.e = null;
                }
            });
            this.e.show();
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.network.f
    public void a(String str, String[] strArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(List<chat.ola.vn.message.f> list, int i2) {
    }

    @Override // chat.ola.vn.network.f
    public void a(List<l> list, String str, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(List<ac> list, List<ah> list2, short s) {
    }

    public void a(List<s> list, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(short s, short s2) {
    }

    protected final void a(boolean z) {
        Window window;
        View decorView;
        int i2 = 1;
        try {
            requestWindowFeature(1);
            if (!z) {
                getWindow().setFlags(1024, 1024);
                if (!com.mg.ola.common.d.g.g()) {
                    return;
                } else {
                    window = getWindow();
                }
            } else if (com.mg.ola.common.d.g.h()) {
                decorView = getWindow().getDecorView();
                i2 = 5894;
                decorView.setSystemUiVisibility(i2);
            } else {
                if (!com.mg.ola.common.d.g.g()) {
                    return;
                }
                getWindow().setFlags(1024, 1024);
                window = getWindow();
            }
            decorView = window.getDecorView();
            decorView.setSystemUiVisibility(i2);
        } catch (Exception unused) {
        }
    }

    @Override // chat.ola.vn.network.f
    public void a(byte[] bArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void a(chat.ola.vn.entity.j[] jVarArr, int i2, short s) {
        a(0);
    }

    @Override // chat.ola.vn.network.f
    public void a_(List<chat.ola.vn.message.f> list) {
    }

    @Override // chat.ola.vn.network.f
    public void b(int i2) {
        try {
            FrameLayout frameLayoutZ = z();
            if (frameLayoutZ != null) {
                a(i2, frameLayoutZ);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.network.f
    public void b(long j2, int i2, short s) {
        if (i2 > 0) {
            try {
                ((OlaBottomTabActivity) b_).I();
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.network.f
    public void b(long j2, short s) {
    }

    public void b(View view, FrameLayout frameLayout) {
        if (frameLayout != null) {
            try {
                int[] iArr = new int[2];
                view.getLocationInWindow(iArr);
                a(iArr[0], iArr[1], frameLayout, R.drawable.sticker_like, 1500L, 0L);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.network.f
    public void b(String str) {
    }

    @Override // chat.ola.vn.network.f
    public void b(String str, int i2) {
    }

    @Override // chat.ola.vn.network.f
    public void b(String str, String str2) {
    }

    @Override // chat.ola.vn.network.f
    public void b(String str, String str2, String str3, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void b(String str, String str2, List<chat.ola.vn.entity.a> list, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void b(String str, String str2, String[] strArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void b(String str, List<l> list, String str2, short s) {
    }

    public void b(String str, short s) {
    }

    public void b(String str, short s, int i2, short s2) {
        String strD;
        try {
            ah ahVarB = j.a().b(s);
            if (ahVarB != null) {
                strD = ahVarB.d();
            } else {
                strD = ((int) s) + "";
            }
            chat.ola.vn.util.j.c(this, getString(R.string.message_gived_day_vip_confirm_format, new Object[]{str, strD, Integer.valueOf(i2)}));
        } catch (Throwable unused) {
        }
    }

    public void b(String str, byte[] bArr) {
    }

    @Override // chat.ola.vn.network.f
    public void b(List<af> list) {
    }

    @Override // chat.ola.vn.network.f
    public void b(List<chat.ola.vn.message.f> list, short s) {
    }

    public void b(short s) {
    }

    @Override // chat.ola.vn.network.f
    public void b(short s, short s2) {
    }

    public void b(boolean z) {
        try {
            if (OlaApplication.b != null) {
                OlaApplication.b.k = true;
            }
            String strA = h.a();
            h.d(null);
            t.a().b();
            t.a().c();
            h.x.o();
            h.u.e();
            h.s.j();
            h.w.a((List<chat.ola.vn.entry.g>) null);
            h.v.b();
            chat.ola.vn.transferken.c.a = 0L;
            if (!z) {
                chat.ola.vn.h.b.b(this, strA);
            }
            OlaBottomTabActivity.E();
        } catch (Throwable unused) {
        }
        if (OlaLoginActivity.a(this)) {
            finish();
        }
    }

    protected boolean b() {
        return true;
    }

    @Override // chat.ola.vn.network.f
    public void c(String str) {
    }

    @Override // chat.ola.vn.network.f
    public void c(String str, int i2) {
    }

    public void c(String str, String str2) {
    }

    @Override // chat.ola.vn.network.f
    public void c(String str, String str2, String[] strArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void c(String str, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void d(String str) {
    }

    @Override // chat.ola.vn.network.f
    public void d(String str, int i2) {
    }

    public void d(String str, String str2) {
    }

    @Override // chat.ola.vn.network.f
    public void d(String str, String str2, String[] strArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void d(String str, short s) {
    }

    protected boolean d() {
        return true;
    }

    @Override // chat.ola.vn.network.f
    public void e(String str, String str2) {
    }

    @Override // chat.ola.vn.network.f
    public void e(String str, String str2, String[] strArr, short s) {
    }

    @Override // chat.ola.vn.network.f
    public void e(String str, short s) {
    }

    protected boolean e() {
        return true;
    }

    public int f() {
        return f.b;
    }

    @Override // chat.ola.vn.network.f
    public void f(String str, short s) {
    }

    @Override // android.app.Activity
    public void finish() {
        super.finish();
        i();
    }

    public int g() {
        return f.c;
    }

    public void g(String str, short s) {
    }

    protected void h() {
        if (OlaLoginActivity.a(this)) {
            finish();
        }
    }

    public void i() {
        try {
            View currentFocus = getCurrentFocus();
            if (currentFocus != null) {
                InputMethodManager inputMethodManager = (InputMethodManager) getSystemService("input_method");
                inputMethodManager.hideSoftInputFromWindow(currentFocus.getWindowToken(), 0);
                inputMethodManager.hideSoftInputFromInputMethod(currentFocus.getWindowToken(), 0);
            }
        } catch (Throwable unused) {
        }
    }

    public void j() {
    }

    @Override // chat.ola.vn.network.f
    public void k() {
    }

    @Override // chat.ola.vn.network.f
    public void l() {
        h();
    }

    public void m() {
    }

    public void n() {
    }

    public void o() {
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        OlaReleaseAppActivity.a(this);
        if (!e() || d()) {
            B();
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
    }

    @Override // android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        b_ = this;
        if (h.i == 0) {
            try {
                h.i = getPackageManager().getPackageInfo(getPackageName(), 0).versionCode;
            } catch (Throwable unused) {
            }
        }
        if (i) {
            return;
        }
        i = true;
        MobileAds.initialize(this, chat.ola.vn.util.a.b());
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        try {
            if (this == b_) {
                b_ = null;
            }
            if (OlaApplication.b != null) {
                OlaApplication.b.b(this);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i2, KeyEvent keyEvent) {
        if (i2 == 82) {
            try {
                if (this.a_ == null || !this.a_.isShowing()) {
                    this.a_ = v();
                    return true;
                }
                this.a_.dismiss();
                this.a_ = null;
                return true;
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
        return super.onKeyDown(i2, keyEvent);
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
        if (this == b_) {
            b_ = null;
        }
        View currentFocus = getCurrentFocus();
        if (currentFocus != null) {
            ((InputMethodManager) getSystemService("input_method")).hideSoftInputFromWindow(currentFocus.getWindowToken(), 0);
            currentFocus.clearFocus();
        }
        C();
        OlaApplication.b((Activity) this);
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected final void onResume() {
        super.onResume();
        b_ = this;
        try {
            OlaApplication.a((Context) this);
            if (OlaApplication.b != null) {
                OlaApplication.b.a(this);
            }
            OlaApplication.a((Activity) this);
            if (E()) {
                a();
            }
            OlaApplication.b(new Runnable() { // from class: chat.ola.vn.c.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        e.a().c(0L);
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
        C();
        try {
            if (g == null) {
                new a().execute(new String[0]);
            } else if (m.a(h.S)) {
                h.S = n.j(this);
            }
        } catch (Throwable unused) {
        }
        D();
        try {
            if (j || Build.VERSION.SDK_INT < 23) {
                return;
            }
            j = true;
            String[] strArr = {"android.permission.GET_ACCOUNTS", "android.permission.READ_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE"};
            ArrayList arrayList = new ArrayList(strArr.length);
            for (int i2 = 0; i2 < strArr.length; i2++) {
                if (checkSelfPermission(strArr[i2]) != 0) {
                    arrayList.add(strArr[i2]);
                }
            }
            if (arrayList.size() > 0) {
                String[] strArr2 = new String[arrayList.size()];
                int size = arrayList.size();
                for (int i3 = 0; i3 < size; i3++) {
                    strArr2[i3] = (String) arrayList.get(i3);
                }
                requestPermissions(strArr2, 0);
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.network.f
    public void p() {
    }

    public void q() {
    }

    @Override // chat.ola.vn.network.f
    public void r() {
    }

    public void s() {
    }

    public void t() {
    }

    @Override // chat.ola.vn.network.f
    public void u() {
    }

    protected Dialog v() {
        return null;
    }

    public void w() {
    }

    public FrameLayout z() {
        return null;
    }
}
