package chat.ola.vn.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.SpannableStringBuilder;
import android.text.TextWatcher;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.ae;
import chat.ola.vn.c;
import chat.ola.vn.f.a;
import chat.ola.vn.i.s;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.message.f;
import chat.ola.vn.util.g;
import chat.ola.vn.util.h;
import chat.ola.vn.util.i;
import chat.ola.vn.util.m;
import chat.ola.vn.view.AutoScrollTextView;
import chat.ola.vn.view.OlaGalleryView;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ChangeChatGroupTopticDialog extends c implements TextWatcher, View.OnClickListener, AdapterView.OnItemClickListener, a, s.a {
    private EditText e;
    private OlaGalleryView f;
    private ae g;
    private String h = null;
    private ArrayList<String> i;
    private int j;
    private ImageView k;
    private f l;

    private void B() {
        StringBuilder sb = new StringBuilder(this.e.getText().toString());
        String str = null;
        if (this.i != null) {
            for (String str2 : this.i) {
                if (str == null) {
                    str = str2;
                } else {
                    sb.append(" #\u001b" + str2 + "#");
                }
            }
        }
        if (OlaApplication.b != null && this.l != null) {
            String string = sb.toString();
            OlaApplication.b.b(this.l.j(), string, str, (short) 0);
            this.l.d(string);
            this.l.g(str);
        }
        finish();
    }

    public static void a(Context context, String str) {
        Intent intent = new Intent(context, (Class<?>) ChangeChatGroupTopticDialog.class);
        intent.putExtra("_chat_group_id", str);
        context.startActivity(intent);
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    public void a(String str, String str2, String str3) {
        SpannableStringBuilder spannableStringBuilder;
        this.h = str2;
        if (!m.a(str3)) {
            this.i.add(str3);
        }
        if (!m.a(this.h) && (spannableStringBuilder = new SpannableStringBuilder(this.h)) != null && !spannableStringBuilder.equals("")) {
            this.i.addAll(i.b(spannableStringBuilder));
            this.e.setText(i.a(null, i.b(null, g.a().a(h.a().a((CharSequence) i.d(spannableStringBuilder, ""))), chat.ola.vn.q.a.a(), chat.ola.vn.f.a, true), chat.ola.vn.q.a.a(), chat.ola.vn.f.a, true));
        }
        this.f.a();
    }

    @Override // android.text.TextWatcher
    public void afterTextChanged(Editable editable) {
        h.a().a(editable);
    }

    @Override // android.text.TextWatcher
    public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }

    @Override // chat.ola.vn.i.s.a
    public void f(String str) {
        this.i.add(str);
        this.f.a();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id == R.id.btnExit) {
            finish();
        } else {
            if (id != R.id.btnUpdate) {
                return;
            }
            B();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setTheme(R.style.Theme_ola_default_dialog);
        setContentView(R.layout.change_status_dialog_layout);
        getWindow().getAttributes().width = getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
        getWindow().getAttributes().height = -2;
        this.j = getResources().getDimensionPixelSize(R.dimen.metric_96dp);
        this.i = new ArrayList<>();
        Intent intent = getIntent();
        if (intent != null) {
            ArrayList<OlaMediaEntity> parcelableArrayListExtra = getIntent().getParcelableArrayListExtra("extra_media_entry_array_list");
            ArrayList arrayList = new ArrayList();
            if (parcelableArrayListExtra != null) {
                for (OlaMediaEntity olaMediaEntity : parcelableArrayListExtra) {
                    switch (olaMediaEntity.a()) {
                        case 1:
                            if (!this.i.contains(olaMediaEntity.c())) {
                                this.i.add(olaMediaEntity.c());
                            }
                            break;
                        case 2:
                            if (!arrayList.contains(olaMediaEntity.c())) {
                                arrayList.add(olaMediaEntity.c());
                            }
                            break;
                    }
                }
                if (!arrayList.isEmpty()) {
                    s.a(this, this, arrayList, (short) 0);
                }
            }
            String stringExtra = intent.getStringExtra("_chat_group_id");
            if (stringExtra != null) {
                this.l = chat.ola.vn.h.t.e(stringExtra, (short) 2);
            }
        }
        AutoScrollTextView autoScrollTextView = (AutoScrollTextView) findViewById(R.id.txtItemTitle);
        if (autoScrollTextView != null) {
            autoScrollTextView.setText(R.string.string_change_topic);
        }
        this.e = (EditText) findViewById(R.id.txtChatItemStatus);
        this.e.addTextChangedListener(this);
        this.f = (OlaGalleryView) findViewById(R.id.mediaContentView);
        this.f.setOnItemClickListener(this);
        this.f.setChildSpaceRes(R.dimen.metric_8dp);
        this.k = new ImageView(this);
        this.k.setBackgroundResource(R.drawable.btn_solid_image_selector);
        this.k.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        this.k.setImageResource(R.drawable.ic_action_add);
        this.k.setLayoutParams(new LinearLayout.LayoutParams(this.j, this.j));
        this.k.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.activity.ChangeChatGroupTopticDialog.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
            }
        });
        this.f.a(this.k);
        findViewById(R.id.btnUpdate).setOnClickListener(this);
        findViewById(R.id.btnExit).setOnClickListener(this);
        this.g = new ae(this, this.i, this.j);
        this.g.a(new View.OnClickListener() { // from class: chat.ola.vn.activity.ChangeChatGroupTopticDialog.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (ChangeChatGroupTopticDialog.this.i.remove(String.valueOf(view.getTag()))) {
                    ChangeChatGroupTopticDialog.this.g.notifyDataSetChanged();
                    ChangeChatGroupTopticDialog.this.f.a();
                }
            }
        });
        this.f.setAdapter(this.g);
        this.f.post(new Runnable() { // from class: chat.ola.vn.activity.ChangeChatGroupTopticDialog.3
            @Override // java.lang.Runnable
            public void run() {
                ChangeChatGroupTopticDialog.this.f.b();
            }
        });
        if (this.l != null) {
            a(this.l.b(), this.l.d(), this.l.o());
        } else {
            finish();
        }
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
    }

    @Override // android.app.Activity
    protected void onRestoreInstanceState(Bundle bundle) {
        super.onRestoreInstanceState(bundle);
        if (bundle != null && (this.i == null || this.i.isEmpty())) {
            this.i = bundle.getStringArrayList("extra_media_code_array_list");
        }
        this.g.a(this.i);
        this.f.a();
    }

    @Override // android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        if (bundle != null && this.i != null && !this.i.isEmpty()) {
            bundle.putStringArrayList("extra_media_code_array_list", this.i);
        }
        super.onSaveInstanceState(bundle);
    }

    @Override // android.text.TextWatcher
    public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }
}
