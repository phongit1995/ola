package chat.ola.vn.m;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListAdapter;
import android.widget.SeekBar;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaAppSettingActivity;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.activity.OlaVipStoreActivity;
import chat.ola.vn.b.ah;
import chat.ola.vn.b.j;
import chat.ola.vn.entity.ad;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.me.OlaMeLikerListActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.view.OlaListView;
import com.mg.ola.common.c.c;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class y extends c implements SwipeRefreshLayout.OnRefreshListener, View.OnLongClickListener, AdapterView.OnItemLongClickListener, j.a {
    protected EditText d;
    private OlaListView e;
    private ah f;
    private Animation g;
    private float h;
    private SwipeRefreshLayout i;
    private boolean j = false;

    private class a implements View.OnClickListener {
        private a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            FragmentActivity activity;
            String string;
            FragmentActivity activity2;
            int iF;
            long jE;
            y yVar;
            List<String> list;
            FragmentActivity activity3;
            String str;
            chat.ola.vn.entry.b bVar;
            FragmentActivity activity4;
            FragmentActivity activity5;
            String strO;
            try {
                int i = 1;
                switch (view.getId()) {
                    case R.id.advSoftwareFrameLayout /* 2131296328 */:
                    case R.id.advSoftwareRatingBar /* 2131296333 */:
                        chat.ola.vn.entity.k kVar = (chat.ola.vn.entity.k) view.getTag();
                        if (!chat.ola.vn.util.m.a(kVar.h)) {
                            chat.ola.vn.util.b.n(y.this.getActivity(), kVar.h);
                            OlaApplication.b.l(kVar.g, "wap");
                        }
                        break;
                    case R.id.advSoftwareVideoLayout /* 2131296338 */:
                        chat.ola.vn.entity.k kVar2 = (chat.ola.vn.entity.k) view.getTag();
                        if (!chat.ola.vn.util.m.a(kVar2.b)) {
                            activity = y.this.getActivity();
                            string = kVar2.b;
                            chat.ola.vn.util.b.a(activity, string, view);
                        } else if (!chat.ola.vn.util.m.a(kVar2.h)) {
                            chat.ola.vn.util.b.n(y.this.getActivity(), kVar2.h);
                            OlaApplication.b.l(kVar2.g, "wap");
                        }
                        break;
                    case R.id.btnMakeFriend /* 2131296479 */:
                        chat.ola.vn.h.t.b(((chat.ola.vn.entry.b) view.getTag()).c());
                        break;
                    case R.id.btnMeItemFooterMore /* 2131296500 */:
                        if (view.getTag() != null) {
                            y.this.a(y.this.getActivity(), (chat.ola.vn.entry.b) view.getTag());
                            break;
                        }
                        break;
                    case R.id.btnMeItemFooterReply /* 2131296501 */:
                        if (view.getTag() != null) {
                            y.this.a((chat.ola.vn.entry.b) view.getTag());
                            break;
                        }
                        break;
                    case R.id.btnMeItemLikeSpan /* 2131296503 */:
                        chat.ola.vn.entry.b bVar2 = (chat.ola.vn.entry.b) view.getTag();
                        activity2 = y.this.getActivity();
                        iF = bVar2.b.f();
                        jE = bVar2.b.e();
                        OlaMeLikerListActivity.a(activity2, iF, jE);
                        break;
                    case R.id.btnNewsItemLikeSpan /* 2131296511 */:
                        chat.ola.vn.entity.t tVar = (chat.ola.vn.entity.t) view.getTag();
                        activity2 = y.this.getActivity();
                        iF = tVar.s();
                        jE = tVar.r();
                        OlaMeLikerListActivity.a(activity2, iF, jE);
                        break;
                    case R.id.btnNewsViewComment /* 2131296512 */:
                        OlaMeComposerActivity.b(y.this.getActivity(), y.this.b.r());
                        break;
                    case R.id.imgMeItemMediaSound /* 2131296914 */:
                        if (view.getTag() != null) {
                            chat.ola.vn.entry.b bVar3 = (chat.ola.vn.entry.b) view.getTag();
                            if (bVar3.k != null && !bVar3.k.isEmpty()) {
                                if (bVar3.k.size() != 1) {
                                    yVar = y.this;
                                    list = bVar3.k;
                                    yVar.a(view, list);
                                } else {
                                    chat.ola.vn.util.b.f(y.this.getActivity(), bVar3.k.get(0));
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
                                    yVar = y.this;
                                    list = bVar4.j;
                                    yVar.a(view, list);
                                } else {
                                    activity3 = y.this.getActivity();
                                    str = bVar4.j.get(0);
                                    chat.ola.vn.util.b.h(activity3, str);
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
                                    chat.ola.vn.util.b.a(y.this.getActivity(), bVar5.m);
                                    break;
                                case 2:
                                    activity3 = y.this.getActivity();
                                    str = bVar5.m;
                                    break;
                                default:
                                    chat.ola.vn.util.b.a(y.this.getActivity(), bVar5.m, 0, view.getTop());
                                    break;
                            }
                            chat.ola.vn.util.b.h(activity3, str);
                        }
                        break;
                    case R.id.imgNewsThumbnail /* 2131296926 */:
                        String string2 = ((chat.ola.vn.entry.c) view.getTag()).d().toString();
                        ArrayList<String> arrayListJ = y.this.j();
                        OlaImageViewerActivity.a(y.this.getActivity(), view, (Bitmap) null, arrayListJ.indexOf(string2), OlaMediaEntity.a(arrayListJ));
                        break;
                    case R.id.imgNewsYoutubeThumbnail /* 2131296927 */:
                        chat.ola.vn.entry.c cVar = (chat.ola.vn.entry.c) view.getTag();
                        activity = y.this.getActivity();
                        string = cVar.d().toString();
                        chat.ola.vn.util.b.a(activity, string, view);
                        break;
                    case R.id.meOwnerInfoSpan /* 2131297082 */:
                    case R.id.txtMeItemTitle /* 2131297616 */:
                        if (view.getTag() != null) {
                            chat.ola.vn.me.c.a(y.this.getActivity(), OlaApplication.b, ((chat.ola.vn.entry.b) view.getTag()).c());
                            break;
                        }
                        break;
                    case R.id.mediaImageView1 /* 2131297096 */:
                        OlaImageViewerActivity.a(y.this.getActivity(), view, 0, (chat.ola.vn.entry.b) view.getTag());
                        break;
                    case R.id.mediaImageView2 /* 2131297097 */:
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        activity4 = y.this.getActivity();
                        OlaImageViewerActivity.a(activity4, view, i, bVar);
                        break;
                    case R.id.mediaImageView3 /* 2131297098 */:
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        activity4 = y.this.getActivity();
                        i = 2;
                        OlaImageViewerActivity.a(activity4, view, i, bVar);
                        break;
                    case R.id.mediaImageView4 /* 2131297099 */:
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        activity4 = y.this.getActivity();
                        i = 3;
                        OlaImageViewerActivity.a(activity4, view, i, bVar);
                        break;
                    case R.id.mediaImageView5 /* 2131297100 */:
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        activity4 = y.this.getActivity();
                        i = 4;
                        OlaImageViewerActivity.a(activity4, view, i, bVar);
                        break;
                    case R.id.relatedArticle1 /* 2131297299 */:
                    case R.id.relatedArticle2 /* 2131297300 */:
                    case R.id.relatedArticle3 /* 2131297301 */:
                        ad adVar = (ad) view.getTag();
                        activity5 = y.this.getActivity();
                        strO = adVar.o();
                        j.a(activity5, strO);
                        break;
                    case R.id.shareWrapper /* 2131297388 */:
                        String strO2 = ((chat.ola.vn.entity.t) view.getTag()).o();
                        if (!chat.ola.vn.util.m.a(strO2)) {
                            OlaApplication.b.a(OlaApplication.a(R.string.string_shared_this) + "\nrss://" + strO2, (String) null, (short) 0, (String) null, (short) 0);
                            chat.ola.vn.i.i.a(y.this.getActivity(), R.string.dialog_title_inform, R.string.message_shared_on_your_timeline);
                        }
                        break;
                    case R.id.txtMeItemLikeWrapper /* 2131297614 */:
                        if (view.getTag() != null) {
                            y.this.a(view, (chat.ola.vn.entry.b) view.getTag());
                            break;
                        }
                        break;
                    case R.id.txtNewsItemLikeWrapper /* 2131297643 */:
                        chat.ola.vn.entity.t tVar2 = (chat.ola.vn.entity.t) view.getTag();
                        if (tVar2.v() == 1) {
                            if (OlaApplication.b.b(tVar2.r(), false)) {
                                tVar2.b((short) 0);
                                tVar2.b(Math.max(tVar2.s() - 1, 0));
                            }
                        } else if (OlaApplication.b.b(tVar2.r(), true)) {
                            tVar2.b((short) 1);
                            tVar2.b(tVar2.s() + 1);
                        }
                        view.startAnimation(y.this.g);
                        y.this.f.notifyDataSetChanged();
                        break;
                    case R.id.txtRssCommentInput /* 2131297672 */:
                        y.this.z();
                        break;
                    case R.id.viewAllTextView /* 2131297767 */:
                        strO = (String) view.getTag();
                        activity5 = y.this.getActivity();
                        j.a(activity5, strO);
                        break;
                }
            } catch (Throwable unused) {
            }
        }
    }

    private void A() {
        try {
            if (this.b.a() >= 0) {
                return;
            }
            final chat.ola.vn.entity.t tVar = this.b;
            chat.ola.vn.entry.c.e eVar = new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.m.y.2
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 6;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    if (34 == i) {
                        tVar.b(false);
                    }
                    tVar.b(-1L);
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    try {
                        chat.ola.vn.entity.g gVar = (chat.ola.vn.entity.g) objArr[0];
                        List<chat.ola.vn.entity.g> list = (List) objArr[1];
                        if (tVar.a() > 0) {
                            tVar.b(gVar, list);
                        } else {
                            tVar.a(gVar, list);
                        }
                        tVar.b(!list.isEmpty());
                        tVar.b(-1L);
                        y.this.f.notifyDataSetChanged();
                    } catch (Throwable unused) {
                    }
                }
            };
            tVar.b(0L);
            try {
                tVar.c();
                this.f.notifyDataSetChanged();
            } catch (Throwable unused) {
            }
            OlaApplication.b.a(this.b.r(), 0L, chat.ola.vn.entry.c.f.a(eVar));
        } catch (Throwable unused2) {
        }
    }

    private void C() {
        if (this.j) {
            return;
        }
        if (chat.ola.vn.c.x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.s);
        }
        this.j = !this.j;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void D() {
        if (this.j) {
            if (chat.ola.vn.c.x.e()) {
                chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.t);
            }
            this.j = !this.j;
        }
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
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.y.14
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str;
                String str2;
                Context context2;
                String str3;
                try {
                    String str4 = (String) arrayList.get(i);
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_view_me))) {
                        chat.ola.vn.me.c.a(y.this.getActivity(), OlaApplication.b, strC);
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
                    view.findViewById(R.id.txtMeItemLikeIcon).startAnimation(this.g);
                } catch (Throwable unused) {
                }
            }
            this.f.notifyDataSetChanged();
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
        bVar.a(new c.a() { // from class: chat.ola.vn.m.y.13
            @Override // com.mg.ola.common.c.c.a
            public void a(com.mg.ola.common.c.c cVar, int i) {
                String str = (String) list.get(i);
                switch (chat.ola.vn.util.o.g(str)) {
                    case 2:
                        chat.ola.vn.util.b.h(y.this.getActivity(), str);
                        break;
                    case 3:
                        chat.ola.vn.util.b.f(y.this.getActivity(), str);
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
    public void a(chat.ola.vn.message.f fVar, final String str) {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_copy_nick));
        arrayList.add(getString(R.string.string_copy_plus));
        arrayList.add(getString(R.string.string_block_me));
        arrayList.add(getString(R.string.string_bad_nick_report));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        if (fVar != null) {
            mVar.setTitle(fVar.L());
        } else {
            mVar.a(str);
        }
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.y.4
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str2;
                try {
                    String str3 = (String) arrayList.get(i);
                    if (str3.equals(y.this.getString(R.string.string_copy_nick))) {
                        chat.ola.vn.util.o.a(y.this.getActivity(), "@" + str);
                        return;
                    }
                    if (!str3.equals(y.this.getString(R.string.string_copy_plus))) {
                        if (str3.equals(y.this.getString(R.string.string_block_me))) {
                            if (OlaApplication.b != null) {
                                OlaApplication.b.m(str);
                                return;
                            }
                            return;
                        } else {
                            if (str3.equals(y.this.getString(R.string.string_bad_nick_report))) {
                                chat.ola.vn.i.i.a(y.this.getActivity(), str);
                                return;
                            }
                            return;
                        }
                    }
                    String strA = chat.ola.vn.util.o.a(y.this.getActivity());
                    if (chat.ola.vn.util.m.a(strA)) {
                        str2 = "@" + str;
                    } else {
                        str2 = strA + " @" + str;
                    }
                    chat.ola.vn.util.o.a(y.this.getActivity(), str2);
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void e(final String str) {
        try {
            final ArrayList arrayList = new ArrayList();
            final chat.ola.vn.message.f fVarE = chat.ola.vn.h.t.e(str, (short) 0);
            if (fVarE == null) {
                arrayList.add(getString(R.string.string_make_friend));
            }
            arrayList.add(getString(R.string.string_chat));
            arrayList.add(getString(R.string.string_view_vip_store));
            arrayList.add(getString(R.string.string_more_action));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
            if (fVarE != null) {
                mVar.setTitle(fVarE.L());
            } else {
                mVar.a(str);
            }
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.y.3
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        String str2 = (String) arrayList.get(i);
                        if (str2.equals(y.this.getString(R.string.string_make_friend))) {
                            return;
                        }
                        if (str2.equals(y.this.getString(R.string.string_chat))) {
                            OlaChatViewActivity.a((Context) y.this.getActivity(), OlaApplication.b, str, (short) 0);
                        } else if (chat.ola.vn.util.m.b(str2, y.this.getString(R.string.string_view_vip_store))) {
                            OlaVipStoreActivity.a(y.this.getActivity(), str);
                        } else if (str2.equals(y.this.getString(R.string.string_more_action))) {
                            y.this.a(fVarE, str);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public float y() {
        chat.ola.vn.c.x.i = chat.ola.vn.e.a().d();
        this.h = 12.0f;
        return this.h + (((chat.ola.vn.c.x.i * 10) * this.h) / 100.0f);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void z() {
        OlaMeComposerActivity.b(getActivity(), this.b.r());
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return this.b.k() && this.b != null && this.b.a() < 0;
    }

    @Override // chat.ola.vn.m.p
    public ArrayList<chat.ola.vn.mediastore.a> a(Context context) {
        this.c = new ArrayList<>();
        chat.ola.vn.mediastore.a aVar = new chat.ola.vn.mediastore.a();
        aVar.b = R.drawable.ic_action_home;
        aVar.a = R.id.olaActionBarButtonImageView;
        aVar.f = new View.OnClickListener() { // from class: chat.ola.vn.m.y.8
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                y.this.g().a(new chat.ola.vn.entity.t((String) null));
            }
        };
        aVar.e = true;
        aVar.c = context.getString(R.string.string_homepage);
        this.c.add(aVar);
        chat.ola.vn.mediastore.a aVar2 = new chat.ola.vn.mediastore.a();
        aVar2.b = R.drawable.ic_action_share;
        aVar2.a = R.id.olaActionBarButtonImageView;
        aVar2.f = new View.OnClickListener() { // from class: chat.ola.vn.m.y.9
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                y.this.g().c(y.this.b);
            }
        };
        aVar2.e = true;
        aVar2.c = context.getString(R.string.string_share);
        this.c.add(aVar2);
        return this.c;
    }

    @Override // chat.ola.vn.m.c
    public void a(chat.ola.vn.entity.t tVar) {
        try {
            h();
            c();
        } catch (Throwable unused) {
        }
        super.a(tVar);
        if (this.f != null) {
            this.f.a(tVar);
            this.f.notifyDataSetChanged();
        }
    }

    public boolean a(final chat.ola.vn.entry.b.k kVar) {
        try {
            if (chat.ola.vn.util.m.a(kVar.a.toString())) {
                return false;
            }
            kVar.a.setTextColor(chat.ola.vn.f.A);
            this.f.notifyDataSetChanged();
            final ArrayList arrayList = new ArrayList();
            arrayList.add(getString(R.string.string_copy));
            arrayList.add(getString(R.string.string_copy_plus));
            arrayList.add(getString(R.string.general_tab_translater));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.y.5
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    y yVar;
                    try {
                        String string = kVar.a.getText().toString();
                        String str = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str, y.this.getString(R.string.string_copy))) {
                            if (chat.ola.vn.util.m.a(string)) {
                                return;
                            } else {
                                yVar = y.this;
                            }
                        } else {
                            if (!chat.ola.vn.util.m.b(str, y.this.getString(R.string.string_copy_plus))) {
                                if (!chat.ola.vn.util.m.b(str, y.this.getString(R.string.general_tab_translater)) || chat.ola.vn.util.m.a(string)) {
                                    return;
                                }
                                z.a(y.this.getActivity(), string);
                                return;
                            }
                            if (chat.ola.vn.util.m.a(string)) {
                                return;
                            }
                            String strA = chat.ola.vn.util.o.a(y.this.getActivity());
                            if (!chat.ola.vn.util.m.a(strA)) {
                                string = strA + "\n" + string;
                            }
                            yVar = y.this;
                        }
                        chat.ola.vn.util.o.a(yVar.getActivity(), string);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.m.y.6
                @Override // android.content.DialogInterface.OnDismissListener
                public void onDismiss(DialogInterface dialogInterface) {
                    try {
                        kVar.a.setTextColor(chat.ola.vn.f.h);
                        y.this.f.notifyDataSetChanged();
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (this.b.a() >= 0) {
            return;
        }
        try {
            long jX = x();
            final chat.ola.vn.entity.t tVar = this.b;
            chat.ola.vn.entry.c.e eVar = new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.m.y.15
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 6;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    if (34 == i2) {
                        tVar.b(false);
                    }
                    tVar.b(-1L);
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    try {
                        chat.ola.vn.entity.g gVar = (chat.ola.vn.entity.g) objArr[0];
                        List<chat.ola.vn.entity.g> list = (List) objArr[1];
                        boolean zB = tVar.a() > 0 ? tVar.b(gVar, list) : tVar.a(gVar, list);
                        if (zB) {
                            tVar.b(!list.isEmpty());
                        } else {
                            tVar.b(zB);
                        }
                        tVar.b(-1L);
                        y.this.f.notifyDataSetChanged();
                    } catch (Throwable unused) {
                    }
                }
            };
            tVar.b(jX);
            OlaApplication.b.a(this.b.r(), jX, chat.ola.vn.entry.c.f.a(eVar));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        this.g = AnimationUtils.loadAnimation(getActivity(), R.anim.zoom_icon_animation);
        this.g.setDuration(100L);
        this.f = new ah(getActivity());
        this.f.a(y());
        this.f.a(new a());
        this.f.a((View.OnLongClickListener) this);
        this.f.a(this.b);
        this.f.a((j.a) this);
        this.e.setAdapter((ListAdapter) this.f);
        d();
    }

    @Override // chat.ola.vn.m.c
    public void c() {
        try {
            this.b.a(this.e);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.c
    public void d() {
        try {
            this.f.notifyDataSetChanged();
            this.b.b(this.e);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.c, chat.ola.vn.m.f
    public void d_() {
        this.f.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_copy));
        arrayList.add(getString(R.string.string_add_bookmark));
        arrayList.add(getString(R.string.string_font_size));
        arrayList.add(getString(R.string.string_setup));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.y.10
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (chat.ola.vn.util.m.b(y.this.getString(R.string.string_font_size), str)) {
                        y.this.v();
                        return;
                    }
                    if (chat.ola.vn.util.m.b(y.this.getString(R.string.string_add_bookmark), str)) {
                        y.this.g().b(y.this.b);
                        return;
                    }
                    if (!chat.ola.vn.util.m.b(y.this.getString(R.string.string_copy), str)) {
                        if (chat.ola.vn.util.m.b(y.this.getString(R.string.string_setup), str)) {
                            OlaAppSettingActivity.b(y.this.getActivity());
                            return;
                        }
                        return;
                    }
                    String strO = y.this.b.o();
                    if (chat.ola.vn.util.m.a(strO) || chat.ola.vn.util.m.a(strO, "null")) {
                        return;
                    }
                    chat.ola.vn.util.o.a(y.this.getActivity(), "rss://" + strO);
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return mVar;
    }

    @Override // chat.ola.vn.m.f
    public boolean i() {
        return true;
    }

    public ArrayList<String> j() {
        try {
            return this.b.g();
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.news_page_content_layout, viewGroup, false);
        this.e = (OlaListView) viewInflate.findViewById(R.id.lvCategoryList);
        this.d = (EditText) viewInflate.findViewById(R.id.searchNewsEditText);
        this.i = (SwipeRefreshLayout) viewInflate.findViewById(R.id.swipeRefreshLayout);
        this.i.setOnRefreshListener(this);
        this.i.setColorSchemeResources(R.color.colorOlaPrimary);
        this.e.setOnScrollListener(new AbsListView.OnScrollListener() { // from class: chat.ola.vn.m.y.1
            @Override // android.widget.AbsListView.OnScrollListener
            public void onScroll(AbsListView absListView, int i, int i2, int i3) {
            }

            @Override // android.widget.AbsListView.OnScrollListener
            public void onScrollStateChanged(AbsListView absListView, int i) {
                switch (i) {
                    case 0:
                        if (y.this.b != null) {
                            y.this.b.a(y.this.e);
                        }
                        break;
                }
            }
        });
        this.e.addHeaderView(a(layoutInflater));
        return viewInflate;
    }

    @Override // android.widget.AdapterView.OnItemLongClickListener
    public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            Object tag = view.getTag();
            if (tag == null || !(tag instanceof chat.ola.vn.entry.b.k)) {
                return false;
            }
            return a((chat.ola.vn.entry.b.k) tag);
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.meOwnerInfoSpan) {
                e(((chat.ola.vn.entry.b) view.getTag()).c());
                return true;
            }
            if (id != R.id.txtMeItemLikeWrapper) {
                return false;
            }
            chat.ola.vn.entry.b bVar = (chat.ola.vn.entry.b) view.getTag();
            if (bVar.b.i() != 1) {
                a(view, bVar);
                OlaMeComposerActivity.a(getActivity(), bVar.b.a(), getString(R.string.message_strong_like), bVar.b.e());
            }
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
    public void onRefresh() {
        try {
            this.i.setRefreshing(true);
            C();
            g().a(this.b, new Runnable() { // from class: chat.ola.vn.m.y.7
                @Override // java.lang.Runnable
                public void run() {
                    y.this.d();
                    y.this.D();
                    y.this.i.setRefreshing(false);
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        A();
    }

    public void v() {
        chat.ola.vn.i.n nVar = new chat.ola.vn.i.n(getActivity());
        nVar.requestWindowFeature(1);
        nVar.setContentView(R.layout.font_slide_layout);
        nVar.setCanceledOnTouchOutside(true);
        nVar.getWindow().getAttributes().width = -1;
        ((TextView) nVar.findViewById(R.id.txtMinSize)).setTextSize(12.0f);
        ((TextView) nVar.findViewById(R.id.txtMaxSize)).setTextSize(24.0f);
        SeekBar seekBar = (SeekBar) nVar.findViewById(R.id.skbFontSize);
        seekBar.setMax(10);
        seekBar.setProgress(chat.ola.vn.c.x.i);
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() { // from class: chat.ola.vn.m.y.11
            private Runnable b;

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onProgressChanged(SeekBar seekBar2, final int i, boolean z) {
                if (z) {
                    if (this.b != null) {
                        seekBar2.removeCallbacks(this.b);
                        this.b = null;
                    }
                    this.b = new Runnable() { // from class: chat.ola.vn.m.y.11.1
                        @Override // java.lang.Runnable
                        public void run() {
                            chat.ola.vn.c.x.i = i;
                            chat.ola.vn.e.a().b(chat.ola.vn.c.x.i);
                            y.this.f.a(y.this.y());
                            AnonymousClass11.this.b = null;
                        }
                    };
                    seekBar2.postDelayed(this.b, 500L);
                }
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStartTrackingTouch(SeekBar seekBar2) {
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStopTrackingTouch(SeekBar seekBar2) {
                chat.ola.vn.c.x.h();
            }
        });
        nVar.setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.m.y.12
            @Override // android.content.DialogInterface.OnDismissListener
            public void onDismiss(DialogInterface dialogInterface) {
                chat.ola.vn.c.x.h();
            }
        });
        nVar.show();
    }

    public long x() {
        try {
            if (this.b.d() == null || this.b.d().isEmpty()) {
                return 0L;
            }
            return this.b.d().get(this.b.d().size() - 1).b.e();
        } catch (Throwable unused) {
        }
        return 0L;
    }
}
