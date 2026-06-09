package chat.ola.vn.m;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.me.OlaMeCommentActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class k extends a implements View.OnClickListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener {
    public static List<chat.ola.vn.entity.j> a = new ArrayList();
    private static k b;
    private static long e;
    private static long f;
    private ListView c;
    private chat.ola.vn.b.x d;
    private SwipeRefreshLayout g;
    private boolean h = false;
    private boolean i;
    private View j;
    private View k;

    public static void a(Context context) {
        e = 0L;
        f = -1L;
        if (a != null) {
            a.clear();
        }
        try {
            ((OlaBottomTabActivity) chat.ola.vn.c.c()).I();
        } catch (Throwable unused) {
        }
        chat.ola.vn.entry.e eVarB = chat.ola.vn.h.v.b(R.string.general_tab_notify);
        if (eVarB != null) {
            eVarB.b(1);
            eVarB.c((String) null);
        }
        if (d.c() != null) {
            d.c().d();
        }
        OlaBottomTabActivity.a(context, 9);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        this.j.setVisibility(z ? 0 : 8);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(chat.ola.vn.entity.j[] jVarArr, int i) {
        if (jVarArr == null || jVarArr.length <= 0) {
            this.j.setVisibility(8);
            this.k.setVisibility(0);
            return;
        }
        for (chat.ola.vn.entity.j jVar : jVarArr) {
            a.add(jVar);
        }
        this.d.notifyDataSetChanged();
        e = jVarArr[jVarArr.length - 1].h;
        this.j.setVisibility(8);
        this.k.setVisibility(8);
        if (this.c.getLastVisiblePosition() >= this.d.getCount() - 1) {
            d();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d() {
        if (OlaApplication.b != null) {
            if (!this.h) {
                this.j.setVisibility(0);
                this.k.setVisibility(8);
            }
            if (f != e) {
                OlaApplication.b.a(e, true, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.m.k.2
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 39;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        k.this.j.setVisibility(8);
                        k.this.k.setVisibility(0);
                        k.this.j();
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        k.this.j.setVisibility(8);
                        k.this.k.setVisibility(8);
                        k.this.a((chat.ola.vn.entity.j[]) objArr[0], ((Integer) objArr[1]).intValue());
                        k.this.h();
                    }
                }));
                f = e;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e() {
        this.h = true;
        if (chat.ola.vn.c.x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.s);
        }
        this.g.setRefreshing(true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h() {
        if (this.h && chat.ola.vn.c.x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.t);
        }
        this.g.setRefreshing(false);
        this.h = false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void j() {
        if (this.h && chat.ola.vn.c.x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.t);
        }
        this.g.setRefreshing(false);
        this.h = false;
    }

    @Override // chat.ola.vn.m.f
    public void b(Bundle bundle) {
        super.b(bundle);
        b = this;
        this.c.setOnItemClickListener(this);
        this.d = new chat.ola.vn.b.x(getActivity());
        this.d.a(this);
        this.c.setAdapter((ListAdapter) this.d);
        this.c.setOnScrollListener(this);
        d();
    }

    public int c() {
        return 9;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.imgIcon /* 2131296892 */:
                    break;
                case R.id.notificationButton1 /* 2131297145 */:
                    final chat.ola.vn.entity.j jVar = (chat.ola.vn.entity.j) view.getTag();
                    if (jVar != null) {
                        if (!jVar.f.equals("3")) {
                            chat.ola.vn.i.i.a(getActivity(), getString(R.string.string_box), getString(R.string.message_accept_married_proposal, jVar.b), getString(R.string.string_agree), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.k.3
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    if (i == 0) {
                                        try {
                                            String strB = jVar.a[0].b();
                                            if (chat.ola.vn.util.m.a(strB)) {
                                                strB = jVar.a[0].c();
                                            }
                                            OlaApplication.b.C(strB);
                                            OlaApplication.b.d(new String[]{jVar.d});
                                            k.a.remove(jVar);
                                            k.this.d.notifyDataSetChanged();
                                        } catch (Throwable unused) {
                                        }
                                    }
                                    try {
                                        dialogInterface.dismiss();
                                    } catch (Throwable unused2) {
                                    }
                                }
                            });
                        } else if (chat.ola.vn.h.t.d(jVar.b) == null) {
                            chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(jVar.b, (short) 0);
                            if (!chat.ola.vn.util.m.a(jVar.c)) {
                                fVar.c(jVar.c);
                            }
                            OlaApplication.b.a(fVar);
                            this.d.notifyDataSetChanged();
                        }
                    }
                    break;
                case R.id.notificationButton2 /* 2131297146 */:
                    final chat.ola.vn.entity.j jVar2 = (chat.ola.vn.entity.j) view.getTag();
                    if (jVar2 != null) {
                        chat.ola.vn.i.i.a(getActivity(), getString(R.string.string_box), getString(R.string.message_deny_married_proposal, jVar2.b), getString(R.string.string_deny), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.k.4
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                if (i == 0) {
                                    try {
                                        String strB = jVar2.a[0].b();
                                        if (chat.ola.vn.util.m.a(strB)) {
                                            strB = jVar2.a[0].c();
                                        }
                                        OlaApplication.b.D(strB);
                                        OlaApplication.b.d(new String[]{jVar2.d});
                                        k.a.remove(jVar2);
                                        k.this.d.notifyDataSetChanged();
                                    } catch (Throwable unused) {
                                    }
                                }
                                try {
                                    dialogInterface.dismiss();
                                } catch (Throwable unused2) {
                                }
                            }
                        });
                    }
                    break;
                case R.id.olaActionBarCloseButtonImageView /* 2131297183 */:
                    a().d(c());
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_notification_layout, (ViewGroup) null);
        try {
            viewInflate.findViewById(R.id.olaActionBarCloseButtonImageView).setOnClickListener(this);
            ((ImageView) viewInflate.findViewById(R.id.olaActionBarIconImageView)).setImageResource(R.drawable.ic_tab_notify);
            ((TextView) viewInflate.findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_notification);
            this.c = (ListView) viewInflate.findViewById(R.id.listView);
            this.j = viewInflate.findViewById(R.id.progressBar);
            this.k = viewInflate.findViewById(R.id.noNotificationTextView);
            this.g = (SwipeRefreshLayout) viewInflate.findViewById(R.id.notificationPullToRefreshLayout);
            this.g.setColorSchemeResources(R.color.colorOlaPrimary);
            this.g.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.m.k.1
                @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
                public void onRefresh() {
                    long unused = k.e = 0L;
                    long unused2 = k.f = -1L;
                    try {
                        k.a.clear();
                    } catch (Throwable unused3) {
                    }
                    k.this.d.notifyDataSetChanged();
                    k.this.d();
                    k.this.a(false);
                    k.this.e();
                }
            });
        } catch (Throwable unused) {
        }
        return viewInflate;
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        b = null;
        super.onDetach();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            chat.ola.vn.entity.d[] dVarArr = this.d.getItem(i).a;
            if (dVarArr == null || dVarArr.length <= 0) {
                return;
            }
            chat.ola.vn.entity.d dVar = dVarArr[0];
            String strA = dVar.a();
            if (!chat.ola.vn.util.m.b(strA, "viewme")) {
                if (!chat.ola.vn.util.m.b(strA, "viewmedia")) {
                    dVar.a(getActivity());
                    return;
                }
                chat.ola.vn.entity.i iVarE = dVar.e();
                if (iVarE != null) {
                    OlaImageViewerActivity.a(getActivity(), view, (Bitmap) null, 0, OlaMediaEntity.a(iVarE.d()));
                    return;
                }
                return;
            }
            String strC = dVar.c();
            if (chat.ola.vn.util.m.b(strC, "comment")) {
                if (OlaApplication.b != null) {
                    OlaMeCommentActivity.a(getActivity(), Long.parseLong(dVar.b()));
                }
            } else if (chat.ola.vn.util.m.b(strC, "homepage")) {
                chat.ola.vn.me.c.a(getActivity(), OlaApplication.b, dVar.b());
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public void onPause() {
        b = null;
        super.onPause();
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        this.i = i + i2 >= i3 - 1;
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
        if (i == 0 && this.i) {
            d();
            this.i = false;
        }
    }
}
