package chat.ola.vn.i;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.drawable.ColorDrawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.b.aa;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class m extends n implements View.OnClickListener, AdapterView.OnItemClickListener {
    private ListView a;
    private TextView b;
    private Button c;
    private Button d;
    private View e;
    private View f;
    private DialogInterface.OnClickListener g;
    private a h;
    private AdapterView.OnItemClickListener k;
    private int l;

    private class a extends aa<String> {
        private LayoutInflater a;

        /* JADX INFO: renamed from: chat.ola.vn.i.m$a$a, reason: collision with other inner class name */
        protected class C0030a {
            ImageView a;
            TextView b;

            public C0030a(View view) {
                this.a = (ImageView) view.findViewById(R.id.imgItemIcon);
                this.b = (TextView) view.findViewById(R.id.txtItemTitle);
                view.setTag(this);
            }
        }

        public a(Context context, List<String> list) {
            super(context, list);
            this.a = LayoutInflater.from(context);
        }

        /* JADX WARN: Multi-variable type inference failed */
        /* JADX WARN: Type inference failed for: r0v0 */
        /* JADX WARN: Type inference failed for: r0v1, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r0v4 */
        /* JADX WARN: Type inference failed for: r0v5 */
        /* JADX WARN: Type inference failed for: r0v6 */
        /* JADX WARN: Type inference failed for: r0v8, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r0v9 */
        /* JADX WARN: Type inference failed for: r6v0, types: [android.view.View] */
        /* JADX WARN: Type inference failed for: r6v1 */
        /* JADX WARN: Type inference failed for: r6v2 */
        /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.i.m$a$a] */
        /* JADX WARN: Type inference failed for: r6v9 */
        @Override // chat.ola.vn.b.aa, chat.ola.vn.b.j
        public View a(int i, View view, ViewGroup viewGroup) {
            ?? Inflate;
            ImageView imageView;
            int i2;
            try {
                if (view == 0) {
                    Inflate = this.a.inflate(R.layout.iconable_text_list_item, (ViewGroup) null);
                    try {
                        C0030a c0030a = new C0030a(Inflate);
                        Inflate = Inflate;
                        view = c0030a;
                    } catch (Throwable unused) {
                    }
                } else {
                    Inflate = view;
                    view = (C0030a) view.getTag();
                }
                view.b.setText(a(getItem(i)));
                if (m.this.l < 0) {
                    imageView = view.a;
                    i2 = 8;
                } else if (m.this.l == i) {
                    view.a.setImageResource(R.drawable.ic_star_orange);
                    imageView = view.a;
                    i2 = 0;
                } else {
                    imageView = view.a;
                    i2 = 4;
                }
                imageView.setVisibility(i2);
            } catch (Throwable unused2) {
                Inflate = view;
            }
            return Inflate == 0 ? viewGroup : Inflate;
        }

        @Override // chat.ola.vn.b.aa
        public CharSequence a(String str) {
            return str;
        }
    }

    @TargetApi(14)
    public m(Context context) {
        super(context);
        this.l = -1;
        requestWindowFeature(1);
        setCanceledOnTouchOutside(true);
        if (com.mg.ola.common.d.g.f()) {
            getWindow().setDimAmount(0.7f);
        }
        setContentView(R.layout.list_option_dialog_layout);
        this.a = (ListView) findViewById(R.id.lvListOption);
        this.a.setOnItemClickListener(this);
        this.a.setFadingEdgeLength(0);
        this.a.setCacheColorHint(0);
        this.h = new a(getContext(), null) { // from class: chat.ola.vn.i.m.1
        };
        this.a.setAdapter((ListAdapter) this.h);
        this.a.setDivider(new ColorDrawable(chat.ola.vn.f.w));
        this.a.setDividerHeight(1);
        this.b = (TextView) findViewById(R.id.txtItemTitle);
        this.c = (Button) findViewById(R.id.btnButton1);
        this.d = (Button) findViewById(R.id.btnButton2);
        this.f = findViewById(R.id.linearTitle);
        this.e = findViewById(R.id.linearFooter);
        this.c.setVisibility(8);
        this.d.setVisibility(8);
        this.e.setVisibility(8);
        this.f.setVisibility(8);
        this.c.setOnClickListener(this);
        this.d.setOnClickListener(this);
    }

    public void a(int i) {
        try {
            this.l = i;
            if (this.h != null) {
                this.h.notifyDataSetChanged();
            }
        } catch (Throwable unused) {
        }
    }

    public void a(AdapterView.OnItemClickListener onItemClickListener) {
        this.k = onItemClickListener;
    }

    public void a(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            this.f.setVisibility(8);
        } else {
            this.f.setVisibility(0);
            this.b.setText(str);
        }
    }

    public void a(List<String> list) {
        if (this.h != null) {
            this.h.a((List) list);
            this.h.notifyDataSetChanged();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        DialogInterface.OnClickListener onClickListener;
        int i;
        switch (view.getId()) {
            case R.id.btnButton1 /* 2131296429 */:
                if (this.g == null) {
                    return;
                }
                onClickListener = this.g;
                i = 0;
                break;
            case R.id.btnButton2 /* 2131296430 */:
                if (this.g == null) {
                    return;
                }
                onClickListener = this.g;
                i = 1;
                break;
            default:
                return;
        }
        onClickListener.onClick(this, i);
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            dismiss();
            if (this.k != null) {
                this.k.onItemClick(adapterView, view, i, j);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.app.Dialog
    public void setTitle(CharSequence charSequence) {
        if (chat.ola.vn.util.m.b(charSequence)) {
            this.f.setVisibility(8);
        } else {
            this.f.setVisibility(0);
            this.b.setText(charSequence);
        }
    }

    @Override // chat.ola.vn.i.n, android.app.Dialog
    public void show() {
        try {
            if (this.h != null) {
                this.h.notifyDataSetChanged();
            }
            super.show();
        } catch (Throwable unused) {
        }
    }
}
