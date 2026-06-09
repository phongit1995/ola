package chat.ola.vn.b;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class s extends j<chat.ola.vn.entity.ab> {
    private List<chat.ola.vn.entity.ab> a;
    private boolean b;

    public class a implements View.OnClickListener {
        OlaCachedImageView a;
        View b;
        View c;
        View d;
        private chat.ola.vn.entity.ab f;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.photoImageView);
            this.a.setOnClickListener(this);
            this.c = view.findViewById(R.id.videoPlayImageView);
            this.b = view.findViewById(R.id.deletePhotoImageView);
            this.b.setOnClickListener(this);
            this.d = view.findViewById(R.id.photoLoadingProgressBar);
        }

        public void a(chat.ola.vn.entity.ab abVar) {
            this.f = abVar;
            if (s.this.b) {
                this.b.setVisibility(0);
                this.b.setTag(this.f);
            } else {
                this.b.setVisibility(8);
            }
            this.a.setTag(this.f);
            if (this.f.a == 1) {
                if (this.f.b == 0) {
                    this.c.setVisibility(8);
                    chat.ola.vn.c.t.a().b(this.f.c, this.a, this.d, this.a.getWidth());
                    return;
                } else {
                    this.c.setVisibility(8);
                    chat.ola.vn.c.t.a().a(this.f.c, this.a, this.d, this.a.getWidth(), this.a.getHeight());
                    return;
                }
            }
            if (this.f.a == 2) {
                if (this.f.b != 0) {
                    this.c.setVisibility(0);
                    this.d.setVisibility(8);
                    chat.ola.vn.c.t.a().c(this.f.c, this.a, R.drawable.ic_media_video);
                } else {
                    this.c.setVisibility(8);
                    this.d.setVisibility(8);
                    this.a.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    this.a.setImageResource(R.drawable.ic_media_video);
                }
            }
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            try {
                int id = view.getId();
                if (id == R.id.deletePhotoImageView) {
                    if (s.this.b) {
                        s.this.a.remove((chat.ola.vn.entity.ab) view.getTag());
                        s.this.notifyDataSetChanged();
                        return;
                    }
                    return;
                }
                if (id != R.id.photoImageView) {
                    return;
                }
                chat.ola.vn.entity.ab abVar = (chat.ola.vn.entity.ab) view.getTag();
                OlaMediaEntity[] olaMediaEntityArr = new OlaMediaEntity[s.this.a.size()];
                int i = 0;
                for (int i2 = 0; i2 < olaMediaEntityArr.length; i2++) {
                    chat.ola.vn.entity.ab abVar2 = (chat.ola.vn.entity.ab) s.this.a.get(i2);
                    if (abVar2.equals(abVar)) {
                        i = i2;
                    }
                    if (abVar2.b == 0) {
                        olaMediaEntityArr[i2] = new OlaMediaEntity(abVar2.c, 1, (short) 1);
                    } else {
                        olaMediaEntityArr[i2] = new OlaMediaEntity(abVar2.c, 2, (short) 1);
                    }
                }
                OlaImageViewerActivity.a(chat.ola.vn.c.c(), this.a, (Bitmap) null, i, olaMediaEntityArr);
            } catch (Throwable unused) {
            }
        }
    }

    public s(Context context) {
        super(context);
        this.a = null;
        this.b = true;
    }

    private void a(chat.ola.vn.entity.ab abVar) {
        if (this.a == null) {
            this.a = new ArrayList(100);
        }
        this.a.add(abVar);
    }

    private void a(String str, byte b) {
        try {
            for (chat.ola.vn.entity.ab abVar : this.a) {
                if (abVar.b == b && chat.ola.vn.util.m.a(abVar.c, str)) {
                    return;
                }
            }
        } catch (Throwable unused) {
        }
        chat.ola.vn.entity.ab abVar2 = new chat.ola.vn.entity.ab();
        abVar2.b = b;
        abVar2.a = (short) 2;
        abVar2.c = str;
        a(abVar2);
    }

    private void b(String str, byte b) {
        try {
            for (chat.ola.vn.entity.ab abVar : this.a) {
                if (abVar.b == b && chat.ola.vn.util.m.a(abVar.c, str)) {
                    return;
                }
            }
        } catch (Throwable unused) {
        }
        chat.ola.vn.entity.ab abVar2 = new chat.ola.vn.entity.ab();
        abVar2.b = b;
        abVar2.a = (short) 1;
        abVar2.c = str;
        a(abVar2);
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
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.s$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.e.inflate(R.layout.ola_me_composer_attached_photo_layout, (ViewGroup) null);
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
    public chat.ola.vn.entity.ab getItem(int i) {
        try {
            return this.a.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public List<chat.ola.vn.entity.ab> a() {
        try {
            return new ArrayList(this.a);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(String str) {
        b(str, (byte) 0);
    }

    public void a(List<chat.ola.vn.entity.ab> list) {
        try {
            int size = list.size();
            for (int i = 0; i < size; i++) {
                a(list.get(i));
            }
        } catch (Throwable unused) {
        }
    }

    public void a(boolean z) {
        this.b = z;
    }

    public void b(String str) {
        a(str, (byte) 0);
    }

    public void c() {
        try {
            this.a.clear();
        } catch (Throwable th) {
            this.a = null;
            throw th;
        }
        this.a = null;
    }

    public void c(String str) {
        b(str, (byte) 1);
    }

    public void d(String str) {
        a(str, (byte) 1);
    }

    public boolean d() {
        try {
            return this.a.size() > 0;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.a.size();
        } catch (Throwable unused) {
            return 0;
        }
    }
}
