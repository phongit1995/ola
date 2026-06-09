package chat.ola.vn.m;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Parcelable;
import android.support.v4.app.FragmentActivity;
import android.text.SpannableString;
import android.text.style.ImageSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.contactpicker.OlaContactPickerActivity;
import chat.ola.vn.i.h;
import chat.ola.vn.me.OlaUserMePageActivity;
import chat.ola.vn.message.OlaChatBlockedListActivity;
import chat.ola.vn.message.OlaOtherPeopleListActivity;
import it.sephiroth.android.library.widget.EnhancedListView;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes.dex */
public class o extends p implements View.OnClickListener, AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener, j.a, OlaContactPickerActivity.b, chat.ola.vn.p.f {
    private EnhancedListView b;
    private View d;
    private chat.ola.vn.b.r e;
    private Parcelable a = null;
    private View f = null;

    private void a(final chat.ola.vn.message.f fVar, final Context context) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(getString(R.string.string_popout_balloon_chat));
            arrayList.add(getString(R.string.string_delete_conversation));
            arrayList.add(getString(R.string.string_copy_nick));
            arrayList.add(getString(R.string.string_block_chat));
            arrayList.add(getString(R.string.string_bad_nick_report));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
            mVar.setTitle(fVar.L());
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.o.6
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        String str = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str, o.this.getString(R.string.string_popout_balloon_chat))) {
                            fVar.a((Boolean) true);
                            if (OlaApplication.c != null) {
                                OlaApplication.c.a(fVar);
                                try {
                                    chat.ola.vn.h.t.c(fVar);
                                } catch (Throwable unused) {
                                }
                                try {
                                    OlaApplication.c.c(fVar);
                                } catch (Throwable unused2) {
                                }
                            }
                        }
                        if (chat.ola.vn.util.m.b(str, o.this.getString(R.string.string_delete_conversation))) {
                            new chat.ola.vn.i.h(o.this.getActivity(), o.this.getString(R.string.dialog_title_delete_conversation), o.this.getString(R.string.message_delete_conversation_confirm), new h.a() { // from class: chat.ola.vn.m.o.6.1
                                @Override // chat.ola.vn.i.h.a
                                public void a(boolean z) {
                                    try {
                                        chat.ola.vn.h.t.a(fVar, z);
                                    } catch (Throwable unused3) {
                                    }
                                }
                            }).show();
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, o.this.getString(R.string.string_copy_nick))) {
                            chat.ola.vn.util.o.a(context, "@" + fVar.j());
                            return;
                        }
                        if (!chat.ola.vn.util.m.b(str, o.this.getString(R.string.string_block_chat))) {
                            if (chat.ola.vn.util.m.b(str, o.this.getString(R.string.string_bad_nick_report))) {
                                chat.ola.vn.i.i.a(o.this.getActivity(), fVar.j());
                                return;
                            }
                            return;
                        }
                        chat.ola.vn.i.i.d(context, o.this.getString(R.string.message_block_chat_title), o.this.getString(R.string.message_block_chat_confirm_format, "@" + fVar.j()), o.this.getString(R.string.string_block), o.this.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.o.6.2
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    try {
                                        if (OlaApplication.b != null) {
                                            OlaApplication.b.l(fVar.j());
                                            chat.ola.vn.h.t.b(fVar);
                                        }
                                    } catch (Throwable th) {
                                        th.printStackTrace();
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        });
                    } catch (Throwable unused3) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    private void a(final chat.ola.vn.message.f fVar, View view, Context context) {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_delete_conversation));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.o.2
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j) {
                try {
                    if (chat.ola.vn.util.m.b((String) arrayList.get(i), o.this.getString(R.string.string_delete_conversation))) {
                        chat.ola.vn.i.i.d(o.this.getActivity(), R.string.dialog_title_delete_conversation, R.string.message_delete_conversation_confirm, R.string.string_yes, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.o.2.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    try {
                                        chat.ola.vn.h.t.b(fVar);
                                    } catch (Throwable th) {
                                        th.printStackTrace();
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        });
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void b(final chat.ola.vn.message.f fVar, View view, Context context) {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_quit_chat_room));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.o.3
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j) {
                try {
                    if (chat.ola.vn.util.m.b((String) arrayList.get(i), o.this.getString(R.string.string_quit_chat_room))) {
                        chat.ola.vn.i.i.d(o.this.getActivity(), o.this.getString(R.string.string_quit_chat_room), o.this.getString(R.string.message_quit_chat_room_confirm, fVar.b()), o.this.getString(R.string.string_yes), o.this.getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.o.3.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    try {
                                        OlaApplication.b.e(Long.parseLong(fVar.j()));
                                        chat.ola.vn.h.t.b(fVar);
                                    } catch (Throwable unused) {
                                        return;
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        });
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void c() {
        this.b.a(new EnhancedListView.b() { // from class: chat.ola.vn.m.o.1
            @Override // it.sephiroth.android.library.widget.EnhancedListView.b
            public EnhancedListView.f a(EnhancedListView enhancedListView, int i) {
                try {
                    final chat.ola.vn.message.f fVarC = chat.ola.vn.h.t.c(i);
                    final int size = 0;
                    try {
                        size = fVarC.F().size();
                    } catch (Throwable unused) {
                    }
                    if (fVarC.k() == 7) {
                        Iterator it2 = new ArrayList(fVarC.F()).iterator();
                        while (it2.hasNext()) {
                            chat.ola.vn.h.t.b((chat.ola.vn.message.f) it2.next());
                        }
                    } else if (fVarC.l()) {
                        chat.ola.vn.h.t.a(fVarC);
                    } else {
                        chat.ola.vn.h.t.b(fVarC);
                    }
                    return new EnhancedListView.f() { // from class: chat.ola.vn.m.o.1.1
                        @Override // it.sephiroth.android.library.widget.EnhancedListView.f
                        public void a() {
                            try {
                                if (fVarC.l()) {
                                    chat.ola.vn.h.t.c(fVarC);
                                    o.this.e.notifyDataSetChanged();
                                }
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                        }

                        @Override // it.sephiroth.android.library.widget.EnhancedListView.f
                        public void b() {
                            try {
                                if (fVarC.l()) {
                                    OlaApplication.b.a(fVarC.j(), fVarC.k(), false);
                                    fVarC.C();
                                }
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                        }

                        @Override // it.sephiroth.android.library.widget.EnhancedListView.f
                        public String c() {
                            if (fVarC.k() == 2) {
                                return o.this.getString(R.string.string_deleted) + " " + fVarC.b();
                            }
                            if (fVarC.k() != 7) {
                                if (fVarC.k() == 0) {
                                    return o.this.getString(R.string.string_deleted) + " " + fVarC.j();
                                }
                                return super.c();
                            }
                            if (size > 1) {
                                return o.this.getString(R.string.string_deleted) + " " + size + " " + OlaApplication.a(R.string.string_persons).toLowerCase(Locale.US);
                            }
                            return o.this.getString(R.string.string_deleted) + " " + size + " " + OlaApplication.a(R.string.string_person).toLowerCase(Locale.US);
                        }
                    };
                } catch (Throwable unused2) {
                    return null;
                }
            }
        });
        this.b.a();
        this.b.a(R.id.conversationContentViewLayout);
        this.b.a(EnhancedListView.UndoStyle.SINGLE_POPUP);
        this.b.a(false);
        this.b.a(180000L);
        this.b.a(EnhancedListView.SwipeDirection.END);
    }

    private void c(final chat.ola.vn.message.f fVar, View view, Context context) {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_popout_balloon_chat));
        arrayList.add(getString(R.string.string_delete_conversation));
        arrayList.add(getString(R.string.string_quit_group));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(fVar.b());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.o.4
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (chat.ola.vn.util.m.b(str, o.this.getString(R.string.string_popout_balloon_chat))) {
                        fVar.a((Boolean) true);
                        if (OlaApplication.c != null) {
                            OlaApplication.c.a(fVar);
                            try {
                                chat.ola.vn.h.t.c(fVar);
                            } catch (Throwable unused) {
                            }
                            OlaApplication.c.c(fVar);
                            return;
                        }
                        return;
                    }
                    if (chat.ola.vn.util.m.b(str, o.this.getString(R.string.string_quit_group))) {
                        chat.ola.vn.i.i.d(o.this.getActivity(), o.this.getString(R.string.string_quit_group), o.this.getString(R.string.message_chatgroup_leave_confirm_format, fVar.b()), o.this.getString(R.string.string_quit_group), o.this.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.o.4.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    try {
                                        if (OlaApplication.b != null) {
                                            OlaApplication.b.k(fVar.j());
                                        }
                                        chat.ola.vn.h.t.a(fVar.j(), (short) 2);
                                    } catch (Throwable unused2) {
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        });
                    } else if (chat.ola.vn.util.m.b(str, o.this.getString(R.string.string_delete_conversation))) {
                        new chat.ola.vn.i.h(o.this.getActivity(), o.this.getString(R.string.dialog_title_delete_conversation), o.this.getString(R.string.message_delete_conversation_confirm), new h.a() { // from class: chat.ola.vn.m.o.4.2
                            @Override // chat.ola.vn.i.h.a
                            public void a(boolean z) {
                                try {
                                    chat.ola.vn.h.t.a(fVar, z);
                                } catch (Throwable unused2) {
                                }
                            }
                        }).show();
                    }
                } catch (Throwable unused2) {
                }
            }
        });
        mVar.show();
    }

    private void d(final chat.ola.vn.message.f fVar, View view, Context context) {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_quit_chat_room));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.o.5
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j) {
                try {
                    if (chat.ola.vn.util.m.b((String) arrayList.get(i), o.this.getString(R.string.string_quit_chat_room))) {
                        chat.ola.vn.i.i.d(o.this.getActivity(), o.this.getString(R.string.string_quit_chat_room), o.this.getString(R.string.message_quit_chat_room_confirm, fVar.b()), o.this.getString(R.string.string_yes), o.this.getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.o.5.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    try {
                                        OlaApplication.b.e(Long.parseLong(fVar.j()));
                                        chat.ola.vn.h.t.b(fVar);
                                    } catch (Throwable unused) {
                                        return;
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        });
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void e() {
        try {
            ((e) g()).e();
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void j() {
        if (this.e != null) {
            this.e.notifyDataSetChanged();
        }
        v();
        x();
        try {
            if (this.b == null || this.a == null) {
                return;
            }
            this.b.onRestoreInstanceState(this.a);
            this.a = null;
        } catch (Throwable unused) {
        }
    }

    private void v() {
        try {
            ((e) g()).a(false);
        } catch (Throwable unused) {
        }
    }

    private void x() {
        if (chat.ola.vn.h.t.j() > 0) {
            this.b.setVisibility(0);
            this.d.setVisibility(8);
        } else {
            this.d.setVisibility(0);
            this.b.setVisibility(8);
        }
    }

    private CharSequence y() {
        String string = getString(R.string.message_free_chat);
        if (string == null) {
            return "";
        }
        SpannableString spannableString = new SpannableString(string);
        Matcher matcher = Pattern.compile("<MESSAGE>").matcher(string);
        while (matcher.find()) {
            try {
                spannableString.setSpan(new ImageSpan(getActivity(), R.drawable.ic_chat, 0), matcher.start(), matcher.end(), 33);
            } catch (Throwable unused) {
            }
        }
        return spannableString;
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        try {
            return !chat.ola.vn.util.m.b(chat.ola.vn.h.t.F(), "null");
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.p.f
    public void C() {
        try {
            this.e.notifyDataSetChanged();
            x();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public boolean H() {
        return false;
    }

    @Override // chat.ola.vn.m.p
    public ArrayList<chat.ola.vn.mediastore.a> a(Context context) {
        return null;
    }

    @Override // chat.ola.vn.m.f
    protected void a(Bundle bundle) {
        super.a(bundle);
        try {
            this.a = null;
            if (bundle != null) {
                this.a = bundle.getParcelable("conversation_scroll_parcelable");
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.d dVar, byte b, byte b2) {
        try {
            this.e.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, int i, String str, List<chat.ola.vn.message.d> list) {
        this.e.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
        this.e.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, List<chat.ola.vn.message.d> list) {
        this.e.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void a_() {
        try {
            this.e.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        try {
            String strF = chat.ola.vn.h.t.F();
            if (chat.ola.vn.util.m.a(strF)) {
                return;
            }
            if (i == 0) {
                this.f.setVisibility(4);
            } else {
                this.f.setVisibility(0);
            }
            OlaApplication.b.w(strF, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.m.o.8
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 73;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    o.this.f.setVisibility(4);
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    o.this.f.setVisibility(4);
                }
            }));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.p
    public chat.ola.vn.mediastore.a b(Context context) {
        return null;
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        try {
            this.e = new chat.ola.vn.b.r(getActivity());
            this.b.setAdapter((ListAdapter) this.e);
            this.e.a(this);
            chat.ola.vn.h.t.a(this);
            e();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar) {
        this.e.notifyDataSetChanged();
        j();
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
    }

    @Override // chat.ola.vn.p.f
    public void b(Short sh, int i) {
    }

    @Override // chat.ola.vn.m.p
    public chat.ola.vn.mediastore.a c(Context context) {
        return null;
    }

    @Override // chat.ola.vn.p.f
    public void c(int i) {
        e();
    }

    @Override // chat.ola.vn.p.f
    public void c(chat.ola.vn.message.f fVar) {
        this.e.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void c(List<chat.ola.vn.message.f> list) {
        this.e.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void c(boolean z) {
        try {
            this.e.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void d(chat.ola.vn.message.f fVar) {
        this.e.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void e(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.p.f
    public void f(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.m.p
    public void f_() {
        try {
            this.b.smoothScrollToPosition(0);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public boolean g(chat.ola.vn.message.f fVar) {
        return false;
    }

    @Override // chat.ola.vn.contactpicker.OlaContactPickerActivity.b
    public void h(List<chat.ola.vn.message.f> list) {
        try {
            if (list.size() == 1) {
                OlaChatViewActivity.a((Context) getActivity(), OlaApplication.b, list.get(0).j(), (short) 0);
                return;
            }
            String str = OlaApplication.a(R.string.string_chat_group) + " " + (list.size() + 1) + " " + OlaApplication.a(R.string.string_members).toLowerCase(Locale.US);
            chat.ola.vn.message.f fVarB = chat.ola.vn.h.t.b(".chatgroup." + System.currentTimeMillis(), (short) 2, true);
            fVarB.c(str);
            fVarB.a(list);
            OlaChatViewActivity.a((Context) getActivity(), OlaApplication.b, fVarB.j(), (short) 2);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_delete_all));
        arrayList.add(getString(chat.ola.vn.c.x.v ? R.string.string_show_strangers : R.string.string_delete_all_stranger));
        arrayList.add(getString(R.string.string_block_list));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.o.7
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                o oVar;
                FragmentActivity activity;
                int i2;
                int i3;
                int i4;
                int i5;
                DialogInterface.OnClickListener onClickListener;
                try {
                    String str = (String) arrayList.get(i);
                    if (chat.ola.vn.util.m.b(o.this.getString(R.string.string_delete_all_stranger), str)) {
                        activity = o.this.getActivity();
                        i2 = R.string.dialog_title_confirm;
                        i3 = R.string.string_delete_all_stranger_convsations_confirm;
                        i4 = R.string.string_delete;
                        i5 = R.string.string_no;
                        onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.o.7.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i6) {
                                if (i6 == 0) {
                                    try {
                                        ArrayList arrayList2 = new ArrayList();
                                        for (int size = chat.ola.vn.h.t.p().size() - 1; size >= 0; size--) {
                                            chat.ola.vn.message.f fVar = chat.ola.vn.h.t.p().get(size);
                                            if (fVar.k() == 0 && !chat.ola.vn.h.t.c(fVar.j())) {
                                                arrayList2.add(fVar);
                                            }
                                        }
                                        chat.ola.vn.h.t.a(arrayList2);
                                        o.this.j();
                                    } catch (Throwable unused) {
                                        return;
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        };
                    } else {
                        if (!chat.ola.vn.util.m.b(o.this.getString(R.string.string_delete_all), str)) {
                            if (chat.ola.vn.util.m.b(o.this.getString(R.string.string_block_list), str)) {
                                OlaChatBlockedListActivity.a(o.this.getActivity());
                                return;
                            }
                            if (chat.ola.vn.util.m.b(o.this.getString(R.string.string_show_strangers), str)) {
                                if (!chat.ola.vn.c.x.v) {
                                    return;
                                }
                                chat.ola.vn.c.x.v = false;
                                chat.ola.vn.h.b.c(chat.ola.vn.h.a(), chat.ola.vn.c.x.v);
                                chat.ola.vn.h.t.c();
                                oVar = o.this;
                            } else {
                                if (!chat.ola.vn.util.m.b(o.this.getString(R.string.string_hide_strangers), str) || chat.ola.vn.c.x.v) {
                                    return;
                                }
                                chat.ola.vn.c.x.v = true;
                                chat.ola.vn.h.b.c(chat.ola.vn.h.a(), chat.ola.vn.c.x.v);
                                chat.ola.vn.h.t.c();
                                oVar = o.this;
                            }
                            oVar.e.notifyDataSetChanged();
                            return;
                        }
                        activity = o.this.getActivity();
                        i2 = R.string.dialog_title_confirm;
                        i3 = R.string.message_delete_all_conversations_confirm;
                        i4 = R.string.string_delete;
                        i5 = R.string.string_no;
                        onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.o.7.2
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i6) {
                                if (i6 == 0) {
                                    try {
                                        if (chat.ola.vn.h.t != null) {
                                            chat.ola.vn.h.t.a();
                                        }
                                        o.this.j();
                                    } catch (Throwable unused) {
                                        return;
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        };
                    }
                    chat.ola.vn.i.i.d(activity, i2, i3, i4, i5, onClickListener);
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return mVar;
    }

    @Override // chat.ola.vn.m.f
    public boolean i() {
        return true;
    }

    @Override // chat.ola.vn.p.f
    public String i_() {
        return getClass().getSimpleName();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.addConversationImageButton) {
                OlaContactPickerActivity.a(getActivity(), this);
                return;
            }
            if (id != R.id.imgItemIcon) {
                return;
            }
            try {
                chat.ola.vn.message.f fVar = (chat.ola.vn.message.f) view.getTag();
                short sK = fVar.k();
                if (sK == 0) {
                    OlaUserMePageActivity.a(getActivity(), fVar.j());
                } else {
                    if (sK != 4) {
                        return;
                    }
                    d(fVar, view, getActivity());
                }
            } catch (Throwable unused) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.conversation_tab_layout, viewGroup, false);
        this.b = (EnhancedListView) viewInflate.findViewById(R.id.conversationListView);
        this.b.setOnItemClickListener(this);
        this.b.setOnItemLongClickListener(this);
        this.d = viewInflate.findViewById(R.id.conversationTipLayout);
        ((TextView) viewInflate.findViewById(R.id.conversationTipTextView)).setText(y());
        viewInflate.findViewById(R.id.addConversationImageButton).setOnClickListener(this);
        try {
            this.f = layoutInflater.inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
            this.f.setVisibility(4);
            this.b.addFooterView(this.f);
            c();
            return viewInflate;
        } catch (Throwable th) {
            th.printStackTrace();
            return viewInflate;
        }
    }

    @Override // chat.ola.vn.m.p, android.support.v4.app.Fragment
    public void onDetach() {
        chat.ola.vn.h.t.b(this);
        super.onDetach();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            chat.ola.vn.message.f fVar = (chat.ola.vn.message.f) adapterView.getAdapter().getItem(i);
            if (fVar != null) {
                if (fVar.k() == 5) {
                    try {
                        if (((chat.ola.vn.message.u) fVar).a(getActivity())) {
                            chat.ola.vn.h.t.b(fVar);
                            return;
                        }
                        return;
                    } catch (Throwable unused) {
                        return;
                    }
                }
                if (fVar.k() == 6) {
                    return;
                }
                if (fVar.k() == 7) {
                    OlaOtherPeopleListActivity.a(getActivity());
                } else {
                    OlaChatViewActivity.a(getActivity(), OlaApplication.b, fVar);
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.widget.AdapterView.OnItemLongClickListener
    public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            chat.ola.vn.message.f fVar = (chat.ola.vn.message.f) adapterView.getAdapter().getItem(i);
            short sK = fVar.k();
            if (sK == 4) {
                b(fVar, view, getActivity());
                return true;
            }
            switch (sK) {
                case 0:
                    a(fVar, getActivity());
                    return true;
                case 1:
                    a(fVar, view, getActivity());
                    return true;
                case 2:
                    c(fVar, view, getActivity());
                    return true;
                default:
                    return false;
            }
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // android.support.v4.app.Fragment
    public void onPause() {
        try {
            this.b.b();
        } catch (Throwable unused) {
        }
        super.onPause();
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        j();
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onSaveInstanceState(Bundle bundle) {
        Parcelable parcelableOnSaveInstanceState;
        if (bundle != null) {
            try {
                if (this.b != null && (parcelableOnSaveInstanceState = this.b.onSaveInstanceState()) != null) {
                    bundle.putParcelable("conversation_scroll_parcelable", parcelableOnSaveInstanceState);
                }
            } catch (Throwable unused) {
            }
        }
        super.onSaveInstanceState(bundle);
    }
}
