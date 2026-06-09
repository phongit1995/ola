package chat.ola.vn.entity;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class af {
    private String a;
    private String b;
    private int c;

    public af() {
    }

    public af(String str, String str2) {
        this.a = str;
        this.b = str2;
    }

    public String a() {
        try {
            if (chat.ola.vn.util.m.b(this.b, "mariage diary") && !chat.ola.vn.util.m.a(chat.ola.vn.h.O.e)) {
                return OlaApplication.a(R.string.system_me_box_with, "@" + chat.ola.vn.h.O.e);
            }
        } catch (Throwable unused) {
        }
        return this.a;
    }

    public void a(int i) {
        this.c = i;
    }

    public String b() {
        return this.b;
    }

    public int c() {
        return this.c;
    }
}
