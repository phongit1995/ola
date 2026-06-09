package chat.ola.vn.m;

import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Parcelable;
import android.support.v4.app.FragmentActivity;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.ChangeChatGroupTopticDialog;
import chat.ola.vn.activity.ContactFinderActivity;
import chat.ola.vn.activity.OlaAddContactActivity;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaCropImageActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.b.q.a;
import chat.ola.vn.entity.ag;
import chat.ola.vn.i.j;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.me.OlaUserMePageActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import com.facebook.AccessToken;
import com.facebook.login.LoginManager;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class n extends p<e> implements View.OnClickListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener, chat.ola.vn.p.f {
    private OlaQuickTypingSuggestedText a;
    private ListView b;
    private chat.ola.vn.message.g d;
    private ArrayList<String> e;
    private ProgressDialog f;
    private Runnable g;
    private String h = null;
    private Parcelable i = null;
    private int j = -1;
    private int k = -1;
    private chat.ola.vn.b.q l;

    /* JADX INFO: Access modifiers changed from: private */
    public chat.ola.vn.i.f a(final chat.ola.vn.message.f fVar) {
        return chat.ola.vn.i.i.d(getActivity(), getString(R.string.string_quit_group), getString(R.string.message_chatgroup_leave_confirm_format, fVar.b()), getString(R.string.string_quit_group), getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.n.5
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    if (OlaApplication.b != null) {
                        OlaApplication.b.k(fVar.j());
                    }
                    chat.ola.vn.h.t.a(fVar.j(), (short) 2);
                }
                dialogInterface.dismiss();
            }
        });
    }

    private void a(View view) {
        if (view.getTag() != null && (view.getTag() instanceof String) && chat.ola.vn.util.m.a((String) view.getTag(), getString(R.string.string_search))) {
            ContactFinderActivity.a(getActivity());
        }
    }

    private void a(View view, final chat.ola.vn.message.f fVar) {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_change_topic));
        arrayList.add(getString(R.string.string_rename));
        arrayList.add(getString(R.string.string_quit_group));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.n.1
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_change_topic))) {
                        ChangeChatGroupTopticDialog.a(n.this.getActivity(), fVar.j());
                    } else if (!chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_rename)) && chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_quit_group))) {
                        n.this.a(fVar);
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final boolean z) {
        try {
            if (chat.ola.vn.c.c() != null) {
                new chat.ola.vn.i.j(chat.ola.vn.c.c(), z, new j.a() { // from class: chat.ola.vn.m.n.7
                    @Override // chat.ola.vn.i.j.a
                    public void a() {
                        try {
                            chat.ola.vn.util.c.b.f(OlaApplication.a());
                            if (!OlaApplication.b.h()) {
                                if (z) {
                                    OlaApplication.b.l();
                                    chat.ola.vn.c.c().b(true);
                                    return;
                                } else {
                                    chat.ola.vn.c.c().b(true);
                                    OlaApplication.b.k();
                                    return;
                                }
                            }
                            OlaApplication.b.a(false);
                            try {
                                if (AccessToken.getCurrentAccessToken() != null) {
                                    LoginManager.getInstance().logOut();
                                }
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                            chat.ola.vn.h.t.l();
                            OlaApplication.c.b();
                            chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.message_logout_waiting, 3000L, new Runnable() { // from class: chat.ola.vn.m.n.7.1
                                @Override // java.lang.Runnable
                                public void run() {
                                    try {
                                        if (z) {
                                            OlaApplication.b.l();
                                            chat.ola.vn.c.c().b(true);
                                        } else {
                                            chat.ola.vn.c.c().b(true);
                                            OlaApplication.b.k();
                                        }
                                    } catch (Throwable unused) {
                                    }
                                }
                            });
                        } catch (Throwable unused) {
                        }
                    }
                }).show();
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(boolean z) {
        try {
            if (this.g == null) {
                this.g = new Runnable() { // from class: chat.ola.vn.m.n.4
                    @Override // java.lang.Runnable
                    public void run() {
                        n.this.b(false);
                    }
                };
            }
            OlaApplication.c(this.g);
            if (!z) {
                this.f.dismiss();
                return;
            }
            try {
                if (this.f == null) {
                    this.f = chat.ola.vn.i.i.a((Context) getActivity(), (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_checking_account));
                }
                this.f.show();
            } catch (Throwable unused) {
            }
            OlaApplication.a(this.g, 30000L);
        } catch (Throwable unused2) {
        }
    }

    private void e() {
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e(String str) {
        boolean z;
        try {
            if (this.f != null) {
                if (this.f.isShowing()) {
                    return;
                }
            }
        } catch (Throwable unused) {
        }
        try {
            z = chat.ola.vn.h.O.x;
        } catch (Throwable unused2) {
            z = false;
        }
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        String strJ = chat.ola.vn.util.m.j(str);
        b(true);
        if (z && chat.ola.vn.util.m.t(strJ)) {
            OlaApplication.b.a(strJ, new String[]{"name"}, new chat.ola.vn.p.d() { // from class: chat.ola.vn.m.n.2
                @Override // chat.ola.vn.p.d
                public void a(int i) {
                    FragmentActivity activity;
                    int i2;
                    try {
                        n.this.b(false);
                        if (i != 1) {
                            n.this.a.selectAll();
                            activity = n.this.getActivity();
                            i2 = R.string.string_buddy_is_not_exist;
                        } else {
                            n.this.a.selectAll();
                            activity = n.this.getActivity();
                            i2 = R.string.message_fail_phone_number_invalid;
                        }
                        chat.ola.vn.i.i.a(activity, R.string.dialog_title_inform, i2);
                    } catch (Throwable unused3) {
                    }
                }

                @Override // chat.ola.vn.p.d
                public void a(ag agVar) {
                    try {
                        n.this.b(false);
                        OlaChatViewActivity.a((Context) n.this.getActivity(), OlaApplication.b, agVar.c, (short) 0);
                    } catch (Throwable unused3) {
                    }
                }
            });
        } else {
            OlaApplication.b.a(strJ, new chat.ola.vn.p.i() { // from class: chat.ola.vn.m.n.3
                @Override // chat.ola.vn.p.i
                public void a(String str2, boolean z2) {
                    n.this.b(false);
                    try {
                        if (z2) {
                            OlaChatViewActivity.a((Context) n.this.getActivity(), OlaApplication.b, str2, (short) 0);
                        } else {
                            n.this.a.selectAll();
                            chat.ola.vn.i.i.a(n.this.getActivity(), R.string.dialog_title_inform, R.string.string_buddy_is_not_exist);
                        }
                    } catch (Throwable unused3) {
                    }
                }
            });
        }
    }

    private void j() {
        e eVarG;
        try {
            switch (chat.ola.vn.h.t.m()) {
                case 0:
                    try {
                        g().a(true);
                        break;
                    } catch (Throwable unused) {
                    }
                    if (chat.ola.vn.util.m.a(chat.ola.vn.h.a())) {
                        return;
                    }
                    chat.ola.vn.h.t.a((byte) 1);
                    chat.ola.vn.h.a(new Runnable() { // from class: chat.ola.vn.m.n.8
                        @Override // java.lang.Runnable
                        public void run() {
                            if (chat.ola.vn.util.m.a(chat.ola.vn.h.a())) {
                                chat.ola.vn.h.t.a((byte) 0);
                                return;
                            }
                            try {
                                if (chat.ola.vn.h.t.m() == 1) {
                                    final List<chat.ola.vn.message.f> listD = chat.ola.vn.h.b.d(chat.ola.vn.h.a());
                                    final List<chat.ola.vn.message.f> listV = chat.ola.vn.h.b.v(chat.ola.vn.h.a());
                                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.n.8.1
                                        @Override // java.lang.Runnable
                                        public void run() {
                                            if (chat.ola.vn.h.t.m() == 1) {
                                                try {
                                                    n.this.g().a(false);
                                                } catch (Throwable unused2) {
                                                }
                                                if (listD != null) {
                                                    chat.ola.vn.h.t.d(listD);
                                                }
                                                if (listV != null) {
                                                    chat.ola.vn.h.t.j(listV);
                                                }
                                                chat.ola.vn.h.t.a((byte) 2);
                                            }
                                        }
                                    });
                                }
                            } catch (Throwable unused2) {
                            }
                        }
                    });
                    return;
                case 1:
                    eVarG = g();
                    break;
                case 2:
                    eVarG = g();
                    break;
                case 3:
                    eVarG = g();
                    break;
                default:
                    return;
            }
            eVarG.a(false);
        } catch (Throwable unused2) {
        }
    }

    private void v() {
        try {
            g().e();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void C() {
        try {
            if (this.d != null) {
                this.d.notifyDataSetChanged();
            }
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
        if (bundle == null) {
            this.i = null;
            return;
        }
        this.i = bundle.getParcelable("contact_scroll_parcelable");
        this.j = bundle.getInt("contact_scroll_offset");
        this.k = bundle.getInt("contact_scroll_top_position");
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(ag agVar, short s) {
        try {
            super.a(agVar, s);
            c();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.d dVar, byte b, byte b2) {
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, int i, String str, List<chat.ola.vn.message.d> list) {
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
        if (this.d != null) {
            this.d.notifyDataSetChanged();
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, List<chat.ola.vn.message.d> list) {
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(Short sh, int i) {
        try {
            super.a(sh, i);
            c();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a_() {
    }

    @Override // chat.ola.vn.m.p
    public chat.ola.vn.mediastore.a b(Context context) {
        return null;
    }

    @Override // chat.ola.vn.m.f
    public void b(Bundle bundle) {
        super.b(bundle);
        setHasOptionsMenu(false);
        this.d = chat.ola.vn.h.t;
        this.b.setOnItemClickListener(this);
        this.b.setOnItemLongClickListener(this);
        this.b.setAdapter((ListAdapter) this.d);
        chat.ola.vn.h.t.a(this);
        c();
        v();
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
    }

    @Override // chat.ola.vn.p.f
    public void b(Short sh, int i) {
        e();
    }

    @Override // chat.ola.vn.m.p
    public chat.ola.vn.mediastore.a c(Context context) {
        return null;
    }

    public void c() {
        e();
        this.d.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void c(int i) {
        try {
            if (this.d != null) {
                this.d.notifyDataSetChanged();
            }
            v();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void c(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.p.f
    public void c(List<chat.ola.vn.message.f> list) {
        if (this.d != null) {
            this.d.notifyDataSetChanged();
        }
    }

    @Override // chat.ola.vn.p.f
    public void c(boolean z) {
        try {
            if (this.d != null) {
                this.d.notifyDataSetChanged();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void d(chat.ola.vn.message.f fVar) {
        if (this.d != null) {
            this.d.notifyDataSetChanged();
        }
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

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        int i;
        final ArrayList arrayList = new ArrayList();
        try {
            if (chat.ola.vn.h.H > 0) {
                if (chat.ola.vn.h.K <= 3) {
                    i = R.string.string_buy_vip_day;
                }
                arrayList.add(getString(R.string.string_change_ovatar));
                arrayList.add(getString(R.string.string_logout));
                arrayList.add(getString(R.string.string_logout_all));
                chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
                mVar.a(arrayList);
                mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.n.6
                    @Override // android.widget.AdapterView.OnItemClickListener
                    public void onItemClick(AdapterView<?> adapterView, View view, int i2, long j) {
                        n nVar;
                        boolean z;
                        try {
                            String str = (String) arrayList.get(i2);
                            if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_change_ovatar))) {
                                OlaCropImageActivity.c(n.this.getActivity());
                                return;
                            }
                            if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_buy_vip))) {
                                BuyVipActivity.a(n.this.getActivity());
                                return;
                            }
                            if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_buy_vip_day))) {
                                BuyVipActivity.b(n.this.getActivity());
                                return;
                            }
                            if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_logout))) {
                                nVar = n.this;
                                z = false;
                            } else {
                                if (!chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_logout_all))) {
                                    return;
                                }
                                nVar = n.this;
                                z = true;
                            }
                            nVar.a(z);
                        } catch (Throwable unused) {
                        }
                    }
                });
                mVar.show();
                return mVar;
            }
            i = R.string.string_buy_vip;
            chat.ola.vn.i.m mVar2 = new chat.ola.vn.i.m(getActivity());
            mVar2.a(arrayList);
            mVar2.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.n.6
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i2, long j) {
                    n nVar;
                    boolean z;
                    try {
                        String str = (String) arrayList.get(i2);
                        if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_change_ovatar))) {
                            OlaCropImageActivity.c(n.this.getActivity());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_buy_vip))) {
                            BuyVipActivity.a(n.this.getActivity());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_buy_vip_day))) {
                            BuyVipActivity.b(n.this.getActivity());
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_logout))) {
                            nVar = n.this;
                            z = false;
                        } else {
                            if (!chat.ola.vn.util.m.b(str, n.this.getString(R.string.string_logout_all))) {
                                return;
                            }
                            nVar = n.this;
                            z = true;
                        }
                        nVar.a(z);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar2.show();
            return mVar2;
        } catch (Throwable unused) {
            return null;
        }
        arrayList.add(getString(i));
        arrayList.add(getString(R.string.string_change_ovatar));
        arrayList.add(getString(R.string.string_logout));
        arrayList.add(getString(R.string.string_logout_all));
    }

    @Override // chat.ola.vn.m.f
    public boolean i() {
        return true;
    }

    @Override // chat.ola.vn.p.f
    public String i_() {
        if (this.h == null) {
            this.h = "chat.ola.vn.fragment.OlaContactListSection" + System.currentTimeMillis();
        }
        return this.h;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.addContactImageButton /* 2131296302 */:
                    OlaAddContactActivity.a(getActivity());
                    break;
                case R.id.btnInviteFriend /* 2131296470 */:
                    break;
                case R.id.conversationTabLeftButton /* 2131296714 */:
                    a(view);
                    break;
                case R.id.imgItemIcon /* 2131296897 */:
                    chat.ola.vn.message.f fVar = (chat.ola.vn.message.f) view.getTag();
                    short sK = fVar.k();
                    if (sK == 0) {
                        OlaUserMePageActivity.a(getActivity(), fVar.j());
                        break;
                    } else if (sK == 2) {
                        a(view, fVar);
                        break;
                    }
                    break;
                case R.id.imgMediaThumbnail /* 2131296919 */:
                    chat.ola.vn.message.f fVar2 = (chat.ola.vn.message.f) view.getTag();
                    if (!chat.ola.vn.util.m.a(fVar2.d())) {
                        ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) fVar2.d());
                        if (arrayListB.size() == 1) {
                            OlaImageViewerActivity.a(getActivity(), view, (Bitmap) null, 0, OlaMediaEntity.a(arrayListB));
                        }
                    }
                    break;
                case R.id.statusImageView /* 2131297429 */:
                    OlaImageViewerActivity.a(getActivity(), view, (Bitmap) null, 0, OlaMediaEntity.a(this.e));
                    break;
                case R.id.statusMessageTextView /* 2131297430 */:
                    OlaMeComposerActivity.a(getActivity(), chat.ola.vn.c.x.c);
                    break;
                case R.id.vipIconImageView /* 2131297775 */:
                    h_();
                    break;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_contact_list_view_layout, (ViewGroup) null);
        viewInflate.findViewById(R.id.addContactImageButton).setOnClickListener(this);
        this.b = (ListView) viewInflate.findViewById(R.id.lvBuddyList);
        this.b.setOnScrollListener(this);
        try {
            View viewInflate2 = layoutInflater.inflate(R.layout.edit_view_search_layout, (ViewGroup) null);
            this.a = (OlaQuickTypingSuggestedText) viewInflate2.findViewById(R.id.searchSuggestedText);
            try {
                if (chat.ola.vn.h.O.x) {
                    this.a.setHint(R.string.string_enter_nick_or_phone_number_to_chat);
                } else {
                    this.a.setHint(R.string.string_enter_nick_to_chat);
                }
            } catch (Throwable unused) {
                this.a.setHint(R.string.string_enter_nick_to_chat);
            }
            viewInflate2.findViewById(R.id.searchViewLayout).setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.m.n.9
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    try {
                        n.this.a.requestFocus();
                        chat.ola.vn.util.o.a((Context) n.this.getActivity(), (View) n.this.a, true);
                    } catch (Throwable unused2) {
                    }
                }
            });
            this.a.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.m.n.10
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if ((keyEvent == null || keyEvent.getKeyCode() != 66) && i != 3) {
                        return false;
                    }
                    try {
                        n.this.e(n.this.a.getText().toString());
                        n.this.a.setText("");
                        return true;
                    } catch (Throwable unused2) {
                        return false;
                    }
                }
            });
            this.a.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.m.n.11
                @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
                public void b_(String str) {
                    try {
                        n.this.e(str);
                        n.this.a.setText("");
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            });
            this.l = new chat.ola.vn.b.q(getActivity());
            chat.ola.vn.b.q qVar = this.l;
            chat.ola.vn.b.q qVar2 = this.l;
            qVar2.getClass();
            qVar.a(qVar2.new a());
            this.a.setAdapter(this.l);
            this.a.setOnFocusChangeListener(new View.OnFocusChangeListener() { // from class: chat.ola.vn.m.n.12
                @Override // android.view.View.OnFocusChangeListener
                public void onFocusChange(View view, boolean z) {
                    if (z) {
                        try {
                            List<chat.ola.vn.message.f> listE = chat.ola.vn.h.t.e();
                            if (listE == null || listE.size() <= 0) {
                                return;
                            }
                            ArrayList arrayList = new ArrayList();
                            for (chat.ola.vn.message.f fVar : listE) {
                                chat.ola.vn.entity.x xVar = new chat.ola.vn.entity.x();
                                xVar.c = "@" + fVar.j();
                                xVar.b = fVar.b();
                                xVar.a = (byte) 0;
                                arrayList.add(xVar);
                            }
                            n.this.l.a(arrayList);
                            n.this.l.notifyDataSetChanged();
                        } catch (Throwable unused2) {
                        }
                    }
                }
            });
            this.b.addHeaderView(viewInflate2);
        } catch (Throwable unused2) {
        }
        return viewInflate;
    }

    @Override // android.support.v4.app.Fragment
    public void onDestroy() {
        super.onDestroy();
        chat.ola.vn.h.t.b(this);
    }

    @Override // chat.ola.vn.m.p, android.support.v4.app.Fragment
    public void onDetach() {
        super.onDetach();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            if (this.a != null) {
                i--;
            }
            this.d.b(getActivity(), view, i, j);
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AdapterView.OnItemLongClickListener
    public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            if (this.a != null) {
                i--;
            }
            return this.d.a(getActivity(), view, i, j);
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // android.support.v4.app.Fragment
    public void onPause() {
        super.onPause();
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        try {
            chat.ola.vn.h.t.r();
        } catch (Throwable unused) {
        }
        c();
        j();
        try {
            try {
                if (this.i != null) {
                    this.b.onRestoreInstanceState(this.i);
                    this.i = null;
                }
                if (this.j >= 0) {
                    this.b.setSelectionFromTop(this.j, this.k);
                    this.j = -1;
                }
            } catch (Throwable unused2) {
                this.b.setSelection(this.j);
            }
        } catch (Throwable unused3) {
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onSaveInstanceState(Bundle bundle) {
        if (bundle != null && this.b != null) {
            try {
                Parcelable parcelableOnSaveInstanceState = this.b.onSaveInstanceState();
                if (parcelableOnSaveInstanceState != null) {
                    bundle.putParcelable("contact_scroll_parcelable", parcelableOnSaveInstanceState);
                }
                bundle.putInt("contact_scroll_offset", this.b.getFirstVisiblePosition());
                int top = 0;
                View childAt = this.b.getChildAt(0);
                if (childAt != null) {
                    top = childAt.getTop();
                }
                bundle.putInt("contact_scroll_top_position", top);
            } catch (Throwable unused) {
                bundle.putInt("contact_scroll_offset", this.b.getFirstVisiblePosition());
            }
        }
        super.onSaveInstanceState(bundle);
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
    }
}
