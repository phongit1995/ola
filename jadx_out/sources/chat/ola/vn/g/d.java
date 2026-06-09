package chat.ola.vn.g;

import android.content.Context;
import android.content.DialogInterface;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.i.p;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class d extends a {
    chat.ola.vn.message.f d;
    private boolean e = false;

    public d(chat.ola.vn.message.f fVar) {
        this.a = 7;
        this.d = fVar;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(Context context) {
        String strB;
        try {
            strB = this.d.b();
        } catch (Throwable unused) {
            strB = "";
        }
        chat.ola.vn.i.i.a(context, strB, 0, R.string.message_change_alias, R.string.general_hint_alias, R.string.string_ok, R.string.string_cancel, (List<String>) null, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.g.d.2
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    String strA = ((p) dialogInterface).a();
                    if (OlaApplication.b != null) {
                        OlaApplication.b.c(d.this.d.j(), strA);
                    }
                    d.this.d.b(strA);
                }
                dialogInterface.dismiss();
            }
        }).b(8192);
    }

    @Override // chat.ola.vn.g.a
    public View a(LayoutInflater layoutInflater) {
        return layoutInflater.inflate(R.layout.contact_item_layout, (ViewGroup) null);
    }

    @Override // chat.ola.vn.g.a
    public h a(View view, h hVar) {
        try {
            ((k) hVar).a(this.d);
            ((k) hVar).k = true;
            ((k) hVar).l = false;
            ((k) hVar).c(this.e);
            hVar.b = this.c;
            hVar.a = this.b;
            return hVar;
        } catch (Throwable unused) {
            k kVar = new k(this.d, view);
            kVar.k = true;
            kVar.l = false;
            kVar.c(this.e);
            kVar.b = this.c;
            kVar.a = this.b;
            return kVar;
        }
    }

    @Override // chat.ola.vn.g.a
    public boolean a(final Context context, View view, int i, long j) {
        try {
            if (this.d.k() != 0) {
                return false;
            }
            final ArrayList arrayList = new ArrayList();
            arrayList.add(context.getString(R.string.string_view_me));
            arrayList.add(context.getString(R.string.string_change_alias));
            arrayList.add(context.getString(R.string.string_delete));
            arrayList.add(context.getString(R.string.string_block_chat));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
            mVar.setTitle(this.d.L());
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.g.d.1
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view2, int i2, long j2) {
                    Context context2;
                    String string;
                    String string2;
                    String string3;
                    String string4;
                    DialogInterface.OnClickListener onClickListener;
                    try {
                        String str = (String) arrayList.get(i2);
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_view_me))) {
                            chat.ola.vn.me.c.a(context, OlaApplication.b, d.this.d.j());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_change_alias))) {
                            d.this.a(context);
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_delete))) {
                            context2 = context;
                            string = context.getString(R.string.dialog_title_confirm);
                            string2 = context.getString(R.string.string_delete_something_confirm, d.this.d.L());
                            string3 = context.getString(R.string.string_delete);
                            string4 = context.getString(R.string.string_no);
                            onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.g.d.1.1
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i3) {
                                    if (i3 == 0) {
                                        try {
                                            OlaApplication.b.e(d.this.d.j());
                                            chat.ola.vn.h.t.d(d.this.d);
                                        } catch (Throwable unused) {
                                        }
                                    }
                                    try {
                                        dialogInterface.dismiss();
                                    } catch (Throwable unused2) {
                                    }
                                }
                            };
                        } else {
                            if (!chat.ola.vn.util.m.b(context.getString(R.string.string_block_chat), str)) {
                                return;
                            }
                            context2 = context;
                            string = context.getString(R.string.message_block_chat_title);
                            string2 = context.getString(R.string.message_block_chat_confirm_format, "@" + d.this.d.j());
                            string3 = context.getString(R.string.string_block);
                            string4 = context.getString(R.string.string_cancel);
                            onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.g.d.1.2
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i3) {
                                    if (i3 == 0) {
                                        try {
                                            OlaApplication.b.l(d.this.d.j());
                                        } catch (Throwable th) {
                                            th.printStackTrace();
                                        }
                                    }
                                    dialogInterface.dismiss();
                                }
                            };
                        }
                        chat.ola.vn.i.i.d(context2, string, string2, string3, string4, onClickListener);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.g.a
    public void b(Context context, View view, int i, long j) {
        OlaChatViewActivity.a(context, OlaApplication.b, this.d.j(), this.d.k());
    }

    public void c(boolean z) {
        this.e = z;
    }
}
