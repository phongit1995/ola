package chat.ola.vn.countrypicker;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Base64;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class OlaCountryPickerActivity extends chat.ola.vn.c implements View.OnClickListener, Comparator<a> {
    public static c e;
    private EditText f;
    private ListView g;
    private b h;
    private List<a> i;
    private List<a> j;

    private List<a> B() {
        if (this.i != null) {
            return null;
        }
        try {
            this.i = new ArrayList();
            JSONArray jSONArray = new JSONArray(c(this));
            int length = jSONArray.length();
            for (int i = 0; i < length; i++) {
                JSONObject jSONObject = jSONArray.getJSONObject(i);
                String upperCase = jSONObject.getString("countryCode").toUpperCase(Locale.US);
                a aVar = new a();
                aVar.a(upperCase);
                aVar.b(jSONObject.getString("countryName"));
                aVar.c(jSONObject.getString("phoneCode"));
                this.i.add(aVar);
            }
            Collections.sort(this.i, this);
            this.j = new ArrayList();
            this.j.addAll(this.i);
            return this.i;
        } catch (Exception e2) {
            e2.printStackTrace();
            return null;
        }
    }

    public static Map<String, a> a(Context context) {
        try {
            HashMap map = new HashMap();
            JSONArray jSONArray = new JSONArray(c(context));
            int length = jSONArray.length();
            for (int i = 0; i < length; i++) {
                JSONObject jSONObject = jSONArray.getJSONObject(i);
                String upperCase = jSONObject.getString("countryCode").toUpperCase(Locale.US);
                a aVar = new a();
                aVar.a(upperCase);
                aVar.b(jSONObject.getString("countryName"));
                aVar.c(jSONObject.getString("phoneCode"));
                map.put(aVar.a(), aVar);
            }
            return map;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void b(Context context) {
        try {
            Intent intent = new Intent(context, (Class<?>) OlaCountryPickerActivity.class);
            intent.addFlags(1342177280);
            context.startActivity(intent);
            ((Activity) context).overridePendingTransition(R.anim.push_bottom_in, R.anim.push_top_out);
        } catch (Throwable unused) {
        }
    }

    private static String c(Context context) {
        return new String(Base64.decode(context.getResources().getString(R.string.countries), 0), "UTF-8");
    }

    /* JADX INFO: Access modifiers changed from: private */
    @SuppressLint({"DefaultLocale"})
    public void f(String str) {
        this.j.clear();
        for (a aVar : this.i) {
            if (aVar.b().toLowerCase(Locale.ENGLISH).contains(str.toLowerCase())) {
                this.j.add(aVar);
            }
        }
        this.h.notifyDataSetChanged();
    }

    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(a aVar, a aVar2) {
        if (m.b(aVar.c(), "84") && !m.b(aVar2.c(), "84")) {
            return -1;
        }
        if (!m.b(aVar.c(), "84") && m.b(aVar2.c(), "84")) {
            return 1;
        }
        if (m.b(aVar.c(), "84") && m.b(aVar2.c(), "84")) {
            return 0;
        }
        return aVar.b().compareTo(aVar2.b());
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_top_in, R.anim.push_bottom_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() == R.id.olaActionBarBackViewLayout) {
                finish();
            }
            o.a((Context) getParent(), (View) this.f, false);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.country_picker);
        B();
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_select_country);
        this.f = (EditText) findViewById(R.id.searchEditText);
        this.f.setOnFocusChangeListener(new View.OnFocusChangeListener() { // from class: chat.ola.vn.countrypicker.OlaCountryPickerActivity.1
            @Override // android.view.View.OnFocusChangeListener
            public void onFocusChange(View view, boolean z) {
                OlaCountryPickerActivity olaCountryPickerActivity;
                try {
                    LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) OlaCountryPickerActivity.this.f.getLayoutParams();
                    if (z) {
                        layoutParams.width = 0;
                        layoutParams.weight = 1.0f;
                        olaCountryPickerActivity = OlaCountryPickerActivity.this;
                    } else {
                        layoutParams.width = -2;
                        layoutParams.weight = 0.0f;
                        olaCountryPickerActivity = OlaCountryPickerActivity.this;
                    }
                    olaCountryPickerActivity.f.setLayoutParams(layoutParams);
                } catch (Throwable unused) {
                }
            }
        });
        findViewById(R.id.searchViewLayout).setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.countrypicker.OlaCountryPickerActivity.2
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                try {
                    OlaCountryPickerActivity.this.f.requestFocus();
                    o.a((Context) OlaCountryPickerActivity.this, (View) OlaCountryPickerActivity.this.f, true);
                } catch (Throwable unused) {
                }
            }
        });
        this.g = (ListView) findViewById(R.id.country_picker_listview);
        this.h = new b(this, this.j);
        this.g.setAdapter((ListAdapter) this.h);
        this.g.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.countrypicker.OlaCountryPickerActivity.3
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    if (OlaCountryPickerActivity.e != null) {
                        OlaCountryPickerActivity.e.a((a) OlaCountryPickerActivity.this.j.get(i));
                    }
                    OlaCountryPickerActivity.this.finish();
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
        this.f.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.countrypicker.OlaCountryPickerActivity.4
            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
                OlaCountryPickerActivity.this.f(editable.toString());
            }

            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }
        });
    }
}
