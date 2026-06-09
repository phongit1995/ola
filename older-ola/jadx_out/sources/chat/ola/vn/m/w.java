package chat.ola.vn.m;

import android.content.Context;
import android.os.Bundle;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import java.net.URLEncoder;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class w extends q implements View.OnClickListener, View.OnLongClickListener, AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener, j.a {
    private ListView b;
    private chat.ola.vn.b.g d;
    private View e;
    private View f;
    private TextView g;
    private EditText h;
    private TextView i;
    private View j;
    private Runnable k = new Runnable() { // from class: chat.ola.vn.m.w.6
        @Override // java.lang.Runnable
        public void run() {
            w.this.j.setVisibility(8);
        }
    };

    private void b(final chat.ola.vn.entity.e eVar) {
        String strH = eVar.h();
        if (strH == null || eVar.k()) {
            return;
        }
        eVar.b(true);
        OlaApplication.b.b(strH, new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.w.10
            @Override // chat.ola.vn.p.b
            public void a(String str, String str2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.w.10.2
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            eVar.b(false);
                            w.this.e.setVisibility(8);
                        } catch (Throwable unused) {
                        }
                    }
                });
            }

            @Override // chat.ola.vn.p.b
            public void a(String str, String str2, final chat.ola.vn.entity.e eVar2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.w.10.1
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
                            eVar.j(eVar2.w());
                            eVar3 = eVar;
                            strH2 = eVar2.h();
                        }
                        eVar3.b(strH2);
                        w.this.a.I();
                        w.this.v();
                    }
                });
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e(String str) {
        try {
            f("mall/search?q=" + URLEncoder.encode(str, "UTF-8"));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void f(String str) {
        chat.ola.vn.util.o.a((Context) getActivity(), (View) this.h, false);
        this.h.clearFocus();
        try {
            this.e.setVisibility(0);
            this.a.b(true);
            OlaApplication.b.b(str, new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.w.2
                @Override // chat.ola.vn.p.b
                public void a(String str2, String str3) {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.w.2.2
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                if (w.this.a != null) {
                                    w.this.a.b(false);
                                }
                                w.this.e.setVisibility(8);
                            } catch (Throwable unused) {
                            }
                        }
                    });
                }

                @Override // chat.ola.vn.p.b
                public void a(String str2, String str3, final chat.ola.vn.entity.e eVar) {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.w.2.1
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                w.this.a = eVar;
                                w.this.a.b(0, 0);
                                w.this.v();
                            } catch (Throwable unused) {
                            }
                        }
                    });
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        try {
            if (this.a.k() || this.a.h() == null) {
                return false;
            }
            return this.a.n();
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.m.q, chat.ola.vn.m.p
    public ArrayList<chat.ola.vn.mediastore.a> a(Context context) {
        this.c = new ArrayList<>();
        chat.ola.vn.mediastore.a aVar = new chat.ola.vn.mediastore.a();
        aVar.b = R.drawable.ic_action_quit;
        aVar.a = R.id.mallAction1;
        aVar.f = new View.OnClickListener() { // from class: chat.ola.vn.m.w.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                try {
                    chat.ola.vn.util.o.a((Context) w.this.getActivity(), (View) w.this.h, false);
                    w.this.g().g_();
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

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        try {
            b(this.a);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        this.d = new chat.ola.vn.b.g(getActivity());
        this.d.a((View.OnClickListener) this);
        this.d.a((View.OnLongClickListener) this);
        this.d.a((j.a) this);
        this.b.setAdapter((ListAdapter) this.d);
        View view = new View(getActivity());
        view.setLayoutParams(new AbsListView.LayoutParams(-1, getResources().getDimensionPixelSize(R.dimen.general_list_item_height_smallest)));
        this.b.addFooterView(view, null, false);
        v();
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        if (this.a != null) {
            return this.a.z();
        }
        return null;
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        chat.ola.vn.util.o.a((Context) getActivity(), (View) this.h, false);
        return super.g_();
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:23:0x00c2 A[Catch: Throwable -> 0x0111, TryCatch #0 {Throwable -> 0x0111, blocks: (B:2:0x0000, B:3:0x0004, B:5:0x0008, B:7:0x0025, B:8:0x0028, B:10:0x002c, B:12:0x003a, B:14:0x004a, B:16:0x0063, B:18:0x006b, B:19:0x0079, B:21:0x00b5, B:23:0x00c2, B:25:0x00f0, B:24:0x00dc, B:26:0x00f7), top: B:29:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:24:0x00dc A[Catch: Throwable -> 0x0111, TryCatch #0 {Throwable -> 0x0111, blocks: (B:2:0x0000, B:3:0x0004, B:5:0x0008, B:7:0x0025, B:8:0x0028, B:10:0x002c, B:12:0x003a, B:14:0x004a, B:16:0x0063, B:18:0x006b, B:19:0x0079, B:21:0x00b5, B:23:0x00c2, B:25:0x00f0, B:24:0x00dc, B:26:0x00f7), top: B:29:0x0000 }] */
    @Override // android.view.View.OnClickListener
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void onClick(android.view.View r5) {
        /*
            Method dump skipped, instruction units count: 304
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.m.w.onClick(android.view.View):void");
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.mall_search_layout, viewGroup, false);
        this.e = viewInflate.findViewById(R.id.mallWattingProgress);
        this.g = (TextView) viewInflate.findViewById(R.id.txtMallSearchInputSuggestKey);
        this.b = (ListView) viewInflate.findViewById(R.id.lvMallCategoryList);
        this.b.setOnItemClickListener(this);
        this.b.setOnItemLongClickListener(this);
        this.b.setOnScrollListener(new AbsListView.OnScrollListener() { // from class: chat.ola.vn.m.w.1
            @Override // android.widget.AbsListView.OnScrollListener
            public void onScroll(AbsListView absListView, int i, int i2, int i3) {
            }

            @Override // android.widget.AbsListView.OnScrollListener
            public void onScrollStateChanged(AbsListView absListView, int i) {
                if (i == 1 || i == 2) {
                    chat.ola.vn.util.o.a((Context) w.this.getActivity(), (View) w.this.h, false);
                }
            }
        });
        this.f = layoutInflater.inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
        this.f.setVisibility(8);
        this.b.addFooterView(this.f, null, false);
        this.h = (EditText) viewInflate.findViewById(R.id.txtMallSearchInput);
        this.i = (TextView) viewInflate.findViewById(R.id.txtSearchResInfo);
        this.j = viewInflate.findViewById(R.id.linearSearchResInfo);
        this.g.setOnClickListener(this);
        viewInflate.findViewById(R.id.btnMallSearch).setOnClickListener(this);
        this.h.post(new Runnable() { // from class: chat.ola.vn.m.w.3
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.util.o.a((Context) w.this.getActivity(), (View) w.this.h, true);
                w.this.h.requestFocus();
            }
        });
        this.h.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.m.w.4
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (i != 3) {
                    if (keyEvent == null) {
                        return false;
                    }
                    try {
                        if (keyEvent.getKeyCode() != 66) {
                            return false;
                        }
                    } catch (Throwable unused) {
                        return false;
                    }
                }
                if (w.this.h.length() <= 0) {
                    return true;
                }
                w.this.e(w.this.h.getText().toString());
                return true;
            }
        });
        return viewInflate;
    }

    @Override // chat.ola.vn.m.p, android.support.v4.app.Fragment
    public void onDetach() {
        chat.ola.vn.util.o.a((Context) getActivity(), (View) this.h, false);
        super.onDetach();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            c();
            chat.ola.vn.entity.e eVar = (chat.ola.vn.entity.e) adapterView.getAdapter().getItem(i);
            chat.ola.vn.util.o.a((Context) getActivity(), (View) this.h, false);
            g().a(eVar.t(), eVar.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.w.8
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
            g().a(eVar.t(), eVar.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.w.9
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

    @Override // chat.ola.vn.m.q
    protected void v() {
        try {
            if (this.a != null) {
                if (this.d != null) {
                    this.d.a(this.a.K());
                    this.d.notifyDataSetChanged();
                }
                if (this.e != null) {
                    if (this.a.k()) {
                        this.e.setVisibility(0);
                    } else {
                        this.e.setVisibility(8);
                    }
                }
                if (this.f != null) {
                    if (this.a.h() == null) {
                        this.f.setVisibility(8);
                    } else {
                        this.f.setVisibility(0);
                    }
                }
                if (this.j != null) {
                    if (this.a.L() == 0) {
                        this.j.setVisibility(8);
                    } else {
                        if (this.i != null) {
                            StringBuilder sb = new StringBuilder();
                            sb.append(chat.ola.vn.util.m.a(this.a.L()));
                            sb.append(" " + getString(R.string.string_result));
                            sb.append(" (" + (((float) this.a.M()) / 1000.0f) + "s )");
                            this.i.setText(sb);
                        }
                        if (this.g != null) {
                            chat.ola.vn.entity.e eVarO = this.a.O();
                            if (eVarO != null) {
                                String strZ = eVarO.z();
                                SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder(getString(R.string.message_search_suggest_key));
                                spannableStringBuilder.append((CharSequence) " : ");
                                spannableStringBuilder.append((CharSequence) strZ);
                                spannableStringBuilder.setSpan(new ForegroundColorSpan(-16776961), spannableStringBuilder.length() - strZ.length(), spannableStringBuilder.length(), 33);
                                this.g.setText(spannableStringBuilder);
                                this.g.setVisibility(0);
                            } else {
                                this.g.setVisibility(8);
                            }
                        }
                        this.j.setVisibility(0);
                        this.j.removeCallbacks(this.k);
                        this.j.postDelayed(this.k, 5000L);
                        this.a.b(this.b);
                    }
                }
                if (B()) {
                    this.f.setVisibility(0);
                } else {
                    this.f.setVisibility(4);
                }
            }
        } catch (Throwable unused) {
        }
    }
}
