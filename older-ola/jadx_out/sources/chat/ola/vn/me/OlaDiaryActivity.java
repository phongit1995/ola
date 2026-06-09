package chat.ola.vn.me;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.b.u;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.i;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.r.a.e;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import com.mg.ola.common.c.c;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaDiaryActivity extends chat.ola.vn.c implements View.OnClickListener, j.a {
    private u f;
    private e l;
    private SwipeRefreshLayout n;
    private ListView e = null;
    private boolean g = true;
    private boolean h = false;
    private boolean i = false;
    private View j = null;
    private View k = null;
    private long m = 0;

    private void C() {
        this.e = (ListView) findViewById(R.id.diaryListView);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.system_me_diary);
        TextView textView = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        textView.setText(R.string.string_back);
        textView.setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        findViewById(R.id.writeStatusImageButton).setOnClickListener(this);
        this.k = findViewById(R.id.wattingProgressBar);
        this.j = getLayoutInflater().inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
        this.j.setVisibility(4);
        this.e.addFooterView(this.j);
        this.e.setSelector(new ColorDrawable(0));
        this.n = (SwipeRefreshLayout) findViewById(R.id.diaryPullToRefreshLayout);
        this.n.setColorSchemeResources(R.color.colorOlaPrimary);
        this.n.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.me.OlaDiaryActivity.1
            @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
            public void onRefresh() {
                try {
                    OlaDiaryActivity.this.g = true;
                    OlaDiaryActivity.this.d(true);
                    OlaDiaryActivity.this.c(false);
                    OlaDiaryActivity.this.D();
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void D() {
        this.i = true;
        if (x.e()) {
            n.a(this, chat.ola.vn.util.c.a.s);
        }
        this.n.setRefreshing(true);
    }

    private void E() {
        if (this.i) {
            if (x.e()) {
                n.a(this, chat.ola.vn.util.c.a.t);
            }
            this.i = false;
        }
        this.n.setRefreshing(false);
    }

    private void F() {
        if (this.i) {
            if (x.e()) {
                n.a(this, chat.ola.vn.util.c.a.t);
            }
            this.i = false;
        }
        this.n.setRefreshing(false);
    }

    private void G() {
        try {
            if (this.f == null) {
                this.l = new e();
                this.f = new u(this, this.l);
                this.f.a((j.a) this);
                this.f.a(new View.OnClickListener() { // from class: chat.ola.vn.me.OlaDiaryActivity.2
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        OlaDiaryActivity.this.a(view);
                    }
                });
                this.f.a(new View.OnLongClickListener() { // from class: chat.ola.vn.me.OlaDiaryActivity.3
                    @Override // android.view.View.OnLongClickListener
                    public boolean onLongClick(View view) {
                        return OlaDiaryActivity.this.b(view);
                    }
                });
                this.e.setAdapter((ListAdapter) this.f);
                d(false);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        context.startActivity(new Intent(context, (Class<?>) OlaDiaryActivity.class));
    }

    private void a(Context context, View view, int i, chat.ola.vn.entry.b bVar) {
        OlaImageViewerActivity.a(context, view, i, bVar);
        try {
            String str = bVar.f().get(i);
            if (i.i(str) != 1 || m.b(h.a(), bVar.b.a())) {
                return;
            }
            OlaApplication.b.n(str, f.a(new chat.ola.vn.d.b(bVar)));
        } catch (Throwable unused) {
        }
    }

    private void a(final Context context, final chat.ola.vn.entry.b bVar) {
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_copy));
        arrayList.add(getString(R.string.string_copy_plus));
        arrayList.add(getString(R.string.string_delete_me));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.me.OlaDiaryActivity.5
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str;
                Context context2;
                try {
                    String str2 = (String) arrayList.get(i);
                    if (str2.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                        String str3 = gVar.c() != null ? " #\u001b" + gVar.c() + "#" : "";
                        try {
                            if (bVar.g() != null) {
                                for (String str4 : bVar.g()) {
                                    if (!m.c(gVar.c(), str4)) {
                                        str3 = str3 + " #\u001b" + str4 + "#";
                                    }
                                }
                            }
                        } catch (Throwable unused) {
                        }
                        context2 = context;
                        str = gVar.b() + str3;
                    } else {
                        if (!str2.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                            if (str2.equalsIgnoreCase(context.getString(R.string.string_delete_me))) {
                                chat.ola.vn.i.i.d(context, OlaDiaryActivity.this.getString(R.string.string_delete_me), OlaDiaryActivity.this.getString(R.string.message_delete_me_format, new Object[]{strC}), OlaDiaryActivity.this.getString(R.string.string_delete_me), OlaDiaryActivity.this.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.OlaDiaryActivity.5.1
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i2) {
                                        if (i2 == 0) {
                                            OlaNetworkService olaNetworkService = OlaApplication.b;
                                            if (olaNetworkService != null) {
                                                if (bVar.h() == 0) {
                                                    olaNetworkService.b(gVar.e());
                                                } else if (bVar.h() == 1) {
                                                    olaNetworkService.r(gVar.m());
                                                } else if (bVar.h() == 2) {
                                                    olaNetworkService.s(gVar.m());
                                                }
                                            }
                                            OlaDiaryActivity.this.l.a(bVar);
                                            OlaDiaryActivity.this.f.notifyDataSetChanged();
                                        }
                                        dialogInterface.dismiss();
                                    }
                                });
                                return;
                            }
                            return;
                        }
                        str = gVar.b() + (gVar.c() != null ? " #\u001b" + gVar.c() + "#" : "");
                        if (m.a(str)) {
                            return;
                        }
                        String strA = o.a(context);
                        if (!m.a(strA)) {
                            str = strA + " " + str;
                        }
                        context2 = context;
                    }
                    o.a(context2, str);
                } catch (Throwable unused2) {
                }
            }
        });
        mVar.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @SuppressLint({"NewApi"})
    public void a(View view) {
        chat.ola.vn.entry.b bVar;
        OlaNetworkService olaNetworkService;
        List<String> list;
        String str;
        chat.ola.vn.entry.b bVar2;
        int i;
        try {
            switch (view.getId()) {
                case R.id.advImage /* 2131296325 */:
                    chat.ola.vn.entry.b bVar3 = (chat.ola.vn.entry.b) view.getTag();
                    chat.ola.vn.entity.d dVarS = bVar3.b.s();
                    if (dVarS == null || m.a(dVarS.a())) {
                        try {
                            OlaApplication.b.l(bVar3.b.u(), dVarS.a());
                            break;
                        } catch (Throwable unused) {
                        }
                        OlaImageViewerActivity.a(this, view, 0, bVar3);
                    } else {
                        try {
                            OlaApplication.b.l(bVar3.b.u(), dVarS.a());
                            break;
                        } catch (Throwable unused2) {
                        }
                        chat.ola.vn.entity.d.a(this, dVarS);
                    }
                    break;
                case R.id.advProductTitle /* 2131296327 */:
                    if (view.getTag() != null) {
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        if (bVar.b.s() != null) {
                            chat.ola.vn.entity.d dVarS2 = bVar.b.s();
                            try {
                                OlaApplication.b.l(bVar.b.u(), dVarS2.a());
                                break;
                            } catch (Throwable unused3) {
                            }
                            chat.ola.vn.entity.d.a(this, dVarS2);
                        } else {
                            try {
                                OlaApplication.b.l(bVar.b.u(), "viewme");
                                break;
                            } catch (Throwable unused4) {
                            }
                            olaNetworkService = OlaApplication.b;
                            c.a(this, olaNetworkService, bVar.c());
                        }
                        break;
                    }
                    break;
                case R.id.advViewCount /* 2131296342 */:
                    if (view.getTag() != null) {
                        chat.ola.vn.entry.b bVar4 = (chat.ola.vn.entry.b) view.getTag();
                        if (bVar4.b.A() > 0) {
                            chat.ola.vn.util.b.a(this);
                        } else if (bVar4.b.c) {
                            chat.ola.vn.util.b.a(this, bVar4.b.e());
                        }
                        break;
                    }
                    break;
                case R.id.attachedMeItemSpan /* 2131296377 */:
                    if (view.getTag() != null) {
                        chat.ola.vn.entity.f fVar = (chat.ola.vn.entity.f) view.getTag();
                        chat.ola.vn.entity.d.a(this, fVar.b);
                        if (m.b(fVar.b.a(), "rss")) {
                            String strB = fVar.b.b();
                            if (m.a(strB)) {
                                strB = fVar.b.c();
                            }
                            if (!m.a(strB)) {
                                OlaApplication.b.d(strB, (String) null, (short) 0);
                            }
                        }
                        break;
                    }
                    break;
                case R.id.btnMeItemFooterMore /* 2131296500 */:
                    if (view.getTag() != null) {
                        a(this, (chat.ola.vn.entry.b) view.getTag());
                        break;
                    }
                    break;
                case R.id.imgMeAvatarThumbnail /* 2131296910 */:
                    if (view.getTag() != null) {
                        String strC = ((chat.ola.vn.entry.b) view.getTag()).c();
                        if (!m.a(strC)) {
                            OlaImageViewerActivity.a(this, view, (Bitmap) null, 0, OlaMediaEntity.a(3, (short) 1, false, chat.ola.vn.c.f.c(strC).b()));
                        }
                        break;
                    }
                    break;
                case R.id.imgMeItemMediaSound /* 2131296914 */:
                    if (view.getTag() != null) {
                        chat.ola.vn.entry.b bVar5 = (chat.ola.vn.entry.b) view.getTag();
                        if (bVar5.k != null && !bVar5.k.isEmpty()) {
                            if (bVar5.k.size() != 1) {
                                list = bVar5.k;
                                a(view, list);
                            } else {
                                chat.ola.vn.util.b.f(this, bVar5.k.get(0));
                            }
                            break;
                        }
                    }
                    break;
                case R.id.imgMeItemMediaVideo /* 2131296915 */:
                    if (view.getTag() != null) {
                        chat.ola.vn.entry.b bVar6 = (chat.ola.vn.entry.b) view.getTag();
                        if (bVar6.j != null && !bVar6.j.isEmpty()) {
                            if (bVar6.j.size() != 1) {
                                list = bVar6.j;
                                a(view, list);
                            } else {
                                str = bVar6.j.get(0);
                                chat.ola.vn.util.b.h(this, str);
                            }
                            break;
                        }
                    }
                    break;
                case R.id.imgMeYoutubeThumbnail1 /* 2131296917 */:
                case R.id.linearYoutubeSpan /* 2131297031 */:
                    chat.ola.vn.entry.b bVar7 = (chat.ola.vn.entry.b) view.getTag();
                    if (!m.a(bVar7.m)) {
                        switch (bVar7.l) {
                            case 1:
                                chat.ola.vn.util.b.a(this, bVar7.m);
                                break;
                            case 2:
                                str = bVar7.m;
                                break;
                            default:
                                chat.ola.vn.util.b.a(this, bVar7.m, view);
                                break;
                        }
                        chat.ola.vn.util.b.h(this, str);
                    }
                    break;
                case R.id.meOwnerInfoSpan /* 2131297082 */:
                case R.id.txtMeItemTitle /* 2131297616 */:
                    if (view.getTag() != null) {
                        bVar = (chat.ola.vn.entry.b) view.getTag();
                        if (!m.b(bVar.c(), h.a())) {
                            OlaUserMePageActivity.a(this, bVar.c());
                        } else {
                            olaNetworkService = OlaApplication.b;
                            c.a(this, olaNetworkService, bVar.c());
                        }
                        break;
                    }
                    break;
                case R.id.mediaImageView1 /* 2131297096 */:
                    a(this, view, 0, (chat.ola.vn.entry.b) view.getTag());
                    break;
                case R.id.mediaImageView2 /* 2131297097 */:
                    a(this, view, 1, (chat.ola.vn.entry.b) view.getTag());
                    break;
                case R.id.mediaImageView3 /* 2131297098 */:
                    bVar2 = (chat.ola.vn.entry.b) view.getTag();
                    i = 2;
                    a(this, view, i, bVar2);
                    break;
                case R.id.mediaImageView4 /* 2131297099 */:
                    a(this, view, 3, (chat.ola.vn.entry.b) view.getTag());
                    break;
                case R.id.mediaImageView5 /* 2131297100 */:
                    bVar2 = (chat.ola.vn.entry.b) view.getTag();
                    i = 4;
                    a(this, view, i, bVar2);
                    break;
                case R.id.txtAdMeTitleContainer /* 2131297515 */:
                    chat.ola.vn.util.b.a(this);
                    break;
            }
        } catch (Throwable unused5) {
        }
    }

    private void a(View view, final List<String> list) {
        com.mg.ola.common.c.a aVar;
        com.mg.ola.common.c.b bVar = new com.mg.ola.common.c.b(this);
        bVar.a(true);
        Iterator<String> it2 = list.iterator();
        while (it2.hasNext()) {
            switch (o.g(it2.next())) {
                case 1:
                    aVar = new com.mg.ola.common.c.a(this, R.drawable.ic_media_photo, "");
                    bVar.a(aVar);
                    break;
                case 2:
                    aVar = new com.mg.ola.common.c.a(this, R.drawable.ic_media_video, "");
                    bVar.a(aVar);
                    break;
                case 3:
                    aVar = new com.mg.ola.common.c.a(this, R.drawable.ic_media_sound, "");
                    bVar.a(aVar);
                    break;
            }
        }
        bVar.a(new c.a() { // from class: chat.ola.vn.me.OlaDiaryActivity.4
            @Override // com.mg.ola.common.c.c.a
            public void a(com.mg.ola.common.c.c cVar, int i) {
                String str = (String) list.get(i);
                switch (o.g(str)) {
                    case 2:
                        chat.ola.vn.util.b.h(OlaDiaryActivity.this, str);
                        break;
                    case 3:
                        chat.ola.vn.util.b.f(OlaDiaryActivity.this, str);
                        break;
                }
            }
        });
        bVar.a(view);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean b(View view) {
        return false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void c(boolean z) {
        View view;
        int i;
        if (z) {
            view = this.k;
            i = 0;
        } else {
            view = this.k;
            i = 8;
        }
        view.setVisibility(i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d(boolean z) {
        if (this.h) {
            return;
        }
        long jL = this.l.l();
        if (z) {
            jL = 0;
        }
        if (jL != 0) {
            this.j.setVisibility(0);
            c(false);
        } else {
            this.j.setVisibility(4);
            c(true);
        }
        this.l.a(true);
        this.h = true;
        OlaApplication.b.b(jL, (short) 78);
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return !this.g;
    }

    @Override // chat.ola.vn.c
    protected void a() {
        G();
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        super.a(i, str, bArr, dVarArr, s);
        if (s == 78) {
            try {
                this.h = false;
                this.g = false;
                c(false);
                F();
                this.j.setVisibility(8);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, String str2, g[] gVarArr, short s) {
        try {
            this.h = false;
            this.g = true;
            if (gVarArr == null || gVarArr.length <= 0) {
                this.g = false;
                try {
                    chat.ola.vn.i.i.b(this, R.string.dialog_title_inform, R.string.message_diary_empty, R.string.string_write_diary, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.OlaDiaryActivity.6
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                OlaMeComposerActivity.b(OlaDiaryActivity.this);
                            }
                            dialogInterface.dismiss();
                        }
                    });
                } catch (Throwable unused) {
                }
            } else if (this.m == 0) {
                this.l.a("my diary", (short) 0, Arrays.asList(gVarArr));
            } else {
                this.l.c(Arrays.asList(gVarArr));
            }
            E();
            c(false);
            this.j.setVisibility(8);
            this.f.notifyDataSetChanged();
        } catch (Throwable unused2) {
            try {
                chat.ola.vn.i.i.a(this, R.string.dialog_title_fail, R.string.message_fail_load_diary_with_problem);
            } catch (Throwable unused3) {
            }
        }
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        try {
            d(false);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.olaActionBarBackViewLayout) {
                finish();
            } else if (id == R.id.olaActionBarTitleViewLayout) {
                this.e.smoothScrollToPosition(0);
            } else {
                if (id != R.id.writeStatusImageButton) {
                    return;
                }
                OlaMeComposerActivity.b(this);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_diary_layout);
        C();
    }
}
