package chat.ola.vn.message;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;

/* JADX INFO: loaded from: classes.dex */
public class OlaOtherPeopleListActivity extends chat.ola.vn.c implements View.OnClickListener, AdapterView.OnItemClickListener {
    private ListView e = null;
    private n f = null;

    private void B() {
        this.e = (ListView) findViewById(R.id.visitorListView);
        this.e.setOnItemClickListener(this);
        this.f = new n(this);
        this.e.setAdapter((ListAdapter) this.f);
        TextView textView = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        textView.setText(R.string.string_back);
        textView.setOnClickListener(this);
        TextView textView2 = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        textView2.setText(R.string.string_delete_all);
        textView2.setOnClickListener(this);
        TextView textView3 = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        textView3.setText(R.string.string_other_people);
        textView3.setOnClickListener(this);
    }

    public static void a(Context context) {
        Intent intent = new Intent(context, (Class<?>) OlaOtherPeopleListActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        try {
            this.f.notifyDataSetChanged();
        } catch (Throwable unused) {
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
            if (id == R.id.olaActionBarBackViewLayout) {
                finish();
            } else if (id == R.id.olaActionBarButtonTextView) {
                chat.ola.vn.i.i.d(this, R.string.dialog_title_confirm, R.string.string_delete_all_stranger_convsations_confirm, R.string.string_delete, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.message.OlaOtherPeopleListActivity.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            try {
                                for (int size = chat.ola.vn.h.t.p().size() - 1; size >= 0; size--) {
                                    f fVar = chat.ola.vn.h.t.p().get(size);
                                    if (fVar.k() == 0 && !chat.ola.vn.h.t.c(fVar.j())) {
                                        chat.ola.vn.h.t.b(fVar);
                                    }
                                }
                                OlaOtherPeopleListActivity.this.finish();
                            } catch (Throwable unused) {
                                return;
                            }
                        }
                        dialogInterface.dismiss();
                    }
                });
            } else {
                if (id != R.id.olaActionBarTitleTextView) {
                    return;
                }
                this.e.smoothScrollToPosition(0);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_other_people_list_layout);
        B();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            f fVar = (f) adapterView.getAdapter().getItem(i);
            if (fVar != null) {
                if (fVar.k() == 5) {
                    try {
                        if (((u) fVar).a(this)) {
                            chat.ola.vn.h.t.b(fVar);
                            return;
                        }
                        return;
                    } catch (Throwable unused) {
                        return;
                    }
                }
                if (fVar.k() == 6) {
                    return;
                }
                if (fVar.k() == 7) {
                    a(this);
                } else {
                    OlaChatViewActivity.a(this, OlaApplication.b, fVar);
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
