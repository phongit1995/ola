package com.mg.ola.common.c;

import android.content.Context;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.animation.Interpolator;
import android.widget.HorizontalScrollView;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import com.google.android.gms.common.util.CrashUtils;
import com.mg.ola.common.c.c;
import java.lang.ref.WeakReference;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public class b extends c {
    private HorizontalScrollView f;
    private Animation g;
    private ViewGroup h;
    private ViewGroup i;
    private List<a> j;
    private boolean k;
    private View.OnClickListener l;

    public b(Context context) {
        super(context);
        this.l = new View.OnClickListener() { // from class: com.mg.ola.common.c.b.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                c.a aVarH = b.this.h();
                if (aVarH != null) {
                    int size = b.this.j.size();
                    int i = 0;
                    while (true) {
                        if (i >= size) {
                            break;
                        }
                        if (view == ((a) b.this.j.get(i)).d.get()) {
                            aVarH.a(b.this, i);
                            break;
                        }
                        i++;
                    }
                }
                if (b.this.e()) {
                    b.this.getContentView().postDelayed(new Runnable() { // from class: com.mg.ola.common.c.b.2.1
                        @Override // java.lang.Runnable
                        public void run() {
                            b.this.dismiss();
                        }
                    }, 100L);
                }
            }
        };
        this.g = AnimationUtils.loadAnimation(context, R.anim.rail);
        this.g.setInterpolator(new Interpolator() { // from class: com.mg.ola.common.c.b.1
            @Override // android.animation.TimeInterpolator
            public float getInterpolation(float f) {
                float f2 = (f * 1.55f) - 1.1f;
                return 1.2f - (f2 * f2);
            }
        });
        a(R.layout.horizonal_slide_quickaction_layout);
        View contentView = getContentView();
        this.h = (ViewGroup) contentView.findViewById(R.id.rack);
        this.i = (ViewGroup) contentView.findViewById(R.id.quick_action_items);
        this.f = (HorizontalScrollView) contentView.findViewById(R.id.scroll);
    }

    @Override // com.mg.ola.common.c.c
    protected void a() {
        super.a();
        this.i.removeAllViews();
    }

    @Override // com.mg.ola.common.c.c
    protected void a(Rect rect, View view) {
        int iCenterX;
        view.setLayoutParams(new ViewGroup.LayoutParams(-2, -2));
        view.measure(View.MeasureSpec.makeMeasureSpec(c(), CrashUtils.ErrorDialogData.SUPPRESSED), -2);
        int measuredHeight = view.getMeasuredHeight();
        int measuredWidth = this.f.getMeasuredWidth();
        int iB = b();
        boolean z = rect.top > d() - rect.bottom;
        int i = z ? (rect.top - measuredHeight) + iB : rect.bottom - iB;
        if (rect.left + measuredWidth > c()) {
            iCenterX = rect.left - (measuredWidth - rect.width());
            if (iCenterX < 0) {
                iCenterX = 0;
            }
        } else {
            iCenterX = rect.width() > measuredWidth ? rect.centerX() - (measuredWidth / 2) : rect.left;
        }
        a(iCenterX, i, z);
    }

    @Override // com.mg.ola.common.c.c
    public void a(View view) {
        super.a(view);
        this.f.scrollTo(0, 0);
        if (this.c) {
            this.h.startAnimation(this.g);
        }
    }

    @Override // com.mg.ola.common.c.c
    protected void a(List<a> list) {
        View viewInflate;
        this.j = list;
        LayoutInflater layoutInflaterFrom = LayoutInflater.from(g());
        for (a aVar : list) {
            if (this.k) {
                viewInflate = layoutInflaterFrom.inflate(R.layout.horizonal_quickaction_icon_item, this.i, false);
                ImageView imageView = (ImageView) viewInflate;
                imageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                imageView.setImageDrawable(aVar.a);
            } else {
                viewInflate = layoutInflaterFrom.inflate(R.layout.horizonal_quickaction_item, this.i, false);
                TextView textView = (TextView) viewInflate;
                textView.setText(aVar.b);
                textView.setCompoundDrawablesWithIntrinsicBounds((Drawable) null, aVar.a, (Drawable) null, (Drawable) null);
            }
            viewInflate.setOnClickListener(this.l);
            this.i.addView(viewInflate);
            aVar.d = new WeakReference<>(viewInflate);
        }
    }

    public void a(boolean z) {
        this.k = z;
    }
}
