package chat.ola.vn.m;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.widget.DrawerLayout;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.entity.ag;
import chat.ola.vn.n.b;
import chat.ola.vn.room.OlaPublicRoomFilterSettingActivity;
import chat.ola.vn.sms.OlaSmsSendingActivity;
import com.facebook.share.model.AppInviteContent;
import com.facebook.share.widget.AppInviteDialog;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"RtlHardcoded"})
public class l extends a implements AbsListView.OnScrollListener, AdapterView.OnItemClickListener {
    private static int r = -1;
    private static int s = -1;
    private static int t = -1;
    private static int u = -1;
    private static long v;
    private static long w;
    private Animation A;
    private ImageView C;
    Runnable a;
    private ListView b;
    private ListView c;
    private chat.ola.vn.b.y d;
    private chat.ola.vn.b.z e;
    private SwipeRefreshLayout f;
    private View g;
    private TextView h;
    private View i;
    private ImageButton j;
    private TextView k;
    private TextView l;
    private TextView o;
    private DrawerLayout p;
    private Runnable x;
    private Animation y;
    private Animation z;
    private boolean q = false;
    private long B = 0;

    /* JADX INFO: Access modifiers changed from: private */
    public void A() {
        this.q = true;
        if (chat.ola.vn.c.x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.s);
        }
        this.f.setRefreshing(true);
    }

    private void B() {
        if (this.q && chat.ola.vn.c.x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.t);
        }
        this.f.setRefreshing(false);
        this.q = false;
    }

    private void C() {
        if (this.q && chat.ola.vn.c.x.e()) {
            chat.ola.vn.util.n.a(getActivity(), chat.ola.vn.util.c.a.t);
        }
        this.f.setRefreshing(false);
        this.q = false;
    }

    public static void a(Context context) {
        OlaBottomTabActivity.a(context, 14);
    }

    private void a(chat.ola.vn.entity.s sVar) {
        this.b.setTag(null);
        try {
            switch (sVar.h()) {
                case 1:
                default:
                    b(sVar);
                    break;
                case 2:
                case 4:
                    break;
                case 3:
                    chat.ola.vn.entity.k kVar = sVar.a;
                    if (!chat.ola.vn.util.m.a(kVar.h)) {
                        chat.ola.vn.util.b.n(getActivity(), kVar.h);
                        OlaApplication.b.l(kVar.g, "wap");
                    }
                    break;
                case 5:
                    a(true);
                    OlaApplication.b.b((short) 0);
                    break;
                case 6:
                    if (AppInviteDialog.canShow()) {
                        AppInviteDialog.show(getActivity(), new AppInviteContent.Builder().setApplinkUrl("https://fb.me/1199434326766314").setPreviewImageUrl("http://s1.cdn.kaspee.com/ola/preview.jpg").build());
                    }
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    private void a(chat.ola.vn.message.f fVar) {
        int iZ;
        try {
            if (this.A == null) {
                this.A = AnimationUtils.loadAnimation(OlaApplication.a(), R.anim.notify_flick_animation);
            }
        } catch (Throwable unused) {
        }
        if (fVar != null) {
            try {
                iZ = fVar.z();
            } catch (Throwable unused2) {
                return;
            }
        } else {
            iZ = 0;
        }
        if (iZ <= 0) {
            this.A.cancel();
            this.l.setVisibility(8);
        } else {
            this.l.setVisibility(0);
            this.l.setText(chat.ola.vn.util.m.a(iZ));
            this.A.cancel();
            this.j.setAnimation(this.A);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(boolean z) {
        try {
            this.g.setVisibility(z ? 0 : 8);
            if (this.a == null) {
                this.a = new Runnable() { // from class: chat.ola.vn.m.l.3
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            if (l.this.g.getVisibility() == 0) {
                                l.this.g.setVisibility(8);
                            }
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            OlaApplication.c(this.a);
            if (z) {
                OlaApplication.a(this.a, 60000L);
            }
        } catch (Throwable unused) {
        }
    }

    private void b(chat.ola.vn.entity.s sVar) {
        if (sVar == null) {
            return;
        }
        a(true);
        if (!sVar.e()) {
            OlaApplication.b.a(sVar.c(), true, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c(), (short) 0);
            return;
        }
        try {
            String[] strArrD = chat.ola.vn.n.c.a().d();
            if (strArrD != null) {
                if (OlaApplication.b != null) {
                    OlaApplication.b.a(-1L, strArrD[0], strArrD[1], (short) 0);
                    return;
                }
                return;
            }
        } catch (Throwable unused) {
        }
        if (chat.ola.vn.n.b.b(getActivity())) {
            x();
        } else {
            a(false);
            chat.ola.vn.n.b.a(this, 101);
        }
    }

    private void j() {
        try {
            this.b.setOnScrollListener(null);
            int iE = chat.ola.vn.h.x.e();
            if (iE == 0) {
                this.C.setVisibility(4);
            } else {
                this.C.setVisibility(0);
                if (chat.ola.vn.h.x.r()) {
                    this.C.setImageResource(R.drawable.ic_filter_selected);
                } else {
                    this.C.setImageResource(R.drawable.ic_filter_unselected);
                }
            }
            int iIntValue = -1;
            try {
                iIntValue = ((Integer) this.b.getTag()).intValue();
            } catch (Throwable unused) {
            }
            if (iIntValue != iE) {
                if (iE != 0) {
                    this.p.setDrawerLockMode(0, 3);
                    this.k.setText(chat.ola.vn.h.x.j());
                    this.h.setVisibility(0);
                    if (chat.ola.vn.h.x.c()) {
                        this.i.setVisibility(0);
                        this.j.setImageResource(R.drawable.ic_notify_new_chat_group_message);
                    } else if (chat.ola.vn.h.x.k() <= 0) {
                        this.i.setVisibility(0);
                        this.j.setImageResource(R.drawable.ic_map_white);
                    } else {
                        this.i.setVisibility(8);
                    }
                    try {
                        chat.ola.vn.message.f fVarA = chat.ola.vn.h.t.a(chat.ola.vn.h.x.k());
                        if (fVarA != null) {
                            a(fVarA);
                        }
                    } catch (Throwable unused2) {
                    }
                    this.f.setEnabled(true);
                    a(false);
                    this.b.setAdapter((ListAdapter) this.e);
                    this.b.setTag(Integer.valueOf(iE));
                    this.c.setAdapter((ListAdapter) this.d);
                    this.d.notifyDataSetChanged();
                    this.e.notifyDataSetChanged();
                } else {
                    this.p.setDrawerLockMode(1, 3);
                    this.k.setText(R.string.string_chat_room);
                    this.h.setVisibility(4);
                    this.i.setVisibility(8);
                    this.f.setEnabled(true);
                    if (System.currentTimeMillis() - v >= 900000) {
                        v = System.currentTimeMillis();
                        chat.ola.vn.h.x.b();
                    }
                    if (chat.ola.vn.h.x.f() > 0) {
                        a(false);
                    } else {
                        a(true);
                        if (System.currentTimeMillis() - w >= 180000) {
                            w = System.currentTimeMillis();
                            OlaApplication.b.a((short) 0);
                        }
                    }
                    this.b.setAdapter((ListAdapter) this.d);
                    this.b.setTag(Integer.valueOf(iE));
                    this.d.notifyDataSetChanged();
                }
            } else if (iE != 0) {
                a(false);
                this.e.notifyDataSetChanged();
            } else {
                if (chat.ola.vn.h.x.f() > 0) {
                    a(false);
                } else {
                    a(true);
                }
                this.d.notifyDataSetChanged();
            }
            this.b.post(new Runnable() { // from class: chat.ola.vn.m.l.2
                @Override // java.lang.Runnable
                public void run() {
                    l lVar;
                    ListView listView;
                    int i;
                    int i2;
                    try {
                        if (chat.ola.vn.h.x.e() == 1) {
                            if (l.t >= 0) {
                                listView = l.this.b;
                                i = l.t;
                                i2 = l.r;
                                listView.setSelectionFromTop(i, i2);
                            } else {
                                lVar = l.this;
                                lVar.b.setSelection(0);
                            }
                        } else if (l.u >= 0) {
                            listView = l.this.b;
                            i = l.u;
                            i2 = l.s;
                            listView.setSelectionFromTop(i, i2);
                        } else {
                            lVar = l.this;
                            lVar.b.setSelection(0);
                        }
                        l.this.b.postDelayed(new Runnable() { // from class: chat.ola.vn.m.l.2.1
                            @Override // java.lang.Runnable
                            public void run() {
                                l.this.b.setOnScrollListener(l.this);
                            }
                        }, 1000L);
                    } catch (Throwable unused3) {
                    }
                }
            });
        } catch (Throwable unused3) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void v() {
        t = 0;
        r = 0;
        v = System.currentTimeMillis();
        chat.ola.vn.h.x.b();
        OlaApplication.b.c(chat.ola.vn.h.x.k());
        chat.ola.vn.h.b.a(chat.ola.vn.h.a(), (Long) null);
        chat.ola.vn.h.b.a(chat.ola.vn.h.a(), false);
        chat.ola.vn.h.x.d();
        if (System.currentTimeMillis() - this.B > 300000) {
            this.B = System.currentTimeMillis();
            OlaApplication.b.a((short) 0);
        }
        a((chat.ola.vn.message.f) null);
        j();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void x() {
        chat.ola.vn.n.b.a(OlaApplication.a(), 30000L, new b.InterfaceC0042b() { // from class: chat.ola.vn.m.l.6
            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void a(double d, double d2, float f) {
                try {
                    if (d == 0.0d || d2 == 0.0d) {
                        l.this.a(false);
                        chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.dialog_title_inform, R.string.message_map_loading_gps_fail);
                        return;
                    }
                    if (OlaApplication.b != null) {
                        OlaApplication.b.a(-1L, d + "", d2 + "", (short) 0);
                    }
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void j_() {
                try {
                    l.this.a(false);
                    chat.ola.vn.i.i.a(l.this.getActivity(), R.string.dialog_title_fail, R.string.message_not_yet_get_location);
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void k_() {
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void l_() {
                try {
                    l.this.a(false);
                    chat.ola.vn.i.i.a(l.this.getActivity(), R.string.message_location_provider_gps_unavailable_title, R.string.message_location_provider_unavailable, R.string.string_turn_on_gps, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.l.6.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                try {
                                    l.this.getActivity().startActivity(new Intent("android.settings.LOCATION_SOURCE_SETTINGS"));
                                } catch (Throwable unused) {
                                    return;
                                }
                            }
                            dialogInterface.dismiss();
                        }
                    });
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void y() {
        a(false);
        OlaApplication.b.a(chat.ola.vn.h.x.k(), chat.ola.vn.h.b.i(chat.ola.vn.h.a()), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c(), (short) 0);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void z() {
        a(false);
        OlaApplication.b.a((short) 0);
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s2) {
        a(false);
        C();
        if (i != 14) {
            return;
        }
        chat.ola.vn.i.i.a(getActivity(), R.string.dialog_title_confirm, R.string.message_room_full_format, R.string.string_buy_vip, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.l.4
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i2) {
                if (i2 == 0) {
                    try {
                        if (chat.ola.vn.c.x() && chat.ola.vn.util.n.b(l.this.getActivity()) && chat.ola.vn.h.a) {
                            OlaSmsSendingActivity.a(l.this.getActivity());
                        } else {
                            BuyVipActivity.a(l.this.getActivity());
                        }
                    } catch (Throwable unused) {
                        return;
                    }
                }
                dialogInterface.dismiss();
            }
        });
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(long j, String str, String str2, List<chat.ola.vn.message.f> list, List<chat.ola.vn.message.f> list2, short s2) {
        a(false);
        B();
        j();
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(ag agVar, short s2) {
        try {
            super.a(agVar, s2);
            j();
        } catch (Throwable unused) {
        }
    }

    public void a(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
        if (chat.ola.vn.h.x.e() == 1) {
            try {
                if (fVar.k() == 4) {
                    a(fVar);
                    String str = "@" + dVar.i();
                    if (dVar.x()) {
                        this.o.setText(OlaApplication.a(R.string.message_receive_photo_notification2, str));
                        return;
                    }
                    if (dVar.e() == 3) {
                        this.o.setText(OlaApplication.a(R.string.message_receive_sound_notification2, str));
                        return;
                    }
                    if (dVar.e() == 6) {
                        this.o.setText(OlaApplication.a(R.string.message_receive_video_notification2, str));
                        return;
                    }
                    if (dVar.e() == 14) {
                        this.o.setText(str + ": " + OlaApplication.a(R.string.string_sticker));
                    } else {
                        this.o.setText(str + ": " + ((Object) dVar.l()));
                    }
                    this.o.setVisibility(0);
                    try {
                        if (this.y == null) {
                            this.y = AnimationUtils.loadAnimation(getActivity(), R.anim.slide_in_from_right);
                            this.y.setDuration(150L);
                        }
                        this.y.cancel();
                        this.o.startAnimation(this.y);
                    } catch (Throwable unused) {
                    }
                    if (this.x == null) {
                        this.x = new Runnable() { // from class: chat.ola.vn.m.l.7
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    if (l.this.z == null) {
                                        l.this.z = AnimationUtils.loadAnimation(l.this.getActivity(), R.anim.slide_out_to_right);
                                        l.this.z.setDuration(150L);
                                    }
                                    l.this.z.cancel();
                                    l.this.o.startAnimation(l.this.z);
                                } catch (Throwable unused2) {
                                }
                                l.this.o.setVisibility(8);
                            }
                        };
                    }
                    this.b.removeCallbacks(this.x);
                    this.b.postDelayed(this.x, 5000L);
                }
            } catch (Throwable unused2) {
            }
        }
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(Short sh, int i) {
        try {
            super.a(sh, i);
            j();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(List<chat.ola.vn.entity.s> list, short s2) {
        B();
        j();
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        if (chat.ola.vn.h.x.e() != 1) {
            return super.g_();
        }
        chat.ola.vn.i.i.a(getActivity(), getString(R.string.string_quit_room), getString(R.string.string_do_you_want_to_quit_room, chat.ola.vn.h.x.j()), getString(R.string.string_yes), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.l.8
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    try {
                        l.this.v();
                    } catch (Throwable unused) {
                        return;
                    }
                }
                dialogInterface.dismiss();
            }
        });
        return true;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.olaActionBarBackViewLayout /* 2131297180 */:
                    v();
                    break;
                case R.id.olaActionBarMoreButtonImageView /* 2131297185 */:
                    OlaPublicRoomFilterSettingActivity.a(getActivity());
                    break;
                case R.id.olaActionBarTitleViewLayout /* 2131297188 */:
                    this.b.smoothScrollToPosition(0);
                    break;
                case R.id.roomChatMessageBubbleTextView /* 2131297318 */:
                case R.id.roomChatMessageImageButton /* 2131297319 */:
                    if (chat.ola.vn.h.x.k() > 0) {
                        chat.ola.vn.message.f fVarA = chat.ola.vn.h.t.a(chat.ola.vn.h.x.k());
                        if (fVarA == null) {
                            fVarA = OlaApplication.b.d(chat.ola.vn.h.x.k());
                        }
                        fVarA.a(0);
                        a(fVarA);
                        OlaChatViewActivity.a(getActivity(), OlaApplication.b, fVarA, (chat.ola.vn.entity.n) null);
                    } else {
                        h.a(getActivity());
                    }
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        try {
            View viewInflate = layoutInflater.inflate(R.layout.ola_public_room_layout, viewGroup, false);
            this.b = (ListView) viewInflate.findViewById(R.id.roomListView);
            this.p = (DrawerLayout) viewInflate.findViewById(R.id.roomDrawerLayout);
            this.c = (ListView) viewInflate.findViewById(R.id.roomDrawerListView);
            this.f = (SwipeRefreshLayout) viewInflate.findViewById(R.id.roomPullToRefreshLayout);
            this.f.setColorSchemeResources(R.color.colorOlaPrimary);
            this.f.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() { // from class: chat.ola.vn.m.l.1
                @Override // android.support.v4.widget.SwipeRefreshLayout.OnRefreshListener
                public void onRefresh() {
                    l.this.A();
                    try {
                        if (chat.ola.vn.h.x.e() != 1) {
                            l.this.z();
                        } else {
                            l.this.y();
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            this.g = viewInflate.findViewById(R.id.roomProgressBar);
            this.i = viewInflate.findViewById(R.id.roomChatMessageViewLayout);
            this.i.setVisibility(8);
            this.j = (ImageButton) viewInflate.findViewById(R.id.roomChatMessageImageButton);
            this.j.setOnClickListener(this);
            this.k = (TextView) viewInflate.findViewById(R.id.olaActionBarTitleTextView);
            this.l = (TextView) viewInflate.findViewById(R.id.roomUnreadMessageTextView);
            this.o = (TextView) viewInflate.findViewById(R.id.roomChatMessageBubbleTextView);
            this.o.setOnClickListener(this);
            this.h = (TextView) viewInflate.findViewById(R.id.olaActionBarBackViewLayout);
            this.h.setText(R.string.string_back);
            this.h.setOnClickListener(this);
            viewInflate.findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
            this.d = new chat.ola.vn.b.y(getActivity());
            this.e = new chat.ola.vn.b.z(getActivity());
            this.b.setOnItemClickListener(this);
            this.c.setOnItemClickListener(this);
            viewInflate.findViewById(R.id.olaActionBarButtonTextView).setVisibility(8);
            this.C = (ImageView) viewInflate.findViewById(R.id.olaActionBarMoreButtonImageView);
            this.C.setImageResource(R.drawable.ic_filter_selected);
            this.C.setOnClickListener(this);
            return viewInflate;
        } catch (Throwable unused) {
            return new View(getActivity());
        }
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            this.p.closeDrawer(3);
            if (adapterView == this.c || chat.ola.vn.h.x.e() == 0) {
                chat.ola.vn.r.a.f fVar = chat.ola.vn.h.x;
                a(fVar.b(i));
            } else {
                chat.ola.vn.message.f fVarC = chat.ola.vn.h.x.c(i);
                if (fVarC.k() == 6) {
                    return;
                }
                OlaChatViewActivity.a(getActivity(), OlaApplication.b, fVarC);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public void onRequestPermissionsResult(int i, @NonNull String[] strArr, @NonNull int[] iArr) {
        if (i == 101) {
            try {
                if (chat.ola.vn.n.b.b(getActivity())) {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.m.l.5
                        @Override // java.lang.Runnable
                        public void run() {
                            l.this.a(true);
                            l.this.x();
                        }
                    }, 500L);
                } else {
                    chat.ola.vn.i.i.a(getActivity(), R.string.dialog_title_inform, R.string.message_require_location_permission);
                }
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        j();
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        try {
            int top = 0;
            View childAt = this.b.getChildAt(0);
            if (chat.ola.vn.h.x.e() == 1) {
                if (childAt != null) {
                    top = childAt.getTop();
                }
                r = top;
                t = i;
                return;
            }
            if (childAt != null) {
                top = childAt.getTop();
            }
            s = top;
            u = i;
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
    }
}
