package chat.ola.vn.entity;

import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.support.v4.app.NotificationCompat;
import android.view.View;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.me.OlaMeCommentActivity;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;

/* JADX INFO: loaded from: classes.dex */
public class d {
    private i b;
    private String c;
    private String d;
    private String e;
    private String f;
    private String g;
    private String h;
    private String i;
    private chat.ola.vn.f.b[] l;
    public g a = null;
    private String j = null;
    private String k = null;
    private boolean n = false;
    private boolean m = false;

    public d() {
    }

    public d(String str) {
        this.c = str;
    }

    public static void a(final Context context, final d dVar) {
        try {
            if (chat.ola.vn.util.m.a(dVar.j)) {
                c(context, dVar);
            } else {
                chat.ola.vn.i.i.b(context, context.getString(R.string.dialog_title_confirm), context.getString(R.string.message_advertisment_inline_perform_confirm, dVar.j), context.getString(R.string.string_yes), context.getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.entity.d.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            try {
                                d.c(context, dVar);
                            } catch (Throwable unused) {
                                return;
                            }
                        }
                        dialogInterface.dismiss();
                    }
                });
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void c(Context context, d dVar) {
        String[] strArr;
        try {
            String strA = dVar.a();
            if (chat.ola.vn.util.m.a(strA)) {
                return;
            }
            if (chat.ola.vn.util.m.b(strA, "wap")) {
                String strB = dVar.b();
                if (chat.ola.vn.util.m.a(strB)) {
                    strB = dVar.c();
                }
                if (chat.ola.vn.util.m.a(strB)) {
                    return;
                }
                if (!dVar.f()) {
                    chat.ola.vn.util.b.o(context, strB);
                    return;
                }
                String strF = chat.ola.vn.util.m.f(strB);
                if (!chat.ola.vn.util.m.a(strF)) {
                    try {
                        if (chat.ola.vn.util.b.k(context, strF)) {
                            chat.ola.vn.util.b.i(context, strF);
                            return;
                        } else {
                            chat.ola.vn.util.b.j(context, strF);
                            return;
                        }
                    } catch (Throwable unused) {
                    }
                }
                chat.ola.vn.util.b.n(context, strB);
                return;
            }
            if (chat.ola.vn.util.m.b(strA, "webapp")) {
                String strB2 = dVar.b();
                if (chat.ola.vn.util.m.a(strB2)) {
                    strB2 = dVar.c();
                }
                if (chat.ola.vn.util.m.a(strB2)) {
                    return;
                }
                chat.ola.vn.m.m.a(context, strB2, dVar.d());
                return;
            }
            if (chat.ola.vn.util.m.b(strA, NotificationCompat.CATEGORY_CALL)) {
                String strB3 = dVar.b();
                if (chat.ola.vn.util.m.a(strB3)) {
                    strB3 = dVar.c();
                }
                if (chat.ola.vn.util.m.a(strB3)) {
                    return;
                }
                if (com.mg.ola.common.d.g.a(context) && chat.ola.vn.util.n.b(context)) {
                    chat.ola.vn.i.i.c(context, strB3);
                    return;
                }
                chat.ola.vn.i.i.b(context, strB3);
                return;
            }
            if (chat.ola.vn.util.m.b(strA, "sms") || chat.ola.vn.util.m.b(strA, NotificationCompat.CATEGORY_MESSAGE)) {
                return;
            }
            if (chat.ola.vn.util.m.b(strA, "viewme")) {
                String strC = dVar.c();
                if (chat.ola.vn.util.m.b(strC, "comment")) {
                    if (OlaApplication.b != null) {
                        OlaMeCommentActivity.a(context, Long.parseLong(dVar.b()));
                        return;
                    }
                    return;
                } else {
                    if (chat.ola.vn.util.m.b(strC, "homepage")) {
                        chat.ola.vn.me.c.a(context, OlaApplication.b, dVar.b());
                        return;
                    }
                    return;
                }
            }
            if (chat.ola.vn.util.m.b(strA, "viewbox") || chat.ola.vn.util.m.b(strA, "viewproposalrequest") || chat.ola.vn.util.m.b(strA, "viewproposallist")) {
                return;
            }
            if (chat.ola.vn.util.m.b(strA, "viewmedia")) {
                i iVarE = dVar.e();
                if (iVarE == null) {
                    return;
                } else {
                    strArr = new String[]{iVarE.d()};
                }
            } else {
                if (chat.ola.vn.util.m.b(strA, "chatto")) {
                    String strB4 = dVar.b();
                    if (chat.ola.vn.util.m.a(strB4)) {
                        strB4 = dVar.c();
                    }
                    if (chat.ola.vn.util.m.a(strB4)) {
                        return;
                    }
                    OlaChatViewActivity.a(context, OlaApplication.b, strB4, (short) 0);
                    return;
                }
                if (chat.ola.vn.util.m.b(strA, "replyto")) {
                    return;
                }
                if (!chat.ola.vn.util.m.b(strA, "openphoto")) {
                    if (chat.ola.vn.util.m.b(strA, "openaudio") || chat.ola.vn.util.m.b(strA, "openvideo") || chat.ola.vn.util.m.b(strA, "copy") || chat.ola.vn.util.m.b(strA, "delme")) {
                        return;
                    }
                    if (chat.ola.vn.util.m.b(strA, "rss")) {
                        String strB5 = dVar.b();
                        if (chat.ola.vn.util.m.a(strB5)) {
                            strB5 = dVar.c();
                        }
                        if (chat.ola.vn.util.m.a(strB5)) {
                            return;
                        }
                        chat.ola.vn.m.j.a(context, strB5);
                        return;
                    }
                    if (chat.ola.vn.util.m.b(strA, "vip")) {
                        String strB6 = dVar.b();
                        if (chat.ola.vn.util.m.a(strB6)) {
                            strB6 = dVar.c();
                        }
                        if (chat.ola.vn.util.m.a(strB6) || chat.ola.vn.util.m.b(strB6, chat.ola.vn.h.a())) {
                            BuyVipActivity.a(context);
                            return;
                        } else {
                            BuyVipActivity.a(context, strB6);
                            return;
                        }
                    }
                    if (chat.ola.vn.util.m.b(strA, "app") || chat.ola.vn.util.m.b(strA, "dpk") || chat.ola.vn.util.m.b(strA, "xt")) {
                        return;
                    }
                    if (chat.ola.vn.util.m.b(strA, "like")) {
                        String strB7 = dVar.b();
                        if (chat.ola.vn.util.m.a(strB7)) {
                            strB7 = dVar.c();
                        }
                        long j = Long.parseLong(strB7);
                        if (dVar.n) {
                            dVar.n = false;
                            OlaApplication.b.b(j, false);
                            return;
                        } else {
                            dVar.n = true;
                            OlaApplication.b.b(j, true);
                            return;
                        }
                    }
                    if (chat.ola.vn.util.m.b(strA, "likeadme")) {
                        String strB8 = dVar.b();
                        if (chat.ola.vn.util.m.a(strB8)) {
                            strB8 = dVar.c();
                        }
                        if (dVar.n) {
                            dVar.n = false;
                            OlaApplication.b.a(strB8, false);
                            return;
                        } else {
                            dVar.n = true;
                            OlaApplication.b.a(strB8, true);
                            return;
                        }
                    }
                    if (!chat.ola.vn.util.m.b(strA, "postme")) {
                        if (chat.ola.vn.util.m.b(strA, "checkin") && chat.ola.vn.util.m.b(dVar.c(), "venue")) {
                            dVar.b();
                            return;
                        }
                        return;
                    }
                    String strB9 = dVar.b();
                    String strC2 = dVar.c();
                    if (chat.ola.vn.util.m.a(strB9)) {
                        OlaMeComposerActivity.a(context, strC2, (String) null);
                        return;
                    } else {
                        OlaMeComposerActivity.a(context, strC2, (String) null, Long.parseLong(strB9));
                        return;
                    }
                }
                i iVarE2 = dVar.e();
                if (iVarE2 == null) {
                    return;
                } else {
                    strArr = new String[]{iVarE2.d()};
                }
            }
            OlaImageViewerActivity.a(context, (View) null, (Bitmap) null, 0, OlaMediaEntity.a(strArr));
        } catch (Throwable unused2) {
        }
    }

    public String a() {
        return this.c;
    }

    public void a(Context context) {
        a(context, this);
    }

    public void a(i iVar) {
        this.b = iVar;
    }

    public void a(String str) {
        this.c = str;
    }

    public void a(boolean z) {
        this.m = z;
    }

    public void a(chat.ola.vn.f.b[] bVarArr) {
        this.l = bVarArr;
    }

    public String b() {
        return this.d;
    }

    public void b(String str) {
        this.d = str;
    }

    public void b(boolean z) {
        this.n = z;
    }

    public String c() {
        return this.g;
    }

    public void c(String str) {
        this.e = str;
    }

    public String d() {
        return this.h;
    }

    public void d(String str) {
        this.f = str;
    }

    public i e() {
        return this.b;
    }

    public void e(String str) {
        this.g = str;
    }

    public void f(String str) {
        this.h = str;
    }

    public boolean f() {
        return this.m;
    }

    public String g() {
        return this.k;
    }

    public void g(String str) {
        this.i = str;
    }

    public void h(String str) {
        this.j = str;
    }

    public void i(String str) {
        this.k = str;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("[Action] ");
        sb.append(this.c);
        sb.append(this.h != null ? " [Label] " + this.h : "");
        sb.append(this.d != null ? " [URL] " + this.d : "");
        sb.append(this.e != null ? " [Phone No] " + this.e : "");
        sb.append(this.f != null ? " [SMSC] " + this.f : "");
        sb.append(this.g != null ? " [PRICE] " + this.g : "");
        String string = sb.toString();
        if (this.l != null) {
            for (int i = 0; i < this.l.length; i++) {
                string = string + " " + this.l[i].toString();
            }
        }
        return string;
    }
}
