package chat.ola.vn.contactpicker;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.c.t;
import chat.ola.vn.contactpicker.OlaContactPickerActivity;
import chat.ola.vn.f;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
class a extends BaseAdapter {
    protected LayoutInflater a;
    public OlaContactPickerActivity.c b;
    private final byte c = 0;
    private final byte d = 1;
    private List<b> e;
    private Context f;

    /* JADX INFO: renamed from: chat.ola.vn.contactpicker.a$a, reason: collision with other inner class name */
    private class ViewOnClickListenerC0027a implements View.OnClickListener {
        protected OlaCachedImageView a;
        protected ImageView b;
        protected TextView c;
        protected TextView d;
        protected View e;
        protected View f;
        protected View g;
        private b i;

        protected ViewOnClickListenerC0027a(View view) {
            try {
                this.d = (TextView) view.findViewById(R.id.labelTextView);
            } catch (Throwable unused) {
            }
            try {
                this.g = view.findViewById(R.id.contactSelectionGlobalViewLayout);
                this.a = (OlaCachedImageView) view.findViewById(R.id.contactImageView);
                this.b = (ImageView) view.findViewById(R.id.selectionIconImageView);
                this.c = (TextView) view.findViewById(R.id.contactIdTextView);
                this.f = view.findViewById(R.id.listViewBottomDividerView);
                this.e = view.findViewById(R.id.contactViewLayout);
                this.e.setOnClickListener(this);
            } catch (Throwable unused2) {
            }
        }

        protected void a(b bVar, b bVar2, b bVar3) {
            View view;
            int i;
            try {
                this.i = bVar;
                if (this.i.a == 1) {
                    this.d.setText(bVar.b);
                    return;
                }
                if (this.i == null) {
                    this.a.setImageResource(R.drawable.ic_contact_photo);
                    return;
                }
                if (this.i.f) {
                    this.f.setVisibility(8);
                } else {
                    this.f.setVisibility(0);
                }
                this.e.setTag(this.i);
                if (this.a != null) {
                    t.a().g(this.i.c.j(), this.a);
                }
                try {
                    this.c.setText(this.i.c.L());
                } catch (Throwable unused) {
                }
                if (this.i.d) {
                    this.b.setImageResource(R.drawable.ic_checked);
                    view = this.g;
                    i = f.I;
                } else {
                    this.b.setImageResource(R.drawable.ic_message_sent);
                    view = this.g;
                    i = f.d;
                }
                view.setBackgroundColor(i);
            } catch (Throwable unused2) {
            }
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            try {
                if (view.getId() != R.id.contactViewLayout) {
                    return;
                }
                b bVar = (b) view.getTag();
                bVar.d = !bVar.d;
                if (bVar.d) {
                    this.b.setImageResource(R.drawable.ic_checked);
                    this.g.setBackgroundColor(f.I);
                    if (a.this.b != null) {
                        a.this.b.a(bVar.c);
                        return;
                    }
                    return;
                }
                this.b.setImageResource(R.drawable.ic_message_sent);
                this.g.setBackgroundColor(f.d);
                if (a.this.b != null) {
                    a.this.b.b(bVar.c);
                }
            } catch (Throwable unused) {
            }
        }
    }

    private class b {
        byte a;
        String b;
        chat.ola.vn.message.f c;
        boolean d;
        boolean e;
        boolean f;

        private b() {
            this.a = (byte) 0;
            this.d = false;
            this.e = false;
            this.f = false;
        }
    }

    public a(Context context) {
        this.a = LayoutInflater.from(context);
        this.f = context;
    }

    private void b(List<chat.ola.vn.message.f> list) {
        if (this.e == null) {
            this.e = new ArrayList();
        }
        this.e.clear();
        Collections.sort(list, new chat.ola.vn.e.f());
        int size = list.size();
        b bVar = null;
        char c = '@';
        for (int i = 0; i < size; i++) {
            chat.ola.vn.message.f fVar = list.get(i);
            char cCharAt = fVar.j().charAt(0);
            boolean z = true;
            if (cCharAt != c) {
                b bVar2 = new b();
                bVar2.a = (byte) 1;
                bVar2.b = (cCharAt + "").toUpperCase(Locale.US);
                this.e.add(bVar2);
                if (bVar != null) {
                    bVar.f = true;
                }
                c = cCharAt;
            } else {
                z = false;
            }
            bVar = new b();
            bVar.a = (byte) 0;
            bVar.c = fVar;
            bVar.e = z;
            bVar.f = false;
            this.e.add(bVar);
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public b getItem(int i) {
        try {
            return this.e.get(i);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(chat.ola.vn.message.f fVar) {
        try {
            int size = this.e.size();
            for (int i = 0; i < size; i++) {
                b bVar = this.e.get(i);
                if (bVar.c != null && m.b(bVar.c.j(), fVar.j())) {
                    bVar.d = true;
                    return;
                }
            }
        } catch (Throwable unused) {
        }
    }

    public void a(List<chat.ola.vn.message.f> list) {
        try {
            b(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public int b(chat.ola.vn.message.f fVar) {
        try {
            int size = this.e.size();
            for (int i = 0; i < size; i++) {
                b bVar = this.e.get(i);
                if (bVar.c != null && m.b(bVar.c.j(), fVar.j())) {
                    return i;
                }
            }
            return -1;
        } catch (Throwable unused) {
            return -1;
        }
    }

    @Override // android.widget.Adapter
    public int getCount() {
        try {
            return this.e.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return getItem(i).a;
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewOnClickListenerC0027a viewOnClickListenerC0027a;
        b bVar;
        b bVar2;
        try {
            b bVar3 = this.e.get(i);
            if (view == null) {
                view = bVar3.a == 1 ? this.a.inflate(R.layout.list_view_section_item_layout, (ViewGroup) null) : this.a.inflate(R.layout.contact_item_selection_layout, (ViewGroup) null);
                viewOnClickListenerC0027a = new ViewOnClickListenerC0027a(view);
                view.setTag(viewOnClickListenerC0027a);
            } else {
                try {
                    viewOnClickListenerC0027a = (ViewOnClickListenerC0027a) view.getTag();
                } catch (Throwable th) {
                    ViewOnClickListenerC0027a viewOnClickListenerC0027a2 = new ViewOnClickListenerC0027a(view);
                    view.setTag(viewOnClickListenerC0027a2);
                    th.printStackTrace();
                    viewOnClickListenerC0027a = viewOnClickListenerC0027a2;
                }
            }
            try {
                bVar = this.e.get(i - 1);
            } catch (Throwable unused) {
                bVar = null;
            }
            try {
                bVar2 = this.e.get(i + 1);
            } catch (Throwable unused2) {
                bVar2 = null;
            }
            viewOnClickListenerC0027a.a(bVar3, bVar, bVar2);
            return view;
        } catch (Throwable th2) {
            th2.printStackTrace();
            return view;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 2;
    }
}
