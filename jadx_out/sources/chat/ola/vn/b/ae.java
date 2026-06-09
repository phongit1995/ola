package chat.ola.vn.b;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import chat.ola.vn.R;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ae extends j<String> {
    public int a;
    private LayoutInflater b;
    private View.OnClickListener c;
    private ArrayList<String> d;

    private class a {
        ImageView a;
        ImageView b;

        public a(View view) {
            this.a = (ImageView) view.findViewById(R.id.imgIcon);
            this.a.setMaxHeight(ae.this.a);
            this.a.setMaxWidth(ae.this.a);
            this.b = (ImageView) view.findViewById(R.id.imgDelete);
        }

        public void a(final String str) {
            ImageView imageView;
            int i;
            if (ae.this.c != null) {
                this.b.setVisibility(0);
                this.b.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.b.ae.a.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        view.setTag(str);
                        ae.this.c.onClick(view);
                    }
                });
            } else {
                this.b.setVisibility(4);
            }
            this.a.setImageBitmap(null);
            switch (chat.ola.vn.util.o.g(str)) {
                case 1:
                    Bitmap bitmapB = chat.ola.vn.c.t.a().b(str);
                    if (bitmapB != null) {
                        this.a.setScaleType(ImageView.ScaleType.CENTER_CROP);
                        this.a.setImageBitmap(bitmapB);
                        return;
                    } else {
                        chat.ola.vn.c.f fVarG = chat.ola.vn.c.f.g(str, ae.this.a);
                        fVarG.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.b.ae.a.2
                            @Override // chat.ola.vn.c.g
                            public void a(chat.ola.vn.c.f fVar) {
                                if (fVar != null) {
                                    a.this.a.setScaleType(ImageView.ScaleType.CENTER_CROP);
                                    a.this.a.setImageBitmap(fVar.c());
                                }
                            }

                            @Override // chat.ola.vn.c.g
                            public void b(chat.ola.vn.c.f fVar) {
                            }
                        });
                        try {
                            new chat.ola.vn.c.e().a(fVarG);
                            return;
                        } catch (Throwable unused) {
                            return;
                        }
                    }
                case 2:
                    this.a.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    imageView = this.a;
                    i = R.drawable.ic_media_video;
                    break;
                case 3:
                    this.a.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    imageView = this.a;
                    i = R.drawable.ic_media_sound;
                    break;
                default:
                    this.a.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    imageView = this.a;
                    i = R.drawable.ic_sdcard;
                    break;
            }
            imageView.setImageResource(i);
        }
    }

    public ae(Context context, ArrayList<String> arrayList, int i) {
        super(context);
        this.b = LayoutInflater.from(context);
        this.a = i;
        this.d = arrayList;
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
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.b.ae$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.b.inflate(R.layout.thumb_icon_item, (ViewGroup) null);
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
            return this.d.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.c = onClickListener;
    }

    public void a(ArrayList<String> arrayList) {
        this.d = arrayList;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.d.size();
        } catch (Throwable unused) {
            return 0;
        }
    }
}
