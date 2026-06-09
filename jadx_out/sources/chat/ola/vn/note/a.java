package chat.ola.vn.note;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.d;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.u.b;
import chat.ola.vn.u.o;
import chat.ola.vn.util.c.c;
import chat.ola.vn.util.i;
import chat.ola.vn.util.m;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class a {
    private long d;
    private Runnable h;
    protected String a = null;
    protected String b = null;
    private int e = 0;
    private int f = 0;
    private int g = 0;
    protected byte c = 0;

    public a() {
        this.d = 0L;
        this.d = System.currentTimeMillis();
    }

    static /* synthetic */ int a(a aVar) {
        int i = aVar.f + 1;
        aVar.f = i;
        return i;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c() {
        if (m.a(this.a)) {
            return;
        }
        e eVar = new e() { // from class: chat.ola.vn.note.a.2
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 76;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str, d[] dVarArr) {
                try {
                    c.c(OlaApplication.a());
                    OlaApplication.c(a.this.h);
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                try {
                    c.a(OlaApplication.a());
                    OlaNoteComposerActivity.e = null;
                } catch (Throwable unused) {
                }
            }
        };
        if (m.a(this.b)) {
            this.b = "Note-" + new SimpleDateFormat("dd-MM-yyyy HH:mmZ", Locale.getDefault()).format(new Date(System.currentTimeMillis()));
        }
        OlaApplication.b.j(this.b, this.a, f.a(eVar));
        if (this.h == null) {
            this.h = new Runnable() { // from class: chat.ola.vn.note.a.3
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        c.a(OlaApplication.a());
                        OlaNoteComposerActivity.e = null;
                    } catch (Throwable unused) {
                    }
                }
            };
        }
        OlaApplication.a(this.h, 3000L);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d() {
        c.a(OlaApplication.a(), OlaApplication.a(R.string.message_fail_post_me_by_uploading));
    }

    static /* synthetic */ int g(a aVar) {
        int i = aVar.e + 1;
        aVar.e = i;
        return i;
    }

    public JSONObject a() {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("meDraftId", this.d);
            jSONObject.put("state", (int) this.c);
            if (!m.a(this.a)) {
                jSONObject.put("text", this.a);
            }
            return jSONObject;
        } catch (Throwable unused) {
            return null;
        }
    }

    public void b() {
        ArrayList<String> arrayListC = i.c((CharSequence) this.a);
        boolean z = false;
        if (arrayListC != null && arrayListC.size() > 0) {
            try {
                this.f = 0;
                this.e = 0;
                this.g = arrayListC.size();
                z = true;
            } catch (Throwable unused) {
            }
        }
        if (!z) {
            c();
            return;
        }
        for (final String str : arrayListC) {
            String str2 = null;
            try {
                if (!m.a(chat.ola.vn.n.c.a().b()) && !m.a(chat.ola.vn.n.c.a().c())) {
                    str2 = chat.ola.vn.n.c.a().b() + ":" + chat.ola.vn.n.c.a().c();
                }
                b.a().a(str.startsWith("file://") ? URLDecoder.decode(str.substring("file://".length()), "UTF-8") : str, str2, new o() { // from class: chat.ola.vn.note.a.1
                    private void a() {
                        a.g(a.this);
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(int i, int i2) {
                        chat.ola.vn.util.c.b.a(OlaApplication.a(), i, i2, a.this.e, a.this.f, a.this.g);
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(chat.ola.vn.entity.i iVar) {
                        a.a(a.this);
                        a.this.a = a.this.a.replace(str, "##" + iVar.d() + "#");
                        if (a.this.e > 0 && a.this.f + a.this.e == a.this.g) {
                            a.this.d();
                        } else if (a.this.f == a.this.g) {
                            a.this.c();
                        }
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str3) {
                        a();
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str3, int i) {
                        a();
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str3, int i, String str4) {
                        a();
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str3, String str4) {
                        a();
                    }

                    @Override // chat.ola.vn.u.o
                    public void b(String str3, String str4) {
                        a();
                    }
                });
            } catch (Throwable unused2) {
            }
        }
    }

    public boolean equals(Object obj) {
        try {
            if (this.d == ((a) obj).d) {
                return true;
            }
        } catch (Throwable unused) {
        }
        return super.equals(obj);
    }

    public String toString() {
        try {
            return a().toString();
        } catch (Throwable unused) {
            return null;
        }
    }
}
