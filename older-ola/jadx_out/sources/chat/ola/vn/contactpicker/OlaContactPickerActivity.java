package chat.ola.vn.contactpicker;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.b.q;
import chat.ola.vn.b.q.a;
import chat.ola.vn.c.t;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entity.x;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.message.f;
import chat.ola.vn.p.d;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import it.sephiroth.android.library.widget.HListView;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaContactPickerActivity extends chat.ola.vn.c implements View.OnClickListener {
    private static List<f> j;
    private static String k;
    private static b l;
    private a g;
    private q o;
    private ProgressDialog p;
    private Runnable q;
    private OlaQuickTypingSuggestedText e = null;
    private HListView f = null;
    private ListView h = null;
    private chat.ola.vn.contactpicker.a i = null;
    private List<f> m = null;
    private TextView n = null;
    private boolean r = false;

    private class a extends j<f> {
        private LayoutInflater b;

        public a(Context context) {
            super(context);
            this.b = LayoutInflater.from(context);
        }

        @Override // chat.ola.vn.b.j
        public View a(int i, View view, ViewGroup viewGroup) {
            f item = getItem(i);
            if (view == null) {
                view = this.b.inflate(R.layout.avatar_item_40dp_layout, (ViewGroup) null);
                view.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.contactpicker.OlaContactPickerActivity.a.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view2) {
                        try {
                            int iB = OlaContactPickerActivity.this.i.b((f) view2.getTag());
                            if (iB >= 0) {
                                OlaContactPickerActivity.this.h.smoothScrollToPosition(iB);
                            }
                        } catch (Throwable unused) {
                        }
                    }
                });
            }
            t.a().g(item.j(), (OlaCachedImageView) view.findViewById(R.id.avatarImageView));
            view.setTag(item);
            return view;
        }

        @Override // android.widget.Adapter
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public f getItem(int i) {
            try {
                return (f) OlaContactPickerActivity.this.m.get(i);
            } catch (Throwable unused) {
                return null;
            }
        }

        @Override // chat.ola.vn.b.j, android.widget.Adapter
        public int getCount() {
            try {
                return OlaContactPickerActivity.this.m.size();
            } catch (Throwable unused) {
                return 0;
            }
        }

        @Override // android.widget.BaseAdapter, android.widget.Adapter
        public int getItemViewType(int i) {
            return 0;
        }

        @Override // android.widget.BaseAdapter, android.widget.Adapter
        public int getViewTypeCount() {
            return 1;
        }
    }

    public interface b {
        void h(List<f> list);
    }

    interface c {
        void a(f fVar);

        void b(f fVar);
    }

    private void D() {
        this.h = (ListView) findViewById(R.id.contactListView);
        this.f = (HListView) findViewById(R.id.selectedContactListView);
        this.n = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.n.setOnClickListener(this);
        if (m.a(k)) {
            this.n.setVisibility(8);
        } else {
            this.n.setVisibility(0);
            this.n.setText(k);
        }
        this.e = (OlaQuickTypingSuggestedText) findViewById(R.id.contactInputEditText);
        this.h.setOnTouchListener(new View.OnTouchListener() { // from class: chat.ola.vn.contactpicker.OlaContactPickerActivity.1
            @Override // android.view.View.OnTouchListener
            @SuppressLint({"ClickableViewAccessibility"})
            public boolean onTouch(View view, MotionEvent motionEvent) {
                try {
                    o.a((Context) OlaContactPickerActivity.this, (View) OlaContactPickerActivity.this.e, false);
                } catch (Throwable unused) {
                }
                return false;
            }
        });
        try {
            if (h.O.x) {
                this.e.setHint(R.string.string_enter_nick_name_or_phone_number);
            } else {
                this.e.setHint(R.string.string_enter_nick_name);
            }
        } catch (Throwable unused) {
            this.e.setHint(R.string.string_enter_nick_name);
        }
        this.o = new q(this);
        q qVar = this.o;
        q qVar2 = this.o;
        qVar2.getClass();
        qVar.a(qVar2.new a());
        if (j != null) {
            ArrayList arrayList = new ArrayList(j.size());
            for (f fVar : j) {
                x xVar = new x();
                xVar.a = (byte) 0;
                xVar.c = "@" + fVar.j();
                xVar.b = fVar.b();
                arrayList.add(xVar);
            }
            this.o.a(arrayList);
        }
        this.e.setAdapter(this.o);
        this.e.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.contactpicker.OlaContactPickerActivity.2
            @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
            public void b_(String str) {
                try {
                    if (m.a(str)) {
                        return;
                    }
                    OlaContactPickerActivity.this.e.setText("");
                    OlaContactPickerActivity.this.f(str);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
        this.e.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.contactpicker.OlaContactPickerActivity.3
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if ((keyEvent == null || keyEvent.getKeyCode() != 66) && i != 3) {
                    return false;
                }
                try {
                    String string = OlaContactPickerActivity.this.e.getText().toString();
                    OlaContactPickerActivity.this.e.setText("");
                    OlaContactPickerActivity.this.f(string);
                    try {
                        o.a((Context) OlaContactPickerActivity.this, (View) OlaContactPickerActivity.this.e, false);
                    } catch (Throwable unused2) {
                    }
                    return true;
                } catch (Throwable unused3) {
                    return false;
                }
            }
        });
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_select_contacts);
        findViewById(R.id.olaActionBarTitleTextView).setOnClickListener(this);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
    }

    private void E() {
        try {
            if (this.i == null) {
                this.i = new chat.ola.vn.contactpicker.a(this);
                this.i.a(j);
                this.i.b = new c() { // from class: chat.ola.vn.contactpicker.OlaContactPickerActivity.7
                    @Override // chat.ola.vn.contactpicker.OlaContactPickerActivity.c
                    public void a(f fVar) {
                        if (OlaContactPickerActivity.this.m == null) {
                            OlaContactPickerActivity.this.m = new ArrayList(100);
                        }
                        if (!OlaContactPickerActivity.this.m.contains(fVar)) {
                            OlaContactPickerActivity.this.m.add(fVar);
                        }
                        OlaContactPickerActivity.this.F();
                    }

                    @Override // chat.ola.vn.contactpicker.OlaContactPickerActivity.c
                    public void b(f fVar) {
                        if (OlaContactPickerActivity.this.m == null) {
                            return;
                        }
                        if (!OlaContactPickerActivity.this.m.remove(fVar)) {
                            int i = 0;
                            int size = OlaContactPickerActivity.this.m.size();
                            while (true) {
                                if (i >= size) {
                                    break;
                                }
                                if (m.b(fVar.j(), ((f) OlaContactPickerActivity.this.m.get(i)).j())) {
                                    OlaContactPickerActivity.this.m.remove(i);
                                    break;
                                }
                                i++;
                            }
                        }
                        OlaContactPickerActivity.this.F();
                    }
                };
                this.h.setAdapter((ListAdapter) this.i);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F() {
        if (this.m == null || this.m.size() == 0) {
            this.f.setVisibility(8);
            return;
        }
        this.f.setVisibility(0);
        if (this.g == null) {
            this.g = new a(this);
            this.f.setAdapter((ListAdapter) this.g);
        }
        this.g.notifyDataSetChanged();
    }

    public static void a(Context context, b bVar) {
        try {
            a(context, h.t.e(), context.getString(R.string.string_chat), (List<f>) null, (List<f>) null, bVar);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, List<f> list, b bVar) {
        try {
            a(context, h.t.e(), context.getString(R.string.string_invite), (List<f>) null, list, bVar);
        } catch (Throwable unused) {
        }
    }

    private static void a(Context context, List<f> list, String str, List<f> list2, List<f> list3, b bVar) {
        try {
            j = list;
            if (j == null) {
                j = new ArrayList();
            }
            if (j != null && list3 != null) {
                ArrayList arrayList = new ArrayList(list3);
                Iterator<f> it2 = j.iterator();
                while (it2.hasNext()) {
                    f next = it2.next();
                    Iterator it3 = arrayList.iterator();
                    while (true) {
                        if (it3.hasNext()) {
                            if (m.b(next.j(), ((f) it3.next()).j())) {
                                it2.remove();
                                it3.remove();
                                break;
                            }
                        }
                    }
                }
            }
        } catch (Throwable unused) {
        }
        k = str;
        l = bVar;
        Intent intent = new Intent(context, (Class<?>) OlaContactPickerActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_bottom_in, R.anim.push_top_out);
        } catch (Throwable unused2) {
        }
    }

    public static void b(Context context, b bVar) {
        try {
            a(context, h.t.e(), context.getString(R.string.string_add), (List<f>) null, (List<f>) null, bVar);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        try {
            if (this.q == null) {
                this.q = new Runnable() { // from class: chat.ola.vn.contactpicker.OlaContactPickerActivity.4
                    @Override // java.lang.Runnable
                    public void run() {
                        OlaContactPickerActivity.this.c(false);
                    }
                };
            }
            OlaApplication.c(this.q);
            if (!z) {
                this.p.dismiss();
                return;
            }
            try {
                if (this.p == null) {
                    this.p = i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_checking_account));
                }
                this.p.show();
            } catch (Throwable unused) {
            }
            OlaApplication.a(this.q, 30000L);
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void f(String str) {
        boolean z;
        if (m.a(str)) {
            return;
        }
        try {
            if (this.p != null) {
                if (this.p.isShowing()) {
                    return;
                }
            }
        } catch (Throwable unused) {
        }
        try {
            z = h.O.x;
        } catch (Throwable unused2) {
            z = false;
        }
        c(true);
        if (z && m.t(str)) {
            OlaApplication.b.a(str, new String[]{"name"}, new d() { // from class: chat.ola.vn.contactpicker.OlaContactPickerActivity.5
                @Override // chat.ola.vn.p.d
                public void a(int i) {
                    OlaContactPickerActivity olaContactPickerActivity;
                    int i2;
                    try {
                        OlaContactPickerActivity.this.r = false;
                        OlaContactPickerActivity.this.c(false);
                        if (i != 1) {
                            OlaContactPickerActivity.this.e.selectAll();
                            olaContactPickerActivity = OlaContactPickerActivity.this;
                            i2 = R.string.string_buddy_is_not_exist;
                        } else {
                            OlaContactPickerActivity.this.e.selectAll();
                            olaContactPickerActivity = OlaContactPickerActivity.this;
                            i2 = R.string.message_fail_phone_number_invalid;
                        }
                        i.a(olaContactPickerActivity, R.string.dialog_title_inform, i2);
                    } catch (Throwable unused3) {
                    }
                }

                @Override // chat.ola.vn.p.d
                public void a(ag agVar) {
                    try {
                        OlaContactPickerActivity.this.e.setText("");
                        String str2 = agVar.c;
                        OlaContactPickerActivity.this.c(false);
                        f fVar = null;
                        for (f fVar2 : OlaContactPickerActivity.j) {
                            if (m.b(fVar2.j(), str2)) {
                                fVar = fVar2;
                            }
                        }
                        if (fVar == null) {
                            fVar = new f(str2, (short) 0);
                            OlaContactPickerActivity.j.add(fVar);
                            OlaContactPickerActivity.this.i.a(OlaContactPickerActivity.j);
                        }
                        OlaContactPickerActivity.this.i.a(fVar);
                        OlaContactPickerActivity.this.i.notifyDataSetChanged();
                        OlaContactPickerActivity.this.i.b.a(fVar);
                        if (OlaContactPickerActivity.this.r) {
                            OlaContactPickerActivity.l.h(OlaContactPickerActivity.this.m);
                            OlaContactPickerActivity.this.finish();
                        }
                    } catch (Throwable unused3) {
                    }
                }
            });
        } else {
            OlaApplication.b.a(str, new chat.ola.vn.p.i() { // from class: chat.ola.vn.contactpicker.OlaContactPickerActivity.6
                @Override // chat.ola.vn.p.i
                public void a(String str2, boolean z2) {
                    try {
                        OlaContactPickerActivity.this.c(false);
                        if (!z2) {
                            OlaContactPickerActivity.this.r = false;
                            i.a(OlaContactPickerActivity.this, R.string.dialog_title_fail, R.string.string_buddy_is_not_exist);
                            return;
                        }
                        OlaContactPickerActivity.this.e.setText("");
                        f fVar = null;
                        for (f fVar2 : OlaContactPickerActivity.j) {
                            if (m.b(fVar2.j(), str2)) {
                                fVar = fVar2;
                            }
                        }
                        if (fVar == null) {
                            fVar = new f(str2, (short) 0);
                            OlaContactPickerActivity.j.add(fVar);
                            OlaContactPickerActivity.this.i.a(OlaContactPickerActivity.j);
                        }
                        OlaContactPickerActivity.this.i.a(fVar);
                        OlaContactPickerActivity.this.i.notifyDataSetChanged();
                        OlaContactPickerActivity.this.i.b.a(fVar);
                        if (OlaContactPickerActivity.this.r) {
                            OlaContactPickerActivity.l.h(OlaContactPickerActivity.this.m);
                            OlaContactPickerActivity.this.finish();
                        }
                    } catch (Throwable unused3) {
                    }
                }
            });
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        E();
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
            int id = view.getId();
            if (id != R.id.olaActionBarBackViewLayout) {
                if (id != R.id.olaActionBarButtonTextView) {
                    if (id != R.id.olaActionBarTitleTextView) {
                        return;
                    }
                    this.h.smoothScrollToPosition(0);
                    return;
                } else {
                    String string = null;
                    try {
                        string = this.e.getText().toString();
                    } catch (Throwable unused) {
                    }
                    if (!m.a(string)) {
                        this.r = true;
                        f(string);
                        return;
                    }
                    l.h(this.m);
                }
            }
            finish();
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_contact_picker_layout);
        D();
    }
}
