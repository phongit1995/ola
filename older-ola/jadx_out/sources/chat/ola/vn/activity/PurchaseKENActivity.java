package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.app.PendingIntent;
import android.app.ProgressDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.view.KeyEvent;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.e;
import chat.ola.vn.entity.ae;
import chat.ola.vn.entity.d;
import chat.ola.vn.entity.p;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.p.q;
import chat.ola.vn.sms.a;
import chat.ola.vn.sms.b;
import chat.ola.vn.util.f;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import com.android.vending.billing.IInAppBillingService;
import com.google.android.gms.common.util.CrashUtils;
import com.google.firebase.analytics.FirebaseAnalytics;
import com.mg.ola.common.d.g;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class PurchaseKENActivity extends c implements View.OnClickListener, a.InterfaceC0049a {
    private static String h;
    private static ArrayList<String> l;
    private View A;
    private TextView B;
    private View C;
    private TextView D;
    private TextView E;
    private View F;
    private TextView G;
    private TextView H;
    private View I;
    private TextView J;
    private TextView K;
    private View L;
    private TextView M;
    private TextView N;
    private View O;
    private TextView P;
    private TextView Q;
    private View R;
    private TextView S;
    private TextView T;
    private Animation U;
    private ImageView V;
    private chat.ola.vn.i.c X;
    private IInAppBillingService Y;
    private ServiceConnection Z;
    private String aa;
    private String ab;
    private ProgressDialog ae;
    private Runnable af;
    private a ag;
    public List<chat.ola.vn.entity.a> e;
    private List<ae> f;
    private String g;
    private List<p> j;
    private String k;
    private View m;
    private TextView n;
    private View o;
    private TextView p;
    private TextView q;
    private View r;
    private TextView s;
    private TextView t;
    private View u;
    private TextView v;
    private TextView w;
    private EditText x;
    private EditText y;
    private Button z;
    private int i = -1;
    private int W = 0;
    private Runnable ac = new Runnable() { // from class: chat.ola.vn.activity.PurchaseKENActivity.1
        @Override // java.lang.Runnable
        public void run() {
            if (PurchaseKENActivity.this.Y != null) {
                try {
                    Bundle purchases = PurchaseKENActivity.this.Y.getPurchases(3, PurchaseKENActivity.this.getPackageName(), "inapp", null);
                    int i = purchases.getInt("RESPONSE_CODE");
                    if (i == 0) {
                        try {
                            ArrayList<String> stringArrayList = purchases.getStringArrayList("INAPP_PURCHASE_DATA_LIST");
                            for (int i2 = 0; i2 < stringArrayList.size(); i2++) {
                                String str = stringArrayList.get(i2);
                                try {
                                    JSONObject jSONObject = new JSONObject(str);
                                    String string = jSONObject.getString("productId");
                                    String string2 = jSONObject.getString("purchaseToken");
                                    String strL = e.a().l(string);
                                    if (m.a(strL)) {
                                        e.a().k(string);
                                        if (!m.a(string2)) {
                                            PurchaseKENActivity.this.Y.consumePurchase(3, OlaApplication.f(), string2);
                                        }
                                    } else {
                                        OlaApplication.b.a("" + i, str, strL, PurchaseKENActivity.this.ad);
                                    }
                                } catch (Throwable unused) {
                                }
                            }
                        } catch (Throwable unused2) {
                        }
                    }
                    Bundle bundle = new Bundle();
                    bundle.putStringArrayList("ITEM_ID_LIST", PurchaseKENActivity.l);
                    Bundle skuDetails = PurchaseKENActivity.this.Y.getSkuDetails(3, OlaApplication.f(), "inapp", bundle);
                    if (skuDetails.getInt("RESPONSE_CODE") == 0) {
                        ArrayList<String> stringArrayList2 = skuDetails.getStringArrayList("DETAILS_LIST");
                        if (PurchaseKENActivity.this.j == null) {
                            PurchaseKENActivity.this.j = new ArrayList(0);
                        } else {
                            PurchaseKENActivity.this.j.clear();
                        }
                        Iterator<String> it2 = stringArrayList2.iterator();
                        while (it2.hasNext()) {
                            try {
                                JSONObject jSONObject2 = new JSONObject(it2.next());
                                p pVar = new p();
                                if (jSONObject2.has("productId")) {
                                    pVar.f = jSONObject2.getString("productId");
                                }
                                if (jSONObject2.has("description")) {
                                    pVar.i = jSONObject2.getString("description");
                                }
                                if (jSONObject2.has(FirebaseAnalytics.Param.PRICE)) {
                                    pVar.g = jSONObject2.getString(FirebaseAnalytics.Param.PRICE);
                                }
                                if (jSONObject2.has("price_amount_micros")) {
                                    pVar.k = jSONObject2.getLong("price_amount_micros");
                                }
                                if (jSONObject2.has("price_currency_code")) {
                                    pVar.l = jSONObject2.getString("price_currency_code");
                                }
                                if (jSONObject2.has("title")) {
                                    pVar.h = jSONObject2.getString("title");
                                }
                                if (jSONObject2.has("type")) {
                                    pVar.d = jSONObject2.getString("type");
                                }
                                PurchaseKENActivity.this.j.add(pVar);
                            } catch (Throwable unused3) {
                            }
                        }
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.PurchaseKENActivity.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                PurchaseKENActivity.this.D();
                            }
                        });
                    }
                } catch (Throwable unused4) {
                }
            }
        }
    };
    private q ad = new q() { // from class: chat.ola.vn.activity.PurchaseKENActivity.6
        @Override // chat.ola.vn.p.q
        public void a() {
            try {
                ArrayList unused = PurchaseKENActivity.l = null;
                PurchaseKENActivity.this.X.a();
                i.a(PurchaseKENActivity.this, R.string.dialog_title_inform, R.string.message_service_is_not_available_now, R.string.string_close, 0, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.PurchaseKENActivity.6.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i != 0) {
                            return;
                        }
                        try {
                            PurchaseKENActivity.this.finish();
                        } catch (Throwable unused2) {
                        }
                    }
                });
            } catch (Throwable unused2) {
            }
        }

        @Override // chat.ola.vn.p.q
        public void a(p pVar) {
            try {
                if (m.a(pVar.f)) {
                    i.a(PurchaseKENActivity.this, R.string.dialog_title_inform, R.string.message_service_is_not_available_now);
                    return;
                }
                PendingIntent pendingIntent = (PendingIntent) PurchaseKENActivity.this.Y.getBuyIntent(3, PurchaseKENActivity.this.getPackageName(), pVar.f, "inapp", pVar.e).getParcelable("BUY_INTENT");
                Integer num = 0;
                Integer num2 = 0;
                Integer num3 = 0;
                PurchaseKENActivity.this.startIntentSenderForResult(pendingIntent.getIntentSender(), 1001, new Intent(), num.intValue(), num2.intValue(), num3.intValue());
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.p.q
        public void a(String str, String str2, String str3) {
            try {
                if (PurchaseKENActivity.this.X != null) {
                    PurchaseKENActivity.this.X.a();
                    PurchaseKENActivity.this.X = null;
                }
                if (!m.a(str3)) {
                    i.b(PurchaseKENActivity.this, PurchaseKENActivity.this.getString(R.string.dialog_title_inform), str3);
                }
                e.a().k(str);
            } catch (Throwable unused) {
            }
            try {
                f.a().c("Deposit KEN by IAP");
            } catch (Throwable unused2) {
            }
            try {
                PurchaseKENActivity.this.Y.consumePurchase(3, OlaApplication.f(), str2);
            } catch (Throwable unused3) {
            }
        }

        @Override // chat.ola.vn.p.q
        public void a(List<p> list) {
            try {
                if (PurchaseKENActivity.l == null) {
                    ArrayList unused = PurchaseKENActivity.l = new ArrayList(0);
                } else {
                    PurchaseKENActivity.l.clear();
                }
                if (PurchaseKENActivity.this.e == null) {
                    PurchaseKENActivity.this.e = new ArrayList(0);
                } else {
                    PurchaseKENActivity.this.e.clear();
                }
                if (PurchaseKENActivity.this.f == null) {
                    PurchaseKENActivity.this.f = new ArrayList(0);
                } else {
                    PurchaseKENActivity.this.f.clear();
                }
                for (int i = 0; i < list.size(); i++) {
                    p pVar = list.get(i);
                    if (pVar.d.equals(p.c)) {
                        PurchaseKENActivity.l.add(pVar.f);
                        PurchaseKENActivity.this.k = pVar.j;
                    } else if (pVar.d.equals(p.a)) {
                        PurchaseKENActivity.this.f.add(pVar.o);
                        PurchaseKENActivity.this.g = pVar.j;
                    } else if (pVar.d.equals(p.b)) {
                        PurchaseKENActivity.this.e.add(pVar.n);
                        String unused2 = PurchaseKENActivity.h = pVar.j;
                    }
                }
                PurchaseKENActivity.this.F();
                PurchaseKENActivity.this.E();
                if (PurchaseKENActivity.this.Y != null) {
                    if (PurchaseKENActivity.this.m != null) {
                        try {
                            PurchaseKENActivity.this.m.removeCallbacks(PurchaseKENActivity.this.ac);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        PurchaseKENActivity.this.m.post(PurchaseKENActivity.this.ac);
                    }
                } else if (PurchaseKENActivity.this.Z == null) {
                    PurchaseKENActivity.this.C();
                }
                PurchaseKENActivity.this.X.a();
                PurchaseKENActivity.this.X = null;
            } catch (Throwable unused3) {
            }
        }

        @Override // chat.ola.vn.p.q
        public void b() {
            try {
                i.a(PurchaseKENActivity.this, R.string.dialog_title_inform, R.string.message_service_is_not_available_now);
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.p.q
        public void b(String str, String str2, String str3) {
            try {
                if (PurchaseKENActivity.this.X != null) {
                    PurchaseKENActivity.this.X.a();
                    PurchaseKENActivity.this.X = null;
                }
                if (!m.a(str3)) {
                    i.b(PurchaseKENActivity.this, PurchaseKENActivity.this.getString(R.string.dialog_title_inform), str3);
                }
                e.a().k(str);
            } catch (Throwable unused) {
            }
            if (m.a(str2)) {
                return;
            }
            try {
                PurchaseKENActivity.this.Y.consumePurchase(3, OlaApplication.f(), str2);
            } catch (Throwable unused2) {
            }
        }
    };

    /* JADX INFO: Access modifiers changed from: private */
    public void C() {
        try {
            if (this.Z == null) {
                this.Z = new ServiceConnection() { // from class: chat.ola.vn.activity.PurchaseKENActivity.8
                    @Override // android.content.ServiceConnection
                    public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
                        try {
                            PurchaseKENActivity.this.Y = IInAppBillingService.Stub.asInterface(iBinder);
                            if (PurchaseKENActivity.l == null || PurchaseKENActivity.l.size() <= 0 || PurchaseKENActivity.this.m == null) {
                                return;
                            }
                            try {
                                PurchaseKENActivity.this.m.removeCallbacks(PurchaseKENActivity.this.ac);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            PurchaseKENActivity.this.m.post(PurchaseKENActivity.this.ac);
                        } catch (Throwable unused) {
                            PurchaseKENActivity.this.Y = null;
                            PurchaseKENActivity.this.Z = null;
                        }
                    }

                    @Override // android.content.ServiceConnection
                    public void onServiceDisconnected(ComponentName componentName) {
                        PurchaseKENActivity.this.Y = null;
                        PurchaseKENActivity.this.Z = null;
                    }
                };
            }
            Intent intent = new Intent("com.android.vending.billing.InAppBillingService.BIND");
            intent.setPackage("com.android.vending");
            bindService(intent, this.Z, 1);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void D() {
        TextView textView;
        int size = this.j.size();
        if (size <= 0) {
            this.A.setVisibility(8);
            return;
        }
        this.A.setVisibility(0);
        this.C.setVisibility(8);
        this.F.setVisibility(8);
        this.I.setVisibility(8);
        this.L.setVisibility(8);
        this.O.setVisibility(8);
        this.R.setVisibility(8);
        if (m.a(this.k)) {
            this.B.setVisibility(8);
        } else {
            this.B.setText(this.k);
            this.B.setVisibility(0);
        }
        if (size > 6) {
            size = 6;
        }
        for (int i = 0; i < size; i++) {
            if (i == 0) {
                this.D.setText(this.j.get(i).i);
                this.E.setText(this.j.get(i).g);
                this.C.setVisibility(0);
                textView = this.E;
            } else if (i == 1) {
                this.G.setText(this.j.get(i).i);
                this.H.setText(this.j.get(i).g);
                this.F.setVisibility(0);
                textView = this.H;
            } else if (i == 2) {
                this.J.setText(this.j.get(i).i);
                this.K.setText(this.j.get(i).g);
                this.I.setVisibility(0);
                textView = this.K;
            } else if (i == 3) {
                this.M.setText(this.j.get(i).i);
                this.N.setText(this.j.get(i).g);
                this.L.setVisibility(0);
                textView = this.N;
            } else if (i == 4) {
                this.P.setText(this.j.get(i).i);
                this.Q.setText(this.j.get(i).g);
                this.O.setVisibility(0);
                textView = this.Q;
            } else if (i == 5) {
                this.S.setText(this.j.get(i).i);
                this.T.setText(this.j.get(i).g);
                this.R.setVisibility(0);
                textView = this.T;
            }
            textView.setVisibility(0);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void E() {
        try {
            if (this.e == null || this.e.size() <= 0) {
                this.u.setVisibility(8);
                return;
            }
            this.u.setVisibility(0);
            this.w.setText(this.e.get(0).a);
            this.i = 0;
            if (m.a(h)) {
                this.v.setVisibility(8);
            } else {
                this.v.setText(h);
                this.v.setVisibility(0);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F() {
        View view;
        try {
            int size = this.f != null ? this.f.size() : 0;
            if (size <= 0) {
                this.m.setVisibility(8);
                return;
            }
            this.m.setVisibility(0);
            this.o.setVisibility(8);
            this.r.setVisibility(8);
            if (m.a(this.g)) {
                this.n.setVisibility(8);
            } else {
                this.n.setText(this.g);
                this.n.setVisibility(0);
            }
            if (size > 2) {
                size = 2;
            }
            for (int i = 0; i < size; i++) {
                if (i == 0) {
                    this.p.setText(this.f.get(i).c);
                    this.q.setText(this.f.get(i).b);
                    view = this.o;
                } else if (i == 1) {
                    this.s.setText(this.f.get(i).c);
                    this.t.setText(this.f.get(i).b);
                    view = this.r;
                }
                view.setVisibility(0);
            }
        } catch (Throwable unused) {
        }
    }

    private void G() {
        try {
            this.X = new chat.ola.vn.i.c(this);
            this.X.setCancelable(false);
            this.X.a(R.string.general_load_form_info);
            this.X.a(5000L, new Runnable() { // from class: chat.ola.vn.activity.PurchaseKENActivity.9
                @Override // java.lang.Runnable
                public void run() {
                    j.a(PurchaseKENActivity.this, R.string.message_process_timeout, "");
                    PurchaseKENActivity.this.X = null;
                }
            });
            if (OlaApplication.b != null) {
                OlaApplication.b.a(OlaApplication.f(), h.T, n.b(this), this.ad);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void H() {
        try {
            String str = this.e.get(this.i).b;
            String string = this.x.getText().toString();
            String string2 = this.y.getText().toString();
            if (g(string, string2)) {
                this.X = new chat.ola.vn.i.c(this);
                this.X.setCancelable(false);
                this.X.a(R.string.message_purchase_ken_by_card_watting);
                this.X.a(60000L, new Runnable() { // from class: chat.ola.vn.activity.PurchaseKENActivity.13
                    @Override // java.lang.Runnable
                    public void run() {
                        j.a(PurchaseKENActivity.this, R.string.message_process_timeout, "");
                        PurchaseKENActivity.this.X = null;
                    }
                });
                if (OlaApplication.b != null) {
                    OlaApplication.b.b(string, string2, str, (String) null, (short) 26);
                }
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        Intent intent = new Intent(context, (Class<?>) PurchaseKENActivity.class);
        intent.addFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        context.startActivity(intent);
    }

    private void a(final ae aeVar) {
        i.b(this, getString(R.string.string_purchase_ken_by_sms), getString(R.string.string_purchase_ken_by_sms_confirm, new Object[]{aeVar.b, aeVar.c}), getString(R.string.string_purchase_ken), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.PurchaseKENActivity.3
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    try {
                        PurchaseKENActivity.this.h(aeVar.a);
                    } catch (Throwable unused) {
                    }
                }
                dialogInterface.dismiss();
            }
        });
    }

    private void c(int i) {
        try {
            OlaApplication.b.a(OlaApplication.f(), this.j.get(i).f, this.ad);
        } catch (Throwable unused) {
            i.a(this, R.string.dialog_title_inform, R.string.message_google_play_bill_account_not_available);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        try {
            if (this.af == null) {
                this.af = new Runnable() { // from class: chat.ola.vn.activity.PurchaseKENActivity.4
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            PurchaseKENActivity.this.ae.dismiss();
                            PurchaseKENActivity.this.ae = null;
                            i.b(PurchaseKENActivity.this, PurchaseKENActivity.this.getString(R.string.dialog_title_inform), PurchaseKENActivity.this.getString(R.string.message_send_sms_fail_confirm));
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            OlaApplication.c(this.af);
            if (!z) {
                if (this.ae != null) {
                    this.ae.dismiss();
                    this.ae = null;
                    return;
                }
                return;
            }
            if (this.ae != null) {
                if (!this.ae.isShowing()) {
                }
                OlaApplication.b(this.af, 120000L);
            }
            this.ae = i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_please_wait_sending_sms));
            this.ae.show();
            OlaApplication.b(this.af, 120000L);
        } catch (Throwable unused) {
        }
    }

    private String g(String str) {
        try {
            if (!str.toLowerCase().contains("viettel") && !str.toLowerCase().contains("vietel")) {
                if (!str.toLowerCase().contains("mobifone") && !str.toLowerCase().contains("mobiphone")) {
                    if (str.toLowerCase().contains("vinaphone")) {
                        return "0918681111";
                    }
                    if (str.toLowerCase().contains("vinafone")) {
                        return "0918681111";
                    }
                    return null;
                }
                return "0908144144";
            }
            return "19008198";
        } catch (Throwable unused) {
            return null;
        }
    }

    private boolean g(String str, String str2) {
        boolean z;
        if (m.a(str)) {
            this.x.startAnimation(this.U);
            z = false;
        } else {
            z = true;
        }
        if (!m.a(str2)) {
            return z;
        }
        this.y.startAnimation(this.U);
        return false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h(String str) {
        try {
            h(str, "MGM NAP " + h.a());
        } catch (Throwable unused) {
        }
    }

    @SuppressLint({"NewApi"})
    private void h(String str, String str2) {
        if (b.a(this)) {
            c(true);
            b.a(this, str, str2);
        } else {
            this.aa = str;
            this.ab = str2;
            requestPermissions(new String[]{"android.permission.SEND_SMS", "android.permission.RECEIVE_SMS"}, 106);
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, d[] dVarArr, short s) {
        if (s != 26) {
            super.a(i, str, bArr, dVarArr, s);
            return;
        }
        try {
            this.X.a();
            this.X = null;
            this.W++;
            if (this.W < 3) {
                if (i == 0) {
                    super.a(i, str, bArr, (d[]) null, (short) 0);
                    return;
                } else {
                    if (m.a(str)) {
                        return;
                    }
                    i.b(this, getString(R.string.message_purchase_ken_fail), str);
                    return;
                }
            }
            this.W = 3;
            try {
                final String strG = g(this.e.get(this.i).a);
                if (g.a(this) && n.b(this) && strG != null) {
                    i.b(this, getString(R.string.message_purchase_ken_fail), getString(R.string.message_purchase_ken_by_card_fail_invalid_card), getString(R.string.message_call_support), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.PurchaseKENActivity.2
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i2) {
                            if (i2 == 0) {
                                try {
                                    chat.ola.vn.util.b.c(PurchaseKENActivity.this, strG);
                                } catch (Throwable unused) {
                                    return;
                                }
                            }
                            dialogInterface.dismiss();
                        }
                    });
                } else {
                    i.a(this, R.string.message_purchase_ken_fail, R.string.message_purchase_ken_by_card_fail_invalid_card);
                }
            } catch (Throwable unused) {
                i.a(this, R.string.message_purchase_ken_fail, R.string.message_purchase_ken_by_card_fail_invalid_card);
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void b(String str, short s) {
        if (s == 26) {
            if (str == null) {
                try {
                    str = getString(R.string.message_purchase_ken_success);
                } catch (Throwable unused) {
                }
            }
            this.X.a();
            this.X = null;
            this.W = 0;
            this.x.setText("");
            this.y.setText("");
            i.b(this, getString(R.string.dialog_title_inform), str);
            try {
                f.a().c("Deposit KEN by CARD");
            } catch (Throwable unused2) {
            }
        }
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    @Override // chat.ola.vn.sms.a.InterfaceC0049a
    public void f(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.PurchaseKENActivity.5
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (b.a(str)) {
                        try {
                            PurchaseKENActivity.this.c(false);
                            i.b(PurchaseKENActivity.this, PurchaseKENActivity.this.getString(R.string.dialog_title_inform), str2);
                        } catch (Throwable unused) {
                        }
                        long j = 0;
                        if (str.endsWith("8555")) {
                            j = 5000;
                        } else if (str.endsWith("8655")) {
                            j = 10000;
                        } else if (str.endsWith("8755")) {
                            j = 15000;
                        }
                        f.a().a("Deposit KEN by SMS", (j * 40) / 100);
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i == 1001) {
            try {
                int intExtra = intent.getIntExtra("RESPONSE_CODE", 0);
                if (intExtra == 0) {
                    String stringExtra = intent.getStringExtra("INAPP_PURCHASE_DATA");
                    String stringExtra2 = intent.getStringExtra("INAPP_DATA_SIGNATURE");
                    if (i2 == -1) {
                        try {
                            if (this.X != null) {
                                this.X.a();
                            }
                            this.X = new chat.ola.vn.i.c(this);
                            this.X.setCancelable(false);
                            this.X.a(R.string.message_purchase_is_processing);
                            this.X.a(30000L, new Runnable() { // from class: chat.ola.vn.activity.PurchaseKENActivity.10
                                @Override // java.lang.Runnable
                                public void run() {
                                    j.a(PurchaseKENActivity.this, R.string.message_process_timeout, "");
                                    PurchaseKENActivity.this.X = null;
                                }
                            });
                        } catch (Throwable unused) {
                        }
                        OlaApplication.b.a(intExtra + "", stringExtra, stringExtra2, this.ad);
                        e.a().b(new JSONObject(stringExtra).getString("productId"), stringExtra2);
                    }
                }
            } catch (Throwable unused2) {
            }
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        ae aeVar;
        int i;
        int id = view.getId();
        if (id == R.id.btnPurchase) {
            if (this.W == 0) {
                H();
                return;
            }
            i.b(this, getString(R.string.dialog_title_confirm), getString(R.string.message_purchase_ken_by_card_fail_format, new Object[]{this.W + "", "3"}), getString(R.string.string_retry), getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.PurchaseKENActivity.12
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    if (i2 == 0) {
                        try {
                            PurchaseKENActivity.this.H();
                        } catch (Throwable unused) {
                            return;
                        }
                    }
                    dialogInterface.dismiss();
                }
            });
            return;
        }
        if (id == R.id.btnQuit) {
            finish();
            return;
        }
        if (id == R.id.txtProviderType) {
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
            final ArrayList arrayList = new ArrayList(0);
            if (this.e == null || this.e.size() <= 0) {
                return;
            }
            int size = this.e.size();
            for (int i2 = 0; i2 < size; i2++) {
                arrayList.add(this.e.get(i2).a);
            }
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.PurchaseKENActivity.11
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view2, int i3, long j) {
                    try {
                        PurchaseKENActivity.this.w.setText((String) arrayList.get(i3));
                        PurchaseKENActivity.this.i = i3;
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        }
        try {
            switch (id) {
                case R.id.linearKENPriceSMS1 /* 2131297005 */:
                    aeVar = this.f.get(0);
                    a(aeVar);
                    break;
                case R.id.linearKENPriceSMS2 /* 2131297006 */:
                    aeVar = this.f.get(1);
                    a(aeVar);
                    break;
                case R.id.linearKenPriceGooglePlay1 /* 2131297007 */:
                    c(0);
                    break;
                case R.id.linearKenPriceGooglePlay2 /* 2131297008 */:
                    c(1);
                    break;
                case R.id.linearKenPriceGooglePlay3 /* 2131297009 */:
                    c(2);
                    break;
                case R.id.linearKenPriceGooglePlay4 /* 2131297010 */:
                    i = 3;
                    c(i);
                    break;
                case R.id.linearKenPriceGooglePlay5 /* 2131297011 */:
                    i = 4;
                    c(i);
                    break;
                case R.id.linearKenPriceGooglePlay6 /* 2131297012 */:
                    i = 5;
                    c(i);
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ken_purchase_layout);
        this.m = findViewById(R.id.linearKENBySMS);
        this.n = (TextView) findViewById(R.id.txtSMSDescript);
        this.o = findViewById(R.id.linearKENPriceSMS1);
        this.o.setOnClickListener(this);
        this.p = (TextView) findViewById(R.id.txtKENSMS1);
        this.q = (TextView) findViewById(R.id.txtVNDSMS1);
        this.r = findViewById(R.id.linearKENPriceSMS2);
        this.r.setOnClickListener(this);
        this.s = (TextView) findViewById(R.id.txtKENSMS2);
        this.t = (TextView) findViewById(R.id.txtVNDSMS2);
        this.u = findViewById(R.id.linearKENByCard);
        this.v = (TextView) findViewById(R.id.txtCardDescript);
        this.w = (TextView) findViewById(R.id.txtProviderType);
        this.w.setOnClickListener(this);
        this.x = (EditText) findViewById(R.id.txtSerialCardNumber);
        this.y = (EditText) findViewById(R.id.txtPurchaseCode);
        this.y.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.PurchaseKENActivity.7
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (i != 5) {
                    return true;
                }
                o.a((Context) PurchaseKENActivity.this, (View) PurchaseKENActivity.this.y, false);
                return true;
            }
        });
        this.z = (Button) findViewById(R.id.btnPurchase);
        this.z.setOnClickListener(this);
        this.A = findViewById(R.id.linearKENByGooglePlay);
        this.B = (TextView) findViewById(R.id.txtGooglePlayDescript);
        this.C = findViewById(R.id.linearKenPriceGooglePlay1);
        this.C.setOnClickListener(this);
        this.D = (TextView) findViewById(R.id.txtKENPriceGooglePlay1);
        this.E = (TextView) findViewById(R.id.txtVNDPriceGooglePlay1);
        this.F = findViewById(R.id.linearKenPriceGooglePlay2);
        this.F.setOnClickListener(this);
        this.G = (TextView) findViewById(R.id.txtKENPriceGooglePlay2);
        this.H = (TextView) findViewById(R.id.txtVNDPriceGooglePlay2);
        this.I = findViewById(R.id.linearKenPriceGooglePlay3);
        this.I.setOnClickListener(this);
        this.J = (TextView) findViewById(R.id.txtKENPriceGooglePlay3);
        this.K = (TextView) findViewById(R.id.txtVNDPriceGooglePlay3);
        this.L = findViewById(R.id.linearKenPriceGooglePlay4);
        this.L.setOnClickListener(this);
        this.M = (TextView) findViewById(R.id.txtKENPriceGooglePlay4);
        this.N = (TextView) findViewById(R.id.txtVNDPriceGooglePlay4);
        this.O = findViewById(R.id.linearKenPriceGooglePlay5);
        this.O.setOnClickListener(this);
        this.P = (TextView) findViewById(R.id.txtKENPriceGooglePlay5);
        this.Q = (TextView) findViewById(R.id.txtVNDPriceGooglePlay5);
        this.R = findViewById(R.id.linearKenPriceGooglePlay6);
        this.R.setOnClickListener(this);
        this.S = (TextView) findViewById(R.id.txtKENPriceGooglePlay6);
        this.T = (TextView) findViewById(R.id.txtVNDPriceGooglePlay6);
        this.V = (ImageView) findViewById(R.id.btnQuit);
        this.V.setOnClickListener(this);
        this.m.setVisibility(8);
        this.u.setVisibility(8);
        this.A.setVisibility(8);
        this.U = AnimationUtils.loadAnimation(this, R.anim.shake);
        C();
        G();
        try {
            this.ag = new a();
            this.ag.a(this);
            registerReceiver(this.ag, new IntentFilter("android.provider.Telephony.SMS_RECEIVED"));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onDestroy() {
        try {
            unbindService(this.Z);
        } catch (Throwable unused) {
        }
        try {
            unregisterReceiver(this.ag);
        } catch (Throwable unused2) {
        }
        super.onDestroy();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        if (i == 106) {
            int i2 = 0;
            while (true) {
                if (i2 >= iArr.length) {
                    c(true);
                    b.a(this, this.aa, this.ab);
                    break;
                } else if (iArr[0] != 0) {
                    break;
                } else {
                    i2++;
                }
            }
        }
        this.aa = null;
        this.ab = null;
    }
}
