package chat.ola.vn.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.ak;
import chat.ola.vn.c;
import chat.ola.vn.i.m;
import chat.ola.vn.message.f;
import chat.ola.vn.util.o;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ContactFinderActivity extends c implements TextWatcher, View.OnClickListener, AdapterView.OnItemClickListener, ak.b {
    private EditText e;
    private ListView f;
    private ak g;

    private void C() {
        OlaApplication.b(new Runnable() { // from class: chat.ola.vn.activity.ContactFinderActivity.2
            @Override // java.lang.Runnable
            public void run() {
            }
        });
    }

    private void D() {
    }

    public static void a(Context context) {
        try {
            context.startActivity(new Intent(context, (Class<?>) ContactFinderActivity.class));
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(final f fVar) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(getString(R.string.string_chat));
            m mVar = new m(this);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.ContactFinderActivity.3
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        if (chat.ola.vn.util.m.b((String) arrayList.get(i), ContactFinderActivity.this.getString(R.string.string_chat))) {
                            OlaChatViewActivity.a(ContactFinderActivity.this, OlaApplication.b, fVar);
                            ContactFinderActivity.this.finish();
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    private void b(final f fVar) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(getString(R.string.string_chat));
            arrayList.add(getString(R.string.string_view_me));
            arrayList.add(getString(R.string.string_copy_nick));
            m mVar = new m(this);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.ContactFinderActivity.4
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        String str = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str, ContactFinderActivity.this.getString(R.string.string_chat))) {
                            OlaChatViewActivity.a(ContactFinderActivity.this, OlaApplication.b, fVar);
                        } else {
                            if (!chat.ola.vn.util.m.b(str, ContactFinderActivity.this.getString(R.string.string_view_me))) {
                                if (chat.ola.vn.util.m.b(str, ContactFinderActivity.this.getString(R.string.string_copy_nick))) {
                                    o.a(ContactFinderActivity.this, "@" + fVar.j());
                                    return;
                                }
                                return;
                            }
                            chat.ola.vn.me.c.a(ContactFinderActivity.this, OlaApplication.b, fVar.j());
                        }
                        ContactFinderActivity.this.finish();
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    public void B() {
        setContentView(R.layout.contact_finder_fragment_layout);
        findViewById(R.id.actionButtonBack).setOnClickListener(this);
        findViewById(R.id.actionButtonOption).setOnClickListener(this);
        findViewById(R.id.btnInputClear).setOnClickListener(this);
        this.f = (ListView) findViewById(R.id.lvContact);
        this.e = (EditText) findViewById(R.id.txtFilterInput);
        this.e.addTextChangedListener(this);
        this.e.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.ContactFinderActivity.1
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (i == 4) {
                    try {
                        String string = textView.getText().toString();
                        if (!chat.ola.vn.util.m.a(string)) {
                            OlaChatViewActivity.a((Context) ContactFinderActivity.this, OlaApplication.b, string, (short) 0);
                            ContactFinderActivity.this.finish();
                        }
                    } catch (Throwable unused) {
                    }
                }
                return false;
            }
        });
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.b.ak.b
    public void a(boolean z, f fVar) {
        D();
    }

    @Override // android.text.TextWatcher
    public void afterTextChanged(Editable editable) {
    }

    @Override // android.text.TextWatcher
    public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.actionButtonBack) {
                return;
            }
            finish();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        B();
        this.g = new ak(this);
        this.g.a(this);
        this.f.setAdapter((ListAdapter) this.g);
        this.f.setOnItemClickListener(this);
        this.f.setFastScrollEnabled(true);
        C();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        if (adapterView.getAdapter() != null) {
            f fVar = (f) adapterView.getAdapter().getItem(i);
            short sK = fVar.k();
            if (sK == 0) {
                b(fVar);
            } else {
                if (sK != 2) {
                    return;
                }
                a(fVar);
            }
        }
    }

    @Override // android.text.TextWatcher
    public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        try {
            this.g.getFilter().filter(charSequence);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
