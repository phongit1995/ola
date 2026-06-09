package chat.ola.vn.view;

import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.ListAdapter;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.v;
import chat.ola.vn.entity.w;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import it.sephiroth.android.library.widget.HListView;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class i extends chat.ola.vn.view.d implements ViewPager.OnPageChangeListener {
    private static List<w> b;
    private static List<v> c;
    private static chat.ola.vn.e.k d;
    private static v e;
    protected e a;
    private HListView f;
    private a g;
    private View h;
    private ViewPager i;
    private f j;

    private class a extends chat.ola.vn.b.j<v> {
        private LayoutInflater b;

        public a(Context context) {
            super(context);
            this.b = LayoutInflater.from(context);
        }

        @Override // chat.ola.vn.b.j
        public View a(int i, View view, ViewGroup viewGroup) {
            try {
                if (view == null) {
                    View viewInflate = this.b.inflate(R.layout.ola_attachment_sticker_album_item_layout, (ViewGroup) null);
                    try {
                        viewInflate.setTag(i.this.new b(viewInflate));
                        view = viewInflate;
                    } catch (Throwable th) {
                        th = th;
                        view = viewInflate;
                        th.printStackTrace();
                    }
                } else if (view.getTag() == null) {
                    view.setTag(i.this.new b(view));
                }
                ((b) view.getTag()).a(getItem(i));
            } catch (Throwable th2) {
                th = th2;
            }
            return view == null ? viewGroup : view;
        }

        @Override // android.widget.Adapter
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public v getItem(int i) {
            try {
                return (v) i.c.get(i);
            } catch (Throwable unused) {
                return null;
            }
        }

        @Override // chat.ola.vn.b.j, android.widget.Adapter
        public int getCount() {
            try {
                return i.c.size();
            } catch (Throwable unused) {
                return 0;
            }
        }
    }

    private class b implements View.OnClickListener {
        private View b;
        private OlaCachedImageView c;

        public b(View view) {
            this.c = (OlaCachedImageView) view.findViewById(R.id.stickerAlbumCoverImageView);
            this.b = view.findViewById(R.id.stickerAlbumCoverViewLayout);
            this.c.setOnClickListener(this);
        }

        public void a(v vVar) {
            OlaCachedImageView olaCachedImageView;
            int i;
            View view;
            int i2;
            try {
                this.c.setTag(vVar);
                if (m.b(vVar.a(), i.e.a())) {
                    view = this.b;
                    i2 = chat.ola.vn.f.M;
                } else {
                    view = this.b;
                    i2 = 0;
                }
                view.setBackgroundColor(i2);
            } catch (Throwable unused) {
            }
            if (!m.b(vVar.a(), "recent")) {
                String strB = vVar.b();
                if (strB != null) {
                    t.a().b(strB, this.c, 120);
                    return;
                }
                return;
            }
            if (i.e == null || !m.b(i.e.a(), vVar.a())) {
                olaCachedImageView = this.c;
                i = R.drawable.ic_recent_gray;
            } else {
                olaCachedImageView = this.c;
                i = R.drawable.ic_recent_white;
            }
            olaCachedImageView.setImageResource(i);
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            int iIndexOf;
            try {
                if (view.getId() != R.id.stickerAlbumCoverImageView) {
                    return;
                }
                v vVar = (v) view.getTag();
                if (m.b(vVar.a(), i.e.a())) {
                    return;
                }
                v unused = i.e = vVar;
                i.this.g.notifyDataSetChanged();
                try {
                    iIndexOf = i.c.indexOf(vVar);
                } catch (Throwable unused2) {
                    iIndexOf = 0;
                }
                i.this.i.setCurrentItem(iIndexOf, true);
            } catch (Throwable unused3) {
            }
        }
    }

    private class c extends chat.ola.vn.b.j<w> {
        private LayoutInflater b;
        private v c;

        public c(Context context) {
            super(context);
            this.b = LayoutInflater.from(context);
        }

        @Override // chat.ola.vn.b.j
        public View a(int i, View view, ViewGroup viewGroup) {
            try {
                if (view == null) {
                    View viewInflate = this.b.inflate(R.layout.ola_attachment_sticker_object_item_layout, (ViewGroup) null);
                    try {
                        viewInflate.setTag(i.this.new d(viewInflate));
                        view = viewInflate;
                    } catch (Throwable th) {
                        th = th;
                        view = viewInflate;
                        th.printStackTrace();
                    }
                } else if (view.getTag() == null) {
                    view.setTag(i.this.new d(view));
                }
                ((d) view.getTag()).a(getItem(i));
            } catch (Throwable th2) {
                th = th2;
            }
            return view == null ? viewGroup : view;
        }

        @Override // android.widget.Adapter
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public w getItem(int i) {
            try {
                return this.c.c().get(i);
            } catch (Throwable unused) {
                return null;
            }
        }

        public void a(v vVar) {
            this.c = vVar;
        }

        @Override // chat.ola.vn.b.j, android.widget.Adapter
        public int getCount() {
            try {
                return this.c.c().size();
            } catch (Throwable unused) {
                return 0;
            }
        }

        @Override // android.widget.BaseAdapter, android.widget.Adapter
        public int getViewTypeCount() {
            return 1;
        }
    }

    private class d implements View.OnClickListener {
        private OlaCachedImageView b;
        private View c;

        public d(View view) {
            this.c = view.findViewById(R.id.stickerLoadingProgressBar);
            this.b = (OlaCachedImageView) view.findViewById(R.id.stickerImageView);
            this.b.setOnClickListener(this);
        }

        public void a(w wVar) {
            this.b.setTag(wVar);
            String strA = wVar.a();
            if (strA != null) {
                t.a().a(strA, this.b, ImageView.ScaleType.CENTER_INSIDE, this.c, 240);
                this.b.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            }
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            try {
                if (view.getId() != R.id.stickerImageView) {
                    return;
                }
                final w wVar = (w) view.getTag();
                if (wVar.c) {
                    return;
                }
                if (x.e()) {
                    n.a(chat.ola.vn.c.c(), chat.ola.vn.util.c.a.y);
                }
                Animation animationLoadAnimation = AnimationUtils.loadAnimation(i.this.getContext(), R.anim.fade_in);
                animationLoadAnimation.setDuration(2000L);
                animationLoadAnimation.setAnimationListener(new Animation.AnimationListener() { // from class: chat.ola.vn.view.i.d.1
                    @Override // android.view.animation.Animation.AnimationListener
                    public void onAnimationEnd(Animation animation) {
                        wVar.c = false;
                    }

                    @Override // android.view.animation.Animation.AnimationListener
                    public void onAnimationRepeat(Animation animation) {
                    }

                    @Override // android.view.animation.Animation.AnimationListener
                    public void onAnimationStart(Animation animation) {
                        wVar.c = true;
                    }
                });
                view.startAnimation(animationLoadAnimation);
                if (i.this.a != null) {
                    i.this.a.a(wVar);
                }
                i.a(wVar);
            } catch (Throwable unused) {
            }
        }
    }

    public interface e {
        void a(w wVar);
    }

    private class f extends PagerAdapter {
        Map<String, c> a;

        private f() {
        }

        public void a(String str) {
            try {
                this.a.get(str).notifyDataSetChanged();
            } catch (Throwable unused) {
            }
        }

        @Override // android.support.v4.view.PagerAdapter
        public void destroyItem(ViewGroup viewGroup, int i, Object obj) {
            try {
                viewGroup.removeView((View) obj);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }

        @Override // android.support.v4.view.PagerAdapter
        public int getCount() {
            try {
                return i.c.size();
            } catch (Throwable unused) {
                return 0;
            }
        }

        @Override // android.support.v4.view.PagerAdapter
        public Object instantiateItem(ViewGroup viewGroup, int i) {
            try {
                int dimensionPixelSize = i.this.getContext().getResources().getDimensionPixelSize(R.dimen.metric_2dp);
                GridView gridView = new GridView(i.this.getContext());
                gridView.setColumnWidth((chat.ola.vn.e.c / 5) - (dimensionPixelSize * 2));
                gridView.setStretchMode(2);
                gridView.setFadingEdgeLength(0);
                gridView.setVerticalSpacing(dimensionPixelSize);
                gridView.setHorizontalSpacing(dimensionPixelSize);
                gridView.setNumColumns(5);
                c cVar = i.this.new c(i.this.getContext());
                v vVar = (v) i.c.get(i);
                cVar.a(vVar);
                gridView.setAdapter((ListAdapter) cVar);
                if (this.a == null) {
                    this.a = new HashMap();
                }
                this.a.put(vVar.a(), cVar);
                viewGroup.addView(gridView);
                return gridView;
            } catch (Throwable th) {
                th.printStackTrace();
                return new View(i.this.getContext());
            }
        }

        @Override // android.support.v4.view.PagerAdapter
        public boolean isViewFromObject(View view, Object obj) {
            return view == obj;
        }
    }

    public i(Context context) {
        super(context);
        a(context);
    }

    public i(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        a(context);
    }

    public i(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        a(context);
    }

    private void a(Context context) {
        inflate(context, R.layout.ola_attachment_sticker_tab_layout, this);
        try {
            this.f = (HListView) findViewById(R.id.stickerAlbumListView);
            this.h = findViewById(R.id.stickerProgressBar);
            this.h.setVisibility(8);
            this.i = (ViewPager) findViewById(R.id.stickerViewPager);
            this.i.setOnPageChangeListener(this);
            this.g = new a(context);
            if (c == null) {
                c = new ArrayList();
                e = new v();
                e.a("recent");
                c.add(e);
                d();
                e.a(b);
            }
            this.f.setAdapter((ListAdapter) this.g);
            if (c.size() <= 1) {
                OlaApplication.b.a(new chat.ola.vn.p.m() { // from class: chat.ola.vn.view.i.1
                    @Override // chat.ola.vn.p.m
                    public void a(v vVar, List<w> list) {
                    }

                    @Override // chat.ola.vn.p.m
                    public void a(List<v> list) {
                        if (list != null) {
                            try {
                                if (list.size() > 0) {
                                    i.c.addAll(list);
                                    i.this.g.notifyDataSetChanged();
                                    i.this.j.notifyDataSetChanged();
                                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.i.1.1
                                        @Override // java.lang.Runnable
                                        public void run() {
                                            try {
                                                i.this.i.setCurrentItem(1, true);
                                            } catch (Throwable unused) {
                                            }
                                        }
                                    });
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }
                });
            }
            this.j = new f();
            this.i.setAdapter(this.j);
            if (m.b(e.a(), "recent")) {
                return;
            }
            this.g.notifyDataSetChanged();
            int iIndexOf = 0;
            try {
                iIndexOf = c.indexOf(e);
            } catch (Throwable unused) {
            }
            this.i.setCurrentItem(iIndexOf, true);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void a(w wVar) {
        try {
            d();
            wVar.d = System.currentTimeMillis();
            int iIndexOf = b.indexOf(wVar);
            if (iIndexOf < 0) {
                if (b.size() >= 30) {
                    b.remove(b.size() - 1);
                }
                b.add(wVar);
                if (d == null) {
                    d = new chat.ola.vn.e.k();
                }
                Collections.sort(b, d);
            } else {
                b.get(iIndexOf).d = System.currentTimeMillis();
            }
            chat.ola.vn.e.a().a(b);
        } catch (Throwable unused) {
        }
    }

    private void b(v vVar) {
        List<w> listC = vVar.c();
        if (listC == null || listC.size() == 0) {
            this.h.setVisibility(0);
            OlaApplication.b.a(vVar, new chat.ola.vn.p.m() { // from class: chat.ola.vn.view.i.2
                @Override // chat.ola.vn.p.m
                public void a(v vVar2, List<w> list) {
                    i.this.h.setVisibility(8);
                    if (list != null) {
                        vVar2.a(list);
                    }
                    i.this.j.a(vVar2.a());
                }

                @Override // chat.ola.vn.p.m
                public void a(List<v> list) {
                }
            });
        } else {
            this.h.setVisibility(8);
            this.j.a(vVar.a());
        }
    }

    public static boolean b(w wVar) {
        try {
            d();
            return b.contains(wVar);
        } catch (Throwable unused) {
            return false;
        }
    }

    private static void d() {
        if (b == null) {
            b = new ArrayList(30);
            List<w> listT = chat.ola.vn.e.a().t();
            if (listT == null || listT.size() <= 0) {
                return;
            }
            b.addAll(listT);
        }
    }

    public e getOnStickerClickedListener() {
        return this.a;
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrollStateChanged(int i) {
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrolled(int i, float f2, int i2) {
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageSelected(int i) {
        if (i == 0) {
            try {
                if (d == null) {
                    d = new chat.ola.vn.e.k();
                }
                Collections.sort(b, d);
            } catch (Throwable unused) {
                return;
            }
        }
        this.f.c(i);
        e = c.get(i);
        b(e);
        this.g.notifyDataSetChanged();
    }

    public void setOnStickerClickedListener(e eVar) {
        this.a = eVar;
    }
}
