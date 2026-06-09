package chat.ola.vn.i;

import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.view.View;
import android.widget.AdapterView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.PurchaseKENActivity;
import chat.ola.vn.c.x;
import chat.ola.vn.i.p;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.sms.OlaSmsSendingActivity;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class i {
    public static Dialog a(Context context, int i, int i2) {
        return b(context, context.getString(i), context.getString(i2));
    }

    public static Dialog a(Context context, int i, int i2, int i3, int i4, DialogInterface.OnClickListener onClickListener) {
        return b(context, i != 0 ? context.getString(i) : null, i2 != 0 ? context.getString(i2) : null, i3 != 0 ? context.getString(i3) : null, i4 != 0 ? context.getString(i4) : null, onClickListener);
    }

    public static Dialog a(Context context, Bitmap bitmap, CharSequence charSequence, CharSequence charSequence2) {
        e eVar = new e(context);
        eVar.setTitle(charSequence);
        if (bitmap != null) {
            eVar.a(bitmap);
        }
        eVar.a(charSequence2);
        eVar.a(R.string.string_close);
        eVar.a(new DialogInterface.OnClickListener() { // from class: chat.ola.vn.i.i.8
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.cancel();
            }
        });
        eVar.show();
        return eVar;
    }

    public static Dialog a(Context context, String str, String str2, String str3, String str4, DialogInterface.OnClickListener onClickListener) {
        return b(context, str, str2, str3, str4, onClickListener);
    }

    public static ProgressDialog a(Context context, int i, int i2, CharSequence charSequence, CharSequence charSequence2) {
        return a(context, i, i2, charSequence, charSequence2, 1);
    }

    public static ProgressDialog a(Context context, int i, int i2, CharSequence charSequence, CharSequence charSequence2, int i3) {
        ProgressDialog progressDialog = new ProgressDialog(context);
        progressDialog.setTitle(charSequence);
        progressDialog.setMessage(charSequence2);
        progressDialog.setProgressStyle(i3);
        progressDialog.setProgress(i);
        progressDialog.setMax(i2);
        return progressDialog;
    }

    public static ProgressDialog a(Context context, CharSequence charSequence, CharSequence charSequence2) {
        return a(context, charSequence, charSequence2, 0);
    }

    public static ProgressDialog a(Context context, CharSequence charSequence, CharSequence charSequence2, int i) {
        ProgressDialog progressDialog = new ProgressDialog(context);
        progressDialog.setTitle(charSequence);
        progressDialog.setMessage(charSequence2);
        progressDialog.setProgressStyle(i);
        progressDialog.setIndeterminate(true);
        progressDialog.setProgress(0);
        progressDialog.setMax(0);
        progressDialog.setCancelable(false);
        progressDialog.setCanceledOnTouchOutside(false);
        return progressDialog;
    }

    public static c a(Context context, int i, long j, Runnable runnable) {
        c cVar = new c(context);
        cVar.setCancelable(false);
        cVar.a(i);
        cVar.a(j, runnable);
        return cVar;
    }

    public static p a(Context context, int i, int i2, int i3, int i4, int i5, int i6, List<String> list, DialogInterface.OnClickListener onClickListener) {
        return a(context, null, i, i2, i3, i4, i5, i6, list, onClickListener, null);
    }

    public static p a(final Context context, final String str) {
        return a(context, null, R.drawable.ic_dialog_indicate_info, R.string.string_report, R.string.string_type_your_report_to_ola, R.string.string_send, R.string.string_close, 16384, null, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.i.i.1
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    try {
                        OlaApplication.b.k(str, ((p) dialogInterface).c());
                        chat.ola.vn.util.j.b(context, R.string.message_report_sent);
                    } catch (Throwable unused) {
                    }
                }
                try {
                    dialogInterface.dismiss();
                } catch (Throwable unused2) {
                }
            }
        }, null);
    }

    public static p a(Context context, String str, int i, int i2, int i3, int i4, int i5, int i6, List<String> list, DialogInterface.OnClickListener onClickListener, p.a aVar) {
        p pVar = list == null ? new p(context) : new r(context).a(list);
        if (i > 0) {
            try {
                pVar.a(i);
            } catch (Throwable unused) {
            }
        }
        pVar.b(i6);
        if (i2 != 0) {
            pVar.setTitle(context.getString(i2));
        }
        pVar.a(str);
        if (i3 != 0) {
            pVar.c(context.getString(i3));
        }
        if (i4 > 0) {
            pVar.b(context.getString(i4));
        }
        if (i5 > 0) {
            pVar.d(context.getString(i5));
        }
        pVar.a(onClickListener);
        pVar.show();
        pVar.a(aVar);
        return pVar;
    }

    public static p a(Context context, String str, int i, int i2, int i3, int i4, int i5, List<String> list, DialogInterface.OnClickListener onClickListener) {
        return a(context, str, i, i2, i3, i4, i5, list, onClickListener, null);
    }

    public static p a(Context context, String str, int i, int i2, int i3, int i4, int i5, List<String> list, DialogInterface.OnClickListener onClickListener, p.a aVar) {
        return a(context, str, i, i2, i3, i4, i5, 8192, list, onClickListener, aVar);
    }

    public static void a() {
        try {
            a(chat.ola.vn.c.c(), R.string.dialog_title_warning, R.string.message_warning_password_phishing).setCanceledOnTouchOutside(false);
        } catch (Throwable unused) {
        }
    }

    public static void a(final Context context) {
        try {
            b(context, R.string.dialog_title_confirm, R.string.message_map_loading_fail_no_google_service, R.string.string_install, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.i.i.9
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    try {
                        dialogInterface.dismiss();
                        if (i != 0) {
                            return;
                        }
                        try {
                            Intent intent = new Intent("android.intent.action.VIEW");
                            intent.setComponent(new ComponentName("com.android.vending", "com.google.android.finsky.activities.MainActivity"));
                            intent.setData(Uri.parse("https://play.google.com/store/apps/details?id=com.google.android.gms"));
                            context.startActivity(intent);
                        } catch (Throwable th) {
                            th.printStackTrace();
                            Intent intent2 = new Intent("android.intent.action.VIEW");
                            intent2.setData(Uri.parse("https://play.google.com/store/apps/details?id=com.google.android.gms"));
                            context.startActivity(intent2);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    public static void a(final Context context, final chat.ola.vn.entity.e eVar) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(context.getString(R.string.string_share));
            arrayList.add(context.getString(R.string.string_view));
            arrayList.add(context.getString(R.string.string_copy));
            arrayList.add(context.getString(R.string.string_view_tag));
            m mVar = new m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.i.i.5
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        String str = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_view))) {
                            chat.ola.vn.util.b.a(context, eVar.A(), eVar.G());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_copy))) {
                            chat.ola.vn.util.o.a(context, "http://mall.ola.vn/watch?id=" + eVar.y());
                            return;
                        }
                        if (!chat.ola.vn.util.m.b(str, context.getString(R.string.string_share))) {
                            if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_view_tag))) {
                                q.a(context, eVar.g());
                                return;
                            }
                            return;
                        }
                        OlaMeComposerActivity.b(context, eVar.z() + "\n " + ("http://mall.ola.vn/" + eVar.y()));
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    public static void a(final Context context, final chat.ola.vn.entity.i iVar) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(context.getString(R.string.string_download));
            arrayList.add(context.getString(R.string.string_post_me));
            arrayList.add(context.getString(R.string.string_copy));
            arrayList.add(context.getString(R.string.string_copy_plus));
            arrayList.add(context.getString(R.string.string_more_action));
            m mVar = new m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.i.i.14
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    String str;
                    Context context2;
                    try {
                        String str2 = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_download))) {
                            chat.ola.vn.util.b.b.a(context, iVar.d());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_post_me))) {
                            OlaMeComposerActivity.c(context, iVar.d());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_copy))) {
                            String strD = iVar.d();
                            if (chat.ola.vn.util.m.a(strD)) {
                                return;
                            }
                            context2 = context;
                            str = "#\u001b" + strD + "#";
                        } else {
                            if (!chat.ola.vn.util.m.b(str2, context.getString(R.string.string_copy_plus))) {
                                if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_more_action))) {
                                    i.b(context, iVar);
                                    return;
                                }
                                return;
                            }
                            str = "#\u001b" + iVar.d() + "#";
                            if (chat.ola.vn.util.m.a(str)) {
                                return;
                            }
                            String strA = chat.ola.vn.util.o.a(context);
                            if (!chat.ola.vn.util.m.a(strA)) {
                                str = strA + " " + str;
                            }
                            context2 = context;
                        }
                        chat.ola.vn.util.o.a(context2, str);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    public static void a(final Context context, final String str, String str2) {
        try {
            final ArrayList arrayList = new ArrayList();
            if (!chat.ola.vn.util.m.a(str2) && x.a()) {
                arrayList.add(context.getString(R.string.string_download));
            }
            arrayList.add(context.getString(R.string.string_view));
            m mVar = new m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.i.i.6
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        if (chat.ola.vn.util.m.b((String) arrayList.get(i), context.getString(R.string.string_view))) {
                            chat.ola.vn.util.b.a(context, str, 0, 0);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    public static Dialog b(Context context, int i, int i2, int i3, int i4, DialogInterface.OnClickListener onClickListener) {
        return b(context, i != 0 ? context.getString(i) : null, i2 != 0 ? context.getString(i2) : null, i3 != 0 ? context.getString(i3) : null, i4 != 0 ? context.getString(i4) : null, onClickListener);
    }

    public static Dialog b(Context context, CharSequence charSequence, CharSequence charSequence2) {
        return a(context, (Bitmap) null, charSequence, charSequence2);
    }

    public static e b(Context context, String str, String str2, String str3, String str4, DialogInterface.OnClickListener onClickListener) {
        if (context == null) {
            return null;
        }
        e eVar = new e(context);
        eVar.setCanceledOnTouchOutside(false);
        if (str != null) {
            eVar.setTitle(str);
        } else {
            eVar.setTitle(R.string.dialog_title_inform);
        }
        if (str2 != null) {
            eVar.a((CharSequence) str2);
        }
        if (str3 != null) {
            eVar.a(str3);
        }
        if (str4 != null) {
            eVar.b(str4);
        }
        if (onClickListener != null) {
            eVar.a(onClickListener);
        }
        eVar.show();
        return eVar;
    }

    public static void b(Context context) {
        b(context, context.getString(R.string.message_call_support), context.getString(R.string.message_call_support_hint, "1900588883"));
    }

    public static void b(final Context context, final chat.ola.vn.entity.i iVar) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(context.getString(R.string.string_view_info));
            arrayList.add(context.getString(R.string.string_bad_media_report));
            m mVar = new m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.i.i.15
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        String str = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_view_info))) {
                            if (OlaApplication.b != null) {
                                OlaApplication.b.n(iVar.d(), chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.i.i.15.1
                                    @Override // chat.ola.vn.entry.c.e
                                    public short a() {
                                        return (short) 43;
                                    }

                                    @Override // chat.ola.vn.entry.c.e
                                    public void a(int i2, short s, String str2, chat.ola.vn.entity.d[] dVarArr) {
                                    }

                                    @Override // chat.ola.vn.entry.c.e
                                    public void a(Object... objArr) {
                                        chat.ola.vn.entity.l lVar;
                                        try {
                                            String str2 = (String) objArr[0];
                                            chat.ola.vn.entity.i iVar2 = (chat.ola.vn.entity.i) objArr[1];
                                            try {
                                                lVar = (chat.ola.vn.entity.l) objArr[2];
                                            } catch (Throwable unused) {
                                                lVar = null;
                                            }
                                            k kVar = new k(context);
                                            kVar.a(str2, iVar2.e(), lVar, iVar2.g());
                                            kVar.show();
                                        } catch (Throwable unused2) {
                                        }
                                    }
                                }));
                            }
                        } else if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_bad_media_report))) {
                            OlaApplication.b.v(iVar.d());
                            chat.ola.vn.util.j.b(context, R.string.message_report_sent);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context, String str) {
        b(context, context.getString(R.string.message_call_manual), context.getString(R.string.message_call_manual_hint, str));
    }

    public static Dialog c(final Context context) {
        return a(context, R.string.dialog_title_inform, R.string.message_remove_ad_hint, R.string.string_buy_vip, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.i.i.12
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    BuyVipActivity.a(context);
                }
                dialogInterface.dismiss();
            }
        });
    }

    public static Dialog c(Context context, int i, int i2, int i3, int i4, DialogInterface.OnClickListener onClickListener) {
        return c(context, i != 0 ? context.getString(i) : null, i2 != 0 ? context.getString(i2) : null, i3 != 0 ? context.getString(i3) : null, i4 != 0 ? context.getString(i4) : null, onClickListener);
    }

    public static d c(Context context, String str, String str2, String str3, String str4, DialogInterface.OnClickListener onClickListener) {
        if (context == null) {
            return null;
        }
        d dVar = new d(context);
        if (str != null) {
            dVar.setTitle(str);
        } else {
            dVar.setTitle(R.string.dialog_title_inform);
        }
        if (str2 != null) {
            dVar.a((CharSequence) str2);
        }
        if (str3 != null) {
            dVar.a(str3);
        }
        if (str4 != null) {
            dVar.b(str4);
        }
        if (onClickListener != null) {
            dVar.a(onClickListener);
        }
        dVar.show();
        return dVar;
    }

    public static void c(final Context context, final chat.ola.vn.entity.i iVar) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(context.getString(R.string.string_download));
            arrayList.add(context.getString(R.string.string_post_me));
            arrayList.add(context.getString(R.string.string_copy));
            arrayList.add(context.getString(R.string.string_copy_plus));
            arrayList.add(context.getString(R.string.string_more_action));
            m mVar = new m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.i.i.2
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    String str;
                    Context context2;
                    try {
                        String str2 = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_download))) {
                            chat.ola.vn.util.b.b.a(context, iVar.d());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_post_me))) {
                            OlaMeComposerActivity.c(context, iVar.d());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_copy))) {
                            String strD = iVar.d();
                            if (chat.ola.vn.util.m.a(strD)) {
                                return;
                            }
                            context2 = context;
                            str = "#\u001b" + strD + "#";
                        } else {
                            if (!chat.ola.vn.util.m.b(str2, context.getString(R.string.string_copy_plus))) {
                                if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_more_action))) {
                                    i.d(context, iVar);
                                    return;
                                }
                                return;
                            }
                            str = "#\u001b" + iVar.d() + "#";
                            if (chat.ola.vn.util.m.a(str)) {
                                return;
                            }
                            String strA = chat.ola.vn.util.o.a(context);
                            if (!chat.ola.vn.util.m.a(strA)) {
                                str = strA + " " + str;
                            }
                            context2 = context;
                        }
                        chat.ola.vn.util.o.a(context2, str);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    public static void c(final Context context, final String str) {
        a(context, context.getString(R.string.message_call_manual), context.getString(R.string.message_phone_call_confirm, str), context.getString(R.string.string_call), context.getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.i.i.10
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    try {
                        chat.ola.vn.util.b.c(context, str);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                dialogInterface.dismiss();
            }
        });
    }

    public static Dialog d(final Context context) {
        return d(context, context.getString(R.string.dialog_title_inform), context.getString(R.string.message_fail_permission_novipicon_content), context.getString(R.string.string_buy_vip), context.getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.i.i.13
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    if (chat.ola.vn.c.x() && chat.ola.vn.util.n.b(context) && chat.ola.vn.h.a) {
                        OlaSmsSendingActivity.a(context);
                    } else {
                        BuyVipActivity.a(context);
                    }
                }
                dialogInterface.dismiss();
            }
        });
    }

    public static Dialog d(Context context, int i, int i2, int i3, int i4, DialogInterface.OnClickListener onClickListener) {
        return d(context, i != 0 ? context.getString(i) : null, i2 != 0 ? context.getString(i2) : null, i3 != 0 ? context.getString(i3) : null, i4 != 0 ? context.getString(i4) : null, onClickListener);
    }

    public static Dialog d(final Context context, String str) {
        return a(context, R.string.dialog_title_inform, R.string.message_not_enought_ken, R.string.string_purchase_ken, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.i.i.11
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    PurchaseKENActivity.a(context);
                }
                dialogInterface.dismiss();
            }
        });
    }

    public static f d(Context context, String str, String str2, String str3, String str4, DialogInterface.OnClickListener onClickListener) {
        if (context == null) {
            return null;
        }
        f fVar = new f(context);
        if (str != null) {
            fVar.setTitle(str);
        } else {
            fVar.setTitle(R.string.dialog_title_inform);
        }
        if (str2 != null) {
            fVar.a((CharSequence) str2);
        }
        if (str3 != null) {
            fVar.a(str3);
        }
        if (str4 != null) {
            fVar.b(str4);
        }
        if (onClickListener != null) {
            fVar.a(onClickListener);
        }
        fVar.show();
        return fVar;
    }

    public static void d(final Context context, final chat.ola.vn.entity.i iVar) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(context.getString(R.string.string_view_info));
            arrayList.add(context.getString(R.string.string_bad_media_report));
            m mVar = new m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.i.i.3
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        String str = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_view_info))) {
                            if (OlaApplication.b != null) {
                                OlaApplication.b.n(iVar.d(), chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.i.i.3.1
                                    @Override // chat.ola.vn.entry.c.e
                                    public short a() {
                                        return (short) 43;
                                    }

                                    @Override // chat.ola.vn.entry.c.e
                                    public void a(int i2, short s, String str2, chat.ola.vn.entity.d[] dVarArr) {
                                    }

                                    @Override // chat.ola.vn.entry.c.e
                                    public void a(Object... objArr) {
                                        chat.ola.vn.entity.l lVar;
                                        try {
                                            String str2 = (String) objArr[0];
                                            chat.ola.vn.entity.i iVar2 = (chat.ola.vn.entity.i) objArr[1];
                                            try {
                                                lVar = (chat.ola.vn.entity.l) objArr[2];
                                            } catch (Throwable unused) {
                                                lVar = null;
                                            }
                                            k kVar = new k(context);
                                            kVar.a(str2, iVar2.e(), lVar, iVar2.g());
                                            kVar.show();
                                        } catch (Throwable unused2) {
                                        }
                                    }
                                }));
                            }
                        } else if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_bad_media_report))) {
                            OlaApplication.b.v(iVar.d());
                            chat.ola.vn.util.j.b(context, R.string.message_report_sent);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    public static void e(final Context context) {
        try {
            b(context, context.getResources().getString(R.string.string_turn_on_location_services), context.getResources().getString(R.string.string_to_use_this_feature_location_services_must_be_on), context.getResources().getString(R.string.string_setup), context.getResources().getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.i.i.7
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    if (i == 0) {
                        context.startActivity(new Intent("android.settings.LOCATION_SOURCE_SETTINGS"));
                    }
                    dialogInterface.dismiss();
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void e(final Context context, final String str) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(context.getString(R.string.string_download));
            arrayList.add(context.getString(R.string.string_post_me));
            arrayList.add(context.getString(R.string.string_copy));
            arrayList.add(context.getString(R.string.string_copy_plus));
            m mVar = new m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.i.i.4
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        String str2 = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_download))) {
                            chat.ola.vn.util.b.g(context, str);
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_copy))) {
                            chat.ola.vn.util.o.a(context, "http://m.youtube.com/watch?v=" + str);
                            return;
                        }
                        if (!chat.ola.vn.util.m.b(str2, context.getString(R.string.string_copy_plus))) {
                            if (chat.ola.vn.util.m.b(str2, context.getString(R.string.string_post_me))) {
                                OlaMeComposerActivity.b(context, "http://m.youtube.com/watch?v=" + str + " \n");
                                return;
                            }
                            return;
                        }
                        String str3 = "http://m.youtube.com/watch?v=" + str;
                        if (chat.ola.vn.util.m.a(str3)) {
                            return;
                        }
                        String strA = chat.ola.vn.util.o.a(context);
                        if (!chat.ola.vn.util.m.a(strA)) {
                            str3 = strA + " " + str3;
                        }
                        chat.ola.vn.util.o.a(context, str3);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }
}
