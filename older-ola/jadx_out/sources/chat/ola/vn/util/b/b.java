package chat.ola.vn.util.b;

import android.content.Context;
import android.content.DialogInterface;
import chat.ola.vn.R;
import chat.ola.vn.i.l;

/* JADX INFO: loaded from: classes.dex */
public class b {
    public static void a(final Context context, String str) {
        try {
            final c cVar = new c();
            cVar.a(new a() { // from class: chat.ola.vn.util.b.b.1
                private l c;

                @Override // chat.ola.vn.util.b.a
                public void a() {
                    try {
                        this.c.dismiss();
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.util.b.a
                public void a(long j, long j2) {
                    try {
                        this.c.b(j2);
                        this.c.a(j);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.util.b.a
                public void a(String str2, String str3, String str4) {
                    try {
                        this.c.dismiss();
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.util.b.a
                public void b() {
                    try {
                        this.c.dismiss();
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.util.b.a
                public void c() {
                    this.c = new l(context);
                    try {
                        this.c.b(R.string.message_saving_media_progress);
                        this.c.a(R.string.string_cancel);
                        this.c.a(new DialogInterface.OnClickListener() { // from class: chat.ola.vn.util.b.b.1.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                AnonymousClass1.this.c.dismiss();
                                cVar.a();
                            }
                        });
                        this.c.show();
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.util.b.a
                public void d() {
                    try {
                        this.c.dismiss();
                    } catch (Throwable unused) {
                    }
                }
            });
            cVar.execute(str);
        } catch (Throwable unused) {
        }
    }
}
