package chat.ola.vn.b;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class al extends j<String> {
    private LayoutInflater a;
    private View.OnLongClickListener b;
    private String[] c;

    private class a implements View.OnClickListener {
        OlaCachedImageView a;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.suggestedPictureImageView);
        }

        public void a(String str) {
            if (chat.ola.vn.util.m.a(str)) {
                return;
            }
            this.a.setOnClickListener(this);
            this.a.setTag(str);
            this.a.setOnLongClickListener(al.this.b);
            chat.ola.vn.c.t.a().b(str, this.a, chat.ola.vn.e.c / 3);
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            try {
                if (view.getId() != R.id.suggestedPictureImageView) {
                    return;
                }
                String str = (String) view.getTag();
                int i = 0;
                while (true) {
                    if (i >= al.this.c.length) {
                        i = 0;
                        break;
                    } else if (chat.ola.vn.util.m.a(str, al.this.c[i])) {
                        break;
                    } else {
                        i++;
                    }
                }
                OlaMediaEntity[] olaMediaEntityArr = new OlaMediaEntity[al.this.c.length];
                for (int i2 = 0; i2 < olaMediaEntityArr.length; i2++) {
                    olaMediaEntityArr[i2] = new OlaMediaEntity(al.this.c[i2], 1, chat.ola.vn.util.o.g(al.this.c[i2]));
                }
                OlaImageViewerActivity.a(view.getContext(), view, (Bitmap) null, i, olaMediaEntityArr);
            } catch (Throwable unused) {
            }
        }
    }

    public al(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v0 */
    /* JADX WARN: Type inference failed for: r0v1, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v5 */
    /* JADX WARN: Type inference failed for: r0v6 */
    /* JADX WARN: Type inference failed for: r0v8, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v9 */
    /* JADX WARN: Type inference failed for: r6v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v2 */
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.al$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.suggested_photo_item, (ViewGroup) null);
                try {
                    a aVar = new a(Inflate);
                    Inflate.setTag(aVar);
                    Inflate = Inflate;
                    view = aVar;
                } catch (Throwable unused) {
                }
            } else {
                Inflate = view;
                view = (a) view.getTag();
            }
            view.a(getItem(i));
        } catch (Throwable unused2) {
            Inflate = view;
        }
        return Inflate == 0 ? viewGroup : Inflate;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public String getItem(int i) {
        try {
            return this.c[i];
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(String[] strArr) {
        if (strArr == null) {
            return;
        }
        this.c = strArr;
        notifyDataSetChanged();
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.c.length;
        } catch (Throwable unused) {
            return 0;
        }
    }
}
