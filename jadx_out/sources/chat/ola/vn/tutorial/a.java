package chat.ola.vn.tutorial;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;

/* JADX INFO: loaded from: classes.dex */
public class a extends c implements View.OnClickListener {
    private EditText a;
    private View b;
    private Runnable c;

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        if (this.c == null) {
            this.c = new Runnable() { // from class: chat.ola.vn.tutorial.a.2
                @Override // java.lang.Runnable
                public void run() {
                    a.this.a(false);
                }
            };
        }
        OlaApplication.c(this.c);
        if (!z) {
            this.b.setVisibility(8);
        } else {
            this.b.setVisibility(0);
            OlaApplication.a(this.c, 60000L);
        }
    }

    private void v() {
        try {
            String string = this.a.getText().toString();
            if (!m.a(string) && string.length() >= 6) {
                a(true);
                OlaApplication.b.g(h.b(), string, f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.tutorial.a.1
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 38;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        OlaTutorialActivity olaTutorialActivityJ;
                        String string2;
                        if (i != 10) {
                            if (m.a(str)) {
                                a.this.a(false);
                                olaTutorialActivityJ = a.this.j();
                                string2 = a.this.getString(R.string.message_inform);
                                str = a.this.getString(R.string.message_fail_unknow_reason);
                            } else {
                                a.this.a(false);
                                olaTutorialActivityJ = a.this.j();
                                string2 = a.this.getString(R.string.message_inform);
                            }
                            i.b(olaTutorialActivityJ, string2, str);
                        } else {
                            a.this.a(false);
                            i.a(a.this.j(), R.string.message_inform, R.string.message_fail_password_invalid);
                        }
                        a.this.a.requestFocus();
                        a.this.a.selectAll();
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        try {
                            OlaTutorialActivity.e = false;
                            o.a((Context) a.this.getActivity(), (View) a.this.a, false);
                        } catch (Throwable unused) {
                        }
                        try {
                            a.this.a(false);
                            OlaTutorialActivity olaTutorialActivityJ = a.this.j();
                            if (olaTutorialActivityJ != null) {
                                olaTutorialActivityJ.B();
                            }
                        } catch (Throwable unused2) {
                        }
                    }
                }));
                return;
            }
            i.a(j(), R.string.message_inform, R.string.message_fail_short_password);
            this.a.requestFocus();
            this.a.selectAll();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.tutorial.c
    public c c() {
        try {
            return OlaTutorialActivity.f ? h.t.A() > 0 ? (e) Fragment.instantiate(getActivity(), e.class.getName()) : (b) Fragment.instantiate(getActivity(), b.class.getName()) : (d) Fragment.instantiate(getActivity(), d.class.getName());
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        try {
            return OlaApplication.a(R.string.string_change_password);
        } catch (Throwable unused) {
            return "";
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.nextStepButton) {
                return;
            }
            v();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.tutorial_change_password_layout, (ViewGroup) null);
        this.a = (EditText) viewInflate.findViewById(R.id.txtPassword);
        this.b = viewInflate.findViewById(R.id.loadingProgressBar);
        viewInflate.findViewById(R.id.nextStepButton).setOnClickListener(this);
        return viewInflate;
    }
}
