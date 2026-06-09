package chat.ola.vn.tradingvip;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.ad;
import chat.ola.vn.entity.ah;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.i.i;
import chat.ola.vn.j;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b extends a implements View.OnClickListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener {
    private static int d = -1;
    private static int e = -1;
    protected List<ah> a;
    private ListView b;
    private ad c;

    private void e(final String str) {
        e().c(true);
        OlaNetworkService olaNetworkService = OlaApplication.b;
        if (olaNetworkService != null) {
            olaNetworkService.j(str, f.a(new e() { // from class: chat.ola.vn.tradingvip.b.1
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 22;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str2, chat.ola.vn.entity.d[] dVarArr) {
                    FragmentActivity activity;
                    String string;
                    try {
                        b.this.e().c(false);
                        if (m.a(str2)) {
                            str2 = b.this.getString(R.string.message_fail_load_vipstore);
                        }
                        if (i != 38) {
                            activity = b.this.getActivity();
                            string = b.this.getString(R.string.dialog_title_inform);
                        } else {
                            activity = b.this.getActivity();
                            string = b.this.getString(R.string.dialog_title_inform);
                            str2 = b.this.getString(R.string.message_fail_permission_access_format, str);
                        }
                        i.b(activity, string, str2);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    try {
                        b.this.e().c(false);
                        String str2 = (String) objArr[0];
                        int iIntValue = ((Integer) objArr[1]).intValue();
                        short sShortValue = ((Short) objArr[2]).shortValue();
                        String str3 = (String) objArr[3];
                        Long l = (Long) objArr[4];
                        b.this.a(str2, iIntValue, sShortValue, str3, l.longValue(), (List<ah>) objArr[5]);
                    } catch (Throwable unused) {
                    }
                }
            }));
        }
    }

    public void a(String str, int i, short s, String str2, long j, List<ah> list) {
        this.a = new ArrayList(list.size());
        ah ahVar = null;
        for (ah ahVar2 : list) {
            if (m.a(ahVar2.e(), str2)) {
                ahVar = ahVar2;
            } else {
                this.a.add(ahVar2);
            }
            ah ahVarB = j.a().b(ahVar2.b());
            if (ahVarB != null) {
                ahVar2.a(ahVarB.d());
            }
        }
        this.c.a(this.a);
        if (ahVar != null) {
            this.c.a(ahVar.b());
            this.c.a(ahVar.e());
        }
        this.c.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.tradingvip.a
    public a c() {
        try {
            return (c) Fragment.instantiate(getActivity(), c.class.getName());
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_select_vip_icon_for_tradding);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        if (view.getId() != R.id.olaActionBarBackViewLayout) {
            return;
        }
        j();
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_tradding_vip_step1_fragment_layout, (ViewGroup) null);
        this.b = (ListView) viewInflate.findViewById(R.id.vipIconListView);
        this.b.setOnItemClickListener(this);
        this.c = new ad(getActivity());
        this.c.a(false);
        this.b.setAdapter((ListAdapter) this.c);
        e(null);
        return viewInflate;
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            OlaTraddingVipActivity.e = this.a.get(i);
            e().B();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        this.b.post(new Runnable() { // from class: chat.ola.vn.tradingvip.b.2
            @Override // java.lang.Runnable
            public void run() {
                if (b.e >= 0) {
                    b.this.b.setSelectionFromTop(b.e, b.d);
                } else {
                    b.this.b.setSelection(0);
                }
                b.this.b.setOnScrollListener(b.this);
            }
        });
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        try {
            int top = 0;
            View childAt = this.b.getChildAt(0);
            if (childAt != null) {
                top = childAt.getTop();
            }
            d = top;
        } catch (Throwable unused) {
        }
        e = i;
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
    }
}
