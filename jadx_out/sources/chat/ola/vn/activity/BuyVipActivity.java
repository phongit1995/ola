package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.aa;
import chat.ola.vn.b.ad;
import chat.ola.vn.c;
import chat.ola.vn.entity.ac;
import chat.ola.vn.entity.ah;
import chat.ola.vn.entity.d;
import chat.ola.vn.h;
import chat.ola.vn.i.e;
import chat.ola.vn.i.i;
import chat.ola.vn.j;
import chat.ola.vn.message.f;
import chat.ola.vn.sms.a;
import chat.ola.vn.util.k;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaSuggestEditText;
import com.google.android.gms.common.util.CrashUtils;
import com.mg.ola.common.widget.b;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"ClickableViewAccessibility"})
public class BuyVipActivity extends c implements View.OnClickListener, a.InterfaceC0049a {
    private static List<ac> e;
    private static List<ac> f;
    private static List<ah> g;
    private BroadcastReceiver A;
    private chat.ola.vn.i.c B;
    private b C;
    private ProgressDialog D;
    private Runnable E;
    private a F;
    private String h;
    private String i;
    private TextView j;
    private ImageView k;
    private TextView l;
    private OlaSuggestEditText m;
    private OlaSuggestEditText n;
    private Button o;
    private CheckBox p;
    private ah q;
    private ac r;
    private ad s;
    private aa<ac> t;
    private View u;
    private e v;
    private TextView w;
    private int x;
    private View y;
    private Animation z;

    private void F() {
        this.w = (TextView) findViewById(R.id.txtKenAvaliable);
        this.j = (TextView) findViewById(R.id.txtActionTitle);
        this.k = (ImageView) findViewById(R.id.imgVipThumbnail);
        this.p = (CheckBox) findViewById(R.id.rechargeBySMS);
        this.m = (OlaSuggestEditText) findViewById(R.id.txtPricePackage);
        this.n = (OlaSuggestEditText) findViewById(R.id.txtReceiverNickname);
        this.o = (Button) findViewById(R.id.btnPurchaseVip);
        this.l = (TextView) findViewById(R.id.txtVipName);
        this.u = findViewById(R.id.receiverInputBlock);
        this.y = findViewById(R.id.vipListItemBlock);
        this.n.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.BuyVipActivity.12
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                o.a((Context) BuyVipActivity.this, (View) BuyVipActivity.this.n, false);
            }
        });
        this.n.setConvertItemFactory(new OlaSuggestEditText.a() { // from class: chat.ola.vn.activity.BuyVipActivity.13
            @Override // chat.ola.vn.view.OlaSuggestEditText.a
            public String a(Object obj) {
                return ((f) obj).j();
            }
        });
        this.t = new aa<ac>(this, e) { // from class: chat.ola.vn.activity.BuyVipActivity.14
            @Override // chat.ola.vn.b.aa
            public CharSequence a(ac acVar) {
                Context contextB;
                int i;
                Object[] objArr;
                if (m.c(acVar.b)) {
                    contextB = b();
                    i = R.string.vip_lable_ken_price_format;
                    objArr = new Object[]{m.a(acVar.c), m.a(acVar.d)};
                } else {
                    contextB = b();
                    i = R.string.vip_lable_sms_price_format;
                    objArr = new Object[]{acVar.a, m.a(acVar.d)};
                }
                return contextB.getString(i, objArr);
            }
        };
        this.m.setAdapter(this.t);
        this.p.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() { // from class: chat.ola.vn.activity.BuyVipActivity.15
            /* JADX WARN: Removed duplicated region for block: B:21:0x007a  */
            /* JADX WARN: Removed duplicated region for block: B:24:0x00ac  */
            /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
            @Override // android.widget.CompoundButton.OnCheckedChangeListener
            /*
                Code decompiled incorrectly, please refer to instructions dump.
                To view partially-correct add '--show-bad-code' argument
            */
            public void onCheckedChanged(android.widget.CompoundButton r7, boolean r8) {
                /*
                    Method dump skipped, instruction units count: 212
                    To view this dump add '--comments-level debug' option
                */
                throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.BuyVipActivity.AnonymousClass15.onCheckedChanged(android.widget.CompoundButton, boolean):void");
            }
        });
        findViewById(R.id.linearVipName).setOnTouchListener(new View.OnTouchListener() { // from class: chat.ola.vn.activity.BuyVipActivity.16
            @Override // android.view.View.OnTouchListener
            public boolean onTouch(View view, MotionEvent motionEvent) {
                if (motionEvent.getAction() != 0) {
                    return false;
                }
                BuyVipActivity.this.a(view);
                return true;
            }
        });
        this.m.setOnTouchListener(new View.OnTouchListener() { // from class: chat.ola.vn.activity.BuyVipActivity.17
            @Override // android.view.View.OnTouchListener
            public boolean onTouch(View view, MotionEvent motionEvent) {
                if (motionEvent.getAction() != 0) {
                    return false;
                }
                if (BuyVipActivity.this.m.isPopupShowing()) {
                    BuyVipActivity.this.m.dismissDropDown();
                    return true;
                }
                BuyVipActivity.this.m.showDropDown();
                return true;
            }
        });
        chat.ola.vn.entry.b.a aVar = new chat.ola.vn.entry.b.a(this);
        aVar.b.setVisibility(4);
        aVar.d.setText(R.string.string_buy_vip);
        aVar.c.setImageResource(R.drawable.ic_action_quit);
        aVar.c.setOnClickListener(this);
        findViewById(R.id.btnPurchaseVip).setOnClickListener(this);
        this.m.setConvertItemFactory(new OlaSuggestEditText.a() { // from class: chat.ola.vn.activity.BuyVipActivity.18
            @Override // chat.ola.vn.view.OlaSuggestEditText.a
            public String a(Object obj) {
                BuyVipActivity buyVipActivity;
                int i;
                Object[] objArr;
                ac acVar = (ac) obj;
                if (m.a(acVar.b)) {
                    buyVipActivity = BuyVipActivity.this;
                    i = R.string.vip_lable_ken_price_format;
                    objArr = new Object[]{m.a(acVar.c), m.a(acVar.d)};
                } else {
                    buyVipActivity = BuyVipActivity.this;
                    i = R.string.vip_lable_sms_price_format;
                    objArr = new Object[]{acVar.a, m.a(acVar.d)};
                }
                return buyVipActivity.getString(i, objArr);
            }
        });
        this.m.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.BuyVipActivity.19
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                BuyVipActivity.this.r = (ac) BuyVipActivity.this.t.getItem(i);
                BuyVipActivity.this.B();
            }
        });
        if (!n.b(this) || !x() || !h.a) {
            this.p.setChecked(false);
            this.p.setVisibility(8);
            return;
        }
        if (h.o >= 1000) {
            this.p.setEnabled(true);
            this.p.setChecked(false);
            this.p.setVisibility(0);
        } else {
            this.p.setChecked(true);
            this.p.setVisibility(8);
            if (f == null) {
                I();
            }
            this.t.a(f);
            this.t.notifyDataSetChanged();
        }
    }

    private void G() {
        View view;
        int i;
        findViewById(R.id.btnReceiveMore).setOnClickListener(this);
        String stringExtra = getIntent().getStringExtra("receiver_id");
        if (!m.a(stringExtra)) {
            this.n.setText(stringExtra);
            if (m.b(stringExtra, h.a())) {
                this.o.setText(R.string.string_extend_vip);
                view = this.u;
                i = 8;
            } else {
                this.o.setText(R.string.string_buy_vip);
                view = this.u;
                i = 0;
            }
            view.setVisibility(i);
        }
        H();
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void H() {
        TextView textView;
        int i = this.x;
        int i2 = R.string.string_buy_vip;
        switch (i) {
            case 0:
            default:
                textView = this.j;
                break;
            case 1:
                textView = this.j;
                i2 = R.string.string_give_vip;
                break;
            case 2:
                textView = this.j;
                i2 = R.string.string_send_vip_days;
                break;
            case 3:
                textView = this.j;
                i2 = R.string.string_extend_vip;
                break;
        }
        textView.setText(i2);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void I() {
        ac acVar = new ac();
        acVar.d = 10;
        acVar.a = "10,000";
        acVar.b = "8655";
        ac acVar2 = new ac();
        acVar2.d = 20;
        acVar2.a = "15,000";
        acVar2.b = "8755";
        f = new ArrayList(3);
        f.add(acVar2);
        f.add(acVar);
    }

    private boolean J() {
        if (this.r == null) {
            this.m.startAnimation(this.z);
            return false;
        }
        switch (this.x) {
            case 1:
            case 2:
                if (this.n.length() == 0) {
                    this.n.startAnimation(this.z);
                }
                break;
        }
        return false;
    }

    private void K() {
        String string;
        String string2;
        String string3;
        String string4;
        DialogInterface.OnClickListener onClickListener;
        Activity activity;
        String str;
        String string5;
        e eVarB;
        Object objD = this.q.d();
        final String string6 = this.n.getText().toString();
        String string7 = getString(R.string.vip_lable_ken_price_format, new Object[]{m.a(this.r.c), m.a(this.r.d)});
        switch (this.x) {
            case 0:
                string = getString(R.string.string_buy_vip);
                string2 = getString(R.string.message_buy_vip_confirm_format, new Object[]{objD, string7});
                string3 = getString(R.string.string_buy_vip);
                string4 = getString(R.string.string_cancel);
                onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.BuyVipActivity.6
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            BuyVipActivity.this.a(h.a(), BuyVipActivity.this.r.d, (short) BuyVipActivity.this.q.b());
                        }
                        dialogInterface.dismiss();
                    }
                };
                activity = this;
                str = string;
                string5 = string3;
                eVarB = i.b(activity, str, string2, string5, string4, onClickListener);
                this.v = eVarB;
                this.v.a(j.a().a(this.q.b()));
                this.v.show();
                break;
            case 1:
                string = getString(R.string.string_buy_vip);
                string2 = getString(R.string.message_give_vip_confirm_format, new Object[]{objD, string7, string6});
                string3 = getString(R.string.string_buy_vip);
                string4 = getString(R.string.string_cancel);
                onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.BuyVipActivity.7
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            BuyVipActivity.this.a(string6, BuyVipActivity.this.r.d, (short) BuyVipActivity.this.q.b());
                        }
                        dialogInterface.dismiss();
                    }
                };
                activity = this;
                str = string;
                string5 = string3;
                eVarB = i.b(activity, str, string2, string5, string4, onClickListener);
                this.v = eVarB;
                this.v.a(j.a().a(this.q.b()));
                this.v.show();
                break;
            case 2:
            case 3:
                if (!m.b(string6, h.a())) {
                    String string8 = getString(R.string.string_buy_vip);
                    string2 = getString(R.string.message_give_day_vip_confirm_format, new Object[]{m.a(this.r.d), m.a(this.r.c), string6});
                    string5 = getString(R.string.string_buy_vip);
                    string4 = getString(R.string.string_cancel);
                    onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.BuyVipActivity.9
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                BuyVipActivity.this.a(string6, BuyVipActivity.this.r.d, (short) 0);
                            }
                            dialogInterface.dismiss();
                        }
                    };
                    activity = this;
                    str = string8;
                    eVarB = i.b(activity, str, string2, string5, string4, onClickListener);
                    this.v = eVarB;
                    this.v.a(j.a().a(this.q.b()));
                    this.v.show();
                } else {
                    eVarB = i.b(this, getString(R.string.string_extend_vip), getString(R.string.message_extend_day_vip_confirm_format, new Object[]{m.a(this.r.d), m.a(this.r.c)}), getString(R.string.string_extend_vip), getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.BuyVipActivity.8
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                BuyVipActivity.this.a(string6, BuyVipActivity.this.r.d, (short) 0);
                            }
                            dialogInterface.dismiss();
                        }
                    });
                    this.v = eVarB;
                    this.v.a(j.a().a(this.q.b()));
                    this.v.show();
                }
                break;
        }
    }

    public static void a(Context context) {
        if (context != null) {
            Intent intent = new Intent(context, (Class<?>) BuyVipActivity.class);
            intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
            intent.putExtra("form_type", 0);
            a(context, intent);
        }
    }

    private static void a(final Context context, final Intent intent) {
        if (e == null || g == null) {
            final chat.ola.vn.i.c cVar = new chat.ola.vn.i.c(context);
            cVar.a(R.string.message_loading_buy_info);
            cVar.a(10000L, new Runnable() { // from class: chat.ola.vn.activity.BuyVipActivity.3
                @Override // java.lang.Runnable
                public void run() {
                    chat.ola.vn.util.j.b(context, R.string.message_process_timeout);
                }
            });
            chat.ola.vn.entry.c.e eVar = new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.BuyVipActivity.4
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 10;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, d[] dVarArr) {
                    cVar.a();
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    cVar.a();
                    List unused = BuyVipActivity.e = (List) objArr[0];
                    List unused2 = BuyVipActivity.g = (List) objArr[1];
                    if (BuyVipActivity.e == null || BuyVipActivity.g == null) {
                        return;
                    }
                    for (ah ahVar : BuyVipActivity.g) {
                        ah ahVarB = j.a().b(ahVar.b());
                        if (ahVarB != null && ahVar.b() == ahVarB.b()) {
                            ahVar.b(ahVarB.e());
                            ahVar.a(ahVarB.d());
                        }
                    }
                    context.startActivity(intent);
                }
            };
            if (OlaApplication.b == null) {
                return;
            } else {
                OlaApplication.b.c(chat.ola.vn.entry.c.f.a(eVar));
            }
        } else {
            context.startActivity(intent);
            if (OlaApplication.b == null) {
                return;
            }
        }
        OlaApplication.b.r();
    }

    public static void a(Context context, String str) {
        Intent intent = new Intent(context, (Class<?>) BuyVipActivity.class);
        if (str != null) {
            intent.putExtra("receiver_id", str);
        }
        intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        intent.putExtra("form_type", 1);
        a(context, intent);
    }

    public static void b(Context context) {
        b(context, (String) null);
    }

    public static void b(Context context, String str) {
        Intent intent = new Intent(context, (Class<?>) BuyVipActivity.class);
        if (str != null) {
            intent.putExtra("receiver_id", str);
        }
        intent.putExtra("receiver_id", h.a());
        intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        intent.putExtra("form_type", 3);
        a(context, intent);
    }

    public static void c(Context context, String str) {
        Intent intent = new Intent(context, (Class<?>) BuyVipActivity.class);
        if (str != null) {
            intent.putExtra("receiver_id", str);
        }
        intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        intent.putExtra("form_type", 2);
        a(context, intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        try {
            if (this.E == null) {
                this.E = new Runnable() { // from class: chat.ola.vn.activity.BuyVipActivity.5
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            BuyVipActivity.this.D.dismiss();
                            BuyVipActivity.this.D = null;
                            BuyVipActivity.this.c(false);
                            i.b(BuyVipActivity.this, BuyVipActivity.this.getString(R.string.dialog_title_inform), BuyVipActivity.this.getString(R.string.message_send_sms_fail_confirm));
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            OlaApplication.c(this.E);
            if (!z) {
                if (this.D != null) {
                    this.D.dismiss();
                    this.D = null;
                    return;
                }
                return;
            }
            if (this.D != null) {
                if (!this.D.isShowing()) {
                }
                OlaApplication.b(this.E, 120000L);
            }
            this.D = i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_please_wait_sending_sms));
            this.D.show();
            OlaApplication.b(this.E, 120000L);
        } catch (Throwable unused) {
        }
    }

    @SuppressLint({"NewApi"})
    private void g(String str, String str2) {
        if (chat.ola.vn.sms.b.a(this)) {
            c(true);
            chat.ola.vn.sms.b.a(this, str, str2);
        } else {
            this.h = str;
            this.i = str2;
            requestPermissions(new String[]{"android.permission.SEND_SMS", "android.permission.RECEIVE_SMS"}, 106);
        }
    }

    protected void B() {
        OlaSuggestEditText olaSuggestEditText;
        int i;
        Object[] objArr;
        List<ac> list;
        ac acVar;
        if (g == null || g.isEmpty() || e == null || e.isEmpty()) {
            return;
        }
        if (this.q == null) {
            try {
                this.q = g.get(new Random().nextInt(g.size()));
            } catch (Throwable unused) {
                this.q = g.get(0);
            }
        }
        if (this.q != null) {
            this.l.setText(this.q.d());
        }
        if (this.r == null) {
            if (this.p.isChecked()) {
                list = f;
            } else if (e.size() > 2) {
                acVar = e.get(2);
                this.r = acVar;
            } else {
                list = e;
            }
            acVar = list.get(0);
            this.r = acVar;
        }
        if (this.r != null) {
            this.k.setImageBitmap(j.a().a(this.q.b()));
            if (m.a(this.r.b)) {
                olaSuggestEditText = this.m;
                i = R.string.vip_lable_ken_price_format;
                objArr = new Object[]{m.a(this.r.c), m.a(this.r.d)};
            } else {
                olaSuggestEditText = this.m;
                i = R.string.vip_lable_sms_price_format;
                objArr = new Object[]{this.r.a, m.a(this.r.d)};
            }
            olaSuggestEditText.setText(getString(i, objArr));
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        try {
            registerReceiver(this.A, new IntentFilter("chat.ola.vn.ACTION_CHANGE_BALANCE"));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, d[] dVarArr, short s) {
        super.a(i, str, bArr, dVarArr, s);
        if (s == 25) {
            this.B.a();
            chat.ola.vn.util.j.c(this, R.string.message_buy_vip_tranning_fail);
        }
        if (OlaApplication.b != null) {
            OlaApplication.b.r();
        }
    }

    protected void a(View view) {
        try {
            if (this.s == null) {
                this.s = new ad(this);
                this.s.a(false);
            }
            this.s.a(g);
            this.s.notifyDataSetChanged();
            if (this.C == null) {
                this.C = k.a(this, this.s, new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.BuyVipActivity.2
                    @Override // android.widget.AdapterView.OnItemClickListener
                    public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j) {
                        BuyVipActivity.this.q = BuyVipActivity.this.s.getItem(i);
                        BuyVipActivity.this.B();
                        BuyVipActivity.this.C.d();
                    }
                });
                this.C.c(true);
                this.C.d(R.drawable.abs__menu_dropdown_panel_holo_light);
            }
            this.C.a(view);
            if (this.C.f()) {
                return;
            }
            this.C.b();
        } catch (Throwable unused) {
        }
    }

    protected void a(String str, int i, short s) {
        this.B = new chat.ola.vn.i.c(this);
        this.B.a(R.string.message_buy_vip_tranning);
        this.B.a(60000L, new Runnable() { // from class: chat.ola.vn.activity.BuyVipActivity.10
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.util.j.c(BuyVipActivity.this, R.string.message_buy_vip_tranning_fail_timeout);
            }
        });
        if (OlaApplication.b != null) {
            OlaApplication.b.a(str, i, s, (short) 25);
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, short s, int i, long j, short s2) {
        String strD;
        try {
            this.B.dismiss();
            this.B = null;
        } catch (Throwable unused) {
        }
        ah ahVarB = j.a().b(s);
        if (ahVarB != null) {
            strD = ahVarB.d();
        } else {
            strD = ((int) s) + "";
        }
        i.a(this, j.a().a(s), getString(R.string.dialog_title_inform), getString(R.string.message_bought_vip_confirm_format, new Object[]{Long.valueOf(j), strD, Integer.valueOf(i)}));
        if (OlaApplication.b != null) {
            OlaApplication.b.r();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, short s, int i, short s2) {
        String strD;
        try {
            this.B.dismiss();
            this.B = null;
        } catch (Throwable unused) {
        }
        ah ahVarB = j.a().b(s);
        if (ahVarB != null) {
            strD = ahVarB.d();
        } else {
            strD = ((int) s) + "";
        }
        i.a(this, j.a().a(s), getString(R.string.dialog_title_inform), getString(R.string.message_gived_vip_confirm_format, new Object[]{str, strD, Integer.valueOf(i)}));
        if (OlaApplication.b != null) {
            OlaApplication.b.r();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void b(String str, short s, int i, short s2) {
        super.b(str, s, i, s2);
        if (OlaApplication.b != null) {
            OlaApplication.b.r();
        }
    }

    @Override // chat.ola.vn.sms.a.InterfaceC0049a
    public void f(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.BuyVipActivity.11
            @Override // java.lang.Runnable
            public void run() {
                if (chat.ola.vn.sms.b.a(str)) {
                    try {
                        BuyVipActivity.this.c(false);
                        i.b(BuyVipActivity.this, BuyVipActivity.this.getString(R.string.dialog_title_inform), str2);
                    } catch (Throwable unused) {
                    }
                    long j = 0;
                    try {
                        if (str.endsWith("8555")) {
                            j = 5000;
                        } else if (str.endsWith("8655")) {
                            j = 10000;
                        } else if (str.endsWith("8755")) {
                            j = 15000;
                        }
                        chat.ola.vn.util.f.a().a("Buy VIP by SMS", (j * 40) / 100);
                    } catch (Throwable unused2) {
                    }
                }
            }
        });
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        OlaSuggestEditText olaSuggestEditText;
        try {
            int id = view.getId();
            if (id == R.id.btnActionButtonRight) {
                finish();
                return;
            }
            if (id != R.id.btnPurchaseVip) {
                if (id != R.id.btnReceiveMore) {
                    if (id != R.id.txtPricePackage || this.m.isPopupShowing()) {
                        return;
                    } else {
                        olaSuggestEditText = this.m;
                    }
                } else if (this.n.isPopupShowing()) {
                    return;
                } else {
                    olaSuggestEditText = this.n;
                }
                olaSuggestEditText.showDropDown();
                return;
            }
            if (J()) {
                if (!this.p.isChecked()) {
                    K();
                    return;
                }
                String str = this.r.b;
                if (m.a(str)) {
                    str = "8755";
                }
                String string = this.n.getText().toString();
                if (this.x == 0) {
                    string = h.a();
                }
                if (m.a(string)) {
                    string = h.a();
                }
                g(str, "MGM BUYVIP " + string + " " + this.q.b());
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        TextView textView;
        int i;
        super.onCreate(bundle);
        setContentView(R.layout.vip_purchase_layout);
        this.z = AnimationUtils.loadAnimation(this, R.anim.shake);
        F();
        this.x = getIntent().getIntExtra("form_type", 0);
        switch (this.x) {
            case 0:
                this.u.setVisibility(8);
                this.y.setVisibility(0);
                this.j.setText(R.string.string_buy_vip);
                break;
            case 1:
                this.u.setVisibility(0);
                this.y.setVisibility(0);
                textView = this.j;
                i = R.string.string_give_vip;
                textView.setText(i);
                G();
                break;
            case 2:
                this.u.setVisibility(0);
                this.y.setVisibility(8);
                textView = this.j;
                i = R.string.string_give_vip_day;
                textView.setText(i);
                G();
                break;
            case 3:
                this.n.setEnabled(false);
                this.u.setVisibility(0);
                this.y.setVisibility(8);
                textView = this.j;
                i = R.string.string_buy_vip_day;
                textView.setText(i);
                G();
                break;
        }
        if (OlaApplication.b != null) {
            OlaApplication.b.r();
        }
        this.A = new BroadcastReceiver() { // from class: chat.ola.vn.activity.BuyVipActivity.1
            @Override // android.content.BroadcastReceiver
            public void onReceive(Context context, Intent intent) {
                BuyVipActivity.this.w.setText(m.a(h.o) + " KEN");
            }
        };
        B();
        try {
            this.F = new a();
            this.F.a(this);
            registerReceiver(this.F, new IntentFilter("android.provider.Telephony.SMS_RECEIVED"));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        try {
            unregisterReceiver(this.F);
        } catch (Throwable unused) {
        }
        super.onDestroy();
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        try {
            unregisterReceiver(this.A);
        } catch (Throwable unused) {
        }
        super.onPause();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        if (i == 106) {
            int i2 = 0;
            while (true) {
                if (i2 >= iArr.length) {
                    c(true);
                    chat.ola.vn.sms.b.a(this, this.h, this.i);
                    break;
                } else if (iArr[i2] != 0) {
                    break;
                } else {
                    i2++;
                }
            }
        }
        this.h = null;
        this.i = null;
    }
}
