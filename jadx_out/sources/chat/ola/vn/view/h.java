package chat.ola.vn.view;

import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.ListAdapter;
import chat.ola.vn.R;
import chat.ola.vn.b.ab;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
public class h extends d implements ViewPager.OnPageChangeListener, View.OnClickListener {
    private static List<chat.ola.vn.entry.h> c;
    protected b a;
    ab b;
    private ViewPager d;
    private ImageView[] e;

    private class a extends PagerAdapter {
        private a() {
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
            return 6;
        }

        @Override // android.support.v4.view.PagerAdapter
        public Object instantiateItem(ViewGroup viewGroup, int i) {
            try {
                int dimensionPixelSize = h.this.getContext().getResources().getDimensionPixelSize(R.dimen.general_icon_smile_size);
                switch (i) {
                    case 0:
                        int dimensionPixelSize2 = h.this.getContext().getResources().getDimensionPixelSize(R.dimen.metric_2dp);
                        GridView gridView = new GridView(h.this.getContext());
                        gridView.setColumnWidth(dimensionPixelSize);
                        gridView.setVerticalFadingEdgeEnabled(true);
                        gridView.setFadingEdgeLength(dimensionPixelSize);
                        gridView.setHorizontalSpacing(dimensionPixelSize2);
                        gridView.setVerticalSpacing(dimensionPixelSize2);
                        gridView.setNumColumns(-1);
                        h.this.b = new ab(h.this.getContext());
                        if (h.c == null) {
                            List unused = h.c = new ArrayList();
                            List<chat.ola.vn.entry.h> listX = chat.ola.vn.e.a().x();
                            if (listX != null && listX.size() > 0) {
                                h.c.addAll(listX);
                            }
                        }
                        h.this.b.a(h.c);
                        h.this.b.a(h.this);
                        gridView.setAdapter((ListAdapter) h.this.b);
                        viewGroup.addView(gridView);
                        return gridView;
                    case 1:
                        int dimensionPixelSize3 = h.this.getContext().getResources().getDimensionPixelSize(R.dimen.metric_2dp);
                        GridView gridView2 = new GridView(h.this.getContext());
                        gridView2.setColumnWidth(dimensionPixelSize);
                        gridView2.setVerticalFadingEdgeEnabled(true);
                        gridView2.setFadingEdgeLength(dimensionPixelSize);
                        gridView2.setHorizontalSpacing(dimensionPixelSize3);
                        gridView2.setVerticalSpacing(dimensionPixelSize3);
                        gridView2.setNumColumns(-1);
                        ab abVar = new ab(h.this.getContext(), chat.ola.vn.r.c.a);
                        abVar.a(h.this);
                        gridView2.setAdapter((ListAdapter) abVar);
                        viewGroup.addView(gridView2);
                        return gridView2;
                    case 2:
                        int dimensionPixelSize4 = h.this.getContext().getResources().getDimensionPixelSize(R.dimen.metric_2dp);
                        GridView gridView3 = new GridView(h.this.getContext());
                        gridView3.setColumnWidth(dimensionPixelSize);
                        gridView3.setVerticalFadingEdgeEnabled(true);
                        gridView3.setFadingEdgeLength(dimensionPixelSize);
                        gridView3.setHorizontalSpacing(dimensionPixelSize4);
                        gridView3.setVerticalSpacing(dimensionPixelSize4);
                        gridView3.setNumColumns(-1);
                        ab abVar2 = new ab(h.this.getContext(), chat.ola.vn.r.c.d);
                        abVar2.a(h.this);
                        gridView3.setAdapter((ListAdapter) abVar2);
                        viewGroup.addView(gridView3);
                        return gridView3;
                    case 3:
                        int dimensionPixelSize5 = h.this.getContext().getResources().getDimensionPixelSize(R.dimen.metric_2dp);
                        GridView gridView4 = new GridView(h.this.getContext());
                        gridView4.setColumnWidth(dimensionPixelSize);
                        gridView4.setVerticalFadingEdgeEnabled(true);
                        gridView4.setFadingEdgeLength(dimensionPixelSize);
                        gridView4.setHorizontalSpacing(dimensionPixelSize5);
                        gridView4.setVerticalSpacing(dimensionPixelSize5);
                        gridView4.setNumColumns(-1);
                        ab abVar3 = new ab(h.this.getContext(), chat.ola.vn.r.c.e);
                        abVar3.a(h.this);
                        gridView4.setAdapter((ListAdapter) abVar3);
                        viewGroup.addView(gridView4);
                        return gridView4;
                    case 4:
                        int dimensionPixelSize6 = h.this.getContext().getResources().getDimensionPixelSize(R.dimen.metric_2dp);
                        GridView gridView5 = new GridView(h.this.getContext());
                        gridView5.setColumnWidth(dimensionPixelSize);
                        gridView5.setVerticalFadingEdgeEnabled(true);
                        gridView5.setFadingEdgeLength(dimensionPixelSize);
                        gridView5.setHorizontalSpacing(dimensionPixelSize6);
                        gridView5.setVerticalSpacing(dimensionPixelSize6);
                        gridView5.setNumColumns(-1);
                        ab abVar4 = new ab(h.this.getContext(), chat.ola.vn.r.c.c);
                        abVar4.a(h.this);
                        gridView5.setAdapter((ListAdapter) abVar4);
                        viewGroup.addView(gridView5);
                        return gridView5;
                    case 5:
                        int dimensionPixelSize7 = h.this.getContext().getResources().getDimensionPixelSize(R.dimen.metric_2dp);
                        GridView gridView6 = new GridView(h.this.getContext());
                        gridView6.setColumnWidth(dimensionPixelSize);
                        gridView6.setVerticalFadingEdgeEnabled(true);
                        gridView6.setFadingEdgeLength(dimensionPixelSize);
                        gridView6.setHorizontalSpacing(dimensionPixelSize7);
                        gridView6.setVerticalSpacing(dimensionPixelSize7);
                        gridView6.setNumColumns(-1);
                        ab abVar5 = new ab(h.this.getContext(), chat.ola.vn.r.c.b);
                        abVar5.a(h.this);
                        gridView6.setAdapter((ListAdapter) abVar5);
                        viewGroup.addView(gridView6);
                        return gridView6;
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
            return new View(h.this.getContext());
        }

        @Override // android.support.v4.view.PagerAdapter
        public boolean isViewFromObject(View view, Object obj) {
            return view == obj;
        }
    }

    public interface b {
        void L();

        void g(String str);
    }

    public h(Context context) {
        super(context);
        this.b = null;
        a(context);
    }

    public h(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.b = null;
        a(context);
    }

    public h(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.b = null;
        a(context);
    }

    private void a(int i) {
        for (int i2 = 0; i2 < this.e.length; i2++) {
            try {
                if (i2 == i) {
                    this.e[i2].setBackgroundColor(chat.ola.vn.f.M);
                } else {
                    this.e[i2].setBackgroundColor(0);
                }
                if (i2 == 0) {
                    if (i2 == i) {
                        this.e[i2].setImageResource(R.drawable.ic_recent_white);
                    } else {
                        this.e[i2].setImageResource(R.drawable.ic_recent_gray);
                    }
                }
            } catch (Throwable unused) {
                return;
            }
        }
    }

    private void a(Context context) {
        inflate(context, R.layout.ola_attachment_smiley_tab_layout, this);
        try {
            this.d = (ViewPager) findViewById(R.id.smileyViewPager);
            this.e = new ImageView[6];
            this.e[0] = (ImageView) findViewById(R.id.smileyPageIndicator1);
            this.e[1] = (ImageView) findViewById(R.id.smileyPageIndicator2);
            this.e[2] = (ImageView) findViewById(R.id.smileyPageIndicator3);
            this.e[3] = (ImageView) findViewById(R.id.smileyPageIndicator4);
            this.e[4] = (ImageView) findViewById(R.id.smileyPageIndicator5);
            this.e[5] = (ImageView) findViewById(R.id.smileyPageIndicator6);
            this.e[0].setOnClickListener(this);
            this.e[1].setOnClickListener(this);
            this.e[2].setOnClickListener(this);
            this.e[3].setOnClickListener(this);
            this.e[4].setOnClickListener(this);
            this.e[5].setOnClickListener(this);
            this.e[0].setImageResource(R.drawable.ic_recent_gray);
            this.e[1].setImageResource(chat.ola.vn.r.c.a[new Random().nextInt(chat.ola.vn.r.c.a.length)].d);
            this.e[2].setImageResource(chat.ola.vn.r.c.d[new Random().nextInt(chat.ola.vn.r.c.d.length)].d);
            this.e[3].setImageResource(chat.ola.vn.r.c.e[new Random().nextInt(chat.ola.vn.r.c.e.length)].d);
            this.e[4].setImageResource(chat.ola.vn.r.c.c[new Random().nextInt(chat.ola.vn.r.c.c.length)].d);
            this.e[5].setImageResource(chat.ola.vn.r.c.b[new Random().nextInt(chat.ola.vn.r.c.b.length)].d);
            this.d.setAdapter(new a());
            this.d.setOnPageChangeListener(this);
            if (c == null) {
                c = new ArrayList();
                List<chat.ola.vn.entry.h> listX = chat.ola.vn.e.a().x();
                if (listX != null && listX.size() > 0) {
                    c.addAll(listX);
                }
            }
            setCurrentTab(1);
            findViewById(R.id.backSpaceImageView).setOnClickListener(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public b getOlaSmileyListener() {
        return this.a;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.backSpaceImageView) {
                if (this.a != null) {
                    this.a.L();
                    return;
                }
                return;
            }
            switch (id) {
                case R.id.smileyPageIndicator1 /* 2131297404 */:
                    setCurrentTab(0);
                    break;
                case R.id.smileyPageIndicator2 /* 2131297405 */:
                    setCurrentTab(1);
                    break;
                case R.id.smileyPageIndicator3 /* 2131297406 */:
                    setCurrentTab(2);
                    break;
                case R.id.smileyPageIndicator4 /* 2131297407 */:
                    setCurrentTab(3);
                    break;
                case R.id.smileyPageIndicator5 /* 2131297408 */:
                    setCurrentTab(4);
                    break;
                case R.id.smileyPageIndicator6 /* 2131297409 */:
                    setCurrentTab(5);
                    break;
                default:
                    String strValueOf = null;
                    chat.ola.vn.entry.h hVar = (chat.ola.vn.entry.h) view.getTag();
                    hVar.a = System.currentTimeMillis();
                    switch (hVar.c) {
                        case 0:
                            strValueOf = hVar.b[0];
                            break;
                        case 1:
                            strValueOf = String.valueOf(Character.toChars(hVar.b()));
                            break;
                    }
                    if (this.a != null) {
                        this.a.g(strValueOf);
                    }
                    int iIndexOf = c.indexOf(hVar);
                    if (iIndexOf < 0) {
                        if (c.size() >= 30) {
                            c.remove(c.size() - 1);
                        }
                        c.add(hVar);
                        Collections.sort(c, new chat.ola.vn.e.j());
                    } else {
                        c.get(iIndexOf).a = System.currentTimeMillis();
                    }
                    chat.ola.vn.e.a().c(c);
                    try {
                        this.b.notifyDataSetChanged();
                    } catch (Throwable unused) {
                        return;
                    }
                    break;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        requestDisallowInterceptTouchEvent(true);
        return super.onInterceptTouchEvent(motionEvent);
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrollStateChanged(int i) {
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrolled(int i, float f, int i2) {
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageSelected(int i) {
        if (i == 0) {
            try {
                Collections.sort(c, new chat.ola.vn.e.j());
                this.b.notifyDataSetChanged();
            } catch (Throwable unused) {
            }
        }
        a(i);
    }

    public void setCurrentTab(int i) {
        try {
            this.d.setCurrentItem(i, true);
            a(i);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void setOlaSmileyListener(b bVar) {
        this.a = bVar;
    }
}
