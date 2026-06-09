package chat.ola.vn.pickercontacts;

import chat.ola.vn.view.OlaCachedImageView;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public class f {
    private String a;
    private WeakReference<OlaCachedImageView> b;

    public f(OlaCachedImageView olaCachedImageView, String str) {
        this.a = str;
        this.b = new WeakReference<>(olaCachedImageView);
    }

    public WeakReference<OlaCachedImageView> a() {
        return this.b;
    }

    public String b() {
        return this.a;
    }
}
