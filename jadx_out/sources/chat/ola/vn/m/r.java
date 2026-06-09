package chat.ola.vn.m;

import android.annotation.TargetApi;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.me.OlaMeCommentActivity;
import chat.ola.vn.me.OlaMeComposerActivity;
import com.mg.ola.common.pager.indicator.CirclePageIndicator;
import com.mg.ola.common.widget.OlaViewPager;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class r extends q implements View.OnClickListener, View.OnLongClickListener {
    private ListView b;
    private OlaViewPager d;
    private chat.ola.vn.b.g e;
    private a f;
    private LinearLayout g;
    private Runnable h = new Runnable() { // from class: chat.ola.vn.m.r.1
        @Override // java.lang.Runnable
        public void run() {
            OlaViewPager olaViewPager;
            int i;
            int count = r.this.f.getCount();
            int currentItem = r.this.d.getCurrentItem();
            if (currentItem >= count - 1) {
                olaViewPager = r.this.d;
                i = 0;
            } else {
                olaViewPager = r.this.d;
                i = currentItem + 1;
            }
            olaViewPager.setCurrentItem(i, true);
            r.this.d.postDelayed(this, 5000L);
        }
    };
    private View i;

    private class a extends PagerAdapter {
        private a() {
        }

        @Override // android.support.v4.view.PagerAdapter
        public void destroyItem(ViewGroup viewGroup, int i, Object obj) {
            try {
                viewGroup.removeView((View) obj);
            } catch (Throwable unused) {
            }
        }

        @Override // android.support.v4.view.PagerAdapter
        public int getCount() {
            if (r.this.a == null) {
                return 0;
            }
            return r.this.a.u();
        }

        @Override // android.support.v4.view.PagerAdapter
        @TargetApi(16)
        public Object instantiateItem(ViewGroup viewGroup, int i) {
            chat.ola.vn.entity.e eVarG = r.this.a.g(i);
            View viewA = chat.ola.vn.entry.b.h.a(LayoutInflater.from(viewGroup.getContext()), viewGroup, eVarG.j() == null);
            chat.ola.vn.entry.b.h hVar = (chat.ola.vn.entry.b.h) viewA.getTag();
            hVar.a((View.OnClickListener) r.this);
            hVar.a(eVarG);
            if (hVar.a != null) {
                hVar.a.setVisibility(8);
            }
            viewGroup.addView(viewA);
            return viewA;
        }

        @Override // android.support.v4.view.PagerAdapter
        public boolean isViewFromObject(View view, Object obj) {
            return view == obj;
        }
    }

    private void a(ListView listView) {
        try {
            if (this.a.u() != 0) {
                View viewInflate = LayoutInflater.from(getActivity()).inflate(R.layout.mall_highlinght_span, (ViewGroup) null);
                this.g = (LinearLayout) viewInflate.findViewById(R.id.linearPageTabSpan);
                this.g.setVisibility(8);
                this.d = (OlaViewPager) viewInflate.findViewById(R.id.viewpagerMallConver);
                CirclePageIndicator circlePageIndicator = (CirclePageIndicator) viewInflate.findViewById(R.id.pageIndicator);
                circlePageIndicator.setStrokeWidth(1.0f);
                circlePageIndicator.setRadius(getResources().getDimensionPixelSize(R.dimen.metric_4dp));
                circlePageIndicator.setStrokeColor(-1);
                circlePageIndicator.setPageColor(chat.ola.vn.f.i);
                circlePageIndicator.setFillColor(-1);
                this.f = new a();
                this.d.setAdapter(this.f);
                this.d.postDelayed(this.h, 5000L);
                circlePageIndicator.setViewPager(this.d);
                circlePageIndicator.setOnPageChangeListener(new ViewPager.OnPageChangeListener() { // from class: chat.ola.vn.m.r.4
                    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
                    public void onPageScrollStateChanged(int i) {
                        r.this.d.removeCallbacks(r.this.h);
                        if (i != 0) {
                            return;
                        }
                        r.this.d.postDelayed(r.this.h, 5000L);
                    }

                    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
                    public void onPageScrolled(int i, float f, int i2) {
                    }

                    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
                    public void onPageSelected(int i) {
                    }
                });
                listView.addHeaderView(viewInflate, null, false);
            }
            View view = new View(getActivity());
            view.setLayoutParams(new AbsListView.LayoutParams(-1, getResources().getDimensionPixelSize(R.dimen.metric_8dp)));
            listView.addHeaderView(view, null, false);
            View view2 = new View(getActivity());
            view2.setLayoutParams(new AbsListView.LayoutParams(-1, getResources().getDimensionPixelSize(R.dimen.general_list_item_height_smallest)));
            listView.addFooterView(view2, null, false);
        } catch (Throwable unused) {
        }
    }

    private void a(chat.ola.vn.entity.e eVar, final chat.ola.vn.entity.e eVar2) {
        if (eVar2 == null) {
            return;
        }
        eVar.c(eVar2);
        try {
            if (eVar2.p()) {
                v();
            } else if (eVar2.k()) {
                if (this.i != null) {
                    this.i.setVisibility(0);
                    return;
                }
                return;
            } else {
                eVar2.b(true);
                OlaApplication.b.b(eVar2.t(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.r.8
                    @Override // chat.ola.vn.p.b
                    public void a(String str, String str2) {
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.r.8.2
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    eVar2.e(true);
                                    eVar2.b(false);
                                    r.this.i.setVisibility(8);
                                } catch (Throwable unused) {
                                }
                            }
                        });
                    }

                    @Override // chat.ola.vn.p.b
                    public void a(String str, String str2, final chat.ola.vn.entity.e eVar3) {
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.r.8.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    eVar2.g(eVar3.w());
                                    eVar2.h(eVar3.x());
                                    eVar2.b(eVar3.h());
                                    eVar2.e(true);
                                    eVar2.b(false);
                                    r.this.v();
                                } catch (Throwable unused) {
                                }
                            }
                        });
                    }
                });
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        v();
    }

    @Override // chat.ola.vn.m.q, chat.ola.vn.m.p
    public ArrayList<chat.ola.vn.mediastore.a> a(Context context) {
        this.c = new ArrayList<>();
        chat.ola.vn.mediastore.a aVar = new chat.ola.vn.mediastore.a();
        aVar.b = R.drawable.ic_action_search;
        aVar.a = R.id.mallAction1;
        aVar.f = new View.OnClickListener() { // from class: chat.ola.vn.m.r.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                try {
                    r.this.g().v();
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
        this.e = new chat.ola.vn.b.g(getActivity());
        this.e.a((View.OnClickListener) this);
        this.e.a((View.OnLongClickListener) this);
        this.b.setAdapter((ListAdapter) this.e);
        v();
    }

    @Override // chat.ola.vn.m.q
    public void c() {
        try {
            super.c();
            if (this.b != null) {
                this.a.a(this.b);
            }
        } catch (Throwable unused) {
        }
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
        try {
            int id = view.getId();
            if (id == R.id.imgVideoThumbnail) {
                chat.ola.vn.entity.e eVar = (chat.ola.vn.entity.e) view.getTag();
                if (eVar.E() == 101) {
                    g().a(eVar.t(), eVar.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.r.5
                        @Override // chat.ola.vn.p.b
                        public void a(String str, String str2) {
                        }

                        @Override // chat.ola.vn.p.b
                        public void a(String str, String str2, chat.ola.vn.entity.e eVar2) {
                            eVar2.j(1);
                        }
                    });
                    return;
                } else {
                    chat.ola.vn.util.b.a(getActivity(), view, eVar.A(), eVar.G());
                    OlaApplication.b.z(eVar.y());
                    return;
                }
            }
            if (id != R.id.linearMallItemTabSpan) {
                switch (id) {
                    case R.id.btnMallItemDetailActionComment /* 2131296485 */:
                        OlaMeCommentActivity.a(getActivity(), this.a.B());
                        return;
                    case R.id.btnMallItemDetailComment /* 2131296486 */:
                        chat.ola.vn.entity.e eVar2 = (chat.ola.vn.entity.e) view.getTag();
                        g().a(eVar2.t(), eVar2.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.r.6
                            @Override // chat.ola.vn.p.b
                            public void a(String str, String str2) {
                            }

                            @Override // chat.ola.vn.p.b
                            public void a(String str, String str2, chat.ola.vn.entity.e eVar3) {
                                eVar3.j(0);
                            }
                        });
                        return;
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
                        OlaMeComposerActivity.a(getActivity(), eVar4.z() + "\n " + ("http://mall.ola.vn/" + eVar4.y()), (String) null);
                        return;
                    default:
                        return;
                }
            } else {
                c();
            }
            v();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.mall_list_content_layout, viewGroup, false);
        this.i = viewInflate.findViewById(R.id.mallWattingProgress);
        this.b = (ListView) viewInflate.findViewById(R.id.lvMallCategoryList);
        this.b.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.r.2
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    r.this.c();
                    chat.ola.vn.entity.e eVar = (chat.ola.vn.entity.e) adapterView.getAdapter().getItem(i);
                    r.this.g().a(eVar.t(), eVar.J(), new chat.ola.vn.p.b() { // from class: chat.ola.vn.m.r.2.1
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
                } catch (Throwable unused) {
                }
            }
        });
        this.b.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() { // from class: chat.ola.vn.m.r.3
            @Override // android.widget.AdapterView.OnItemLongClickListener
            public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    chat.ola.vn.i.i.a(r.this.getActivity(), (chat.ola.vn.entity.e) adapterView.getAdapter().getItem(i));
                    return true;
                } catch (Throwable unused) {
                    return false;
                }
            }
        });
        a(this.b);
        return viewInflate;
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
            if (this.e != null) {
                if (this.a != null) {
                    if (this.a.m() != null) {
                        ArrayList arrayList = new ArrayList();
                        arrayList.add(this.a);
                        chat.ola.vn.entity.e eVarL = this.a.l();
                        if (eVarL.p()) {
                            List<chat.ola.vn.entity.e> listW = eVarL.w();
                            if (listW != null) {
                                arrayList.addAll(listW);
                            }
                        } else if (!eVarL.k()) {
                            a(this.a, eVarL);
                        }
                        this.e.a(arrayList);
                    } else if (this.a.x() != null) {
                        this.e.b(this.a.x());
                    } else {
                        this.e.a(this.a.w());
                    }
                    if (this.a.k()) {
                        this.i.setVisibility(0);
                    } else {
                        this.i.setVisibility(8);
                    }
                }
                this.e.notifyDataSetChanged();
                if (this.a != null) {
                    this.a.b(this.b);
                }
            }
            if (this.f != null) {
                this.f.notifyDataSetChanged();
            }
        } catch (Throwable unused) {
        }
    }
}
