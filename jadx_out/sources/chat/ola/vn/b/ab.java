package chat.ola.vn.b;

import android.annotation.SuppressLint;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import chat.ola.vn.view.OlaSquareCachedImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ab extends j<chat.ola.vn.entry.h> {
    private View.OnClickListener a;
    private List<chat.ola.vn.entry.h> b;

    public ab(Context context) {
        this(context, null);
    }

    public ab(Context context, chat.ola.vn.entry.h[] hVarArr) {
        super(context);
        if (hVarArr == null || hVarArr.length <= 0) {
            return;
        }
        this.b = new ArrayList(hVarArr.length);
        for (chat.ola.vn.entry.h hVar : hVarArr) {
            this.b.add(hVar);
        }
    }

    @Override // chat.ola.vn.b.j
    @SuppressLint({"NewApi"})
    public View a(int i, View view, ViewGroup viewGroup) {
        if (view == null) {
            try {
                OlaSquareCachedImageView olaSquareCachedImageView = new OlaSquareCachedImageView(b());
                try {
                    olaSquareCachedImageView.setAdjustViewBounds(true);
                    olaSquareCachedImageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    view = olaSquareCachedImageView;
                } catch (Throwable unused) {
                    return olaSquareCachedImageView;
                }
            } catch (Throwable unused2) {
            }
        }
        OlaSquareCachedImageView olaSquareCachedImageView2 = (OlaSquareCachedImageView) view;
        chat.ola.vn.entry.h item = getItem(i);
        olaSquareCachedImageView2.setTag(item);
        if (this.a != null) {
            olaSquareCachedImageView2.setOnClickListener(this.a);
        }
        olaSquareCachedImageView2.setImageResource(item.d);
        return view;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entry.h getItem(int i) {
        try {
            return this.b.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.a = onClickListener;
    }

    public void a(List<chat.ola.vn.entry.h> list) {
        this.b = list;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.b.size();
        } catch (Throwable unused) {
            return 0;
        }
    }
}
