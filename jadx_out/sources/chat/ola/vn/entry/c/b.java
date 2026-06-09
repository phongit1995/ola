package chat.ola.vn.entry.c;

import android.content.DialogInterface;
import chat.ola.vn.R;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.g;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b extends e {
    private long a;

    public b(long j) {
        this.a = 0L;
        this.a = j;
    }

    private void a(String str, short s, List<g> list) {
        h.u.a(str, s, list);
    }

    private void a(List<g> list) {
        h.u.c(list);
    }

    @Override // chat.ola.vn.entry.c.e
    public short a() {
        return (short) 65;
    }

    @Override // chat.ola.vn.entry.c.e
    public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
        chat.ola.vn.r.a.e eVar = h.u;
        if (i == 34) {
            try {
                if (chat.ola.vn.c.c() != null) {
                    if (this.a == 0) {
                        i.b(chat.ola.vn.c.c(), R.string.dialog_title_inform, R.string.message_diary_empty, R.string.string_edit_me, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.entry.c.b.2
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    x.j = (short) 11;
                                    OlaMeComposerActivity.a(chat.ola.vn.c.c());
                                }
                                dialogInterface.dismiss();
                            }
                        });
                    } else {
                        i.a(chat.ola.vn.c.c(), R.string.dialog_title_inform, R.string.message_fail_load_diary);
                    }
                }
            } catch (Throwable unused) {
            }
        }
        eVar.a(false);
    }

    @Override // chat.ola.vn.entry.c.e
    public void a(Object... objArr) {
        List<chat.ola.vn.entry.b> listI;
        try {
            try {
                String str = (String) objArr[0];
                g[] gVarArr = objArr.length > 2 ? (g[]) objArr[2] : null;
                if (gVarArr != null) {
                    String strG = h.u.g();
                    if (!m.b(strG, str) && (listI = h.u.i()) != null && listI.size() > 0) {
                        chat.ola.vn.entry.a aVar = new chat.ola.vn.entry.a();
                        aVar.a = new ArrayList(listI);
                        aVar.b = strG;
                        aVar.e = h.u.a();
                        h.u.a(aVar);
                    }
                    if (this.a == 0) {
                        a("mariage diary", (short) 0, Arrays.asList(gVarArr));
                    } else {
                        a(Arrays.asList(gVarArr));
                    }
                } else if (chat.ola.vn.c.c() != null) {
                    i.b(chat.ola.vn.c.c(), R.string.dialog_title_inform, R.string.message_diary_empty, R.string.string_edit_me, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.entry.c.b.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                x.j = (short) 11;
                                OlaMeComposerActivity.a(chat.ola.vn.c.c());
                            }
                            dialogInterface.dismiss();
                        }
                    });
                }
            } catch (Throwable unused) {
                if (chat.ola.vn.c.c() != null) {
                    i.a(chat.ola.vn.c.c(), R.string.dialog_title_fail, R.string.message_fail_load_diary_with_problem);
                }
            }
        } catch (Throwable unused2) {
        }
        h.u.a(false);
    }
}
