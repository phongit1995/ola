package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.m;
import chat.ola.vn.c;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.i.p;
import chat.ola.vn.message.f;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaChatGroupListActivity extends c implements View.OnClickListener, AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener {
    private View e = null;
    private ListView f = null;
    private m g = null;

    private void B() {
        this.f = (ListView) findViewById(R.id.chatGroupListView);
        this.e = findViewById(R.id.addChatGroupHintTextView);
        this.f.setOnItemClickListener(this);
        this.f.setOnItemLongClickListener(this);
        findViewById(R.id.addChatGroupButton).setOnClickListener(this);
        findViewById(R.id.backView).setOnClickListener(this);
    }

    private void C() {
        try {
            this.g = new m();
            this.f.setVisibility(8);
            this.f.setAdapter((ListAdapter) this.g);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        Intent intent = new Intent(context, (Class<?>) OlaChatGroupListActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(Context context, final f fVar) {
        String strB;
        try {
            strB = fVar.b();
        } catch (Throwable unused) {
            strB = "";
        }
        i.a(context, strB, 0, R.string.message_change_alias, R.string.general_hint_alias, R.string.string_ok, R.string.string_cancel, (List<String>) null, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaChatGroupListActivity.2
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    String strA = ((p) dialogInterface).a();
                    if (OlaApplication.b != null) {
                        OlaApplication.b.a(fVar.j(), strA, (short) 0);
                    }
                    fVar.b(strA);
                }
                dialogInterface.dismiss();
            }
        }).b(8192);
    }

    @Override // chat.ola.vn.c
    protected void a() {
        if (h.t.E() > 0) {
            this.f.setVisibility(0);
            this.e.setVisibility(8);
        } else {
            this.f.setVisibility(8);
            this.e.setVisibility(0);
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.addChatGroupButton || id != R.id.backView) {
                return;
            }
            finish();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_chatgroup_list_layout);
        B();
        C();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            f fVarD = h.t.d(i);
            OlaChatViewActivity.a(OlaApplication.a(), OlaApplication.b, fVarD.j(), fVarD.k());
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AdapterView.OnItemLongClickListener
    public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            final f fVarD = h.t.d(i);
            final ArrayList arrayList = new ArrayList();
            arrayList.add(getString(R.string.string_change_alias));
            arrayList.add(getString(R.string.string_delete));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
            mVar.setTitle(fVarD.L());
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaChatGroupListActivity.1
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView2, View view2, int i2, long j2) {
                    try {
                        String str = (String) arrayList.get(i2);
                        if (chat.ola.vn.util.m.b(str, OlaChatGroupListActivity.this.getString(R.string.string_change_alias))) {
                            OlaChatGroupListActivity.this.a(OlaChatGroupListActivity.this, fVarD);
                        } else if (chat.ola.vn.util.m.b(str, OlaChatGroupListActivity.this.getString(R.string.string_delete))) {
                            i.d(OlaChatGroupListActivity.this, OlaChatGroupListActivity.this.getString(R.string.dialog_title_confirm), OlaChatGroupListActivity.this.getString(R.string.string_delete_something_confirm, new Object[]{fVarD.L()}), OlaChatGroupListActivity.this.getString(R.string.string_delete), OlaChatGroupListActivity.this.getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaChatGroupListActivity.1.1
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i3) {
                                    if (i3 == 0) {
                                        try {
                                            OlaApplication.b.k(fVarD.j());
                                            h.t.f(fVarD.j());
                                            OlaChatGroupListActivity.this.g.notifyDataSetChanged();
                                        } catch (Throwable unused) {
                                        }
                                    }
                                    try {
                                        dialogInterface.dismiss();
                                    } catch (Throwable unused2) {
                                    }
                                }
                            });
                        }
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
}
