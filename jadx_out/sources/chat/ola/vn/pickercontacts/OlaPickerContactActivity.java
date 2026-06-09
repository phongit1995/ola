package chat.ola.vn.pickercontacts;

import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.SparseBooleanArray;
import android.view.View;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaPickerContactActivity extends chat.ola.vn.c implements View.OnClickListener, AbsListView.OnScrollListener {
    private ListView e;
    private EditText f;
    private h g;
    private View h;
    private List<c> i;
    private TextView j;
    private View k;

    public class a extends AsyncTask<Context, Void, List<c>> {
        public a() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public List<c> doInBackground(Context... contextArr) {
            String str;
            if (contextArr == null || contextArr.length == 0) {
                return null;
            }
            int i = 0;
            Context context = contextArr[0];
            if (context == null) {
                return null;
            }
            try {
                Uri uri = ContactsContract.CommonDataKinds.Phone.CONTENT_URI;
                Cursor cursorQuery = context.getContentResolver().query(uri, new String[]{"contact_id", "display_name", "starred"}, null, null, null);
                if (cursorQuery != null) {
                    int columnIndex = cursorQuery.getColumnIndex("display_name");
                    int columnIndex2 = cursorQuery.getColumnIndex("contact_id");
                    ArrayList arrayList = new ArrayList(0);
                    if (cursorQuery.moveToFirst()) {
                        while (true) {
                            c cVar = new c();
                            String string = cursorQuery.getString(columnIndex);
                            long j = cursorQuery.getLong(columnIndex2);
                            cVar.a(j);
                            cVar.a(string);
                            ArrayList arrayList2 = new ArrayList(i);
                            Cursor cursorQuery2 = context.getContentResolver().query(uri, null, "contact_id = " + j, null, null);
                            if (cursorQuery2.moveToFirst()) {
                                str = null;
                                do {
                                    String string2 = cursorQuery2.getString(cursorQuery2.getColumnIndex("data1"));
                                    if (cursorQuery2.getInt(cursorQuery2.getColumnIndex("is_primary")) > 0) {
                                        str = string2;
                                    }
                                    arrayList2.add(string2);
                                } while (cursorQuery2.moveToNext());
                            } else {
                                str = null;
                            }
                            cVar.b(str);
                            cVar.a(arrayList2);
                            arrayList.add(cVar);
                            if (!cursorQuery.moveToNext()) {
                                break;
                            }
                            i = 0;
                        }
                    }
                    cursorQuery.close();
                    return arrayList;
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
            return null;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public void onPostExecute(List<c> list) {
            if (list != null) {
                try {
                    OlaPickerContactActivity.this.i = new ArrayList(list);
                    OlaPickerContactActivity.this.g.a(OlaPickerContactActivity.this.i);
                    OlaPickerContactActivity.this.g.notifyDataSetChanged();
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
            super.onPostExecute(list);
        }
    }

    private void B() {
        try {
            getWindow().setBackgroundDrawable(new ColorDrawable(f()));
            this.k = findViewById(R.id.numberActionWrap);
            findViewById(R.id.btnNumberAction).setOnClickListener(this);
            findViewById(R.id.imgIcon).setOnClickListener(this);
            findViewById(R.id.imgBack).setOnClickListener(this);
            this.j = (TextView) findViewById(R.id.numberActionInfo);
            this.e = (ListView) findViewById(R.id.lvContactList);
            this.e.setDivider(null);
            this.e.setFastScrollEnabled(true);
            this.e.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.pickercontacts.OlaPickerContactActivity.1
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        OlaPickerContactActivity.this.g.c(i);
                        OlaPickerContactActivity.this.C();
                    } catch (Throwable unused) {
                    }
                }
            });
            this.f = (EditText) findViewById(R.id.editSearch);
            findViewById(R.id.btnClearText).setOnClickListener(this);
            this.h = findViewById(R.id.vLinearHeaderIndex);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void C() {
        try {
            int iA = this.g.a();
            if (iA == 0) {
                this.k.setVisibility(8);
                return;
            }
            this.k.setVisibility(0);
            this.j.setText(iA + "");
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void D() {
        if (this.i == null) {
            this.i = new ArrayList(0);
            new a().execute(this);
        }
        this.g = new h(this);
        this.g.a(this.i);
        this.e.setAdapter((ListAdapter) this.g);
        this.e.setOnScrollListener(this);
        this.g.notifyDataSetChanged();
    }

    private void E() {
        this.f.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.pickercontacts.OlaPickerContactActivity.2
            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
                if (OlaPickerContactActivity.this.g != null) {
                    OlaPickerContactActivity.this.g.getFilter().filter(editable);
                }
            }

            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }
        });
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.btnClearText /* 2131296444 */:
                    if (m.a(this.f.getText().toString())) {
                        return;
                    }
                    this.f.setText("");
                    this.g.getFilter().filter("");
                    return;
                case R.id.btnNumberAction /* 2131296513 */:
                    SparseBooleanArray sparseBooleanArrayC = this.g.c();
                    String str = "";
                    for (int i = 0; i < this.g.getCount(); i++) {
                        if (sparseBooleanArrayC.get(i, false)) {
                            str = str + this.g.getItem(i).f() + ";";
                        }
                    }
                    if (m.a(str)) {
                        return;
                    }
                    String strA = OlaApplication.a(R.string.message_sms_content_invite_ola);
                    Intent intent = new Intent("android.intent.action.SENDTO", Uri.parse("smsto:" + str));
                    intent.putExtra("sms_body", strA);
                    startActivity(intent);
                    break;
                case R.id.imgBack /* 2131296867 */:
                case R.id.imgIcon /* 2131296892 */:
                    break;
                case R.id.relativeContactItem /* 2131297303 */:
                    return;
                default:
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
        setContentView(R.layout.contact_list_activity);
        B();
        D();
        E();
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
    }
}
