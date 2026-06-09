package chat.ola.vn.m;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.me.OlaMeLikerListActivity;
import chat.ola.vn.network.OlaNetworkService;
import com.mg.ola.common.c.c;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class t extends q implements View.OnClickListener, View.OnLongClickListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener {
    private ListView b;
    private chat.ola.vn.b.g d;
    private chat.ola.vn.b.e e;
    private chat.ola.vn.b.f f;
    private boolean g = true;
    private View h;
    private chat.ola.vn.entry.b.h i;
    private LinearLayout j;
    private Animation k;

    private class a implements View.OnClickListener {
        private a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            t tVar;
            List<String> list;
            FragmentActivity activity;
            String str;
            chat.ola.vn.entry.b bVar;
            FragmentActivity activity2;
            try {
                int i = 1;
                switch (view.getId()) {
                    case R.id.btnMeItemFooterMore /* 2131296500 */:
                        if (view.getTag() != null) {
                            t.this.a(t.this.getActivity(), (chat.ola.vn.entry.b) view.getTag());
                            break;
                        }
                        break;
                    case R.id.btnMeItemFooterReply /* 2131296501 */:
                        if (view.getTag() != null) {
                            t.this.a((chat.ola.vn.entry.b) view.getTag());
                            break;
                        }
                        break;
                    case R.id.btnMeItemLikeSpan /* 2131296503 */:
                        chat.ola.vn.entry.b bVar2 = (chat.ola.vn.entry.b) view.getTag();
                        OlaMeLikerListActivity.a(t.this.getActivity(), bVar2.b.f(), bVar2.b.e());
                        break;
                    case R.id.imgMeItemMediaSound /* 2131296914 */:
                        if (view.getTag() != null) {
                            chat.ola.vn.entry.b bVar3 = (chat.ola.vn.entry.b) view.getTag();
                            if (bVar3.k != null && !bVar3.k.isEmpty()) {
                                if (bVar3.k.size() != 1) {
                                    tVar = t.this;
                                    list = bVar3.k;
                                    tVar.a(view, list);
                                } else {
                                    chat.ola.vn.util.b.f(t.this.getActivity(), bVar3.k.get(0));
                                }
                                break;
                            }
                        }
                        break;
                    case R.id.imgMeItemMediaVideo /* 2131296915 */:
                        if (view.getTag() != null) {
                            chat.ola.vn.entry.b bVar4 = (chat.ola.vn.entry.b) view.getTag();
                            if (bVar4.j != null && !bVar4.j.isEmpty()) {
                                if (bVar4.j.size() != 1) {
                                    tVar = t.this;
                                    list = bVar4.j;
                                    tVar.a(view, list);
                                } else {
                                    activity = t.this.getActivity();
                                    str = bVar4.j.get(0);
                                    chat.ola.vn.util.b.h(activity, str);
                                }
                                break;
                            }
                        }
                        break;
                    case R.id.imgMeYoutubeThumbnail1 /* 2131296917 */:
                    case R.id.linearYoutubeSpan /* 2131297031 */:
                        chat.ola.vn.entry.b bVar5 = (chat.ola.vn.entry.b) view.getTag();
                        if (!chat.ola.vn.util.m.a(bVar5.m)) {
                            switch (bVar5.l) {
                                case 1:
                                    chat.ola.vn.util.b.a(t.this.getActivity(), bVar5.m);
                                    break;
                                case 2:
                                    activity = t.this.getActivity();
                                    str = bVar5.m;
                                    break;
                                default:
                                    chat.ola.vn.util.b.a(t.this.getActivity(), bVar5.m, view);
                                    break;
                            }
                            chat.ola.vn.util.b.h(activity, str);
                        }
                        break;
                    case R.id.meOwnerInfoSpan /* 2131297082 */:
                    case R.id.txtMeItemTitle /* 2131297616 */:
                        if (view.getTag() != null) {
                            chat.ola.vn.me.c.a(t.this.getActivity(), OlaApplication.b, ((chat.ola.vn.entry.b) view.getTag()).c());
                            break;
                        }
                        break;
                    case R.id.mediaImageView1 /* 2131297096 */:
                        OlaImageViewerActivity.a(t.this.getActivity(), view, 0, (chat.ola.vn.entry.b) view.getTag());
                        break;
                    case R.id.mediaImageView2 /* 2131297097 */:
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        activity2 = t.this.getActivity();
                        OlaImageViewerActivity.a(activity2, view, i, bVar);
                        break;
                    case R.id.mediaImageView3 /* 2131297098 */:
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        activity2 = t.this.getActivity();
                        i = 2;
                        OlaImageViewerActivity.a(activity2, view, i, bVar);
                        break;
                    case R.id.mediaImageView4 /* 2131297099 */:
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        activity2 = t.this.getActivity();
                        i = 3;
                        OlaImageViewerActivity.a(activity2, view, i, bVar);
                        break;
                    case R.id.mediaImageView5 /* 2131297100 */:
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        activity2 = t.this.getActivity();
                        i = 4;
                        OlaImageViewerActivity.a(activity2, view, i, bVar);
                        break;
                    case R.id.txtMeItemLikeWrapper /* 2131297614 */:
                        if (view.getTag() != null) {
                            t.this.a(view, (chat.ola.vn.entry.b) view.getTag());
                            break;
                        }
                        break;
                }
            } catch (Throwable unused) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(long j, final long j2) {
        if (j == 0) {
            return;
        }
        if (this.a != null) {
            if (this.a.k()) {
                return;
            } else {
                this.a.b(true);
            }
        }
        this.h.setVisibility(0);
        OlaApplication.b.a(j, j2, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.m.t.11
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 6;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                t.this.g = false;
                t.this.a.d(false);
                t.this.a.b(false);
                t.this.v();
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                List list = (List) objArr[1];
                if (list == null || list.isEmpty()) {
                    t.this.g = false;
                    t.this.a.d(false);
                } else {
                    List<chat.ola.vn.entry.b> listB = chat.ola.vn.r.a.e.b((List<chat.ola.vn.entity.g>) list);
                    if (j2 == 0) {
                        t.this.a.a(listB);
                    } else {
                        t.this.c();
                        t.this.a.b(listB);
                    }
                }
                t.this.a.b(false);
                t.this.v();
            }
        }));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final Context context, final chat.ola.vn.entry.b bVar) {
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final chat.ola.vn.entity.g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_view_me));
        arrayList.add(getString(R.string.string_chat));
        arrayList.add(getString(R.string.string_copy));
        arrayList.add(getString(R.string.string_copy_plus));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.t.5
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str;
                String str2;
                Context context2;
                String str3;
                try {
                    String str4 = (String) arrayList.get(i);
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_view_me))) {
                        chat.ola.vn.me.c.a(t.this.getActivity(), OlaApplication.b, strC);
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_chat))) {
                        OlaChatViewActivity.a(context, OlaApplication.b, strC, (short) 0);
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                        if (gVar.c() != null) {
                            str3 = " #\u001b" + gVar.c() + "#";
                        } else {
                            str3 = "";
                        }
                        try {
                            if (bVar.g() != null) {
                                Iterator<String> it2 = bVar.g().iterator();
                                while (it2.hasNext()) {
                                    str3 = str3 + " #\u001b" + it2.next() + "#";
                                }
                            }
                        } catch (Throwable unused) {
                        }
                        context2 = context;
                        str2 = gVar.b() + str3;
                    } else {
                        if (!str4.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                            return;
                        }
                        if (gVar.c() != null) {
                            str = " #\u001b" + gVar.c() + "#";
                        } else {
                            str = "";
                        }
                        str2 = gVar.b() + str;
                        if (chat.ola.vn.util.m.a(str2)) {
                            return;
                        }
                        String strA = chat.ola.vn.util.o.a(context);
                        if (!chat.ola.vn.util.m.a(strA)) {
                            str2 = strA + " " + str2;
                        }
                        context2 = context;
                    }
                    chat.ola.vn.util.o.a(context2, str2);
                } catch (Throwable unused2) {
                }
            }
        });
        mVar.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(View view, chat.ola.vn.entry.b bVar) {
        if (OlaApplication.b.b(bVar.b.e(), bVar.b.i() != 1)) {
            int iF = bVar.b.f();
            if (bVar.b.i() == 1) {
                bVar.b.c((short) 0);
                bVar.b.a(iF - 1);
            } else {
                bVar.b.c((short) 1);
                bVar.b.a(iF + 1);
                try {
                    view.findViewById(R.id.txtMeItemLikeIcon).startAnimation(this.k);
                } catch (Throwable unused) {
                }
            }
            this.d.notifyDataSetChanged();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(View view, final List<String> list) {
        com.mg.ola.common.c.a aVar;
        com.mg.ola.common.c.b bVar = new com.mg.ola.common.c.b(getActivity());
        bVar.a(true);
        Iterator<String> it2 = list.iterator();
        while (it2.hasNext()) {
            switch (chat.ola.vn.util.o.g(it2.next())) {
                case 1:
                    aVar = new com.mg.ola.common.c.a(getActivity(), R.drawable.ic_media_photo, "");
                    bVar.a(aVar);
                    break;
                case 2:
                    aVar = new com.mg.ola.common.c.a(getActivity(), R.drawable.ic_media_video, "");
                    bVar.a(aVar);
                    break;
                case 3:
                    aVar = new com.mg.ola.common.c.a(getActivity(), R.drawable.ic_media_sound, "");
                    bVar.a(aVar);
                    break;
            }
        }
        bVar.a(new c.a() { // from class: chat.ola.vn.m.t.6
            @Override // com.mg.ola.common.c.c.a
            public void a(com.mg.ola.common.c.c cVar, int i) {
                String str = (String) list.get(i);
                switch (chat.ola.vn.util.o.g(str)) {
                    case 2:
                        chat.ola.vn.util.b.h(t.this.getActivity(), str);
                        break;
                    case 3:
                        chat.ola.vn.util.b.f(t.this.getActivity(), str);
                        break;
                }
            }
        });
        bVar.a(view);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(chat.ola.vn.entry.b bVar) {
        String strG;
        if (!chat.ola.vn.h.u.a(chat.ola.vn.h.u.g()) && chat.ola.vn.h.u.c() == 0 && (strG = chat.ola.vn.h.u.g()) != null && !strG.startsWith("#")) {
            String str = "@" + strG;
        }
        String strB = chat.ola.vn.util.i.b(bVar.b.b(), "@" + chat.ola.vn.h.a());
        String strA = chat.ola.vn.util.i.a((CharSequence) bVar.b.b());
        if (!chat.ola.vn.util.m.a(strA)) {
            if (chat.ola.vn.util.m.a(strB)) {
                strB = strA;
            } else {
                strB = strB + " " + strA;
            }
        }
        OlaMeComposerActivity.a(getActivity(), "@" + bVar.b.a(), strB, bVar.b.e());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(final chat.ola.vn.entity.e eVar) {
        String strH = eVar.h();
        if (strH == null || eVar.k()) {
            return;
        }
        eVar.b(true);
        OlaApplication.b.b(strH, new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.t.14
            @Override // chat.ola.vn.p.b
            public void a(String str, String str2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.t.14.2
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            eVar.b(false);
                            t.this.h.setVisibility(8);
                        } catch (Throwable unused) {
                        }
                    }
                });
            }

            @Override // chat.ola.vn.p.b
            public void a(String str, String str2, final chat.ola.vn.entity.e eVar2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.t.14.1
                    @Override // java.lang.Runnable
                    public void run() {
                        chat.ola.vn.entity.e eVar3;
                        String strH2;
                        eVar.b(false);
                        if (eVar2.w() == null || eVar2.w().isEmpty()) {
                            eVar.c(false);
                            eVar3 = eVar;
                            strH2 = null;
                        } else {
                            eVar.i(eVar2.w());
                            eVar3 = eVar;
                            strH2 = eVar2.h();
                        }
                        eVar3.b(strH2);
                        t.this.a.I();
                        t.this.v();
                    }
                });
            }
        });
    }

    private void x() {
        chat.ola.vn.entity.e eVar;
        try {
            if (this.a.R() == 0) {
                this.j.getChildAt(0).setSelected(true);
                this.j.getChildAt(2).setSelected(false);
                if (this.e != null) {
                    this.e.a(this.a.f());
                }
                this.f.a(this.e);
                this.f.notifyDataSetChanged();
                eVar = this.a;
            } else {
                this.j.getChildAt(0).setSelected(false);
                this.j.getChildAt(2).setSelected(true);
                if (this.d != null) {
                    if (this.a.x() != null) {
                        this.d.b(this.a.x());
                    } else {
                        this.d.a(this.a.w());
                    }
                }
                this.f.a(this.d);
                this.f.notifyDataSetChanged();
                eVar = this.a;
            }
            eVar.b(this.b);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.q, chat.ola.vn.m.p
    public ArrayList<chat.ola.vn.mediastore.a> a(Context context) {
        this.c = new ArrayList<>();
        chat.ola.vn.mediastore.a aVar = new chat.ola.vn.mediastore.a();
        aVar.b = R.drawable.ic_action_search;
        aVar.a = R.id.mallAction1;
        aVar.f = new View.OnClickListener() { // from class: chat.ola.vn.m.t.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                try {
                    t.this.g().v();
                } catch (Throwable unused) {
                }
            }
        };
        aVar.e = true;
        this.c.add(aVar);
        return this.c;
    }

    @Override // chat.ola.vn.m.q
    public void a(chat.ola.vn.entity.e eVar) {
        super.a(eVar);
        v();
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        this.k = AnimationUtils.loadAnimation(getActivity(), R.anim.zoom_icon_animation);
        this.k.setDuration(100L);
        this.d = new chat.ola.vn.b.g(getActivity());
        this.d.a((View.OnClickListener) this);
        this.d.a((View.OnLongClickListener) this);
        this.d.a(new j.a() { // from class: chat.ola.vn.m.t.8
            @Override // chat.ola.vn.b.j.a
            public boolean B() {
                try {
                    if (t.this.a.k()) {
                        return false;
                    }
                    return t.this.a.h() != null;
                } catch (Throwable unused) {
                    return false;
                }
            }

            @Override // chat.ola.vn.b.j.a
            public void a_(int i) {
                try {
                    t.this.b(t.this.a);
                } catch (Throwable unused) {
                }
            }
        });
        this.e = new chat.ola.vn.b.e(getActivity()) { // from class: chat.ola.vn.m.t.9
            @Override // chat.ola.vn.b.e
            protected void a(String str, final EditText editText) {
                OlaApplication.b.a(str, t.this.a.B(), (String) null, (short) 0, (String) null, (short) 0);
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.t.9.1
                    @Override // java.lang.Runnable
                    public void run() {
                        t.this.a(t.this.a.B(), 0L);
                        chat.ola.vn.util.o.a((Context) t.this.getActivity(), (View) editText, false);
                    }
                }, 1000L);
            }
        };
        this.e.a(new a());
        this.e.a(new j.a() { // from class: chat.ola.vn.m.t.10
            @Override // chat.ola.vn.b.j.a
            public boolean B() {
                return t.this.a != null && t.this.g && !t.this.a.k() && t.this.a.o();
            }

            @Override // chat.ola.vn.b.j.a
            public void a_(int i) {
                t.this.a(t.this.a.B(), t.this.a.H());
            }
        });
        if (this.a != null) {
            a(this.a.B(), 0L);
        }
        this.f = new chat.ola.vn.b.f(this.e, this.d);
        this.b.setAdapter((ListAdapter) this.f);
        v();
    }

    @Override // chat.ola.vn.m.q
    public void c() {
        try {
            super.c();
            if (this.b == null || this.a.R() != 0) {
                return;
            }
            this.a.a(this.b);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.q, chat.ola.vn.m.f
    public void d_() {
        v();
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        if (this.a != null) {
            return this.a.z();
        }
        return null;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        OlaNetworkService olaNetworkService;
        chat.ola.vn.entity.e eVar;
        String str;
        FragmentActivity activity;
        try {
            int id = view.getId();
            try {
                if (id == R.id.imgMallConver) {
                    chat.ola.vn.util.b.a(getActivity(), view, this.a.A(), this.a.G());
                    olaNetworkService = OlaApplication.b;
                    eVar = this.a;
                } else {
                    if (id != R.id.imgVideoThumbnail) {
                        if (id != R.id.linearMallItemTabSpan) {
                            switch (id) {
                                case R.id.btnMallItemDetailComment /* 2131296486 */:
                                    chat.ola.vn.entity.e eVar2 = (chat.ola.vn.entity.e) view.getTag();
                                    g().a(eVar2.t(), eVar2.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.t.12
                                        @Override // chat.ola.vn.p.b
                                        public void a(String str2, String str3) {
                                        }

                                        @Override // chat.ola.vn.p.b
                                        public void a(String str2, String str3, chat.ola.vn.entity.e eVar3) {
                                            eVar3.j(0);
                                        }
                                    });
                                    break;
                                case R.id.btnMallItemDetailLike /* 2131296487 */:
                                    chat.ola.vn.entity.e eVar3 = (chat.ola.vn.entity.e) view.getTag();
                                    if (eVar3.a()) {
                                        eVar3.a(false);
                                        eVar3.a(Math.max(eVar3.b() - 1, 0));
                                        OlaApplication.b.b(eVar3.y(), false);
                                    } else {
                                        eVar3.a(true);
                                        eVar3.a(eVar3.b() + 1);
                                        OlaApplication.b.b(eVar3.y(), true);
                                    }
                                    this.a.I();
                                    break;
                                case R.id.btnMallItemDetailShare /* 2131296488 */:
                                    chat.ola.vn.entity.e eVar4 = (chat.ola.vn.entity.e) view.getTag();
                                    str = eVar4.z() + "\n " + ("http://mall.ola.vn/" + eVar4.y());
                                    activity = getActivity();
                                    OlaMeComposerActivity.a(activity, str, (String) null);
                                    break;
                                case R.id.btnMallItemShare /* 2131296489 */:
                                    str = this.a.z() + "\n" + ("http://mall.ola.vn/" + this.a.y()) + "\n";
                                    activity = getActivity();
                                    OlaMeComposerActivity.a(activity, str, (String) null);
                                    break;
                            }
                            return;
                        }
                        c();
                        v();
                        return;
                    }
                    eVar = (chat.ola.vn.entity.e) view.getTag();
                    if (eVar.E() == 101) {
                        g().a(eVar.t(), eVar.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.t.13
                            @Override // chat.ola.vn.p.b
                            public void a(String str2, String str3) {
                            }

                            @Override // chat.ola.vn.p.b
                            public void a(String str2, String str3, chat.ola.vn.entity.e eVar5) {
                                eVar5.j(1);
                            }
                        });
                        return;
                    } else {
                        chat.ola.vn.util.b.a(getActivity(), view, eVar.A(), eVar.G());
                        olaNetworkService = OlaApplication.b;
                    }
                }
                olaNetworkService.z(eVar.y());
            } catch (Throwable unused) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.mall_list_content_layout, viewGroup, false);
        this.h = viewInflate.findViewById(R.id.mallWattingProgress);
        this.b = (ListView) viewInflate.findViewById(R.id.lvMallCategoryList);
        this.b.setOnItemClickListener(this);
        this.b.setOnItemLongClickListener(this);
        this.b.setOnScrollListener(this);
        View viewB = chat.ola.vn.entry.b.h.b(LayoutInflater.from(getActivity()), this.b, true);
        this.i = (chat.ola.vn.entry.b.h) viewB.getTag();
        this.i.a((View.OnClickListener) this);
        this.i.a((View.OnLongClickListener) this);
        viewB.findViewById(R.id.btnMallItemShare).setOnClickListener(this);
        viewB.findViewById(R.id.btnMallItemDetailActionComment).setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.m.t.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                t.this.a.j(0);
                t.this.c();
                t.this.v();
            }
        });
        viewB.findViewById(R.id.btnMallItemTabVideo).setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.m.t.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                t.this.a.j(1);
                t.this.c();
                t.this.v();
            }
        });
        this.j = (LinearLayout) viewB.findViewById(R.id.linearMallItemTabSpan);
        this.b.addHeaderView(viewB, null, false);
        View view = new View(getActivity());
        view.setLayoutParams(new AbsListView.LayoutParams(-1, getResources().getDimensionPixelSize(R.dimen.metric_8dp)));
        this.b.addHeaderView(view, null, false);
        View view2 = new View(getActivity());
        view2.setLayoutParams(new AbsListView.LayoutParams(-1, getResources().getDimensionPixelSize(R.dimen.general_list_item_height_smallest)));
        this.b.addFooterView(view2, null, false);
        return viewInflate;
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            c();
            chat.ola.vn.entity.e eVar = (chat.ola.vn.entity.e) adapterView.getAdapter().getItem(i);
            g().a(eVar.t(), eVar.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.t.3
                @Override // chat.ola.vn.p.b
                public void a(String str, String str2) {
                }

                /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
                @Override // chat.ola.vn.p.b
                public void a(String str, String str2, chat.ola.vn.entity.e eVar2) {
                    int iE = eVar2.E();
                    eVar2.j((iE == -4 || iE == 101) ? 1 : 2);
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.widget.AdapterView.OnItemLongClickListener
    public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            chat.ola.vn.entity.e eVar = (chat.ola.vn.entity.e) adapterView.getAdapter().getItem(i);
            g().a(eVar.t(), eVar.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.t.4
                @Override // chat.ola.vn.p.b
                public void a(String str, String str2) {
                }

                /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
                @Override // chat.ola.vn.p.b
                public void a(String str, String str2, chat.ola.vn.entity.e eVar2) {
                    int iE = eVar2.E();
                    eVar2.j((iE == -4 || iE == 101) ? 1 : 2);
                }
            });
            return true;
        } catch (Throwable th) {
            th.printStackTrace();
            return false;
        }
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        try {
            if (view.getId() != R.id.imgVideoThumbnail) {
                return false;
            }
            chat.ola.vn.i.i.a(getActivity(), (chat.ola.vn.entity.e) view.getTag());
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        try {
            int top = 0;
            View childAt = this.b.getChildAt(0);
            if (childAt != null) {
                top = childAt.getTop();
            }
            this.a.b(i, top);
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
    }

    @Override // chat.ola.vn.m.q
    protected void v() {
        try {
            x();
            if (this.a != null) {
                if (this.h != null) {
                    if (this.a.k()) {
                        this.h.setVisibility(0);
                    } else {
                        this.h.setVisibility(8);
                    }
                }
                if (this.i != null) {
                    this.i.a(this.a);
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
