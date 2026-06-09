package chat.ola.vn.badger;

import android.content.Context;
import android.content.Intent;

/* JADX INFO: loaded from: classes.dex */
public abstract class j {
    protected Context a;

    protected j(Context context) {
        this.a = context;
    }

    public static void a(Context context, int i) throws ShortcutBadgeException {
        if (i < 0 || i > 99) {
            throw new ShortcutBadgeException(String.format("ShortBadger is currently not support the badgeCount \"%d\"", Integer.valueOf(i)));
        }
        Intent intent = new Intent("android.intent.action.MAIN");
        intent.addCategory("android.intent.category.HOME");
        String str = context.getPackageManager().resolveActivity(intent, 65536).activityInfo.packageName;
        j aVar = null;
        if ("com.sonyericsson.home".equals(str)) {
            aVar = new k(context);
        } else if ("com.sec.android.app.launcher".equals(str)) {
            aVar = new i(context);
        } else if ("com.lge.launcher2".equals(str)) {
            aVar = new f(context);
        } else if ("com.htc.launcher".equals(str)) {
            aVar = new g(context);
        } else if ("com.android.launcher".equals(str)) {
            aVar = new b(context);
        } else if ("com.anddoes.launcher".equals(str)) {
            aVar = new c(context);
        } else if ("org.adw.launcher".equals(str) || "org.adwfreak.launcher".equals(str)) {
            aVar = new a(context);
        } else if ("com.teslacoilsw.launcher".equals(str)) {
            aVar = new h(context);
        } else if ("com.asus.launcher".equals(str)) {
            aVar = new d(context);
        }
        if (aVar == null) {
            throw new ShortcutBadgeException(String.format("ShortcutBadger is currently not support the home launcher package \"%s\"", str));
        }
        try {
            aVar.a(i);
        } catch (Throwable unused) {
        }
    }

    protected String a() {
        return this.a.getPackageManager().getLaunchIntentForPackage(this.a.getPackageName()).getComponent().getClassName();
    }

    protected abstract void a(int i);

    protected String b() {
        return this.a.getPackageName();
    }
}
