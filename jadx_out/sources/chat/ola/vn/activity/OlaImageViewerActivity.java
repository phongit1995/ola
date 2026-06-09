package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.TransitionDrawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewCompat;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.animation.DecelerateInterpolator;
import android.widget.AdapterView;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.e;
import chat.ola.vn.entity.d;
import chat.ola.vn.entity.l;
import chat.ola.vn.f;
import chat.ola.vn.h;
import chat.ola.vn.me.OlaMeCommentActivity;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.me.OlaMeLikerListActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.util.i;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import chat.ola.vn.view.k;
import com.mg.ola.a.a.b.j;
import com.mg.ola.common.d.g;
import com.mg.ola.common.widget.OlaViewPager;
import com.mg.ola.common.widget.image.viewer.PhotoView;
import com.mg.ola.common.widget.image.viewer.b;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class OlaImageViewerActivity extends c implements ViewPager.OnPageChangeListener, View.OnClickListener, View.OnLongClickListener, chat.ola.vn.f.a, b.f, b.g {
    private ImageView A;
    private long B;
    private String C;
    private int D;
    private int E;
    private int F;
    private short G;
    private View H;
    private Animation I;
    private Animation J;
    private Animation K;
    private Animation L;
    private View M;
    private ImageView N;
    private String O;
    private Float P;
    private Float Q;
    private OlaViewPager e;
    private View f;
    private Animation g;
    private Animation h;
    private PagerAdapter i;
    private ArrayList<OlaMediaEntity> j;
    private View l;
    private View o;
    private TextView p;
    private Rect q;
    private Rect r;
    private com.mg.ola.a.a.b.c t;
    private FrameLayout u;
    private TextView v;
    private TextView w;
    private TextView x;
    private TextView y;
    private ImageView z;
    private boolean k = true;
    private long s = 200;

    private class a extends PagerAdapter {
        private LayoutInflater b;

        a() {
            this.b = LayoutInflater.from(OlaImageViewerActivity.this);
        }

        @Override // android.support.v4.view.PagerAdapter
        public void destroyItem(ViewGroup viewGroup, int i, Object obj) {
            try {
                View view = (View) obj;
                new b(view).a();
                viewGroup.removeView(view);
            } catch (Throwable unused) {
            }
        }

        @Override // android.support.v4.view.PagerAdapter
        public int getCount() {
            if (OlaImageViewerActivity.this.j == null) {
                return 0;
            }
            return OlaImageViewerActivity.this.j.size();
        }

        @Override // android.support.v4.view.PagerAdapter
        public Object instantiateItem(ViewGroup viewGroup, int i) {
            final OlaMediaEntity olaMediaEntity = (OlaMediaEntity) OlaImageViewerActivity.this.j.get(i);
            short sB = olaMediaEntity.b();
            if (sB != 1) {
                if (sB != 3) {
                    return new View(OlaImageViewerActivity.this);
                }
                ImageView imageView = new ImageView(OlaImageViewerActivity.this);
                imageView.setImageResource(R.drawable.ic_media_sound);
                imageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                imageView.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.activity.OlaImageViewerActivity.a.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        switch (olaMediaEntity.a()) {
                            case 1:
                                chat.ola.vn.util.b.f(OlaImageViewerActivity.this, olaMediaEntity.c());
                                break;
                            case 2:
                                chat.ola.vn.util.b.b(OlaImageViewerActivity.this, Uri.fromFile(new File(olaMediaEntity.c())));
                                break;
                            case 3:
                                chat.ola.vn.util.b.e(OlaImageViewerActivity.this, olaMediaEntity.c());
                                break;
                        }
                    }
                });
                return imageView;
            }
            View viewInflate = this.b.inflate(R.layout.image_detail_view_layout, (ViewGroup) null);
            b bVar = new b(viewInflate);
            if (OlaImageViewerActivity.this.j != null) {
                bVar.a((OlaMediaEntity) OlaImageViewerActivity.this.j.get(i));
            }
            viewInflate.setTag("page_" + i);
            viewGroup.addView(viewInflate);
            return viewInflate;
        }

        @Override // android.support.v4.view.PagerAdapter
        public boolean isViewFromObject(View view, Object obj) {
            return view == obj;
        }
    }

    private class b {
        PhotoView a;
        ProgressBar b;
        ImageView.ScaleType c;
        OlaMediaEntity d;

        private b(View view) {
            this.a = (PhotoView) view.findViewById(R.id.imageView);
            this.a.setAllowParentInterceptOnEdge(true);
            this.a.setOnPhotoTapListener(OlaImageViewerActivity.this);
            this.a.setOnViewTapListener(OlaImageViewerActivity.this);
            this.a.setOnLongClickListener(OlaImageViewerActivity.this);
            this.c = this.a.getScaleType();
            this.b = (ProgressBar) view.findViewById(R.id.loadingProgress);
        }

        void a() {
            this.a.b();
        }

        /* JADX WARN: Removed duplicated region for block: B:20:0x006d  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void a(chat.ola.vn.mediastore.OlaMediaEntity r12) {
            /*
                Method dump skipped, instruction units count: 284
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaImageViewerActivity.b.a(chat.ola.vn.mediastore.OlaMediaEntity):void");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    @SuppressLint({"NewApi"})
    public void B() {
        this.q = (Rect) getIntent().getParcelableExtra("extra_src_animation_rect");
        this.r = (Rect) getIntent().getParcelableExtra("extra_target_animation_rect");
        if (this.q != null && this.r != null) {
            b(this.q, this.r);
            return;
        }
        this.e.setVisibility(0);
        TransitionDrawable transitionDrawable = new TransitionDrawable(new ColorDrawable[]{new ColorDrawable(0), new ColorDrawable(ViewCompat.MEASURED_STATE_MASK)});
        if (g.g()) {
            this.u.setBackground(transitionDrawable);
        } else {
            this.u.setBackgroundDrawable(transitionDrawable);
        }
        transitionDrawable.startTransition(((int) this.s) / 2);
    }

    private void C() {
        this.u = (FrameLayout) findViewById(R.id.globalViewLayout);
        this.f = findViewById(R.id.linearWrap);
        this.e = (OlaViewPager) findViewById(R.id.pageView);
        this.e.setPageMargin(getResources().getDimensionPixelSize(R.dimen.metric_16dp));
        this.e.setPageTransformer(true, new k());
        this.p = (TextView) findViewById(R.id.pageIndicator);
        this.l = findViewById(R.id.moreOptionButton);
        this.o = findViewById(R.id.btnRotate);
        this.M = findViewById(R.id.btnImageInfo);
        this.M.setOnClickListener(this);
        this.l.setOnClickListener(this);
        this.o.setOnClickListener(this);
        this.H = findViewById(R.id.linearMeCommentSpan);
        this.w = (TextView) findViewById(R.id.dislikeTextView);
        this.v = (TextView) findViewById(R.id.txtImageLikeCount);
        this.v.setOnClickListener(this);
        findViewById(R.id.likeViewLayout).setOnClickListener(this);
        findViewById(R.id.dislikeViewLayout).setOnClickListener(this);
        this.z = (ImageView) findViewById(R.id.imgImageLikeState);
        this.y = (TextView) findViewById(R.id.likeTextView);
        this.A = (ImageView) findViewById(R.id.imgImageDislikeState);
        this.x = (TextView) findViewById(R.id.txtImageCommentCount);
        this.x.setOnClickListener(this);
        this.N = (ImageView) findViewById(R.id.imgImageReply);
        this.N.setOnClickListener(this);
    }

    private void D() {
        TextView textView;
        int i;
        TextView textView2;
        int i2;
        TextView textView3;
        StringBuilder sb;
        int i3;
        TextView textView4;
        StringBuilder sb2;
        int i4;
        if (this.B == 0) {
            this.H.setVisibility(8);
            return;
        }
        this.H.setVisibility(0);
        if (this.G == 1) {
            this.z.setImageResource(R.drawable.ic_like_selected);
            textView = this.y;
            i = f.H;
        } else {
            this.z.setImageResource(R.drawable.ic_like_white);
            textView = this.y;
            i = f.g;
        }
        textView.setTextColor(i);
        if (this.G == 2) {
            this.A.setImageResource(R.drawable.ic_dislike_green);
            textView2 = this.w;
            i2 = f.H;
        } else {
            this.A.setImageResource(R.drawable.ic_dislike_white);
            textView2 = this.w;
            i2 = f.g;
        }
        textView2.setTextColor(i2);
        if (this.E == 0) {
            this.v.setVisibility(8);
        } else {
            this.v.setVisibility(0);
            if (this.E > 1) {
                textView3 = this.v;
                sb = new StringBuilder();
                sb.append(m.a(this.E));
                sb.append(" ");
                i3 = R.string.string_like_plural;
            } else {
                textView3 = this.v;
                sb = new StringBuilder();
                sb.append(m.a(this.E));
                sb.append(" ");
                i3 = R.string.string_like_single;
            }
            sb.append(getString(i3));
            textView3.setText(sb.toString());
        }
        if (this.F == 0) {
            this.w.setText(R.string.string_dislike);
        } else {
            this.w.setText(getString(R.string.string_dislike) + " (" + m.a(this.F) + ")");
        }
        if (this.D == 0) {
            this.x.setVisibility(8);
            return;
        }
        this.x.setVisibility(0);
        if (this.D > 1) {
            textView4 = this.x;
            sb2 = new StringBuilder();
            sb2.append(m.a(this.D));
            sb2.append(" ");
            i4 = R.string.string_comment_plural;
        } else {
            textView4 = this.x;
            sb2 = new StringBuilder();
            sb2.append(m.a(this.D));
            sb2.append(" ");
            i4 = R.string.string_comment;
        }
        sb2.append(getString(i4));
        textView4.setText(sb2.toString());
    }

    private int E() {
        if (getIntent() == null) {
            finish();
            return 0;
        }
        ArrayList<OlaMediaEntity> parcelableArrayListExtra = getIntent().getParcelableArrayListExtra("extra_media_entry_array_list");
        if (parcelableArrayListExtra != null && !parcelableArrayListExtra.isEmpty()) {
            for (OlaMediaEntity olaMediaEntity : parcelableArrayListExtra) {
                if (olaMediaEntity != null) {
                    this.j.add(olaMediaEntity);
                }
            }
        }
        if (this.j.isEmpty()) {
            finish();
            return 0;
        }
        this.B = getIntent().getLongExtra("_me_id", 0L);
        if (this.B != 0) {
            this.O = getIntent().getStringExtra("_sender");
            this.C = getIntent().getStringExtra("me_message");
            this.D = getIntent().getIntExtra("me_comment_count", 0);
            this.E = getIntent().getIntExtra("me_like_count", 0);
            this.F = getIntent().getIntExtra("me_dislike_count", 0);
            this.G = getIntent().getShortExtra("me_like_state", (short) 0);
        }
        int iMax = Math.max(0, getIntent().getIntExtra("_index", 0));
        if (this.j.size() == 1) {
            this.p.setVisibility(8);
        } else {
            this.p.setVisibility(0);
        }
        this.p.setText((iMax + 1) + "/" + this.j.size());
        if (this.j.get(iMax).a() == 1) {
            this.M.setVisibility(0);
        } else {
            this.M.setVisibility(4);
        }
        this.e.setVisibility(4);
        this.e.post(new Runnable() { // from class: chat.ola.vn.activity.OlaImageViewerActivity.2
            @Override // java.lang.Runnable
            public void run() {
                OlaImageViewerActivity.this.B();
            }
        });
        return iMax;
    }

    private b F() {
        View viewFindViewWithTag = this.e.findViewWithTag("page_" + this.e.getCurrentItem());
        if (viewFindViewWithTag != null) {
            return new b(viewFindViewWithTag);
        }
        return null;
    }

    private static Rect a(Rect rect, float f, float f2) {
        float fHeight;
        float fHeight2;
        float f3 = f / f2;
        if (rect.width() / rect.height() > f3) {
            fHeight = rect.width();
            fHeight2 = rect.width() / f3;
        } else {
            fHeight = rect.height() * f3;
            fHeight2 = rect.height();
        }
        Rect rect2 = new Rect(0, 0, (int) fHeight, (int) fHeight2);
        rect2.offset(rect.centerX() - rect2.centerX(), rect.centerY() - rect2.centerY());
        return rect2;
    }

    private static Rect a(Rect rect, Rect rect2) {
        float fHeight;
        float fHeight2;
        float fWidth = rect2.width() / rect2.height();
        if (rect.width() / rect.height() > fWidth) {
            fHeight = rect.width();
            fHeight2 = rect.width() / fWidth;
        } else {
            fHeight = rect.height() * fWidth;
            fHeight2 = rect.height();
        }
        Rect rect3 = new Rect(0, 0, (int) fHeight, (int) fHeight2);
        rect3.offset(rect.centerX() - rect3.centerX(), rect.centerY() - rect3.centerY());
        return rect3;
    }

    private void a(long j, String str, String str2, String str3) {
        String strA;
        String strB = i.b(str2, "@" + h.a());
        if (m.a(strB)) {
            strA = i.a((CharSequence) str2);
        } else {
            strA = strB + " " + i.a((CharSequence) str2);
        }
        OlaMeComposerActivity.a(this, "@" + str, strA, str3, j);
    }

    public static void a(Context context, View view, int i, chat.ola.vn.entry.b bVar) {
        Drawable drawable;
        try {
            Intent intent = new Intent("android.intent.action.VIEW");
            intent.setClass(context, OlaImageViewerActivity.class);
            List<String> listF = bVar.f();
            if (listF != null && !listF.isEmpty()) {
                intent.putExtra("extra_media_entry_array_list", OlaMediaEntity.a(listF));
            }
            intent.putExtra("_index", i);
            if (bVar != null) {
                intent.putExtra("_me_id", bVar.b.e());
                intent.putExtra("_sender", bVar.b.a());
                intent.putExtra("me_message", bVar.b.b());
                intent.putExtra("me_comment_count", bVar.b.g());
                intent.putExtra("me_like_count", bVar.b.f());
                intent.putExtra("me_dislike_count", bVar.b.D());
                intent.putExtra("me_like_state", bVar.b.i());
            }
            if (view != null) {
                Rect rect = new Rect(0, n.a(context), e.c, e.d);
                Rect rect2 = new Rect();
                view.getGlobalVisibleRect(rect2);
                if (!(view instanceof ImageView) || (drawable = ((ImageView) view).getDrawable()) == null) {
                    intent.putExtra("extra_src_animation_rect", a(rect2, rect));
                } else {
                    intent.putExtra("extra_src_animation_rect", a(a(rect2, drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight()), rect));
                }
                intent.putExtra("extra_target_animation_rect", rect);
            }
            try {
                ((FragmentActivity) context).startActivityForResult(intent, 0);
            } catch (Throwable unused) {
                context.startActivity(intent);
            }
        } catch (Throwable unused2) {
        }
    }

    public static void a(Context context, View view, Bitmap bitmap, int i, ArrayList<OlaMediaEntity> arrayList) {
        Rect rectA;
        if (arrayList == null || arrayList.isEmpty()) {
            return;
        }
        int iMin = Math.min(Math.max(0, i), arrayList.size() - 1);
        try {
            int size = arrayList.size();
            if (size > 700) {
                int iMax = Math.max(0, iMin - 350);
                ArrayList<OlaMediaEntity> arrayList2 = new ArrayList<>(arrayList.subList(iMax, Math.min(size, iMax + 700)));
                if (iMax != 0) {
                    iMin -= iMax;
                }
                try {
                    iMin = Math.min(Math.max(0, iMin), arrayList2.size() - 1);
                    arrayList = arrayList2;
                } catch (Throwable th) {
                    th = th;
                    arrayList = arrayList2;
                    th.printStackTrace();
                }
            }
        } catch (Throwable th2) {
            th = th2;
        }
        Intent intent = new Intent("android.intent.action.VIEW");
        intent.setClass(context, OlaImageViewerActivity.class);
        intent.putExtra("_index", iMin);
        intent.putExtra("extra_media_entry_array_list", arrayList);
        if (view != null) {
            Rect rect = new Rect(0, n.a(context), e.c, e.d);
            Rect rect2 = new Rect();
            view.getGlobalVisibleRect(rect2);
            if (bitmap != null) {
                rectA = a(rect2, bitmap.getWidth(), bitmap.getHeight());
            } else if (view instanceof ImageView) {
                if (((ImageView) view).getDrawable() != null) {
                    rectA = a(rect2, r5.getIntrinsicWidth(), r5.getIntrinsicHeight());
                }
            } else {
                intent.putExtra("extra_src_animation_rect", a(rect2, rect));
                intent.putExtra("extra_target_animation_rect", rect);
            }
            intent.putExtra("extra_src_animation_rect", a(rectA, rect));
            intent.putExtra("extra_target_animation_rect", rect);
        }
        context.startActivity(intent);
    }

    public static void a(Context context, View view, Bitmap bitmap, int i, OlaMediaEntity... olaMediaEntityArr) {
        if (olaMediaEntityArr == null || olaMediaEntityArr.length == 0) {
            return;
        }
        a(context, view, bitmap, i, (ArrayList<OlaMediaEntity>) new ArrayList(Arrays.asList(olaMediaEntityArr)));
    }

    @SuppressLint({"NewApi"})
    private void b(Rect rect, Rect rect2) {
        this.e.setVisibility(0);
        if (this.t != null) {
            this.t.b();
        }
        if (rect == null || rect2 == null) {
            return;
        }
        Rect rect3 = new Rect(rect);
        Rect rect4 = new Rect(rect2);
        int i = -n.a(this);
        rect3.offset(0, i);
        rect4.offset(0, i);
        float fWidth = rect3.width() / rect4.width();
        com.mg.ola.a.a.c.b.b(this.e, 0.0f);
        com.mg.ola.a.a.c.b.c(this.e, 0.0f);
        com.mg.ola.a.a.b.c cVar = new com.mg.ola.a.a.b.c();
        j jVarA = j.a(this.e, "translationX", rect3.left, rect4.left);
        j jVarA2 = j.a(this.e, "translationY", rect3.top, rect4.top);
        j jVarA3 = j.a(this.e, "scaleX", fWidth, 1.0f);
        j jVarA4 = j.a(this.e, "scaleY", fWidth, 1.0f);
        TransitionDrawable transitionDrawable = new TransitionDrawable(new ColorDrawable[]{new ColorDrawable(0), new ColorDrawable(ViewCompat.MEASURED_STATE_MASK)});
        if (g.g()) {
            this.u.setBackground(transitionDrawable);
        } else {
            this.u.setBackgroundDrawable(transitionDrawable);
        }
        cVar.a(jVarA).a(jVarA2).a(jVarA3).a(jVarA4);
        transitionDrawable.startTransition((((int) this.s) * 2) / 3);
        cVar.a(this.s);
        cVar.a(new DecelerateInterpolator());
        cVar.a(new com.mg.ola.a.a.b.b() { // from class: chat.ola.vn.activity.OlaImageViewerActivity.6
            @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
            public void a(com.mg.ola.a.a.b.a aVar) {
                OlaImageViewerActivity.this.t = null;
            }

            @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
            public void b(com.mg.ola.a.a.b.a aVar) {
                OlaImageViewerActivity.this.t = null;
            }
        });
        cVar.a();
        this.t = cVar;
    }

    private void c(Rect rect, Rect rect2) {
        if (this.t != null) {
            this.t.b();
        }
        if (rect == null || rect2 == null) {
            super.finish();
            return;
        }
        com.mg.ola.a.a.c.b.b(this.e, 0.0f);
        com.mg.ola.a.a.c.b.c(this.e, 0.0f);
        Rect rect3 = new Rect(rect);
        Rect rect4 = new Rect(rect2);
        int i = -n.a(this);
        rect3.offset(0, i);
        rect4.offset(0, i);
        float fHeight = rect3.height() / rect4.height();
        com.mg.ola.a.a.b.c cVar = new com.mg.ola.a.a.b.c();
        j jVarA = j.a(this.e, "translationX", rect3.left);
        cVar.a(jVarA).a(j.a(this.e, "translationY", rect3.top)).a(j.a(this.e, "scaleX", fHeight)).a(j.a(this.e, "scaleY", fHeight));
        cVar.a(this.s);
        cVar.a(new DecelerateInterpolator());
        cVar.a(new com.mg.ola.a.a.b.b() { // from class: chat.ola.vn.activity.OlaImageViewerActivity.7
            @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
            public void a(com.mg.ola.a.a.b.a aVar) {
                OlaImageViewerActivity.this.t = null;
                OlaImageViewerActivity.this.e.setVisibility(4);
                OlaImageViewerActivity.super.finish();
            }

            @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
            public void b(com.mg.ola.a.a.b.a aVar) {
                OlaImageViewerActivity.this.e.setVisibility(4);
                OlaImageViewerActivity.super.finish();
            }
        });
        cVar.a();
        if (this.u != null && this.u.getBackground() != null && (this.u.getBackground() instanceof TransitionDrawable)) {
            ((TransitionDrawable) this.u.getBackground()).reverseTransition((int) ((this.s * 2) / 3));
        }
        this.t = cVar;
    }

    @TargetApi(16)
    private void c(boolean z) {
        if (z) {
            if (g.g()) {
                getWindow().getDecorView().setSystemUiVisibility(1);
            }
            if (this.f.getVisibility() == 0) {
                this.f.startAnimation(this.g);
                this.f.setVisibility(4);
            }
            if (this.H.getVisibility() == 0) {
                this.H.startAnimation(this.L);
                this.H.setVisibility(4);
            }
            if (this.M.getVisibility() == 0) {
                this.M.startAnimation(this.L);
                this.M.setVisibility(4);
            }
        } else {
            if (g.g()) {
                getWindow().getDecorView().setSystemUiVisibility(0);
            }
            if (this.f.getVisibility() != 0) {
                this.f.startAnimation(this.h);
                this.f.setVisibility(0);
            }
            if (this.B != 0 && this.H.getVisibility() != 0) {
                this.H.startAnimation(this.K);
                this.H.setVisibility(0);
            }
            try {
                OlaMediaEntity olaMediaEntity = this.j.get(this.e.getCurrentItem());
                if (olaMediaEntity != null && olaMediaEntity.a() == 1 && this.M.getVisibility() != 0) {
                    this.M.startAnimation(this.K);
                    this.M.setVisibility(0);
                }
            } catch (Throwable unused) {
            }
        }
        this.k = z;
    }

    private void g(String str) {
        if (OlaApplication.b != null) {
            OlaApplication.b.n(str, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaImageViewerActivity.1
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 43;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str2, d[] dVarArr) {
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    l lVar;
                    try {
                        String str2 = (String) objArr[0];
                        chat.ola.vn.entity.i iVar = (chat.ola.vn.entity.i) objArr[1];
                        try {
                            lVar = (l) objArr[2];
                        } catch (Throwable unused) {
                            lVar = null;
                        }
                        chat.ola.vn.i.k kVar = new chat.ola.vn.i.k(OlaImageViewerActivity.this);
                        kVar.a(str2, iVar.e(), lVar, iVar.g());
                        kVar.show();
                    } catch (Throwable unused2) {
                    }
                }
            }));
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        a(false);
    }

    @Override // com.mg.ola.common.widget.image.viewer.b.f
    public void a(View view, float f, float f2) {
        c(!this.k);
    }

    protected void a(final OlaMediaEntity olaMediaEntity) {
        if (olaMediaEntity == null) {
            return;
        }
        try {
            final ArrayList arrayList = new ArrayList();
            if (olaMediaEntity.a() == 1 || olaMediaEntity.a() == 3) {
                arrayList.add(getString(R.string.string_save));
            }
            if (olaMediaEntity.a() == 1) {
                arrayList.add(getString(R.string.string_copy));
                arrayList.add(getString(R.string.string_copy_plus));
            }
            if (arrayList.isEmpty()) {
                return;
            }
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaImageViewerActivity.5
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    String str;
                    OlaImageViewerActivity olaImageViewerActivity;
                    String strC;
                    try {
                        String str2 = (String) arrayList.get(i);
                        if (m.b(str2, OlaImageViewerActivity.this.getString(R.string.string_copy))) {
                            switch (olaMediaEntity.a()) {
                                case 1:
                                    olaImageViewerActivity = OlaImageViewerActivity.this;
                                    strC = "#\u001b" + olaMediaEntity.c() + "#";
                                    break;
                                case 2:
                                    olaImageViewerActivity = OlaImageViewerActivity.this;
                                    strC = olaMediaEntity.c();
                                    break;
                                case 3:
                                    olaImageViewerActivity = OlaImageViewerActivity.this;
                                    strC = olaMediaEntity.c();
                                    break;
                                default:
                                    return;
                            }
                            o.a(olaImageViewerActivity, strC);
                        } else {
                            if (!m.b(str2, OlaImageViewerActivity.this.getString(R.string.string_copy_plus))) {
                                if (m.b(str2, OlaImageViewerActivity.this.getString(R.string.string_save))) {
                                    int iA = olaMediaEntity.a();
                                    if (iA == 1) {
                                        chat.ola.vn.util.b.b.a(OlaImageViewerActivity.this, olaMediaEntity.c());
                                        h.G = 0;
                                        return;
                                    } else {
                                        if (iA != 3) {
                                            return;
                                        }
                                        OlaImageViewerActivity.this.f(olaMediaEntity.c());
                                        return;
                                    }
                                }
                                return;
                            }
                            if (olaMediaEntity.a() != 1) {
                                return;
                            }
                            String strA = o.a(OlaImageViewerActivity.this);
                            if (m.a(strA)) {
                                str = "##" + olaMediaEntity.c() + "#";
                            } else {
                                str = strA + " ##" + olaMediaEntity.c() + "#";
                            }
                            o.a(OlaImageViewerActivity.this, str);
                        }
                        h.G = 5;
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    @Override // com.mg.ola.common.widget.image.viewer.b.g
    public void b(View view, float f, float f2) {
        c(!this.k);
    }

    /* JADX WARN: Removed duplicated region for block: B:22:0x008f A[Catch: Throwable -> 0x0093, TRY_LEAVE, TryCatch #0 {Throwable -> 0x0093, blocks: (B:2:0x0000, B:4:0x000d, B:6:0x0014, B:7:0x0018, B:9:0x001d, B:11:0x0021, B:13:0x0025, B:15:0x0049, B:17:0x0051, B:19:0x0055, B:21:0x0082, B:22:0x008f), top: B:26:0x0000 }] */
    @Override // android.app.Activity, android.view.Window.Callback
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean dispatchTouchEvent(android.view.MotionEvent r9) {
        /*
            r8 = this;
            chat.ola.vn.activity.OlaImageViewerActivity$b r0 = r8.F()     // Catch: java.lang.Throwable -> L93
            com.mg.ola.common.widget.image.viewer.PhotoView r0 = r0.a     // Catch: java.lang.Throwable -> L93
            boolean r0 = r0.a()     // Catch: java.lang.Throwable -> L93
            r1 = 0
            if (r0 != 0) goto L8f
            int r0 = r9.getPointerCount()     // Catch: java.lang.Throwable -> L93
            r2 = 1
            if (r0 != r2) goto L8f
            int r0 = r9.getActionMasked()     // Catch: java.lang.Throwable -> L93
            switch(r0) {
                case 0: goto L55;
                case 1: goto L1d;
                case 2: goto L1b;
                case 3: goto L1b;
                case 4: goto L1b;
                case 5: goto L55;
                case 6: goto L1d;
                default: goto L1b;
            }     // Catch: java.lang.Throwable -> L93
        L1b:
            goto L93
        L1d:
            java.lang.Float r0 = r8.P     // Catch: java.lang.Throwable -> L93
            if (r0 == 0) goto L93
            java.lang.Float r0 = r8.Q     // Catch: java.lang.Throwable -> L93
            if (r0 == 0) goto L93
            float r0 = r9.getX()     // Catch: java.lang.Throwable -> L93
            float r1 = r9.getY()     // Catch: java.lang.Throwable -> L93
            java.lang.Float r3 = r8.P     // Catch: java.lang.Throwable -> L93
            float r3 = r3.floatValue()     // Catch: java.lang.Throwable -> L93
            float r0 = r0 - r3
            float r0 = java.lang.Math.abs(r0)     // Catch: java.lang.Throwable -> L93
            java.lang.Float r3 = r8.Q     // Catch: java.lang.Throwable -> L93
            float r3 = r3.floatValue()     // Catch: java.lang.Throwable -> L93
            float r1 = r1 - r3
            float r1 = java.lang.Math.abs(r1)     // Catch: java.lang.Throwable -> L93
            r3 = 1112014848(0x42480000, float:50.0)
            int r3 = (r1 > r3 ? 1 : (r1 == r3 ? 0 : -1))
            if (r3 <= 0) goto L93
            r3 = 1077936128(0x40400000, float:3.0)
            float r0 = r0 * r3
            int r0 = (r1 > r0 ? 1 : (r1 == r0 ? 0 : -1))
            if (r0 <= 0) goto L93
            r8.finish()     // Catch: java.lang.Throwable -> L93
            return r2
        L55:
            float r0 = r9.getX()     // Catch: java.lang.Throwable -> L93
            float r2 = r9.getY()     // Catch: java.lang.Throwable -> L93
            android.graphics.Rect r3 = new android.graphics.Rect     // Catch: java.lang.Throwable -> L93
            android.view.View r4 = r8.H     // Catch: java.lang.Throwable -> L93
            int r4 = r4.getLeft()     // Catch: java.lang.Throwable -> L93
            android.view.View r5 = r8.H     // Catch: java.lang.Throwable -> L93
            int r5 = r5.getTop()     // Catch: java.lang.Throwable -> L93
            android.view.View r6 = r8.H     // Catch: java.lang.Throwable -> L93
            int r6 = r6.getRight()     // Catch: java.lang.Throwable -> L93
            android.view.View r7 = r8.H     // Catch: java.lang.Throwable -> L93
            int r7 = r7.getBottom()     // Catch: java.lang.Throwable -> L93
            r3.<init>(r4, r5, r6, r7)     // Catch: java.lang.Throwable -> L93
            int r4 = (int) r0     // Catch: java.lang.Throwable -> L93
            int r5 = (int) r2     // Catch: java.lang.Throwable -> L93
            boolean r3 = r3.contains(r4, r5)     // Catch: java.lang.Throwable -> L93
            if (r3 != 0) goto L8f
            java.lang.Float r0 = java.lang.Float.valueOf(r0)     // Catch: java.lang.Throwable -> L93
            r8.P = r0     // Catch: java.lang.Throwable -> L93
            java.lang.Float r0 = java.lang.Float.valueOf(r2)     // Catch: java.lang.Throwable -> L93
            r8.Q = r0     // Catch: java.lang.Throwable -> L93
            goto L93
        L8f:
            r8.P = r1     // Catch: java.lang.Throwable -> L93
            r8.Q = r1     // Catch: java.lang.Throwable -> L93
        L93:
            boolean r9 = super.dispatchTouchEvent(r9)
            return r9
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaImageViewerActivity.dispatchTouchEvent(android.view.MotionEvent):boolean");
    }

    /* JADX WARN: Type inference failed for: r0v0, types: [chat.ola.vn.activity.OlaImageViewerActivity$3] */
    protected void f(String str) {
        try {
            new AsyncTask<String, String, Boolean>() { // from class: chat.ola.vn.activity.OlaImageViewerActivity.3
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Boolean doInBackground(String... strArr) {
                    File file = new File(chat.ola.vn.d.a((short) 1), System.currentTimeMillis() + ".jpg");
                    if (file.exists()) {
                        return false;
                    }
                    try {
                        o.c(strArr[0], file.getAbsolutePath());
                        chat.ola.vn.util.l.a(OlaImageViewerActivity.this, file.getName(), file.getAbsolutePath(), "jpg");
                    } catch (Throwable unused) {
                    }
                    return true;
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Boolean bool) {
                    chat.ola.vn.util.j.d(OlaImageViewerActivity.this, R.string.message_download_image_ok, chat.ola.vn.d.d);
                }
            }.execute(str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        if (this.q == null || this.r == null) {
            super.finish();
        } else {
            c(this.q, this.r);
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        finish();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        ImageView imageView;
        Animation animation;
        try {
            switch (view.getId()) {
                case R.id.btnImageInfo /* 2131296467 */:
                    OlaMediaEntity olaMediaEntity = this.j.get(this.e.getCurrentItem());
                    if (olaMediaEntity.a() == 1) {
                        g(olaMediaEntity.c());
                        return;
                    }
                    return;
                case R.id.btnRotate /* 2131296537 */:
                    b bVarF = F();
                    if (bVarF != null) {
                        bVarF.a.a(90.0f);
                        return;
                    }
                    return;
                case R.id.dislikeViewLayout /* 2131296748 */:
                    if (OlaApplication.b == null) {
                        return;
                    }
                    if (this.G != 2) {
                        if (this.G == 1) {
                            this.E--;
                            if (this.E < 0) {
                                this.E = 0;
                            }
                        }
                        OlaApplication.b.a(this.B, true);
                        this.G = (short) 2;
                        this.F++;
                        D();
                        imageView = this.A;
                        animation = this.I;
                    } else {
                        OlaApplication.b.a(this.B, false);
                        this.G = (short) 0;
                        this.F--;
                        if (this.F < 0) {
                            this.F = 0;
                        }
                        D();
                        imageView = this.A;
                        animation = this.J;
                    }
                    break;
                case R.id.imgImageReply /* 2131296896 */:
                    String strC = null;
                    try {
                        if (this.j != null && this.j.size() > 1) {
                            OlaMediaEntity olaMediaEntity2 = this.j.get(this.e.getCurrentItem());
                            if (olaMediaEntity2.a() == 1) {
                                strC = olaMediaEntity2.c();
                            }
                        }
                    } catch (Throwable unused) {
                    }
                    a(this.B, this.O, this.C, strC);
                    return;
                case R.id.likeViewLayout /* 2131296981 */:
                    if (this.G != 1) {
                        if (OlaApplication.b.b(this.B, true)) {
                            if (this.G == 2) {
                                this.F--;
                                if (this.F < 0) {
                                    this.F = 0;
                                }
                            }
                            this.G = (short) 1;
                            this.E++;
                            D();
                            this.z.startAnimation(this.I);
                            try {
                                b(this.z, z());
                                return;
                            } catch (Throwable unused2) {
                                return;
                            }
                        }
                        return;
                    }
                    if (!OlaApplication.b.b(this.B, false)) {
                        return;
                    }
                    this.G = (short) 0;
                    this.E--;
                    if (this.E < 0) {
                        this.E = 0;
                    }
                    D();
                    imageView = this.z;
                    animation = this.J;
                    break;
                    break;
                case R.id.moreOptionButton /* 2131297122 */:
                    v();
                    return;
                case R.id.txtImageCommentCount /* 2131297572 */:
                    OlaMeCommentActivity.a(this, this.B);
                    return;
                case R.id.txtImageLikeCount /* 2131297573 */:
                    OlaMeLikerListActivity.a(this, this.E, this.B);
                    return;
                default:
                    return;
            }
            imageView.startAnimation(animation);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        try {
            overridePendingTransition(0, 0);
        } catch (Throwable unused) {
        }
        setContentView(R.layout.image_viewer_layout);
        this.j = new ArrayList<>();
        this.h = AnimationUtils.loadAnimation(this, R.anim.slide_in_from_top);
        this.g = AnimationUtils.loadAnimation(this, R.anim.slide_out_to_top);
        this.K = AnimationUtils.loadAnimation(this, R.anim.slide_in_from_bottom);
        this.L = AnimationUtils.loadAnimation(this, R.anim.slide_out_to_bottom);
        this.I = AnimationUtils.loadAnimation(this, R.anim.zoom_icon_animation);
        this.J = AnimationUtils.loadAnimation(this, R.anim.zoom_out_icon_animation);
        C();
        int iE = E();
        this.i = new a();
        this.e.setAdapter(this.i);
        this.e.setOnPageChangeListener(this);
        this.e.setCurrentItem(iE);
        c(false);
        D();
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        c(!this.k);
        return true;
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrollStateChanged(int i) {
    }

    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageScrolled(int i, float f, int i2) {
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.support.v4.view.ViewPager.OnPageChangeListener
    public void onPageSelected(int i) {
        View view;
        int i2;
        this.p.setText((i + 1) + "/" + this.i.getCount());
        if (this.j.get(i).a() == 1) {
            view = this.M;
            i2 = 0;
        } else {
            view = this.M;
            i2 = 4;
        }
        view.setVisibility(i2);
    }

    @Override // chat.ola.vn.c
    protected Dialog v() {
        final OlaMediaEntity olaMediaEntity = this.j.get(this.e.getCurrentItem());
        if (olaMediaEntity == null) {
            return null;
        }
        final ArrayList arrayList = new ArrayList();
        boolean z = false;
        if (olaMediaEntity.a() == 2 || olaMediaEntity.a() == 1) {
            arrayList.add(getString(R.string.string_send_me));
            arrayList.add(getString(R.string.string_post_status));
            z = true;
        }
        arrayList.add(getString(R.string.string_set_avatar));
        arrayList.add(getString(R.string.string_set_cover));
        arrayList.add(getString(R.string.string_set_app_background));
        arrayList.add(getString(z ? R.string.string_more_action : R.string.string_save));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaImageViewerActivity.4
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                int i2;
                OlaImageViewerActivity olaImageViewerActivity;
                String strK;
                try {
                    String str = (String) arrayList.get(i);
                    if (m.b(str, OlaImageViewerActivity.this.getString(R.string.string_send_me))) {
                        switch (olaMediaEntity.a()) {
                            case 1:
                                OlaMeComposerActivity.c(OlaImageViewerActivity.this, olaMediaEntity.c());
                                break;
                            case 2:
                                OlaMeComposerActivity.d(OlaImageViewerActivity.this, olaMediaEntity.c());
                                break;
                        }
                        h.G = 1;
                        return;
                    }
                    if (m.b(str, OlaImageViewerActivity.this.getString(R.string.string_post_status))) {
                        switch (olaMediaEntity.a()) {
                            case 1:
                                ArrayList arrayList2 = new ArrayList();
                                arrayList2.add(olaMediaEntity.c());
                                OlaMeComposerActivity.a(OlaImageViewerActivity.this, (String) null, arrayList2);
                                break;
                            case 2:
                                ArrayList arrayList3 = new ArrayList();
                                arrayList3.add(olaMediaEntity.c());
                                OlaMeComposerActivity.b(OlaImageViewerActivity.this, (String) null, arrayList3);
                                break;
                        }
                        i2 = 4;
                    } else {
                        if (m.b(str, OlaImageViewerActivity.this.getString(R.string.string_set_avatar))) {
                            switch (olaMediaEntity.a()) {
                                case 1:
                                    olaImageViewerActivity = OlaImageViewerActivity.this;
                                    strK = chat.ola.vn.entity.i.k(olaMediaEntity.c());
                                    OlaCropImageActivity.g(olaImageViewerActivity, strK);
                                    break;
                                case 2:
                                    OlaCropImageActivity.h(OlaImageViewerActivity.this, olaMediaEntity.c());
                                    break;
                                case 3:
                                    olaImageViewerActivity = OlaImageViewerActivity.this;
                                    strK = olaMediaEntity.c();
                                    OlaCropImageActivity.g(olaImageViewerActivity, strK);
                                    break;
                            }
                            h.G = 3;
                            return;
                        }
                        if (m.b(str, OlaImageViewerActivity.this.getString(R.string.string_set_cover))) {
                            switch (olaMediaEntity.a()) {
                                case 1:
                                    OlaCropImageActivity.d(OlaImageViewerActivity.this, olaMediaEntity.c());
                                    break;
                                case 2:
                                    OlaCropImageActivity.f(OlaImageViewerActivity.this, olaMediaEntity.c());
                                    break;
                                case 3:
                                    OlaCropImageActivity.e(OlaImageViewerActivity.this, olaMediaEntity.c());
                                    break;
                            }
                            i2 = 6;
                        } else if (m.b(str, OlaImageViewerActivity.this.getString(R.string.string_set_app_background))) {
                            switch (olaMediaEntity.a()) {
                                case 1:
                                    OlaCropImageActivity.a(OlaImageViewerActivity.this, olaMediaEntity.c());
                                    break;
                                case 2:
                                    OlaCropImageActivity.c(OlaImageViewerActivity.this, olaMediaEntity.c());
                                    break;
                                case 3:
                                    OlaCropImageActivity.b(OlaImageViewerActivity.this, olaMediaEntity.c());
                                    break;
                            }
                            i2 = 7;
                        } else {
                            if (!m.b(str, OlaImageViewerActivity.this.getString(R.string.string_save))) {
                                if (m.b(str, OlaImageViewerActivity.this.getString(R.string.string_more_action))) {
                                    OlaImageViewerActivity.this.a(olaMediaEntity);
                                    return;
                                }
                                return;
                            }
                            int iA = olaMediaEntity.a();
                            if (iA != 1) {
                                if (iA != 3) {
                                    return;
                                }
                                OlaImageViewerActivity.this.f(olaMediaEntity.c());
                                return;
                            }
                            chat.ola.vn.util.b.b.a(OlaImageViewerActivity.this, olaMediaEntity.c());
                            i2 = 0;
                        }
                    }
                    h.G = i2;
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return mVar;
    }

    @Override // chat.ola.vn.c
    public FrameLayout z() {
        return this.u;
    }
}
