package chat.ola.vn.tutorial;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListAdapter;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.y;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.m.l;
import chat.ola.vn.n.b;
import chat.ola.vn.network.OlaNetworkService;

/* JADX INFO: loaded from: classes.dex */
public class b extends c implements View.OnClickListener, AdapterView.OnItemClickListener {
    private ListView a;
    private y b;
    private Button c;

    private void v() {
        try {
            if (chat.ola.vn.n.b.c(getActivity())) {
                this.c.setTag(true);
                this.c.setText(R.string.string_find_around_you);
            } else {
                this.c.setTag(false);
                this.c.setText(R.string.string_enter_chat_room);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void x() {
        try {
            if (chat.ola.vn.n.c.a().d() != null) {
                j().c(false);
                getActivity().finish();
                l.a(getActivity());
                return;
            }
        } catch (Throwable unused) {
        }
        if (!chat.ola.vn.n.b.b(getActivity())) {
            chat.ola.vn.n.b.a(getActivity(), 0);
        } else {
            j().c(true);
            chat.ola.vn.n.b.a(getActivity(), 30000L, new b.InterfaceC0042b() { // from class: chat.ola.vn.tutorial.b.1
                private void d() {
                    chat.ola.vn.entry.c.e eVar = new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.tutorial.b.1.2
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 17;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                            try {
                                b.this.j().c(false);
                                b.this.getActivity().finish();
                                l.a(b.this.getActivity());
                            } catch (Throwable unused2) {
                            }
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                            try {
                                b.this.j().c(false);
                                b.this.getActivity().finish();
                                l.a(b.this.getActivity());
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                        }
                    };
                    OlaNetworkService olaNetworkService = OlaApplication.b;
                    if (olaNetworkService != null) {
                        olaNetworkService.b(f.a(eVar));
                    }
                }

                @Override // chat.ola.vn.n.b.InterfaceC0042b
                public void a(double d, double d2, float f) {
                    chat.ola.vn.entry.c.e eVar = new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.tutorial.b.1.1
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 17;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                            try {
                                b.this.j().c(false);
                                b.this.getActivity().finish();
                                l.a(b.this.getActivity());
                            } catch (Throwable unused2) {
                            }
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                            try {
                                if (h.x.g() < 10) {
                                    b.this.j().c(true);
                                    b.this.y();
                                } else {
                                    b.this.j().c(false);
                                    b.this.getActivity().finish();
                                    l.a(b.this.getActivity());
                                }
                            } catch (Throwable unused2) {
                            }
                        }
                    };
                    OlaNetworkService olaNetworkService = OlaApplication.b;
                    if (olaNetworkService != null) {
                        olaNetworkService.a(-1L, d + "", d2 + "", f.a(eVar));
                    }
                }

                @Override // chat.ola.vn.n.b.InterfaceC0042b
                public void j_() {
                    d();
                }

                @Override // chat.ola.vn.n.b.InterfaceC0042b
                public void k_() {
                }

                @Override // chat.ola.vn.n.b.InterfaceC0042b
                public void l_() {
                    d();
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void y() {
        j().c(true);
        chat.ola.vn.entry.c.e eVar = new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.tutorial.b.2
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 17;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                try {
                    b.this.j().c(false);
                    b.this.getActivity().finish();
                    l.a(b.this.getActivity());
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                try {
                    b.this.j().c(false);
                    b.this.getActivity().finish();
                    l.a(b.this.getActivity());
                } catch (Throwable unused) {
                }
            }
        };
        OlaNetworkService olaNetworkService = OlaApplication.b;
        if (olaNetworkService != null) {
            olaNetworkService.b(f.a(eVar));
        }
    }

    @Override // chat.ola.vn.tutorial.c
    public c c() {
        return null;
    }

    @Override // chat.ola.vn.tutorial.c
    public String d() {
        try {
            return OlaApplication.a(R.string.string_skip);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.tutorial.c
    public void e() {
        try {
            j().c(false);
            chat.ola.vn.m.e.b(getActivity());
            getActivity().finish();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        try {
            return OlaApplication.a(R.string.general_tab_publicroom);
        } catch (Throwable unused) {
            return "";
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            OlaApplication.b.a("#ola", true, (short) 0);
            OlaApplication.b.a("#apk", true, (short) 0);
            OlaApplication.b.a("#hai", true, (short) 0);
        } catch (Throwable unused) {
        }
        try {
            if (view.getId() != R.id.enterChatRoomButton) {
                return;
            }
            if (((Boolean) view.getTag()).booleanValue()) {
                x();
            } else {
                y();
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.tutorial_finish_layout, viewGroup, false);
        try {
            this.a = (ListView) viewInflate.findViewById(R.id.roomListView);
            this.a.setOnItemClickListener(this);
            this.b = new y(getActivity());
            this.a.setAdapter((ListAdapter) this.b);
            this.b.notifyDataSetChanged();
            this.c = (Button) viewInflate.findViewById(R.id.enterChatRoomButton);
            this.c.setOnClickListener(this);
            v();
        } catch (Throwable unused) {
        }
        return viewInflate;
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            if (chat.ola.vn.n.b.c(getActivity())) {
                x();
            } else {
                y();
            }
        } catch (Throwable unused) {
        }
    }
}
