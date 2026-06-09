package chat.ola.vn.util;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.net.Uri;
import android.view.View;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.c.x;
import chat.ola.vn.mediastore.OlaMediaEntity;
import com.google.android.gms.common.util.CrashUtils;
import com.google.android.youtube.player.YouTubeStandalonePlayer;
import java.io.File;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class b {
    public static void a(Context context) {
        chat.ola.vn.m.m.a(context, "adme", context.getString(R.string.general_tab_post_adme));
    }

    public static void a(Context context, long j) {
        chat.ola.vn.m.m.a(context, "adme/create-adme?meid=" + j, context.getString(R.string.general_tab_post_adme));
    }

    public static void a(Context context, long j, String str) {
        try {
            chat.ola.vn.m.m.a(context, "adme/createAdRoom?status=" + URLEncoder.encode(str, "UTF-8") + "&roomId=" + j, context.getString(R.string.general_tab_post_adme));
        } catch (Throwable unused) {
            chat.ola.vn.m.m.a(context, "adme/createAdRoom?status=" + URLEncoder.encode(str) + "&roomId=" + j, context.getString(R.string.general_tab_post_adme));
        }
    }

    public static void a(final Context context, final Uri uri) {
        if (uri != null) {
            try {
                if (!k(context, "mall.ola.vn")) {
                    chat.ola.vn.i.i.b(context, context.getString(R.string.dialog_title_inform), context.getString(R.string.message_install_video_player_require), context.getString(R.string.string_install), context.getString(R.string.string_default), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.util.b.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            try {
                                dialogInterface.dismiss();
                                if (i == 0) {
                                    b.b(context);
                                    return;
                                }
                                Intent intent = new Intent();
                                intent.setAction("android.intent.action.VIEW");
                                intent.setDataAndType(uri, "video/*");
                                context.startActivity(intent);
                            } catch (Throwable unused) {
                            }
                        }
                    });
                    return;
                }
                Intent intent = new Intent();
                intent.setComponent(new ComponentName("mall.ola.vn", "mall.ola.vn.VideoPlayerActivity"));
                intent.setAction("android.intent.action.VIEW");
                intent.setDataAndType(uri, "video/*");
                context.startActivity(intent);
            } catch (Throwable unused) {
            }
        }
    }

    public static void a(Context context, View view, String str, short s) {
        OlaMediaEntity[] olaMediaEntityArr;
        switch (s) {
            case 1:
                if (view == null || Math.min(chat.ola.vn.e.c, chat.ola.vn.e.d) - view.getMeasuredWidth() >= 20) {
                    a(context, str, 0, 0);
                    return;
                }
                Rect rect = new Rect();
                view.getGlobalVisibleRect(rect);
                a(context, str, 0, rect.top - n.a(context));
                return;
            case 2:
                switch (o.g(str)) {
                    case 1:
                        olaMediaEntityArr = new OlaMediaEntity[]{new OlaMediaEntity(str, 1, o.g(str))};
                        break;
                    case 2:
                        h(context, str);
                        return;
                    case 3:
                        f(context, str);
                        return;
                    default:
                        return;
                }
                break;
            case 3:
                olaMediaEntityArr = new OlaMediaEntity[]{new OlaMediaEntity(str, 3, (short) 1)};
                break;
            case 4:
            case 5:
                return;
            default:
                return;
        }
        OlaImageViewerActivity.a(context, view, (Bitmap) null, 0, olaMediaEntityArr);
    }

    public static void a(Context context, String str) {
        chat.ola.vn.m.g.a(context, str);
    }

    public static void a(Context context, String str, int i) {
        a(context, Uri.fromFile(new File(str)));
    }

    public static void a(Context context, String str, int i, int i2) {
        File fileE;
        try {
            fileE = chat.ola.vn.d.e(str);
        } catch (Throwable unused) {
        }
        if (fileE != null) {
            if (com.mg.ola.common.d.c.h(fileE) >= 1000000) {
                a(context, Uri.fromFile(fileE));
                return;
            } else {
                com.mg.ola.common.d.c.c(fileE);
                b(context, str, i, i2);
                return;
            }
        }
        switch (x.p) {
            case 0:
                b(context, str, i, i2);
                return;
            case 1:
                try {
                    context.startActivity(YouTubeStandalonePlayer.createVideoIntent((Activity) context, context.getString(R.string.ola_google_api_key), str, 0, true, false));
                    return;
                } catch (Throwable unused2) {
                    chat.ola.vn.i.i.a(context);
                    return;
                }
            default:
                return;
        }
    }

    public static void a(Context context, String str, View view) {
        if (view == null || Math.min(chat.ola.vn.e.c, chat.ola.vn.e.d) - view.getMeasuredWidth() >= 20) {
            a(context, str, 0, 0);
            return;
        }
        Rect rect = new Rect();
        view.getGlobalVisibleRect(rect);
        a(context, str, 0, rect.top - n.a(context));
    }

    public static void a(Context context, String str, String str2, String str3) {
        try {
            Intent intent = new Intent("android.intent.action.VIEW", Uri.parse("geo:" + str + "," + str2 + "?q=" + str + "," + str2 + "(" + str3 + ")"));
            if (k(context, "com.google.android.apps.maps")) {
                intent.setClassName("com.google.android.apps.maps", "com.google.android.maps.MapsActivity");
            }
            context.startActivity(intent);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str, String str2, String str3, String str4) {
        try {
            Intent intent = new Intent("android.intent.action.VIEW", Uri.parse("http://maps.google.com/maps?saddr=" + str + "," + str2 + "&daddr=" + str3 + "," + str4));
            if (k(context, "com.google.android.apps.maps")) {
                intent.setClassName("com.google.android.apps.maps", "com.google.android.maps.MapsActivity");
            }
            context.startActivity(intent);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str, short s) {
        a(context, (View) null, str, s);
    }

    private static void a(Context context, String str, boolean z) {
        try {
            if (m.a(str)) {
                return;
            }
            String strG = m.g(str);
            if (strG != null) {
                a(context, strG);
                return;
            }
            String strE = m.e(str);
            if (!m.a(strE)) {
                try {
                    a((Activity) context, strE, 0, 0);
                    return;
                } catch (Throwable unused) {
                }
            }
            String strF = m.f(str);
            if (!m.a(strF)) {
                try {
                    if (k(context, strF)) {
                        context.startActivity(context.getPackageManager().getLaunchIntentForPackage(strF));
                        return;
                    } else {
                        j(context, strF);
                        return;
                    }
                } catch (Throwable unused2) {
                }
            }
            String host = new URL(str).getHost();
            if (m.b(host, "ola.vn") || host.toLowerCase().endsWith(".ola.vn")) {
                try {
                    context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(chat.ola.vn.util.http.c.h(str))));
                    return;
                } catch (Throwable th) {
                    th = th;
                }
            } else if (!z) {
                OlaApplication.b.j(str);
                try {
                    f.a().a(str);
                    return;
                } catch (Throwable unused3) {
                    return;
                }
            } else {
                try {
                    context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(chat.ola.vn.util.http.c.h(str))));
                    return;
                } catch (Throwable th2) {
                    th = th2;
                }
            }
            th.printStackTrace();
        } catch (Throwable th3) {
            if (!z) {
                OlaApplication.b.j(str);
                return;
            }
            try {
                context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(chat.ola.vn.util.http.c.h(str))));
            } catch (Throwable unused4) {
                th3.printStackTrace();
            }
        }
    }

    public static void a(Context context, List<String> list, int i) {
        try {
            a(context, Uri.parse(chat.ola.vn.entity.i.k(list.get(0))));
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context) {
        Intent flags = new Intent("android.intent.action.VIEW").setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        try {
            try {
                context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse("market://details?id=mall.ola.vn")));
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
            flags.setData(Uri.parse("http://lnk.vn/olamallplayer"));
            context.startActivity(flags);
        }
    }

    public static void b(Context context, Uri uri) {
        try {
            Intent intent = new Intent("android.intent.action.VIEW");
            intent.setDataAndType(uri, "audio/*");
            context.startActivity(intent);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void b(Context context, String str) {
        chat.ola.vn.m.g.b(context, str);
    }

    private static void b(final Context context, final String str, int i, int i2) {
        try {
            if (!k(context, "mall.ola.vn")) {
                chat.ola.vn.i.i.b(context, context.getString(R.string.dialog_title_inform), context.getString(R.string.message_install_video_player_require), context.getString(R.string.string_install), context.getString(R.string.string_default), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.util.b.3
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i3) {
                        try {
                            dialogInterface.dismiss();
                            if (i3 == 0) {
                                b.b(context);
                                return;
                            }
                            try {
                                context.startActivity(YouTubeStandalonePlayer.createVideoIntent((Activity) context, context.getString(R.string.ola_google_api_key), str, 0, true, false));
                            } catch (Throwable unused) {
                                chat.ola.vn.i.i.a(context);
                            }
                        } catch (Throwable unused2) {
                        }
                    }
                });
                return;
            }
            Intent intent = new Intent();
            intent.setComponent(new ComponentName("mall.ola.vn", "mall.ola.vn.VideoPlayerActivity"));
            intent.setAction("android.intent.action.VIEW");
            intent.putExtra("youtubeCode", str);
            intent.putExtra("vipIndex", chat.ola.vn.h.H);
            intent.putExtra("x", i);
            intent.putExtra("y", i2);
            if (!m.a(chat.ola.vn.h.a())) {
                intent.putExtra("username", chat.ola.vn.h.a());
            }
            context.startActivity(intent);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void c(Context context, String str) {
        try {
            Intent intent = new Intent("android.intent.action.DIAL");
            intent.setData(Uri.parse("tel:" + Uri.encode(str)));
            intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
            context.startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void d(Context context, String str) {
        a(context, Uri.parse(str));
    }

    public static void e(Context context, String str) {
        try {
            if (m.a(str)) {
                return;
            }
            b(context, Uri.parse(str));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void f(Context context, String str) {
        try {
            if (chat.ola.vn.entity.i.i(str) == 3) {
                e(context, chat.ola.vn.entity.i.k(str));
            }
        } catch (Throwable unused) {
        }
    }

    public static void g(final Context context, String str) {
        try {
            if (!k(context, "mall.ola.vn")) {
                chat.ola.vn.i.i.b(context, context.getString(R.string.dialog_title_inform), context.getString(R.string.message_install_video_player_require), context.getString(R.string.string_install), context.getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.util.b.2
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        try {
                            dialogInterface.dismiss();
                            if (i == 0) {
                                b.b(context);
                            }
                        } catch (Throwable unused) {
                        }
                    }
                });
                return;
            }
            Intent intent = new Intent();
            intent.setComponent(new ComponentName("mall.ola.vn", "mall.ola.vn.VideoDownloadHandlerActivity"));
            intent.setAction("mall.ola.vn.ACTION_DOWLOAD_VIDEO");
            intent.putExtra("youtubeCode", str);
            context.startActivity(intent);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void h(Context context, String str) {
        a(context, Uri.parse(chat.ola.vn.entity.i.k(str)));
    }

    public static void i(Context context, String str) {
        try {
            context.startActivity(context.getPackageManager().getLaunchIntentForPackage(str));
        } catch (Throwable unused) {
        }
    }

    public static void j(Context context, String str) {
        try {
            try {
                context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse("market://details?id=" + str)));
            } catch (Throwable unused) {
                context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse("https://play.google.com/store/apps/details?id=" + str + "&rdid=" + str)));
            }
        } catch (Throwable unused2) {
        }
    }

    public static boolean k(Context context, String str) {
        try {
            if (m.b(OlaApplication.f(), str) || m.a(str)) {
                return false;
            }
            return context.getPackageManager().getApplicationInfo(str, 1) != null;
        } catch (Throwable unused) {
            return false;
        }
    }

    public static void l(Context context, String str) {
        try {
            try {
                context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse("market://search?q=pub:\"" + str + "\"")));
            } catch (Throwable unused) {
                context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse("https://play.google.com/store/apps/developer?id=\"" + str + "\"")));
            }
        } catch (Throwable unused2) {
        }
    }

    public static void m(Context context, String str) {
        try {
            context.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(str)));
        } catch (Throwable unused) {
        }
    }

    public static void n(Context context, String str) {
        a(context, str, true);
    }

    public static void o(Context context, String str) {
        a(context, str, false);
    }
}
