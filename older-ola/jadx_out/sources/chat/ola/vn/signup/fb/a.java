package chat.ola.vn.signup.fb;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.c.t;
import chat.ola.vn.e;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class a extends chat.ola.vn.signup.fb.b implements View.OnClickListener {
    private ListView a;
    private View b;
    private C0046a c;
    private List<b> d;
    private String e;
    private chat.ola.vn.network.c f = new chat.ola.vn.network.c() { // from class: chat.ola.vn.signup.fb.a.1
        @Override // chat.ola.vn.network.c
        public void a() {
        }

        @Override // chat.ola.vn.network.c
        public void a(String str) {
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, String str2, String str3) {
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, boolean z) {
        }

        @Override // chat.ola.vn.network.c
        public void a(List<String> list) {
        }

        @Override // chat.ola.vn.network.c
        public void a(short s) {
        }

        @Override // chat.ola.vn.network.c
        public void b() {
        }

        @Override // chat.ola.vn.network.c
        public void b(String str, String str2, String str3) {
            try {
                if (OlaApplication.b != null) {
                    h.d(str);
                    if (!m.a(str2)) {
                        h.b(str2);
                    }
                    h.c(str3);
                    e.a().a(str);
                    e.a().b(str3);
                    if (!m.a(str2)) {
                        chat.ola.vn.h.b.a(OlaApplication.a(), str, str2, str3, null);
                    }
                    OlaApplication.b.b(str);
                    a.this.a(OlaBottomTabActivity.class);
                    a.this.v();
                }
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void b(List<String> list) {
        }

        @Override // chat.ola.vn.network.c
        public void b(short s) {
        }

        @Override // chat.ola.vn.network.c
        public void c() {
        }

        @Override // chat.ola.vn.network.c
        public void d() {
        }
    };

    /* JADX INFO: renamed from: chat.ola.vn.signup.fb.a$a, reason: collision with other inner class name */
    public class C0046a extends j<b> {
        private List<b> b;
        private LayoutInflater c;
        private View.OnClickListener d;

        public C0046a(Context context) {
            super(context);
            this.c = LayoutInflater.from(context);
        }

        /* JADX WARN: Multi-variable type inference failed */
        /* JADX WARN: Type inference failed for: r6v0, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r6v1 */
        /* JADX WARN: Type inference failed for: r6v2 */
        /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.signup.fb.a$c] */
        /* JADX WARN: Type inference failed for: r6v4, types: [chat.ola.vn.signup.fb.a$c] */
        /* JADX WARN: Type inference failed for: r6v5 */
        /* JADX WARN: Type inference failed for: r7v1 */
        /* JADX WARN: Type inference failed for: r7v2, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r7v5 */
        /* JADX WARN: Type inference failed for: r7v6 */
        /* JADX WARN: Type inference failed for: r7v7, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r7v8, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r7v9 */
        @Override // chat.ola.vn.b.j
        public View a(int i, View view, ViewGroup viewGroup) {
            ?? Inflate;
            try {
                if (view == 0) {
                    Inflate = this.c.inflate(R.layout.link_facebook_account_item, viewGroup, false);
                    try {
                        ?? cVar = new c();
                        cVar.a(Inflate);
                        view = cVar;
                        Inflate = Inflate;
                    } catch (Throwable th) {
                        th = th;
                        th.printStackTrace();
                        return Inflate;
                    }
                } else {
                    Inflate = view;
                    view = (c) view.getTag();
                }
                view.a(this.d);
                view.a(this.b.get(i));
                return Inflate;
            } catch (Throwable th2) {
                th = th2;
                Inflate = view;
            }
        }

        @Override // android.widget.Adapter
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public b getItem(int i) {
            try {
                if (this.b != null) {
                    return this.b.get(i);
                }
                return null;
            } catch (Throwable unused) {
                return null;
            }
        }

        public void a(View.OnClickListener onClickListener) {
            this.d = onClickListener;
        }

        public void a(List<b> list) {
            this.b = list;
        }

        @Override // chat.ola.vn.b.j, android.widget.Adapter
        public int getCount() {
            try {
                if (this.b != null) {
                    return this.b.size();
                }
                return 0;
            } catch (Throwable unused) {
                return 0;
            }
        }
    }

    private class b {
        private String b;

        private b() {
        }

        public String a() {
            return this.b;
        }

        public void a(String str) {
            this.b = str;
        }
    }

    private class c {
        private View b;
        private b c;
        private OlaCachedImageView d;
        private TextView e;
        private View.OnClickListener f;

        private c() {
        }

        private void a() {
            try {
                if (this.d != null) {
                    t.a().a(this.c.a(), false, this.d);
                }
            } catch (Throwable unused) {
            }
        }

        public void a(View.OnClickListener onClickListener) {
            this.f = onClickListener;
        }

        public void a(View view) {
            try {
                this.b = view;
                this.d = (OlaCachedImageView) view.findViewById(R.id.imgContactPhoto);
                this.e = (TextView) view.findViewById(R.id.txtNickOla);
                this.b.setTag(this);
            } catch (Throwable unused) {
            }
        }

        public void a(b bVar) {
            try {
                this.c = bVar;
                a();
                this.e.setText(this.c.a());
                View.OnClickListener onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.signup.fb.a.c.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        view.setTag(c.this.c);
                        if (c.this.f != null) {
                            c.this.f.onClick(view);
                        }
                    }
                };
                this.d.setOnClickListener(onClickListener);
                this.e.setOnClickListener(onClickListener);
            } catch (Throwable unused) {
            }
        }
    }

    private void a(View view) {
        try {
            view.findViewById(R.id.btnRegisterWhite).setOnClickListener(this);
            this.b = view.findViewById(R.id.progressBar);
            this.a = (ListView) view.findViewById(R.id.lvFacebookAccountList);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(boolean z) {
        View view;
        int i;
        try {
            if (z) {
                view = this.b;
                i = 0;
            } else {
                view = this.b;
                i = 8;
            }
            view.setVisibility(i);
        } catch (Throwable unused) {
        }
    }

    private void x() {
        this.c = new C0046a(e());
        this.c.a(this);
        if (this.d != null) {
            this.c.a(this.d);
        }
        this.a.setAdapter((ListAdapter) this.c);
    }

    @Override // chat.ola.vn.signup.fb.b
    public chat.ola.vn.signup.fb.b c() {
        try {
            chat.ola.vn.signup.fb.b bVar = (chat.ola.vn.signup.fb.b) Fragment.instantiate(getActivity(), chat.ola.vn.signup.fb.c.class.getName());
            d.a = this.e;
            return bVar;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_linked_account_list);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.btnRegisterWhite) {
                e().B();
            } else if (id == R.id.imgContactPhoto || id == R.id.txtNickOla) {
                a(true);
                chat.ola.vn.l.b.d(this.e, ((b) view.getTag()).a(), this.f);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        try {
            this.e = getArguments().getString("_trust_token");
            String[] stringArray = getArguments().getStringArray("_byte_data");
            this.d = new ArrayList(stringArray.length);
            for (String str : stringArray) {
                b bVar = new b();
                bVar.a(str);
                this.d.add(bVar);
            }
            this.c.a(this.d);
            this.c.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.face_book_account_layout, (ViewGroup) null);
        a(viewInflate);
        x();
        return viewInflate;
    }
}
