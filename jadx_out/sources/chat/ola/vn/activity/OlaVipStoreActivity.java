package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.ad;
import chat.ola.vn.c;
import chat.ola.vn.entity.ah;
import chat.ola.vn.entity.d;
import chat.ola.vn.entry.c.a;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.tradingvip.OlaTraddingVipActivity;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class OlaVipStoreActivity extends c implements View.OnClickListener, AdapterView.OnItemClickListener {
    private static String j;
    protected ah e;
    protected Integer f = null;
    protected Short g;
    protected Long h;
    protected List<ah> i;
    private TextView k;
    private TextView l;
    private TextView m;
    private ListView n;
    private ImageView o;
    private String[] p;
    private SimpleDateFormat q;
    private ad r;
    private TextView s;
    private ImageView t;
    private TextView u;
    private TextView v;
    private View w;
    private Runnable x;

    private boolean D() {
        try {
            if (j != null) {
                if (!m.b(j, h.a())) {
                    return false;
                }
            }
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    private void E() {
        ArrayList arrayList = new ArrayList();
        for (int i = 0; i < this.p.length; i++) {
            arrayList.add(this.p[i]);
        }
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaVipStoreActivity.1
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i2, long j2) {
                a aVar = new a(OlaVipStoreActivity.this.g.shortValue()) { // from class: chat.ola.vn.activity.OlaVipStoreActivity.1.1
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 27;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i3, short s, String str, d[] dVarArr) {
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        j.c(OlaVipStoreActivity.this, R.string.message_change_vip_store_privacy, "");
                        OlaVipStoreActivity.this.B();
                    }
                };
                OlaNetworkService olaNetworkService = OlaApplication.b;
                if (olaNetworkService != null) {
                    olaNetworkService.a((short) i2, f.a(aVar));
                }
                OlaVipStoreActivity.this.C();
            }
        });
        mVar.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F() {
        f(j);
    }

    public static void a(Context context, String str) {
        try {
            j = str;
            Intent intent = new Intent(context, (Class<?>) OlaVipStoreActivity.class);
            intent.addFlags(131072);
            context.startActivity(intent);
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    private void a(final ah ahVar, View view) {
        final ArrayList arrayList = new ArrayList();
        if (!ahVar.g()) {
            arrayList.add(getString(R.string.string_use_vip));
        }
        arrayList.add(getString(ahVar.f() ? R.string.string_unlock : R.string.string_lock));
        arrayList.add(getString(R.string.string_transfer_vip));
        arrayList.add(getString(R.string.string_delete_vip));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
        mVar.a(ahVar.d());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaVipStoreActivity.2
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j2) {
                try {
                    String str = (String) arrayList.get(i);
                    if (m.b(OlaVipStoreActivity.this.getString(R.string.string_use_vip), str)) {
                        OlaVipStoreActivity.this.a(ahVar);
                        return;
                    }
                    if (m.b(OlaVipStoreActivity.this.getString(R.string.string_unlock), str)) {
                        OlaNetworkService olaNetworkService = OlaApplication.b;
                        if (olaNetworkService == null) {
                            return;
                        } else {
                            olaNetworkService.b(new String[]{ahVar.e()});
                        }
                    } else {
                        if (!m.b(OlaVipStoreActivity.this.getString(R.string.string_lock), str)) {
                            if (m.b(OlaVipStoreActivity.this.getString(R.string.string_transfer_vip), str)) {
                                if (!ahVar.f()) {
                                    OlaTraddingVipActivity.a(OlaVipStoreActivity.this, (String) null, ahVar);
                                    return;
                                }
                            } else {
                                if (!m.b(OlaVipStoreActivity.this.getString(R.string.string_delete_vip), str)) {
                                    return;
                                }
                                if (!ahVar.f()) {
                                    OlaVipStoreActivity.this.b(ahVar);
                                    return;
                                }
                            }
                            i.a(OlaVipStoreActivity.this, R.string.dialog_title_inform, R.string.message_vip_is_locked);
                            return;
                        }
                        OlaNetworkService olaNetworkService2 = OlaApplication.b;
                        if (olaNetworkService2 == null) {
                            return;
                        } else {
                            olaNetworkService2.a(new String[]{ahVar.e()});
                        }
                    }
                    OlaVipStoreActivity.this.F();
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void c(ah ahVar) {
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (this.x == null) {
            this.x = new Runnable() { // from class: chat.ola.vn.activity.OlaVipStoreActivity.6
                @Override // java.lang.Runnable
                public void run() {
                    OlaVipStoreActivity.this.c(false);
                    i.b(OlaVipStoreActivity.this, OlaVipStoreActivity.this.getString(R.string.dialog_title_inform), OlaVipStoreActivity.this.getString(R.string.message_fail_load_vipstore));
                }
            };
        }
        OlaApplication.c(this.x);
        if (!z) {
            this.w.setVisibility(8);
        } else if (this.w.getVisibility() != 0) {
            this.w.setVisibility(0);
            OlaApplication.a(this.x, 60000L);
        }
    }

    private void f(final String str) {
        OlaNetworkService olaNetworkService = OlaApplication.b;
        if (olaNetworkService != null) {
            olaNetworkService.j(str, f.a(new e() { // from class: chat.ola.vn.activity.OlaVipStoreActivity.5
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 22;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str2, d[] dVarArr) {
                    OlaVipStoreActivity olaVipStoreActivity;
                    String string;
                    try {
                        OlaVipStoreActivity.this.c(false);
                        if (m.a(str2)) {
                            str2 = OlaVipStoreActivity.this.getString(R.string.message_fail_load_vipstore);
                        }
                        if (i != 38) {
                            olaVipStoreActivity = OlaVipStoreActivity.this;
                            string = OlaVipStoreActivity.this.getString(R.string.dialog_title_inform);
                        } else {
                            olaVipStoreActivity = OlaVipStoreActivity.this;
                            string = OlaVipStoreActivity.this.getString(R.string.dialog_title_inform);
                            str2 = OlaVipStoreActivity.this.getString(R.string.message_fail_permission_access_format, new Object[]{str});
                        }
                        i.b(olaVipStoreActivity, string, str2);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    try {
                        OlaVipStoreActivity.this.c(false);
                        String str2 = (String) objArr[0];
                        int iIntValue = ((Integer) objArr[1]).intValue();
                        short sShortValue = ((Short) objArr[2]).shortValue();
                        String str3 = (String) objArr[3];
                        Long l = (Long) objArr[4];
                        OlaVipStoreActivity.this.a(str2, iIntValue, sShortValue, str3, l.longValue(), (List<ah>) objArr[5]);
                    } catch (Throwable unused) {
                    }
                }
            }));
        }
        c(true);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void B() {
        TextView textView;
        int i;
        TextView textView2;
        StringBuilder sb;
        int i2;
        int size;
        TextView textView3;
        String str;
        if (this.e == null) {
            return;
        }
        this.r.a(this.i);
        this.r.notifyDataSetChanged();
        this.r.a(this.e.b());
        this.r.a(this.e.e());
        if (D()) {
            if (this.o != null) {
                this.o.setImageBitmap(chat.ola.vn.j.a().a(this.e.b()));
            }
            this.k.setText(this.e.d());
            this.l.setText(this.q.format(new Date(this.h.longValue())));
            try {
                size = this.i.size();
            } catch (Throwable unused) {
                size = 0;
            }
            this.u.setText(getString(R.string.string_vip_icon_quantity) + ": " + size);
            switch (this.g.shortValue()) {
                case 0:
                    this.m.setText(this.p[0]);
                    break;
                case 1:
                    textView3 = this.m;
                    str = this.p[1];
                    textView3.setText(str);
                    break;
                case 2:
                    textView3 = this.m;
                    str = this.p[2];
                    textView3.setText(str);
                    break;
            }
            this.s.setText(R.string.message_your_vip_store);
        } else {
            String string = j;
            chat.ola.vn.message.f fVarD = h.t.d(j);
            if (fVarD != null) {
                string = fVarD.L().toString();
            }
            this.s.setText(string);
        }
        if (this.f == null) {
            textView = this.v;
            i = R.string.string_vip_expired;
        } else {
            if (this.f.intValue() > 0) {
                if (this.f.intValue() > 1) {
                    textView2 = this.v;
                    sb = new StringBuilder();
                    sb.append(m.a(this.f.intValue()));
                    sb.append(" ");
                    i2 = R.string.string_days;
                } else {
                    textView2 = this.v;
                    sb = new StringBuilder();
                    sb.append(m.a(this.f.intValue()));
                    sb.append(" ");
                    i2 = R.string.string_day;
                }
                sb.append(getString(i2));
                textView2.setText(sb.toString());
                return;
            }
            textView = this.v;
            i = R.string.string_vip_duration_unlimited;
        }
        textView.setText(i);
    }

    protected void C() {
        f(j);
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    protected void a(final ah ahVar) {
        chat.ola.vn.i.e eVar = new chat.ola.vn.i.e(this);
        eVar.setTitle(R.string.string_use_vip);
        eVar.a(chat.ola.vn.j.a().a(ahVar.b()));
        eVar.a((CharSequence) getString(R.string.message_active_vipicon_confirm, new Object[]{ahVar.d()}));
        eVar.a(R.string.string_use_vip);
        eVar.b(R.string.string_cancel);
        eVar.a(new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaVipStoreActivity.3
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    OlaNetworkService olaNetworkService = OlaApplication.b;
                    if (olaNetworkService != null) {
                        olaNetworkService.p(ahVar.e());
                    }
                    OlaVipStoreActivity.this.C();
                }
                dialogInterface.dismiss();
            }
        });
        eVar.show();
    }

    public void a(String str, int i, short s, String str2, long j2, List<ah> list) {
        c(false);
        j = str;
        this.f = i != 0 ? Integer.valueOf(i) : null;
        this.g = Short.valueOf(s);
        this.h = Long.valueOf(j2);
        this.i = list;
        for (ah ahVar : list) {
            if (ahVar.e().equals(str2)) {
                this.e = ahVar;
            }
            ah ahVarB = chat.ola.vn.j.a().b(ahVar.b());
            if (ahVarB != null) {
                ahVar.a(ahVarB.d());
            }
        }
        B();
    }

    protected void b(final ah ahVar) {
        chat.ola.vn.i.f fVar = new chat.ola.vn.i.f(this);
        fVar.setTitle(R.string.string_delete_vip);
        fVar.a(chat.ola.vn.j.a().a(ahVar.b()));
        fVar.a((CharSequence) getString(R.string.message_delete_vipicon_confirm, new Object[]{ahVar.d()}));
        fVar.a(R.string.string_delete_vip);
        fVar.b(R.string.string_cancel);
        fVar.a(new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaVipStoreActivity.4
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    OlaNetworkService olaNetworkService = OlaApplication.b;
                    if (olaNetworkService != null) {
                        olaNetworkService.c(new String[]{ahVar.e()});
                    }
                    OlaVipStoreActivity.this.C();
                }
                dialogInterface.dismiss();
            }
        });
        fVar.show();
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.buyVipTextView /* 2131296578 */:
                    BuyVipActivity.a(this);
                    break;
                case R.id.extendVipButton /* 2131296778 */:
                case R.id.extendVipTextView /* 2131296779 */:
                    BuyVipActivity.b(this);
                    break;
                case R.id.olaActionBarBackViewLayout /* 2131297180 */:
                case R.id.olaActionBarMoreButtonImageView /* 2131297185 */:
                    finish();
                    break;
                case R.id.policyViewLayout /* 2131297245 */:
                    E();
                    break;
                case R.id.vipIconImageView /* 2131297775 */:
                    c((ah) view.getTag());
                    break;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.vip_manager_layout);
        this.s = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        this.t = (ImageView) findViewById(R.id.olaActionBarMoreButtonImageView);
        this.t.setVisibility(0);
        this.t.setImageResource(R.drawable.ic_action_quit);
        this.w = findViewById(R.id.wattingProgressBar);
        this.n = (ListView) findViewById(R.id.listView);
        this.v = (TextView) findViewById(R.id.vipDurationTextView);
        findViewById(R.id.extendVipButton).setOnClickListener(this);
        if (D()) {
            View viewInflate = LayoutInflater.from(this).inflate(R.layout.vip_storage_header_layout, (ViewGroup) null);
            this.o = (ImageView) viewInflate.findViewById(R.id.vipIconImageView);
            this.o.setOnClickListener(this);
            viewInflate.findViewById(R.id.buyVipTextView).setOnClickListener(this);
            viewInflate.findViewById(R.id.extendVipTextView).setOnClickListener(this);
            this.k = (TextView) viewInflate.findViewById(R.id.vipNameTextView);
            this.l = (TextView) viewInflate.findViewById(R.id.vipStateTextView);
            viewInflate.findViewById(R.id.policyViewLayout).setOnClickListener(this);
            this.m = (TextView) viewInflate.findViewById(R.id.policyTextView);
            this.u = (TextView) viewInflate.findViewById(R.id.labelTextView);
            this.u.setText(R.string.string_vip_store);
            this.n.addHeaderView(viewInflate);
        }
        this.t.setOnClickListener(this);
        this.n.setOnItemClickListener(this);
        this.p = getResources().getStringArray(R.array.privacy_lable);
        this.q = new SimpleDateFormat("dd-MM-yyyy", Locale.getDefault());
        this.r = new ad(this);
        this.r.a(true);
        this.n.setAdapter((ListAdapter) this.r);
        f(!m.a(j) ? j : h.a());
        B();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j2) {
        try {
            if (this.r != null) {
                ah item = this.r.getItem(i - 1);
                if (D()) {
                    a(item, view);
                }
            }
        } catch (Throwable unused) {
        }
    }
}
