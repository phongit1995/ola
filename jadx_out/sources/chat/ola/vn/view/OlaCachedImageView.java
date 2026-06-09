package chat.ola.vn.view;

import android.content.Context;
import android.graphics.Bitmap;
import android.util.AttributeSet;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import chat.ola.vn.R;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class OlaCachedImageView extends ImageView {
    protected String a;
    protected Animation b;
    protected int c;
    protected int d;
    private String e;
    private boolean f;

    public OlaCachedImageView(Context context) {
        super(context);
        this.a = null;
        this.f = true;
        this.c = 0;
        this.d = 0;
    }

    public OlaCachedImageView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = null;
        this.f = true;
        this.c = 0;
        this.d = 0;
    }

    public OlaCachedImageView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = null;
        this.f = true;
        this.c = 0;
        this.d = 0;
    }

    public void a(Bitmap bitmap, String str) {
        if (m.a(this.a, str)) {
            return;
        }
        super.setImageBitmap(bitmap);
        this.a = str;
        if (!this.f || bitmap == null) {
            return;
        }
        if (this.b == null) {
            this.b = AnimationUtils.loadAnimation(getContext(), R.anim.ola_cache_imageview_fade_in);
        }
        startAnimation(this.b);
    }

    public boolean a(String str) {
        return m.b(this.a, str);
    }

    public String getCachingId() {
        return this.a;
    }

    public String getLoadingUrl() {
        return this.e;
    }

    public void setAnimationEnable(boolean z) {
        this.f = z;
    }

    public void setCachingId(String str) {
        this.a = str;
    }

    @Override // android.widget.ImageView
    @Deprecated
    public void setImageBitmap(Bitmap bitmap) {
        super.setImageBitmap(bitmap);
        this.a = null;
    }

    @Override // android.widget.ImageView
    public void setImageResource(int i) {
        if (m.a(this.a, "" + i)) {
            return;
        }
        super.setImageResource(i);
        this.a = "" + i;
        this.e = null;
    }

    public void setLoadingUrl(String str) {
        this.e = str;
    }

    @Override // android.widget.ImageView
    public void setMaxHeight(int i) {
        this.d = i;
        super.setMaxHeight(i);
    }

    @Override // android.widget.ImageView
    public void setMaxWidth(int i) {
        this.c = i;
        super.setMaxWidth(i);
    }
}
