package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.graphics.drawable.AnimationDrawable;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Parcelable;
import android.support.v4.widget.DrawerLayout;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Display;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaCropImageActivity;
import chat.ola.vn.b.o;
import chat.ola.vn.b.r;
import chat.ola.vn.b.z;
import chat.ola.vn.c;
import chat.ola.vn.c.x;
import chat.ola.vn.contactpicker.OlaContactPickerActivity;
import chat.ola.vn.entity.ab;
import chat.ola.vn.entity.n;
import chat.ola.vn.entity.w;
import chat.ola.vn.f.a;
import chat.ola.vn.i.m;
import chat.ola.vn.m.l;
import chat.ola.vn.message.OlaOtherPeopleListActivity;
import chat.ola.vn.message.aa;
import chat.ola.vn.message.k;
import chat.ola.vn.message.p;
import chat.ola.vn.message.t;
import chat.ola.vn.message.u;
import chat.ola.vn.n.b;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.p.f;
import chat.ola.vn.tradingvip.OlaTraddingVipActivity;
import chat.ola.vn.transferken.OlaTransferKenActivity;
import chat.ola.vn.u.b;
import chat.ola.vn.util.d.a;
import chat.ola.vn.view.d;
import chat.ola.vn.view.e;
import chat.ola.vn.view.f;
import chat.ola.vn.view.g;
import chat.ola.vn.view.h;
import chat.ola.vn.view.i;
import chat.ola.vn.view.j;
import com.google.android.gms.common.util.CrashUtils;
import com.mg.ola.common.widget.OlaTextView;
import com.mg.ola.common.widget.SoftKeyLinearLayout;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class OlaChatViewActivity extends c implements TextWatcher, View.OnClickListener, View.OnLongClickListener, View.OnTouchListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener, OlaCropImageActivity.a, OlaContactPickerActivity.b, a, f, e.a, f.a, g.e, h.b, i.e, j.a, com.mg.ola.common.widget.a.a {
    private static n Z;
    public static String e;
    public static short f;
    public static int g;
    private TextView A;
    private Animation B;
    private chat.ola.vn.message.f C;
    private View D;
    private Handler F;
    private Runnable G;
    private ListView I;
    private ListView J;
    private r K;
    private z L;
    private SoftKeyLinearLayout M;
    private DrawerLayout N;
    private chat.ola.vn.b.n O;
    private TextView P;
    private ImageButton Q;
    private TextView R;
    private Animation S;
    private Animation T;
    private View U;
    private ImageView V;
    private ImageView W;
    private chat.ola.vn.util.d.a X;
    private View Y;
    private TextView ac;
    private View ad;
    private View af;
    private int am;
    private int an;
    private int ao;
    private ImageButton ap;
    private ImageButton aq;
    private ImageButton ar;
    private ImageButton as;
    private ImageButton at;
    private ImageButton au;
    private FrameLayout av;
    private File ax;
    private chat.ola.vn.i.c ay;
    private int az;
    private o o;
    private ListView p;
    private EditText q;
    private TextView r;
    private ImageView s;
    private FrameLayout t;
    private Button u;
    private ImageButton v;
    private TextView w;
    private TextView x;
    private TextView y;
    private chat.ola.vn.i.c z;
    private String E = null;
    private long H = 0;
    private boolean aa = false;
    private boolean ab = false;
    private int ae = 0;
    private h ag = null;
    private i ah = null;
    private g ai = null;
    private j aj = null;
    private chat.ola.vn.view.f ak = null;
    private d al = null;
    protected Drawable h = null;
    protected boolean i = false;
    int j = 0;
    int k = 0;
    int l = 0;
    private int aw = 0;
    private boolean aA = false;

    /* JADX INFO: renamed from: chat.ola.vn.activity.OlaChatViewActivity$11, reason: invalid class name */
    class AnonymousClass11 implements Runnable {
        final /* synthetic */ aa a;
        final /* synthetic */ String b;
        final /* synthetic */ chat.ola.vn.message.f c;

        AnonymousClass11(aa aaVar, String str, chat.ola.vn.message.f fVar) {
            this.a = aaVar;
            this.b = str;
            this.c = fVar;
        }

        @Override // java.lang.Runnable
        public void run() {
            this.a.b((byte) 4);
            b.a().a(this.b, "mp3", null, new chat.ola.vn.u.o() { // from class: chat.ola.vn.activity.OlaChatViewActivity.11.1
                @Override // chat.ola.vn.u.o
                public void a(int i, int i2) {
                    try {
                        AnonymousClass11.this.a.d(AnonymousClass11.this.b, i, i2);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(final chat.ola.vn.entity.i iVar) {
                    try {
                        AnonymousClass11.this.a.b(AnonymousClass11.this.b, iVar.d());
                        if (AnonymousClass11.this.c.k() == 4) {
                            AnonymousClass11.this.a.b((byte) 2);
                        }
                        short sK = AnonymousClass11.this.c.k();
                        if (sK == 0) {
                            OlaApplication.b.c(AnonymousClass11.this.c.j(), iVar.d(), AnonymousClass11.this.a.p());
                            return;
                        }
                        if (sK == 2) {
                            if (AnonymousClass11.this.c.X()) {
                                OlaChatViewActivity.this.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.11.1.1
                                    @Override // java.lang.Runnable
                                    public void run() {
                                        try {
                                            OlaApplication.b.d(AnonymousClass11.this.c.j(), iVar.d(), AnonymousClass11.this.a.p());
                                        } catch (Throwable unused) {
                                        }
                                    }
                                });
                                return;
                            } else {
                                OlaApplication.b.d(AnonymousClass11.this.c.j(), iVar.d(), AnonymousClass11.this.a.p());
                                return;
                            }
                        }
                        if (sK != 4) {
                            return;
                        }
                        OlaChatViewActivity.this.a(AnonymousClass11.this.c, "##" + iVar.d() + "#", 0, AnonymousClass11.this.a.p());
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str) {
                    try {
                        AnonymousClass11.this.a.p(str);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str, int i) {
                    try {
                        AnonymousClass11.this.a.l(OlaChatViewActivity.this.getString(R.string.message_fail_too_large_image_size));
                        AnonymousClass11.this.a.b((byte) 5);
                        AnonymousClass11.this.a.q(str);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str, int i, String str2) {
                    try {
                        AnonymousClass11.this.a.l(OlaChatViewActivity.this.getString(R.string.message_fail_too_large_file_size));
                        AnonymousClass11.this.a.b((byte) 5);
                        AnonymousClass11.this.a.q(str);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str, String str2) {
                    try {
                        AnonymousClass11.this.a.l(OlaChatViewActivity.this.getString(R.string.message_fail_unsupported_format));
                        AnonymousClass11.this.a.b((byte) 5);
                        AnonymousClass11.this.a.q(str);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void b(String str, String str2) {
                    try {
                        AnonymousClass11.this.a.l(str2);
                        AnonymousClass11.this.a.b((byte) 5);
                        AnonymousClass11.this.a.q(str);
                    } catch (Throwable unused) {
                    }
                }
            });
        }
    }

    /* JADX INFO: renamed from: chat.ola.vn.activity.OlaChatViewActivity$27, reason: invalid class name */
    class AnonymousClass27 implements Runnable {
        final /* synthetic */ p a;
        final /* synthetic */ String b;
        final /* synthetic */ chat.ola.vn.message.f c;

        AnonymousClass27(p pVar, String str, chat.ola.vn.message.f fVar) {
            this.a = pVar;
            this.b = str;
            this.c = fVar;
        }

        @Override // java.lang.Runnable
        public void run() {
            this.a.b((byte) 4);
            b.a().a(this.b, null, new chat.ola.vn.u.o() { // from class: chat.ola.vn.activity.OlaChatViewActivity.27.1
                @Override // chat.ola.vn.u.o
                public void a(int i, int i2) {
                }

                @Override // chat.ola.vn.u.o
                public void a(final chat.ola.vn.entity.i iVar) {
                    p pVar;
                    try {
                        try {
                            chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(AnonymousClass27.this.a.j(), AnonymousClass27.this.a.s());
                            if (fVarD != null && (pVar = (p) fVarD.o(AnonymousClass27.this.a.p())) != null) {
                                List<ab> listA = pVar.a();
                                if (listA != null && listA.size() > 0) {
                                    ab abVar = listA.get(0);
                                    abVar.b = (byte) 0;
                                    abVar.c = iVar.d();
                                }
                                pVar.b(listA);
                                if (AnonymousClass27.this.c.k() == 4) {
                                    AnonymousClass27.this.a.b((byte) 2);
                                }
                            }
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                        short sK = AnonymousClass27.this.c.k();
                        if (sK == 0) {
                            OlaApplication.b.c(AnonymousClass27.this.c.j(), iVar.d(), AnonymousClass27.this.a.p());
                            return;
                        }
                        if (sK == 2) {
                            if (AnonymousClass27.this.c.X()) {
                                OlaChatViewActivity.this.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.27.1.1
                                    @Override // java.lang.Runnable
                                    public void run() {
                                        try {
                                            OlaApplication.b.d(AnonymousClass27.this.c.j(), iVar.d(), AnonymousClass27.this.a.p());
                                        } catch (Throwable unused) {
                                        }
                                    }
                                });
                                return;
                            } else {
                                OlaApplication.b.d(AnonymousClass27.this.c.j(), iVar.d(), AnonymousClass27.this.a.p());
                                return;
                            }
                        }
                        if (sK != 4) {
                            return;
                        }
                        OlaChatViewActivity.this.a(AnonymousClass27.this.c, "##" + iVar.d() + "#", 0, AnonymousClass27.this.a.p());
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str) {
                }

                @Override // chat.ola.vn.u.o
                public void a(String str, int i) {
                    try {
                        AnonymousClass27.this.a.l(OlaChatViewActivity.this.getString(R.string.message_fail_too_large_image_size));
                        AnonymousClass27.this.a.b((byte) 5);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str, int i, String str2) {
                    try {
                        AnonymousClass27.this.a.l(OlaChatViewActivity.this.getString(R.string.message_fail_too_large_file_size));
                        AnonymousClass27.this.a.b((byte) 5);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void a(String str, String str2) {
                    try {
                        AnonymousClass27.this.a.l(OlaChatViewActivity.this.getString(R.string.message_fail_unsupported_format));
                        AnonymousClass27.this.a.b((byte) 5);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.u.o
                public void b(String str, String str2) {
                    try {
                        AnonymousClass27.this.a.l(str2);
                        AnonymousClass27.this.a.b((byte) 5);
                    } catch (Throwable unused) {
                    }
                }
            });
            OlaChatViewActivity.this.o.notifyDataSetChanged();
        }
    }

    private void R() {
        ImageButton imageButton;
        int i;
        this.af = findViewById(R.id.chatAttachmentLayout);
        this.av = (FrameLayout) findViewById(R.id.chatAttachmentFrameLayout);
        this.ap = (ImageButton) findViewById(R.id.quickReplyImageButton);
        this.ap.setOnClickListener(this);
        this.ap.setOnLongClickListener(this);
        if (x.y) {
            imageButton = this.ap;
            i = 0;
        } else {
            imageButton = this.ap;
            i = 8;
        }
        imageButton.setVisibility(i);
        this.aq = (ImageButton) findViewById(R.id.chatTextSmileyImageButton);
        this.aq.setOnClickListener(this);
        View viewFindViewById = findViewById(R.id.cameraImageButton);
        viewFindViewById.setOnClickListener(this);
        viewFindViewById.setOnLongClickListener(this);
        this.ar = (ImageButton) findViewById(R.id.kulImageButton);
        this.ar.setOnClickListener(this);
        this.as = (ImageButton) findViewById(R.id.localPhotoImageButton);
        this.as.setOnClickListener(this);
        this.at = (ImageButton) findViewById(R.id.voiceImageButton);
        this.at.setOnClickListener(this);
        this.au = (ImageButton) findViewById(R.id.moreImageButton);
        this.au.setOnClickListener(this);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void S() {
        if (this.aa) {
            if (x.e()) {
                chat.ola.vn.util.n.a(this, chat.ola.vn.util.c.a.t);
            }
            this.aa = !this.aa;
        }
    }

    @SuppressLint({"ResourceAsColor"})
    private void T() {
        try {
            this.t = (FrameLayout) findViewById(R.id.chatViewGlobalLayout);
            this.N = (DrawerLayout) findViewById(R.id.chatDrawerLayout);
            View viewFindViewById = findViewById(R.id.left_drawer);
            this.I = (ListView) viewFindViewById.findViewById(R.id.leftSliderListView);
            this.R = (TextView) viewFindViewById.findViewById(R.id.leftMenuTitleTextView);
            this.I.setOnItemClickListener(this);
            this.R.setText(R.string.general_tab_conversation);
            View viewFindViewById2 = findViewById(R.id.right_drawer);
            this.J = (ListView) viewFindViewById2.findViewById(R.id.rightSliderListView);
            this.P = (TextView) viewFindViewById2.findViewById(R.id.rightMenuTitleTextView);
            this.Q = (ImageButton) viewFindViewById2.findViewById(R.id.rightMenuAddMemberButton);
            this.Q.setOnClickListener(this);
            this.J.setOnItemClickListener(this);
            this.O = new chat.ola.vn.b.n(this);
            this.J.setAdapter((ListAdapter) this.O);
            this.P.setText(R.string.string_chat_group_member);
            this.M = (SoftKeyLinearLayout) findViewById(R.id.softKeyResizableViewLayout);
            this.M.setOnSoftKeyboardListener(this);
            findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
            this.W = (ImageView) findViewById(R.id.vipIconImageView);
            this.W.setOnClickListener(this);
            this.x = (TextView) findViewById(R.id.olaActionBarTitleTextView);
            this.y = (TextView) findViewById(R.id.olaActionBarSubTitleTextView);
            this.y.setVisibility(8);
            this.D = findViewById(R.id.olaActionBarMoreButtonImageView);
            this.D.setOnClickListener(this);
            this.D.setOnTouchListener(this);
            this.w = (TextView) findViewById(R.id.olaActionBarBackNotificationTextView);
            this.A = (TextView) findViewById(R.id.txtNewMessage);
            this.p = (ListView) findViewById(R.id.lvBubbleList);
            this.p.setOnTouchListener(this);
            this.p.setSelector(new ColorDrawable(0));
            this.p.setOnScrollListener(this);
            this.Y = LayoutInflater.from(this).inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
            this.Y.setBackgroundColor(0);
            this.Y.setLayoutParams(new AbsListView.LayoutParams(-1, getResources().getDimensionPixelSize(R.dimen.metric_72dp) - 2));
            View view = new View(this);
            view.setLayoutParams(new AbsListView.LayoutParams(2, getResources().getDimensionPixelSize(R.dimen.general_list_item_height_small)));
            this.p.addFooterView(view);
            this.p.setTranscriptMode(2);
            this.V = (ImageView) findViewById(R.id.olaActionBarButtonImageView);
            this.V.setVisibility(8);
            this.V.setOnClickListener(this);
            this.U = findViewById(R.id.txtTypingLinear);
            this.U.setVisibility(8);
            this.r = (TextView) findViewById(R.id.txtTypingState);
            this.r.setVisibility(4);
            this.s = (ImageView) findViewById(R.id.imgEditAnimation);
            this.u = (Button) findViewById(R.id.sendTextView);
            this.u.setText(getString(R.string.string_send).toUpperCase(Locale.US));
            this.u.setOnClickListener(this);
            this.v = (ImageButton) findViewById(R.id.likeButton);
            this.v.setOnClickListener(this);
            this.v.setOnLongClickListener(this);
            this.q = (EditText) findViewById(R.id.chatMessageEditText);
            this.q.setOnTouchListener(this);
            this.q.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.39
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if (keyEvent != null && (keyEvent.getKeyCode() == 66 || i == 4)) {
                        OlaChatViewActivity.this.a(OlaChatViewActivity.this.q.getText().toString(), 0, true);
                    }
                    return false;
                }
            });
            this.q.setOnKeyListener(new View.OnKeyListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.40
                @Override // android.view.View.OnKeyListener
                public boolean onKey(View view2, int i, KeyEvent keyEvent) {
                    if (i != 66) {
                        return false;
                    }
                    OlaChatViewActivity.this.a(OlaChatViewActivity.this.q.getText().toString(), 0, true);
                    return true;
                }
            });
            this.A.setOnTouchListener(this);
            findViewById(R.id.olaActionBarBackImageView).setOnClickListener(this);
            this.p.addHeaderView(this.Y);
            am();
            this.ac = (TextView) findViewById(R.id.txtMessageTime);
            R();
            this.ad = findViewById(R.id.scrollDownIndicatorView);
            this.ad.setOnClickListener(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void U() {
        if (Build.VERSION.SDK_INT >= 23 && checkSelfPermission("android.permission.READ_EXTERNAL_STORAGE") != 0) {
            requestPermissions(new String[]{"android.permission.READ_EXTERNAL_STORAGE"}, 103);
            return;
        }
        f(false);
        this.ae = 3;
        if (this.M.a()) {
            return;
        }
        j(false);
    }

    private void V() {
        String string;
        try {
            if (this.C.J != null) {
                this.C.J = null;
                d(true);
                return;
            }
            ArrayList arrayList = new ArrayList();
            if (this.C.J == null || this.C.J.longValue() != Long.MAX_VALUE) {
                arrayList.add(getString(R.string.string_for_mins, new Object[]{"15"}));
                arrayList.add(getString(R.string.string_for_hour, new Object[]{"1"}));
                arrayList.add(getString(R.string.string_for_hours, new Object[]{"8"}));
                arrayList.add(getString(R.string.string_for_hours, new Object[]{"24"}));
                string = getString(R.string.string_mute_until_i_turn_it_back_on);
            } else {
                string = getString(R.string.string_turn_off_mute);
            }
            arrayList.add(string);
            m mVar = new m(this);
            mVar.setTitle(R.string.string_mute_notification);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.4
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    chat.ola.vn.message.f fVar;
                    long jValueOf;
                    OlaChatViewActivity olaChatViewActivity;
                    try {
                        switch (i) {
                            case 0:
                                if (OlaChatViewActivity.this.C.J != null && OlaChatViewActivity.this.C.J.longValue() == Long.MAX_VALUE) {
                                    olaChatViewActivity = OlaChatViewActivity.this;
                                } else {
                                    fVar = OlaChatViewActivity.this.C;
                                    jValueOf = Long.valueOf(System.currentTimeMillis() + 900000);
                                    fVar.J = jValueOf;
                                    OlaChatViewActivity.this.d(true);
                                }
                                break;
                            case 1:
                                fVar = OlaChatViewActivity.this.C;
                                jValueOf = Long.valueOf(System.currentTimeMillis() + 3600000);
                                fVar.J = jValueOf;
                                OlaChatViewActivity.this.d(true);
                            case 2:
                                fVar = OlaChatViewActivity.this.C;
                                jValueOf = Long.valueOf(System.currentTimeMillis() + 28800000);
                                fVar.J = jValueOf;
                                OlaChatViewActivity.this.d(true);
                            case 3:
                                fVar = OlaChatViewActivity.this.C;
                                jValueOf = Long.valueOf(System.currentTimeMillis() + 86400000);
                                fVar.J = jValueOf;
                                OlaChatViewActivity.this.d(true);
                            case 4:
                                fVar = OlaChatViewActivity.this.C;
                                jValueOf = Long.MAX_VALUE;
                                fVar.J = jValueOf;
                                OlaChatViewActivity.this.d(true);
                            default:
                                olaChatViewActivity = OlaChatViewActivity.this;
                                break;
                        }
                        olaChatViewActivity.C.J = null;
                        OlaChatViewActivity.this.d(true);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    private void W() {
        this.N.closeDrawer(3);
        this.N.closeDrawer(5);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void X() {
        try {
            if (this.C == null) {
                return;
            }
            this.o.notifyDataSetChanged();
            ae();
            b(this.q.getText());
            ac();
            Z();
            aa();
            ab();
            am();
            Y();
        } catch (Throwable unused) {
        }
    }

    private void Y() {
        try {
            short sK = this.C.k();
            if (sK == 4) {
                this.af.setVisibility(0);
                this.au.setVisibility(8);
                return;
            }
            switch (sK) {
                case 1:
                    this.af.setVisibility(8);
                    return;
                case 2:
                    this.af.setVisibility(0);
                    break;
                default:
                    this.af.setVisibility(0);
                    break;
            }
            this.au.setVisibility(0);
        } catch (Throwable unused) {
            this.af.setVisibility(0);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Failed to find 'out' block for switch in B:6:0x000b. Please report as an issue. */
    public void Z() {
        if (this.C == null) {
            return;
        }
        switch (this.C.k()) {
        }
        this.o.notifyDataSetChanged();
    }

    public static void a(Context context, OlaNetworkService olaNetworkService, chat.ola.vn.message.f fVar) {
        chat.ola.vn.message.f fVarB;
        if (fVar == null) {
            return;
        }
        chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(fVar.j(), fVar.k());
        if (fVarD == null) {
            boolean z = false;
            if (olaNetworkService != null && fVar.k() != 4) {
                olaNetworkService.c(fVar.j());
                z = true;
            }
            fVarB = chat.ola.vn.h.t.b(fVar.j(), fVar.k(), true);
            fVarB.b(z);
        } else {
            if (!fVarD.S() && olaNetworkService != null) {
                if (fVar.k() != 4) {
                    olaNetworkService.c(fVar.j());
                }
                fVarD.b(true);
            }
            fVarB = fVarD;
        }
        fVarB.b(fVar);
        Intent intent = new Intent(context, (Class<?>) OlaChatViewActivity.class);
        e = fVarB.j();
        f = fVarB.k();
        try {
            context.startActivity(intent);
        } catch (Throwable unused) {
            intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
            context.startActivity(intent);
        }
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused2) {
        }
    }

    public static void a(Context context, OlaNetworkService olaNetworkService, chat.ola.vn.message.f fVar, n nVar) {
        if (fVar == null) {
            return;
        }
        Z = nVar;
        Intent intent = new Intent(context, (Class<?>) OlaChatViewActivity.class);
        e = fVar.j();
        f = fVar.k();
        try {
            context.startActivity(intent);
        } catch (Throwable unused) {
            intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
            context.startActivity(intent);
        }
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused2) {
        }
    }

    public static void a(Context context, OlaNetworkService olaNetworkService, String str, short s) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        a(context, olaNetworkService, chat.ola.vn.h.t.b(str, s, true));
    }

    public static void a(Context context, String str) {
        a(context, OlaApplication.b, str, (short) 0);
    }

    private void a(chat.ola.vn.message.f fVar) {
        EditText editText;
        String string;
        try {
            if (fVar == null) {
                finish();
                return;
            }
            if (chat.ola.vn.h.t.d(fVar.j(), fVar.k()) == null) {
                fVar = chat.ola.vn.h.t.c(fVar);
            }
            ad();
            if (fVar.F == null && fVar.k() == 0) {
                try {
                    OlaApplication.b.p(fVar.j(), chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaChatViewActivity.34
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 48;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                            try {
                                if (chat.ola.vn.util.m.b((String) objArr[0], OlaChatViewActivity.this.C.j())) {
                                    OlaChatViewActivity.this.C.F = true;
                                    OlaChatViewActivity.this.Z();
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }));
                } catch (Throwable unused) {
                }
            }
            this.C = fVar;
            this.o.a(this.C);
            chat.ola.vn.h.t.t();
            this.C.a(0);
            this.C.A();
            e(false);
            if (chat.ola.vn.h.g() && this.C.V == 0 && !chat.ola.vn.util.m.a(chat.ola.vn.h.a())) {
                try {
                    if (this.C.k() == 2 && !this.C.X()) {
                        e(true);
                        if (OlaApplication.b.h(this.C.j(), null, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaChatViewActivity.36
                            @Override // chat.ola.vn.entry.c.e
                            public short a() {
                                return (short) 55;
                            }

                            @Override // chat.ola.vn.entry.c.e
                            public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                                OlaChatViewActivity.this.e(false);
                            }

                            @Override // chat.ola.vn.entry.c.e
                            public void a(Object... objArr) {
                                OlaChatViewActivity.this.e(false);
                            }
                        }))) {
                            this.C.V = (byte) 1;
                            this.C.O = null;
                            this.C.Q = true;
                        } else {
                            e(false);
                        }
                    } else if (this.C.k() == 0) {
                        e(true);
                        if (OlaApplication.b.i(this.C.j(), null, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaChatViewActivity.37
                            @Override // chat.ola.vn.entry.c.e
                            public short a() {
                                return (short) 55;
                            }

                            @Override // chat.ola.vn.entry.c.e
                            public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                                OlaChatViewActivity.this.e(false);
                            }

                            @Override // chat.ola.vn.entry.c.e
                            public void a(Object... objArr) {
                                OlaChatViewActivity.this.e(false);
                            }
                        }))) {
                            this.C.V = (byte) 1;
                            this.C.O = null;
                            this.C.Q = true;
                        } else {
                            e(false);
                        }
                    } else {
                        this.C.V = (byte) 2;
                        this.C.O = null;
                        this.C.Q = false;
                    }
                } catch (Throwable unused2) {
                    e(false);
                }
            }
            X();
            this.Q.setVisibility(8);
            short sK = this.C.k();
            if (sK == 0) {
                this.R.setText(R.string.general_tab_conversation);
                this.I.setAdapter((ListAdapter) this.K);
                this.K.notifyDataSetChanged();
                this.Q.setVisibility(0);
                editText = this.q;
                string = getString(R.string.string_write_a_message_to) + " " + this.C.j();
            } else if (sK == 2) {
                this.R.setText(R.string.general_tab_conversation);
                this.P.setText(R.string.string_member_list);
                this.Q.setVisibility(0);
                this.I.setAdapter((ListAdapter) this.K);
                this.K.notifyDataSetChanged();
                editText = this.q;
                string = getString(R.string.string_write_a_message_group, new Object[]{this.C.L()});
            } else {
                if (sK != 4) {
                    this.R.setText(R.string.general_tab_conversation);
                    this.I.setAdapter((ListAdapter) this.K);
                    this.K.notifyDataSetChanged();
                    this.q.setHint(R.string.string_write_a_message);
                    return;
                }
                this.P.setText(R.string.string_broadcasting_members);
                editText = this.q;
                string = getString(R.string.string_write_a_message_room, new Object[]{this.C.b()});
            }
            editText.setHint(string);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final chat.ola.vn.message.f fVar, final String str, final int i, final String str2) {
        if (this.C == null) {
            return;
        }
        if (this.C.k() == 2 && this.C.X()) {
            a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.10
                @Override // java.lang.Runnable
                public void run() {
                    OlaChatViewActivity.this.b(fVar, str, i, str2);
                }
            });
        } else {
            b(fVar, str, i, str2);
        }
    }

    private void a(CharSequence charSequence) {
        this.q.removeTextChangedListener(this);
        this.q.setText(charSequence);
        this.q.setSelection(this.q.length());
        this.q.addTextChangedListener(this);
        b(charSequence);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final Runnable runnable) {
        String[] strArr;
        String string;
        try {
            final ProgressDialog progressDialogA = chat.ola.vn.i.i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_create_chatgroup));
            List<chat.ola.vn.message.f> listF = this.C.F();
            String strA = OlaApplication.a(R.string.string_chat_group);
            if (listF == null || listF.size() <= 0) {
                strArr = null;
                string = strA;
            } else {
                StringBuilder sb = new StringBuilder();
                sb.append(OlaApplication.a(R.string.string_chat_group));
                sb.append(" ");
                sb.append(listF.size() + 1);
                sb.append(" ");
                sb.append(OlaApplication.a(R.string.string_members).toLowerCase(Locale.US));
                string = sb.toString();
                strArr = new String[listF.size()];
                strArr[0] = listF.get(0).j();
                int size = listF.size();
                for (int i = 1; i < size; i++) {
                    strArr[i] = listF.get(i).j();
                }
            }
            OlaApplication.b.a(this.C.j(), string, strArr, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaChatViewActivity.33
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 18;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    try {
                        progressDialogA.dismiss();
                        chat.ola.vn.i.i.a(OlaChatViewActivity.this, R.string.dialog_title_fail, R.string.message_fail_create_chat_group);
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    try {
                        OlaChatViewActivity.this.C.a((List<chat.ola.vn.message.f>) null);
                        progressDialogA.dismiss();
                        runnable.run();
                    } catch (Throwable unused) {
                    }
                }
            }));
            progressDialogA.show();
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final String str, final int i, final boolean z) {
        if (this.C == null) {
            return;
        }
        if (this.C.k() == 2 && this.C.X()) {
            a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.8
                @Override // java.lang.Runnable
                public void run() {
                    OlaChatViewActivity.this.b(str, i, z);
                }
            });
        } else {
            b(str, i, z);
        }
    }

    private void aa() {
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void ab() {
        c(chat.ola.vn.h.t != null ? chat.ola.vn.h.t.q() : 0);
    }

    /*  JADX ERROR: JadxRuntimeException in pass: RegionMakerVisitor
        jadx.core.utils.exceptions.JadxRuntimeException: Can't find top splitter block for handler:B:83:0x0128
        	at jadx.core.utils.BlockUtils.getTopSplitterForHandler(BlockUtils.java:1182)
        	at jadx.core.dex.visitors.regions.maker.ExcHandlersRegionMaker.collectHandlerRegions(ExcHandlersRegionMaker.java:53)
        	at jadx.core.dex.visitors.regions.maker.ExcHandlersRegionMaker.process(ExcHandlersRegionMaker.java:38)
        	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:27)
        */
    private void ac() {
        /*
            Method dump skipped, instruction units count: 902
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaChatViewActivity.ac():void");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void ad() {
        View view;
        try {
            int i = 8;
            this.r.setVisibility(8);
            this.s.setVisibility(8);
            ((AnimationDrawable) this.s.getDrawable()).stop();
            if (this.A.getVisibility() != 0) {
                view = this.U;
            } else {
                view = this.U;
                i = 0;
            }
            view.setVisibility(i);
        } catch (Throwable unused) {
        }
    }

    @TargetApi(16)
    private void ae() {
        FrameLayout frameLayout;
        int iF;
        try {
            if (this.C.k() != 4) {
                if (this.h == null && !this.i) {
                    this.ab = false;
                    this.t.setBackgroundColor(f());
                    try {
                        AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.activity.OlaChatViewActivity.7
                            /* JADX INFO: Access modifiers changed from: protected */
                            @Override // android.os.AsyncTask
                            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                            public Void doInBackground(Void... voidArr) {
                                OlaChatViewActivity olaChatViewActivity;
                                BitmapDrawable bitmapDrawable;
                                try {
                                    if (OlaChatViewActivity.this.C == null) {
                                        return null;
                                    }
                                    OlaChatViewActivity.this.i = true;
                                    byte[] bArrA = chat.ola.vn.h.b.a(chat.ola.vn.h.a(), OlaChatViewActivity.this.C.j(), OlaChatViewActivity.this.C.k());
                                    if (bArrA != null && bArrA.length > 0) {
                                        OlaChatViewActivity.this.ab = true;
                                        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bArrA, 0, bArrA.length);
                                        olaChatViewActivity = OlaChatViewActivity.this;
                                        bitmapDrawable = new BitmapDrawable(OlaChatViewActivity.this.getResources(), byteArrayInputStream);
                                    } else {
                                        if (OlaBottomTabActivity.e != null) {
                                            OlaChatViewActivity.this.h = OlaBottomTabActivity.e;
                                            return null;
                                        }
                                        byte[] bArrC = chat.ola.vn.h.b.c(chat.ola.vn.h.a());
                                        if (bArrC == null || bArrC.length <= 0) {
                                            return null;
                                        }
                                        ByteArrayInputStream byteArrayInputStream2 = new ByteArrayInputStream(bArrC, 0, bArrC.length);
                                        olaChatViewActivity = OlaChatViewActivity.this;
                                        bitmapDrawable = new BitmapDrawable(OlaChatViewActivity.this.getResources(), byteArrayInputStream2);
                                    }
                                    olaChatViewActivity.h = bitmapDrawable;
                                    return null;
                                } catch (Throwable unused) {
                                    return null;
                                }
                            }

                            /* JADX INFO: Access modifiers changed from: protected */
                            @Override // android.os.AsyncTask
                            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                            public void onPostExecute(Void r2) {
                                try {
                                    if (OlaChatViewActivity.this.h != null) {
                                        if (com.mg.ola.common.d.g.g()) {
                                            OlaChatViewActivity.this.t.setBackground(OlaChatViewActivity.this.h);
                                        } else {
                                            OlaChatViewActivity.this.t.setBackgroundDrawable(OlaChatViewActivity.this.h);
                                        }
                                    }
                                } catch (Throwable unused) {
                                }
                            }
                        };
                        if (com.mg.ola.common.d.g.c()) {
                            asyncTask.executeOnExecutor(chat.ola.vn.h.R, new Void[0]);
                        } else {
                            asyncTask.execute(new Void[0]);
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
                if (this.h != null) {
                    if (com.mg.ola.common.d.g.g()) {
                        this.t.setBackground(this.h);
                        return;
                    } else {
                        this.t.setBackgroundDrawable(this.h);
                        return;
                    }
                }
                frameLayout = this.t;
            } else {
                if (OlaBottomTabActivity.e != null) {
                    this.h = OlaBottomTabActivity.e;
                    getWindow().setBackgroundDrawable(this.h);
                    frameLayout = this.t;
                    iF = g();
                    frameLayout.setBackgroundColor(iF);
                }
                frameLayout = this.t;
            }
            iF = f();
            frameLayout.setBackgroundColor(iF);
        } catch (Throwable unused) {
        }
    }

    private boolean af() {
        if (this.C.D < 0) {
            h(false);
            return false;
        }
        this.p.setTranscriptMode(1);
        try {
            this.p.setSelectionFromTop(this.C.D, this.C.E);
            return true;
        } catch (Throwable unused) {
            this.p.setSelection(this.C.D);
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public chat.ola.vn.message.d ag() {
        if (this.C == null) {
            return null;
        }
        chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
        dVar.d(chat.ola.vn.h.a());
        dVar.e(this.C.j());
        dVar.c(this.C.k());
        dVar.a(chat.ola.vn.h.H);
        dVar.a(System.currentTimeMillis());
        return dVar;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void ah() {
        if (this.C != null) {
            short sK = this.C.k();
            if (sK != 4) {
                switch (sK) {
                    case 0:
                    case 1:
                        chat.ola.vn.m.e.b(this);
                        finish();
                        break;
                    case 2:
                        ai();
                        return;
                }
            } else {
                if (OlaApplication.b != null) {
                    OlaApplication.b.e(Long.valueOf(this.C.j()).longValue());
                }
                onBackPressed();
            }
            chat.ola.vn.h.t.a(this.C.j(), this.C.k());
        }
    }

    private void ai() {
        if (this.C == null) {
            return;
        }
        chat.ola.vn.i.i.d(this, getString(R.string.message_inform), getString(R.string.message_chatgroup_leave_confirm_format, new Object[]{this.C.b()}), getString(R.string.string_yes), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.14
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i != 0) {
                    dialogInterface.dismiss();
                    return;
                }
                if (OlaApplication.b != null) {
                    OlaApplication.b.k(OlaChatViewActivity.this.C.j());
                }
                chat.ola.vn.h.t.a(OlaChatViewActivity.this.C.j(), OlaChatViewActivity.this.C.k());
                chat.ola.vn.util.j.a(OlaChatViewActivity.this, R.string.message_quit_group_format, OlaChatViewActivity.this.C.b());
                dialogInterface.dismiss();
                chat.ola.vn.m.e.b(OlaChatViewActivity.this);
                OlaChatViewActivity.this.finish();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public Dialog aj() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_set_conversation_wallpaper));
        arrayList.add(getString(R.string.string_clear_conversation_wallpaper));
        m mVar = new m(this);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.20
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (chat.ola.vn.util.m.b(OlaChatViewActivity.this.getString(R.string.string_set_conversation_wallpaper), str)) {
                        OlaCropImageActivity.a(OlaChatViewActivity.this, OlaChatViewActivity.this);
                        return;
                    }
                    if (chat.ola.vn.util.m.b(OlaChatViewActivity.this.getString(R.string.string_clear_conversation_wallpaper), str)) {
                        OlaChatViewActivity.this.h = null;
                        OlaChatViewActivity.this.i = true;
                        OlaChatViewActivity.this.ab = false;
                        chat.ola.vn.h.b.a(chat.ola.vn.h.a(), OlaChatViewActivity.this.C.j(), OlaChatViewActivity.this.C.k(), null);
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.20.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    OlaChatViewActivity.this.X();
                                } catch (Throwable unused) {
                                }
                            }
                        }, 2000L);
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return mVar;
    }

    @TargetApi(13)
    private void ak() {
        int height;
        try {
            Display defaultDisplay = ((WindowManager) getSystemService("window")).getDefaultDisplay();
            if (com.mg.ola.common.d.g.e()) {
                Point point = new Point();
                defaultDisplay.getSize(point);
                chat.ola.vn.e.c = point.x;
                height = point.y;
            } else {
                chat.ola.vn.e.c = defaultDisplay.getWidth();
                height = defaultDisplay.getHeight();
            }
            chat.ola.vn.e.d = height;
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void al() {
        chat.ola.vn.message.f fVar;
        try {
            this.C.D();
            short sK = this.C.k();
            try {
                if (sK == 0) {
                    e(true);
                    if (OlaApplication.b.i(this.C.j(), null, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaChatViewActivity.22
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 55;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                            OlaChatViewActivity.this.e(false);
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                            OlaChatViewActivity.this.e(false);
                        }
                    }))) {
                        this.C.V = (byte) 1;
                        this.C.O = null;
                        fVar = this.C;
                        fVar.Q = true;
                        return;
                    }
                    e(false);
                }
                if (sK == 2 && !this.C.X()) {
                    e(true);
                    if (OlaApplication.b.h(this.C.j(), null, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaChatViewActivity.21
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 55;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                            OlaChatViewActivity.this.e(false);
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                            OlaChatViewActivity.this.e(false);
                        }
                    }))) {
                        this.C.V = (byte) 1;
                        this.C.O = null;
                        fVar = this.C;
                        fVar.Q = true;
                        return;
                    }
                    e(false);
                }
            } catch (Throwable unused) {
                e(false);
            }
        } catch (Throwable unused2) {
        }
    }

    private void am() {
        try {
            if (this.C != null) {
                this.C.Q();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void an() {
        try {
            if (Build.VERSION.SDK_INT < 23 || checkSelfPermission("android.permission.CAMERA") == 0) {
                ao();
            } else {
                requestPermissions(new String[]{"android.permission.CAMERA"}, 105);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void ao() {
        Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
        this.ax = new File(chat.ola.vn.d.a(System.currentTimeMillis()));
        if (this.ax.exists()) {
            this.ax.delete();
        }
        intent.putExtra("output", Uri.fromFile(this.ax));
        startActivityForResult(intent, 2);
    }

    @SuppressLint({"InlinedApi"})
    private void ap() {
        if (com.mg.ola.common.d.g.h()) {
            Intent intent = new Intent();
            intent.setType("image/*");
            intent.putExtra("android.intent.extra.ALLOW_MULTIPLE", true);
            intent.setAction("android.intent.action.GET_CONTENT");
            startActivityForResult(Intent.createChooser(intent, getString(R.string.string_select_photo)), 3);
        }
    }

    private void aq() {
        if (this.aw == 0) {
            this.aw = this.N.getHeight() - g;
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.25
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (OlaChatViewActivity.this.N.getLayoutParams().height == -1 || OlaChatViewActivity.this.N.getLayoutParams().height != OlaChatViewActivity.this.aw) {
                        ViewGroup.LayoutParams layoutParams = OlaChatViewActivity.this.N.getLayoutParams();
                        layoutParams.height = OlaChatViewActivity.this.aw;
                        OlaChatViewActivity.this.N.setLayoutParams(layoutParams);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    private void ar() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.26
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (OlaChatViewActivity.this.N.getLayoutParams().height != -1) {
                        ViewGroup.LayoutParams layoutParams = OlaChatViewActivity.this.N.getLayoutParams();
                        layoutParams.height = -1;
                        OlaChatViewActivity.this.N.setLayoutParams(layoutParams);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    private void as() {
        ImageButton imageButton;
        this.aq.setSelected(false);
        this.ar.setSelected(false);
        this.as.setSelected(false);
        this.at.setSelected(false);
        this.au.setSelected(false);
        switch (this.ae) {
            case 0:
                this.aq.setSelected(false);
                return;
            case 1:
                imageButton = this.aq;
                break;
            case 2:
                imageButton = this.ar;
                break;
            case 3:
                imageButton = this.as;
                break;
            case 4:
                imageButton = this.at;
                break;
            case 5:
                imageButton = this.au;
                break;
            default:
                return;
        }
        imageButton.setSelected(true);
    }

    private void at() {
        if (this.ay == null) {
            this.ay = new chat.ola.vn.i.c(this);
            this.ay.a(R.string.message_getting_location);
        }
        try {
            if (chat.ola.vn.n.c.a().a(180000L) != null) {
                c(chat.ola.vn.message.e.a(ag(), (byte) 2, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c()));
                if (this.C.k() == 2) {
                    OlaApplication.b.b(this.C.j(), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c());
                    return;
                } else {
                    OlaApplication.b.a(this.C.j(), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c());
                    return;
                }
            }
        } catch (Throwable unused) {
        }
        this.ay.a(30000L, null);
        chat.ola.vn.n.b.b(this, 15000L, new b.InterfaceC0042b() { // from class: chat.ola.vn.activity.OlaChatViewActivity.31
            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void a(double d, double d2, float f2) {
                OlaChatViewActivity.this.ay.a();
                try {
                    if (d == 0.0d || d2 == 0.0d) {
                        try {
                            OlaChatViewActivity.this.ay.a();
                        } catch (Throwable unused2) {
                        }
                        chat.ola.vn.i.i.a(OlaChatViewActivity.this, R.string.dialog_title_inform, R.string.message_map_loading_gps_fail);
                        return;
                    }
                    OlaChatViewActivity.this.ay.a();
                    OlaChatViewActivity.this.ay.dismiss();
                    OlaChatViewActivity.this.c(chat.ola.vn.message.e.a(OlaChatViewActivity.this.ag(), (byte) 2, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c()));
                    if (OlaChatViewActivity.this.C.k() == 2) {
                        OlaApplication.b.b(OlaChatViewActivity.this.C.j(), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c());
                    } else {
                        OlaApplication.b.a(OlaChatViewActivity.this.C.j(), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c());
                    }
                } catch (Throwable unused3) {
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void j_() {
                try {
                    OlaChatViewActivity.this.ay.a();
                    chat.ola.vn.i.i.a(OlaChatViewActivity.this, R.string.dialog_title_fail, R.string.message_not_yet_get_location);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void k_() {
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void l_() {
                OlaChatViewActivity.this.ay.a();
                chat.ola.vn.i.i.a(c.c(), R.string.message_location_provider_gps_unavailable_title, R.string.message_location_provider_unavailable, R.string.string_turn_on_gps, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.31.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            try {
                                c.c().startActivity(new Intent("android.settings.LOCATION_SOURCE_SETTINGS"));
                            } catch (Throwable unused2) {
                                return;
                            }
                        }
                        dialogInterface.dismiss();
                    }
                });
            }
        });
    }

    private boolean au() {
        try {
            final List<String> listB = OlaQuickReplyComposerActivity.B();
            if (listB == null || listB.size() <= 0) {
                return false;
            }
            m mVar = new m(this);
            mVar.setCanceledOnTouchOutside(true);
            mVar.a(listB);
            mVar.setTitle(R.string.string_quick_reply);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.35
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        OlaChatViewActivity.this.a((String) listB.get(i), 0, false);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(chat.ola.vn.message.f fVar, String str, int i, String str2) {
        try {
            if ((chat.ola.vn.util.m.a(str) && i == 0) || fVar == null) {
                return;
            }
            fVar.B = false;
            if (chat.ola.vn.util.m.b(str, chat.ola.vn.f.c.b)) {
                str = chat.ola.vn.f.c.a;
            }
            chat.ola.vn.message.d dVarAg = ag();
            dVarAg.f(str);
            dVarAg.b((short) i);
            dVarAg.h(str2);
            short sK = fVar.k();
            if (sK == 0) {
                if (OlaApplication.b != null) {
                    OlaApplication.b.a(dVarAg.j(), dVarAg.k(), dVarAg.p(), dVarAg.o());
                }
            } else if (sK == 2) {
                if (OlaApplication.b != null) {
                    OlaApplication.b.c(dVarAg.j(), dVarAg.k(), dVarAg.p(), dVarAg.o());
                }
            } else {
                if (sK != 4) {
                    return;
                }
                OlaApplication.b.a(Long.parseLong(dVarAg.j()), dVarAg.k(), dVarAg.o());
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void b(CharSequence charSequence) {
        if (this.aA) {
            this.aA = false;
            return;
        }
        if (charSequence != null) {
            try {
                if (charSequence.length() != 0) {
                    this.v.setVisibility(8);
                    this.u.setVisibility(0);
                    return;
                }
            } catch (Throwable unused) {
                this.v.setVisibility(0);
                this.u.setVisibility(8);
                return;
            }
        }
        this.v.setVisibility(0);
        this.u.setVisibility(8);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(String str, final int i, boolean z) {
        if ((chat.ola.vn.util.m.a(str) && i == 0) || this.C == null) {
            return;
        }
        this.C.d(true);
        if (chat.ola.vn.util.m.b(str, chat.ola.vn.f.c.b)) {
            str = chat.ola.vn.f.c.a;
        }
        final String str2 = str;
        chat.ola.vn.message.d dVarAg = ag();
        this.C.B = false;
        this.C.H = System.currentTimeMillis();
        dVarAg.f(str2);
        dVarAg.b((short) i);
        final String strJ = this.C.j();
        final short sK = this.C.k();
        final chat.ola.vn.message.d dVarA = chat.ola.vn.message.e.a(dVarAg, (byte) 2);
        Runnable runnable = new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.9
            private void a() {
                dVarA.b((byte) 4);
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.9.1
                    @Override // java.lang.Runnable
                    public void run() {
                        if (dVarA.q() == 4) {
                            dVarA.b((byte) 5);
                        }
                    }
                }, 60000L);
            }

            @Override // java.lang.Runnable
            public void run() {
                try {
                    short s = sK;
                    if (s == 4) {
                        OlaApplication.b.a(Long.parseLong(strJ), str2, dVarA.o());
                        dVarA.b((byte) 2);
                        return;
                    }
                    switch (s) {
                        case 0:
                            OlaApplication.b.a(dVarA.j(), str2, dVarA.p(), (short) i);
                            break;
                        case 1:
                            dVarA.b((byte) 2);
                            OlaApplication.b.a(dVarA.j(), str2, dVarA.p(), (short) i);
                            return;
                        case 2:
                            OlaApplication.b.c(dVarA.j(), str2, dVarA.p(), (short) i);
                            break;
                        default:
                            return;
                    }
                    a();
                } catch (Throwable unused) {
                    dVarA.b((byte) 5);
                }
            }
        };
        runnable.run();
        dVarA.a(runnable);
        if (z) {
            a("");
        }
        c(dVarA);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(chat.ola.vn.message.d dVar) {
        if (dVar != null) {
            this.C.a(dVar);
            this.C.d(true);
        }
        h(true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d(boolean z) {
        ImageView imageView;
        if (!z) {
            this.V.setVisibility(8);
            return;
        }
        this.V.setVisibility(0);
        Long l = this.C.J;
        int i = R.drawable.ic_action_notification;
        if (l == null || System.currentTimeMillis() >= this.C.J.longValue()) {
            imageView = this.V;
        } else {
            imageView = this.V;
            i = R.drawable.ic_action_notification_mute;
        }
        imageView.setImageResource(i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e(boolean z) {
        try {
            if (z) {
                this.p.addHeaderView(this.Y);
            } else {
                this.p.removeHeaderView(this.Y);
            }
        } catch (Throwable unused) {
        }
    }

    @TargetApi(12)
    private void f(final boolean z) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.2
                @Override // java.lang.Runnable
                public void run() {
                    if (z) {
                        OlaChatViewActivity.this.q.requestFocus();
                    }
                    chat.ola.vn.util.o.a(OlaChatViewActivity.this, OlaChatViewActivity.this.q, z);
                }
            });
        } catch (Throwable unused) {
        }
    }

    private void g(boolean z) {
        if (z) {
            this.A.setVisibility(0);
            this.A.startAnimation(this.B);
        } else {
            this.A.setVisibility(8);
            this.A.clearAnimation();
            if (this.r.getVisibility() != 0) {
                this.U.setVisibility(8);
                return;
            }
        }
        this.U.setVisibility(0);
    }

    @SuppressLint({"NewApi"})
    private void h(final boolean z) {
        try {
            this.C.D = -1;
            this.C.E = 0;
        } catch (Throwable unused) {
        }
        this.p.postDelayed(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.13
            @Override // java.lang.Runnable
            public void run() {
                try {
                    int count = OlaChatViewActivity.this.o.getCount();
                    OlaChatViewActivity.this.p.setTranscriptMode(2);
                    if (!z || count - OlaChatViewActivity.this.p.getLastVisiblePosition() >= 30) {
                        OlaChatViewActivity olaChatViewActivity = OlaChatViewActivity.this;
                        olaChatViewActivity.p.setSelection(count);
                    } else if (com.mg.ola.common.d.g.c()) {
                        OlaChatViewActivity.this.p.smoothScrollToPositionFromTop(count, 0, 500);
                    } else {
                        OlaChatViewActivity.this.p.smoothScrollToPosition(count);
                    }
                } catch (Throwable unused2) {
                }
            }
        }, 250L);
    }

    private void i(boolean z) {
        if (z) {
            ViewGroup.LayoutParams layoutParams = this.av.getLayoutParams();
            if (layoutParams.height != g) {
                layoutParams.height = g;
                this.av.setLayoutParams(layoutParams);
            }
            this.av.setVisibility(0);
            return;
        }
        if (this.av.getVisibility() != 8) {
            this.av.setVisibility(8);
        }
        try {
            this.av.removeAllViews();
            if (this.al != null) {
                this.al.a();
            }
            this.al = null;
        } catch (Throwable unused) {
        }
    }

    private void j(boolean z) {
        d dVar;
        try {
            as();
            boolean z2 = true;
            switch (this.ae) {
                case 0:
                    this.av.removeAllViews();
                    i(false);
                    if (!z) {
                        ar();
                    } else {
                        aq();
                    }
                    break;
                case 1:
                    i(true);
                    aq();
                    if (this.ag == null) {
                        this.ag = new h(this);
                        this.ag.setOlaSmileyListener(this);
                    }
                    try {
                        if (this.al == null || this.al != this.ag) {
                            this.av.removeAllViews();
                            this.av.addView(this.ag);
                            this.al = this.ag;
                        }
                    } catch (Throwable unused) {
                    }
                    break;
                case 2:
                    i(true);
                    aq();
                    if (this.ah == null) {
                        this.ah = new i(this);
                        this.ah.setOnStickerClickedListener(this);
                    }
                    if (this.al == null || this.al != this.ah) {
                        this.av.removeAllViews();
                        this.av.addView(this.ah);
                        dVar = this.ah;
                        this.al = dVar;
                    }
                    z2 = false;
                    break;
                case 3:
                    i(true);
                    aq();
                    if (this.ai == null) {
                        this.ai = new g(this);
                        this.ai.setAllowVideo(false);
                        this.ai.setOlaPhotoListener(this);
                    }
                    if (this.al == null || this.al != this.ai) {
                        this.av.removeAllViews();
                        this.av.addView(this.ai);
                        dVar = this.ai;
                        this.al = dVar;
                    }
                    z2 = false;
                    break;
                case 4:
                    i(true);
                    aq();
                    if (this.aj == null) {
                        this.aj = new j(this);
                        this.aj.setOnVoiceRecordListener(this);
                    }
                    if (this.al == null || this.al != this.aj) {
                        this.av.removeAllViews();
                        this.av.addView(this.aj);
                        dVar = this.aj;
                        this.al = dVar;
                    }
                    z2 = false;
                    break;
                case 5:
                    i(true);
                    aq();
                    if (this.ak == null) {
                        this.ak = new chat.ola.vn.view.f(this);
                        this.ak.setOnMoreActionClickedListener(this);
                    }
                    if (this.ak != null) {
                        if (this.C.k() == 2) {
                            this.ak.setTransferKenButtonVisibility(false);
                            this.ak.setTradingVipButtonVisibility(false);
                            this.ak.setSendVipDayButtonVisibility(false);
                        } else {
                            this.ak.setTransferKenButtonVisibility(true);
                            this.ak.setTradingVipButtonVisibility(true);
                            this.ak.setSendVipDayButtonVisibility(true);
                        }
                    }
                    if (this.al == null || this.al != this.ak) {
                        this.av.removeAllViews();
                        this.av.addView(this.ak);
                        dVar = this.ak;
                        this.al = dVar;
                    }
                    z2 = false;
                    break;
                default:
                    z2 = false;
                    break;
            }
            if (z2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.24
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            OlaChatViewActivity.this.q.requestFocus();
                        } catch (Throwable unused2) {
                        }
                    }
                });
            }
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void m(String str) {
        try {
            this.r.setText(str);
            this.r.setVisibility(0);
            this.s.setVisibility(0);
            this.U.setVisibility(0);
            ((AnimationDrawable) this.s.getDrawable()).start();
        } catch (Throwable unused) {
        }
    }

    private void n(String str) {
        try {
            if (this.C == null || OlaApplication.b == null) {
                return;
            }
            aa aaVarA = chat.ola.vn.message.e.a(ag(), (byte) 2, str);
            c(aaVarA);
            AnonymousClass11 anonymousClass11 = new AnonymousClass11(aaVarA, str, this.C);
            aaVarA.a(anonymousClass11);
            anonymousClass11.run();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void o(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.18
            @Override // java.lang.Runnable
            public void run() {
                TextView textView;
                int i;
                try {
                    if (chat.ola.vn.util.m.a(str)) {
                        textView = OlaChatViewActivity.this.ac;
                        i = 8;
                    } else {
                        OlaChatViewActivity.this.ac.setText(str);
                        textView = OlaChatViewActivity.this.ac;
                        i = 0;
                    }
                    textView.setVisibility(i);
                } catch (Throwable unused) {
                }
            }
        });
    }

    private void p(String str) {
        try {
            String string = this.q.getText().toString();
            int selectionStart = this.q.getSelectionStart() >= 0 ? this.q.getSelectionStart() : 0;
            StringBuilder sb = new StringBuilder(string);
            sb.insert(selectionStart, str);
            this.q.setText(q(sb.toString()));
            this.q.setSelection(selectionStart + str.length());
        } catch (Throwable unused) {
            this.q.append(str);
        }
    }

    private CharSequence q(String str) {
        return chat.ola.vn.util.i.a(str, (OlaTextView.b) null);
    }

    @Override // chat.ola.vn.p.f
    public void C() {
        chat.ola.vn.message.f fVarD;
        if (this.C == null || (fVarD = chat.ola.vn.h.t.d(this.C.j(), this.C.k())) == null) {
            return;
        }
        a(fVarD);
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void D() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void E() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void F() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void G() {
    }

    @Override // chat.ola.vn.p.f
    public boolean H() {
        return true;
    }

    @Override // chat.ola.vn.view.e.a
    public boolean I() {
        an();
        this.ae = 0;
        j(false);
        return true;
    }

    @Override // chat.ola.vn.view.e.a
    public boolean J() {
        try {
            ViewGroup.LayoutParams layoutParams = this.av.getLayoutParams();
            layoutParams.height = -1;
            this.av.setLayoutParams(layoutParams);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.view.e.a
    public boolean K() {
        try {
            ViewGroup.LayoutParams layoutParams = this.av.getLayoutParams();
            if (layoutParams.height == g) {
                return true;
            }
            layoutParams.height = g;
            this.av.setLayoutParams(layoutParams);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.view.h.b
    public void L() {
        try {
            String string = this.q.getText().toString();
            int selectionStart = this.q.getSelectionStart() >= 0 ? this.q.getSelectionStart() : 0;
            StringBuilder sb = new StringBuilder(string);
            if (selectionStart > 0) {
                selectionStart--;
            }
            sb.replace(selectionStart, selectionStart + 1, "");
            this.q.setText(sb.toString());
            this.q.setSelection(selectionStart);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void M() {
    }

    @Override // chat.ola.vn.view.f.a
    public void N() {
        if (chat.ola.vn.n.b.b(this)) {
            at();
        } else {
            chat.ola.vn.n.b.a(this, 101);
        }
    }

    @Override // chat.ola.vn.view.f.a
    public void O() {
        OlaTransferKenActivity.a(this, this.C.j());
    }

    @Override // chat.ola.vn.view.f.a
    public void P() {
        OlaTraddingVipActivity.a(this, this.C.j());
    }

    @Override // chat.ola.vn.view.f.a
    public void Q() {
        BuyVipActivity.c(this, this.C.j());
    }

    /* JADX WARN: Can't wrap try/catch for region: R(18:0|(2:43|2)|39|3|4|(1:6)|7|(1:9)(2:35|10)|11|(8:13|(2:15|(0))(1:18)|41|22|26|37|27|28)(2:19|(2:29|30))|21|41|22|26|37|27|28|(1:(0))) */
    /* JADX WARN: Code restructure failed: missing block: B:24:0x0092, code lost:
    
        r0 = move-exception;
     */
    /* JADX WARN: Code restructure failed: missing block: B:25:0x0093, code lost:
    
        r0.printStackTrace();
     */
    @Override // chat.ola.vn.c
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void a() {
        /*
            r5 = this;
            chat.ola.vn.util.d.a r0 = r5.X     // Catch: java.lang.Throwable -> L5
            r0.a()     // Catch: java.lang.Throwable -> L5
        L5:
            android.content.res.Resources r0 = r5.getResources()     // Catch: java.lang.Throwable -> L11
            android.content.res.Configuration r0 = r0.getConfiguration()     // Catch: java.lang.Throwable -> L11
            int r0 = r0.orientation     // Catch: java.lang.Throwable -> L11
            r5.az = r0     // Catch: java.lang.Throwable -> L11
        L11:
            java.lang.Runnable r0 = r5.G
            if (r0 != 0) goto L1c
            chat.ola.vn.activity.OlaChatViewActivity$38 r0 = new chat.ola.vn.activity.OlaChatViewActivity$38
            r0.<init>()
            r5.G = r0
        L1c:
            android.os.Handler r0 = r5.F
            if (r0 != 0) goto L28
            android.os.Handler r0 = new android.os.Handler
            r0.<init>()
            r5.F = r0
            goto L2f
        L28:
            android.os.Handler r0 = r5.F     // Catch: java.lang.Throwable -> L2f
            java.lang.Runnable r1 = r5.G     // Catch: java.lang.Throwable -> L2f
            r0.removeCallbacks(r1)     // Catch: java.lang.Throwable -> L2f
        L2f:
            android.os.Handler r0 = r5.F
            java.lang.Runnable r1 = r5.G
            r0.post(r1)
            chat.ola.vn.message.g r0 = chat.ola.vn.h.t
            r0.a(r5)
            android.widget.EditText r0 = r5.q
            r0.addTextChangedListener(r5)
            chat.ola.vn.message.f r0 = r5.C
            r1 = 0
            r2 = 1
            if (r0 == 0) goto L75
            java.lang.String r0 = chat.ola.vn.activity.OlaChatViewActivity.e
            if (r0 == 0) goto L5f
            java.lang.String r0 = chat.ola.vn.activity.OlaChatViewActivity.e
            short r3 = chat.ola.vn.activity.OlaChatViewActivity.f
            java.lang.String r0 = chat.ola.vn.message.f.b(r0, r3)
            chat.ola.vn.message.f r3 = r5.C
            java.lang.String r3 = r3.y()
            boolean r0 = chat.ola.vn.util.m.a(r0, r3)
            if (r0 != 0) goto L88
            goto L79
        L5f:
            chat.ola.vn.message.g r0 = chat.ola.vn.h.t
            chat.ola.vn.message.f r1 = r5.C
            java.lang.String r1 = r1.j()
            chat.ola.vn.message.f r3 = r5.C
            short r3 = r3.k()
            chat.ola.vn.message.f r0 = r0.b(r1, r3, r2)
            r5.a(r0)
            goto L88
        L75:
            java.lang.String r0 = chat.ola.vn.activity.OlaChatViewActivity.e
            if (r0 == 0) goto La2
        L79:
            chat.ola.vn.message.g r0 = chat.ola.vn.h.t
            java.lang.String r3 = chat.ola.vn.activity.OlaChatViewActivity.e
            short r4 = chat.ola.vn.activity.OlaChatViewActivity.f
            chat.ola.vn.message.f r0 = r0.b(r3, r4, r2)
            r5.a(r0)
            chat.ola.vn.activity.OlaChatViewActivity.e = r1
        L88:
            chat.ola.vn.message.f r0 = r5.C     // Catch: java.lang.Throwable -> L92
            int r0 = r0.U()     // Catch: java.lang.Throwable -> L92
            chat.ola.vn.util.c.b.a(r5, r0)     // Catch: java.lang.Throwable -> L92
            goto L96
        L92:
            r0 = move-exception
            r0.printStackTrace()
        L96:
            r5.X()
            r5.af()
            chat.ola.vn.balloon.OlaBalloonService r0 = chat.ola.vn.OlaApplication.c     // Catch: java.lang.Throwable -> La1
            r0.a()     // Catch: java.lang.Throwable -> La1
        La1:
            return
        La2:
            r5.onBackPressed()
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaChatViewActivity.a():void");
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
    }

    @Override // chat.ola.vn.view.i.e
    public void a(w wVar) {
        try {
            String strA = wVar.a();
            if (chat.ola.vn.util.m.a(strA)) {
                if (wVar.c() > 0) {
                    a((String) null, wVar.c(), false);
                }
            } else {
                a("##" + strA + "#", 0, false);
            }
        } catch (Throwable unused) {
        }
    }

    protected void a(chat.ola.vn.message.d dVar) {
        try {
            if (chat.ola.vn.util.m.a(dVar.i())) {
            }
            final ArrayList arrayList = new ArrayList();
            final chat.ola.vn.message.f fVarE = chat.ola.vn.h.t.e(dVar.i(), (short) 0);
            if (fVarE == null) {
                fVarE = new chat.ola.vn.message.f(dVar.i(), (short) 0);
            }
            switch (fVarE.k()) {
                case 0:
                    if (fVarE.u() != 1) {
                        arrayList.add(getString(R.string.string_make_friend));
                    }
                    arrayList.add(getString(R.string.string_chat));
                    arrayList.add(getString(R.string.string_view_me));
                    if (fVarE.u() != 1) {
                        arrayList.add(getString(R.string.string_block));
                        break;
                    }
                case 1:
                    m mVar = new m(this);
                    mVar.a(arrayList);
                    mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.5
                        @Override // android.widget.AdapterView.OnItemClickListener
                        public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                            try {
                                String str = (String) arrayList.get(i);
                                if (chat.ola.vn.util.m.b(OlaChatViewActivity.this.getString(R.string.string_make_friend), str)) {
                                    OlaApplication.b.b(chat.ola.vn.util.m.j(fVarE.j()), (String) null);
                                    return;
                                }
                                if (chat.ola.vn.util.m.b(OlaChatViewActivity.this.getString(R.string.string_chat), str)) {
                                    OlaChatViewActivity.a((Context) OlaChatViewActivity.this, OlaApplication.b, fVarE.j(), (short) 0);
                                    return;
                                }
                                if (chat.ola.vn.util.m.b(OlaChatViewActivity.this.getString(R.string.string_view_me), str)) {
                                    chat.ola.vn.me.c.a(OlaChatViewActivity.this, OlaApplication.b, fVarE.j());
                                    return;
                                }
                                if (chat.ola.vn.util.m.b(OlaChatViewActivity.this.getString(R.string.string_block), str)) {
                                    chat.ola.vn.i.i.d(OlaChatViewActivity.this, OlaChatViewActivity.this.getString(R.string.message_block_chat_title), OlaChatViewActivity.this.getString(R.string.message_block_chat_confirm_format, new Object[]{"@" + fVarE.j()}), OlaChatViewActivity.this.getString(R.string.string_block), OlaChatViewActivity.this.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.5.1
                                        @Override // android.content.DialogInterface.OnClickListener
                                        public void onClick(DialogInterface dialogInterface, int i2) {
                                            dialogInterface.dismiss();
                                            if (i2 == 0) {
                                                try {
                                                    if (OlaApplication.b != null) {
                                                        OlaApplication.b.l(fVarE.j());
                                                        chat.ola.vn.h.t.b(fVarE);
                                                    }
                                                } catch (Throwable unused) {
                                                }
                                            }
                                        }
                                    });
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    });
                    mVar.show();
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.d dVar, byte b, byte b2) {
        if (this.o != null) {
            this.o.notifyDataSetChanged();
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, int i, String str, List<chat.ola.vn.message.d> list) {
        try {
            e(false);
            S();
            if (i <= 0 || !fVar.equals(this.C)) {
                return;
            }
            if (chat.ola.vn.util.m.a(str)) {
                h(false);
                return;
            }
            int firstVisiblePosition = this.p.getFirstVisiblePosition() + i;
            if (this.o != null) {
                this.o.notifyDataSetChanged();
            }
            this.p.setSelection(firstVisiblePosition);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
        try {
            if (this.C != null) {
                if (this.C.z() > 0) {
                    this.C.a(0);
                    this.C.A();
                }
                if (chat.ola.vn.util.m.a(this.C.y(), fVar.y())) {
                    if (dVar.d() == 1) {
                        try {
                            if (!chat.ola.vn.util.m.b(((chat.ola.vn.message.d) this.p.getItemAtPosition(this.p.getLastVisiblePosition())).p(), dVar.p())) {
                                g(true);
                            }
                        } catch (Throwable unused) {
                        }
                        if (this.C.D < 0) {
                            h(true);
                        }
                    }
                    if (dVar.e() == 0) {
                        ac();
                    }
                    this.o.notifyDataSetChanged();
                }
                this.K.notifyDataSetChanged();
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, List<chat.ola.vn.message.d> list) {
        if (fVar.equals(this.C)) {
            e(false);
            if (this.o != null) {
                this.o.notifyDataSetChanged();
                h(false);
            }
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, int i) {
        super.a(str, i);
        if (chat.ola.vn.util.m.b(str, this.C.j())) {
            am();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, int i, int[] iArr, int[] iArr2) {
        super.a(str, i, iArr, iArr2);
        chat.ola.vn.util.m.b(str, this.C.j());
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, String str2, String str3, String str4, String str5, String str6) {
        super.a(str, str2, str3, str4, str5, str6);
        try {
            if (this.z != null) {
                this.z.a();
            }
            a(chat.ola.vn.h.t.b(str3, (short) 2, true));
            X();
            h(false);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // com.mg.ola.common.widget.a.a
    public void a(boolean z, int i) {
        if (z) {
            ak();
            int i2 = (chat.ola.vn.e.d - chat.ola.vn.e.e) - i;
            if (g != i2) {
                g = i2;
                chat.ola.vn.e.a().c(g);
            }
            this.aw = i;
            this.ae = 0;
        } else if (g == 0) {
            g = getResources().getDimensionPixelSize(R.dimen.metric_240dp);
        }
        j(z);
        if (this.ae == 0) {
            i(false);
        }
    }

    @Override // chat.ola.vn.p.f
    public void a_() {
        if (this.o != null) {
            this.o.notifyDataSetChanged();
        }
    }

    @Override // chat.ola.vn.view.e.a
    public void a_(String str) {
        try {
            p pVar = new p(new chat.ola.vn.message.d(), (byte) 2);
            pVar.e(this.C.j());
            pVar.c(this.C.k());
            ArrayList arrayList = new ArrayList(1);
            arrayList.add(ab.a(str));
            pVar.b(arrayList);
            if (pVar != null) {
                c(pVar);
            }
            AnonymousClass27 anonymousClass27 = new AnonymousClass27(pVar, str, this.C);
            pVar.a(anonymousClass27);
            anonymousClass27.run();
        } catch (Throwable unused) {
        }
    }

    @Override // android.text.TextWatcher
    public void afterTextChanged(Editable editable) {
        b(editable);
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar) {
        try {
            this.K.notifyDataSetChanged();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
        this.o.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void b(Short sh, int i) {
    }

    /* JADX WARN: Removed duplicated region for block: B:15:0x0033  */
    /* JADX WARN: Removed duplicated region for block: B:18:0x004e  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean b(final chat.ola.vn.message.d r7) {
        /*
            r6 = this;
            java.util.ArrayList r0 = new java.util.ArrayList
            r0.<init>()
            boolean r1 = r7.w
            if (r1 != 0) goto L1f
            java.lang.Long r1 = r7.p
            if (r1 == 0) goto L1f
            long r1 = java.lang.System.currentTimeMillis()
            java.lang.Long r3 = r7.p
            long r3 = r3.longValue()
            int r5 = (r1 > r3 ? 1 : (r1 == r3 ? 0 : -1))
            if (r5 >= 0) goto L1f
            r1 = 2131690996(0x7f0f05f4, float:1.9011051E38)
            goto L26
        L1f:
            boolean r1 = r7.x
            if (r1 != 0) goto L2d
            r1 = 2131690557(0x7f0f043d, float:1.901016E38)
        L26:
            java.lang.String r1 = r6.getString(r1)
            r0.add(r1)
        L2d:
            boolean r1 = r7.w()
            if (r1 == 0) goto L47
            r1 = 2131690641(0x7f0f0491, float:1.9010331E38)
            java.lang.String r1 = r6.getString(r1)
            r0.add(r1)
            r1 = 2131690643(0x7f0f0493, float:1.9010335E38)
            java.lang.String r1 = r6.getString(r1)
            r0.add(r1)
        L47:
            byte r1 = r7.e()
            r2 = 1
            if (r1 != r2) goto L58
            r1 = 2131689722(0x7f0f00fa, float:1.9008467E38)
            java.lang.String r1 = r6.getString(r1)
            r0.add(r1)
        L58:
            r1 = 2131690662(0x7f0f04a6, float:1.9010374E38)
            java.lang.String r1 = r6.getString(r1)
            r0.add(r1)
            chat.ola.vn.i.m r1 = new chat.ola.vn.i.m
            r1.<init>(r6)
            r1.a(r0)
            chat.ola.vn.activity.OlaChatViewActivity$15 r3 = new chat.ola.vn.activity.OlaChatViewActivity$15
            r3.<init>()
            r1.a(r3)
            r1.show()
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaChatViewActivity.b(chat.ola.vn.message.d):boolean");
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void b_() {
    }

    @Override // android.text.TextWatcher
    public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // chat.ola.vn.p.f
    public void c(int i) {
        TextView textView;
        int i2;
        if (i == 0) {
            textView = this.w;
            i2 = 8;
        } else {
            if (i >= 100) {
                this.w.setText("99+");
            } else {
                this.w.setText(i + "");
            }
            textView = this.w;
            i2 = 0;
        }
        textView.setVisibility(i2);
    }

    @Override // chat.ola.vn.p.f
    public void c(chat.ola.vn.message.f fVar) {
        if (this.C != fVar || this.C.B) {
            return;
        }
        finish();
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void c(String str, String str2) {
        super.c(str, str2);
        try {
            if (this.z != null) {
                this.z.a();
            }
            a(chat.ola.vn.h.t.b(str, (short) 2, true));
            X();
            h(false);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.f
    public void c(List<chat.ola.vn.message.f> list) {
    }

    @Override // chat.ola.vn.p.f
    public void c(boolean z) {
    }

    @Override // chat.ola.vn.p.f
    public void d(chat.ola.vn.message.f fVar) {
        try {
            if (this.C == null) {
                return;
            }
            if (chat.ola.vn.util.m.a(this.C.y(), fVar.y())) {
                this.C.b(fVar);
                ac();
                Z();
            }
            this.K.notifyDataSetChanged();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void d(String str, String str2) {
        super.d(str, str2);
    }

    @Override // chat.ola.vn.view.g.e
    public void d(List<String> list) {
        try {
            if (list.size() > 0) {
                ArrayList arrayList = new ArrayList(list);
                String str = "##" + ((String) arrayList.get(0)) + "#";
                int size = arrayList.size();
                for (int i = 1; i < size; i++) {
                    str = str + " ##" + ((String) arrayList.get(i)) + "#";
                }
                if (chat.ola.vn.util.m.a(str)) {
                    return;
                }
                a(str, 0, false);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void e(chat.ola.vn.message.f fVar) {
        if (this.C == null || !this.C.equals(fVar)) {
            return;
        }
        m(getString(R.string.message_chat_typing, new Object[]{fVar.n}));
    }

    @Override // chat.ola.vn.view.g.e
    public void e(List<String> list) {
    }

    @Override // chat.ola.vn.p.f
    public void f(chat.ola.vn.message.f fVar) {
        if (this.C == null || !this.C.equals(fVar)) {
            return;
        }
        ad();
    }

    /* JADX WARN: Type inference failed for: r1v2, types: [chat.ola.vn.activity.OlaChatViewActivity$32] */
    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void f(final String str) {
        try {
            final ProgressDialog progressDialogA = chat.ola.vn.i.i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_changing_chat_background));
            new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.activity.OlaChatViewActivity.32
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    try {
                        Bitmap bitmapDecodeFile = BitmapFactory.decodeFile(str);
                        if (bitmapDecodeFile == null) {
                            return null;
                        }
                        chat.ola.vn.h.b.a(chat.ola.vn.h.a(), OlaChatViewActivity.this.C.j(), OlaChatViewActivity.this.C.k(), chat.ola.vn.badger.e.a(bitmapDecodeFile));
                        return null;
                    } catch (Throwable unused) {
                        return null;
                    }
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(Void r2) {
                    try {
                        chat.ola.vn.util.j.d(OlaChatViewActivity.this, R.string.message_change_chat_background_success);
                        OlaChatViewActivity.this.h = null;
                        OlaChatViewActivity.this.i = false;
                        OlaChatViewActivity.this.X();
                        progressDialogA.dismiss();
                    } catch (Throwable unused) {
                    }
                }

                @Override // android.os.AsyncTask
                protected void onPreExecute() {
                    try {
                        progressDialogA.show();
                    } catch (Throwable unused) {
                    }
                }
            }.execute(new Void[0]);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void f(List<String> list) {
        try {
            if (list.size() > 0) {
                ArrayList arrayList = new ArrayList(list.size());
                Iterator<String> it2 = list.iterator();
                while (it2.hasNext()) {
                    arrayList.add(ab.a(it2.next()));
                }
                final p pVar = new p(new chat.ola.vn.message.d(), (byte) 2);
                pVar.e(this.C.j());
                pVar.c(this.C.k());
                pVar.b((byte) 4);
                final ArrayList arrayList2 = new ArrayList(arrayList);
                pVar.b(arrayList2);
                if (pVar != null) {
                    c(pVar);
                }
                final chat.ola.vn.message.f fVar = this.C;
                Runnable runnable = new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.30
                    @Override // java.lang.Runnable
                    public void run() {
                        for (final ab abVar : arrayList2) {
                            chat.ola.vn.u.b.a().a(abVar.c, null, new chat.ola.vn.u.o() { // from class: chat.ola.vn.activity.OlaChatViewActivity.30.1
                                private void a() {
                                    p pVar2;
                                    List<ab> listA;
                                    try {
                                        chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(pVar.j(), pVar.s());
                                        if (fVarD == null || (pVar2 = (p) fVarD.o(pVar.p())) == null || (listA = pVar2.a()) == null) {
                                            return;
                                        }
                                        listA.remove(abVar);
                                        pVar2.b(listA);
                                    } catch (Throwable unused) {
                                    }
                                }

                                @Override // chat.ola.vn.u.o
                                public void a(int i, int i2) {
                                }

                                @Override // chat.ola.vn.u.o
                                public void a(chat.ola.vn.entity.i iVar) {
                                    p pVar2;
                                    List<ab> listA;
                                    boolean z;
                                    try {
                                        abVar.b = (byte) 0;
                                        abVar.c = iVar.d();
                                        chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(pVar.j(), pVar.s());
                                        if (fVarD == null || (pVar2 = (p) fVarD.o(pVar.p())) == null || (listA = pVar2.a()) == null) {
                                            return;
                                        }
                                        String str = "";
                                        Iterator<ab> it3 = listA.iterator();
                                        while (true) {
                                            z = true;
                                            if (!it3.hasNext()) {
                                                break;
                                            }
                                            ab next = it3.next();
                                            if (next.b == 1) {
                                                z = false;
                                                break;
                                            }
                                            if (chat.ola.vn.util.m.a(str)) {
                                                str = "##" + next.c + "#";
                                            } else {
                                                str = str + " ##" + next.c + "#";
                                            }
                                        }
                                        if (z) {
                                            OlaChatViewActivity.this.a(fVar, str, 0, pVar.p());
                                            if (fVar.k() == 4) {
                                                pVar.b((byte) 2);
                                            }
                                        }
                                    } catch (Throwable th) {
                                        th.printStackTrace();
                                    }
                                }

                                @Override // chat.ola.vn.u.o
                                public void a(String str) {
                                    a();
                                }

                                @Override // chat.ola.vn.u.o
                                public void a(String str, int i) {
                                    a();
                                }

                                @Override // chat.ola.vn.u.o
                                public void a(String str, int i, String str2) {
                                    a();
                                }

                                @Override // chat.ola.vn.u.o
                                public void a(String str, String str2) {
                                    a();
                                }

                                @Override // chat.ola.vn.u.o
                                public void b(String str, String str2) {
                                    a();
                                }
                            });
                        }
                    }
                };
                pVar.a(runnable);
                runnable.run();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        try {
            if (this.C.B) {
                chat.ola.vn.h.t.a(this.C);
            }
        } catch (Throwable unused) {
        }
        try {
            OlaApplication.c.c();
        } catch (Throwable unused2) {
        }
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused3) {
        }
    }

    @Override // chat.ola.vn.view.h.b
    public void g(String str) {
        p(str + " ");
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void g(String str, short s) {
        try {
            if (this.C.k() == s && chat.ola.vn.util.m.b(str, this.C.j())) {
                chat.ola.vn.m.e.b(this);
                finish();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void g(List<String> list) {
    }

    @Override // chat.ola.vn.p.f
    public boolean g(chat.ola.vn.message.f fVar) {
        try {
            return fVar.equals(this.C);
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void h(String str) {
        a_(str);
    }

    @Override // chat.ola.vn.view.e.a
    public void h(String str, short s) {
        t tVarA;
        try {
            byte[] bArrA = com.mg.ola.common.d.c.a(new File(str));
            if (bArrA == null || bArrA.length <= 0 || bArrA.length >= 512000 || this.C == null || (tVarA = chat.ola.vn.message.e.a(chat.ola.vn.h.a(), this.C.j(), this.C.k(), chat.ola.vn.h.H, (byte) 2)) == null) {
                return;
            }
            tVarA.b((byte) 1);
            tVarA.a(str, s);
            c(tVarA);
            short sK = this.C.k();
            if (sK == 0) {
                OlaApplication.b.a(this.C.j(), bArrA, s);
            } else {
                if (sK != 2) {
                    return;
                }
                OlaApplication.b.b(this.C.j(), bArrA, s);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.contactpicker.OlaContactPickerActivity.b
    public void h(List<chat.ola.vn.message.f> list) {
        if (list != null) {
            try {
                if (list.size() == 0) {
                    return;
                }
                if (this.C.k() == 2) {
                    if (list == null || list.size() <= 0) {
                        return;
                    }
                    String[] strArr = new String[list.size()];
                    for (int i = 0; i < strArr.length; i++) {
                        strArr[i] = list.get(i).j();
                    }
                    OlaApplication.b.a(this.C.j(), strArr);
                    return;
                }
                if (this.C.k() == 0) {
                    Iterator<chat.ola.vn.message.f> it2 = list.iterator();
                    boolean z = true;
                    while (it2.hasNext()) {
                        if (it2.next().equals(this.C)) {
                            z = false;
                        }
                    }
                    if (z) {
                        list.add(this.C);
                    }
                    String str = OlaApplication.a(R.string.string_chat_group) + " " + (list.size() + 1) + " " + OlaApplication.a(R.string.string_members).toLowerCase(Locale.US);
                    chat.ola.vn.message.f fVarB = chat.ola.vn.h.t.b(".chatgroup." + System.currentTimeMillis(), (short) 2, true);
                    fVarB.c(str);
                    fVarB.a(list);
                    a(fVarB);
                }
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void i(String str) {
    }

    @Override // chat.ola.vn.p.f
    public String i_() {
        if (this.E == null) {
            this.E = "chat.ola.vn.activity.ChatViewActivity" + System.currentTimeMillis();
        }
        return this.E;
    }

    @Override // chat.ola.vn.view.g.e
    public void j(final String str) {
        if (this.C.k() == 0 || this.C.k() == 2 || this.C.k() == 4) {
            final p pVar = new p(new chat.ola.vn.message.d(), (byte) 2);
            pVar.e(this.C.j());
            pVar.c(this.C.k());
            ArrayList arrayList = new ArrayList(1);
            arrayList.add(ab.b(str));
            pVar.b(arrayList);
            if (pVar != null) {
                c(pVar);
            }
            if (this.C.k() == 0) {
                OlaApplication.b.c(this.C.j(), str, pVar.p());
                return;
            }
            if (this.C.k() == 2) {
                if (this.C.X()) {
                    a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.28
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                OlaApplication.b.d(OlaChatViewActivity.this.C.j(), str, pVar.p());
                            } catch (Throwable unused) {
                            }
                        }
                    });
                    return;
                } else {
                    OlaApplication.b.d(this.C.j(), str, pVar.p());
                    return;
                }
            }
            if (this.C.k() == 4) {
                a(this.C, "##" + str + "#", 0, pVar.p());
                pVar.b((byte) 2);
            }
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void k(final String str) {
        if (this.C.k() == 0 || this.C.k() == 2 || this.C.k() == 4) {
            final p pVar = new p(new chat.ola.vn.message.d(), (byte) 2);
            pVar.e(this.C.j());
            pVar.c(this.C.k());
            ArrayList arrayList = new ArrayList(1);
            arrayList.add(ab.c(str));
            pVar.b(arrayList);
            if (pVar != null) {
                c(pVar);
            }
            if (this.C.k() == 0) {
                OlaApplication.b.c(this.C.j(), str, pVar.p());
                return;
            }
            if (this.C.k() == 2) {
                if (this.C.X()) {
                    a(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.29
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                OlaApplication.b.d(OlaChatViewActivity.this.C.j(), str, pVar.p());
                            } catch (Throwable unused) {
                            }
                        }
                    });
                    return;
                } else {
                    OlaApplication.b.d(this.C.j(), str, pVar.p());
                    return;
                }
            }
            if (this.C.k() == 4) {
                a(this.C, "##" + str + "#", 0, pVar.p());
                pVar.b((byte) 2);
            }
        }
    }

    @Override // chat.ola.vn.view.j.a
    public void l(String str) {
        try {
            n(str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void n() {
        if (this.C != null) {
            a(chat.ola.vn.h.t.b(this.C.j(), this.C.k(), true));
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i == 2 && i2 == -1) {
            try {
                if (this.ax != null && this.ax.exists()) {
                    File file = new File(chat.ola.vn.d.a(this.ax.length()));
                    com.mg.ola.common.d.c.a(this.ax, file, true);
                    this.ax.delete();
                    a_(file.getAbsolutePath());
                }
            } catch (Throwable unused) {
            }
        }
        this.ax = null;
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        switch (this.ae) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
                this.ae = 0;
                j(false);
                break;
            default:
                try {
                    if (Z.a(this)) {
                        Z = null;
                        finish();
                    }
                    break;
                } catch (Throwable unused) {
                }
                super.onBackPressed();
                break;
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.cameraImageButton /* 2131296579 */:
                    an();
                    return;
                case R.id.chatTextSmileyImageButton /* 2131296604 */:
                    this.ae = 1;
                    if (this.M.a()) {
                        f(false);
                        return;
                    }
                    break;
                case R.id.kulImageButton /* 2131296968 */:
                    f(false);
                    this.ae = 2;
                    if (this.M.a()) {
                        return;
                    }
                    break;
                case R.id.likeButton /* 2131296979 */:
                    a("(y)", 0, false);
                    Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.zoom_icon_animation);
                    animationLoadAnimation.setDuration(150L);
                    this.v.startAnimation(animationLoadAnimation);
                    return;
                case R.id.localPhotoImageButton /* 2131297040 */:
                    U();
                    return;
                case R.id.moreImageButton /* 2131297120 */:
                    String string = this.q.getText().toString();
                    if (!chat.ola.vn.util.m.a(string)) {
                        a(string, 0, true);
                        return;
                    }
                    f(false);
                    this.ae = 5;
                    if (this.M.a()) {
                        return;
                    }
                    break;
                    break;
                case R.id.olaActionBarBackImageView /* 2131297178 */:
                    if (this.C.k() != 4 || chat.ola.vn.h.t.q() > 0) {
                        chat.ola.vn.m.e.b(this);
                    } else {
                        l.a(this);
                    }
                    finish();
                    return;
                case R.id.olaActionBarButtonImageView /* 2131297181 */:
                    V();
                    return;
                case R.id.olaActionBarMoreButtonImageView /* 2131297185 */:
                    v();
                    return;
                case R.id.olaActionBarTitleViewLayout /* 2131297188 */:
                case R.id.vipIconImageView /* 2131297775 */:
                    if (this.C.k() == 0) {
                        chat.ola.vn.me.c.a(this, OlaApplication.b, this.C.j(), (n) null);
                        return;
                    }
                    return;
                case R.id.quickReplyImageButton /* 2131297275 */:
                    au();
                    return;
                case R.id.rightMenuAddMemberButton /* 2131297311 */:
                    W();
                    OlaContactPickerActivity.a(this, this.C.F(), this);
                    return;
                case R.id.scrollDownIndicatorView /* 2131297351 */:
                    h(true);
                    return;
                case R.id.sendTextView /* 2131297382 */:
                    this.aA = true;
                    a(this.q.getText().toString(), 0, true);
                    Animation animationLoadAnimation2 = AnimationUtils.loadAnimation(this, R.anim.disappear_animation);
                    animationLoadAnimation2.setDuration(200L);
                    animationLoadAnimation2.setAnimationListener(new Animation.AnimationListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.3
                        @Override // android.view.animation.Animation.AnimationListener
                        public void onAnimationEnd(Animation animation) {
                            try {
                                OlaChatViewActivity.this.u.setVisibility(8);
                                Animation animationLoadAnimation3 = AnimationUtils.loadAnimation(OlaChatViewActivity.this, R.anim.appear_animation);
                                animationLoadAnimation3.setDuration(200L);
                                OlaChatViewActivity.this.v.startAnimation(animationLoadAnimation3);
                                OlaChatViewActivity.this.v.setVisibility(0);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // android.view.animation.Animation.AnimationListener
                        public void onAnimationRepeat(Animation animation) {
                        }

                        @Override // android.view.animation.Animation.AnimationListener
                        public void onAnimationStart(Animation animation) {
                        }
                    });
                    this.u.startAnimation(animationLoadAnimation2);
                    return;
                case R.id.voiceImageButton /* 2131297792 */:
                    f(false);
                    this.ae = 4;
                    if (this.M.a()) {
                        return;
                    }
                    break;
                default:
                    return;
            }
            j(false);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        if (this.az != configuration.orientation) {
            this.az = configuration.orientation;
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_chat_view_resizable_layout);
        try {
            Bundle extras = getIntent().getExtras();
            String string = extras.getString("_conv_id");
            short s = extras.getShort("_conv_type");
            if (!chat.ola.vn.util.m.a(string)) {
                e = string;
                f = s;
            }
        } catch (Throwable unused) {
        }
        try {
            if (g == 0) {
                g = chat.ola.vn.e.a().e();
            }
        } catch (Throwable unused2) {
        }
        this.B = AnimationUtils.loadAnimation(this, R.anim.fade_notify_animation);
        this.S = AnimationUtils.loadAnimation(this, R.anim.fade_in);
        this.S.setDuration(200L);
        this.T = AnimationUtils.loadAnimation(this, R.anim.fade_out);
        this.T.setDuration(200L);
        T();
        ae();
        this.o = new o(this, null);
        this.o.a(new View.OnClickListener() { // from class: chat.ola.vn.activity.OlaChatViewActivity.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                OlaChatViewActivity.this.onMessageItemButtonClick(view);
            }
        });
        this.o.a((View.OnLongClickListener) this);
        this.p.setAdapter((ListAdapter) this.o);
        this.K = new r(this);
        this.L = new z(this);
        this.I.setAdapter((ListAdapter) this.K);
        try {
            if (this.X == null && x.s) {
                this.X = new chat.ola.vn.util.d.a(this);
                this.X.a(new a.InterfaceC0053a() { // from class: chat.ola.vn.activity.OlaChatViewActivity.12
                    @Override // chat.ola.vn.util.d.a.InterfaceC0053a
                    public void a() {
                        try {
                            if (x.s) {
                                long jCurrentTimeMillis = System.currentTimeMillis();
                                if (jCurrentTimeMillis - OlaChatViewActivity.this.C.t > 10000) {
                                    OlaChatViewActivity.this.a(chat.ola.vn.f.c.a, 0, false);
                                    OlaChatViewActivity.this.C.t = jCurrentTimeMillis;
                                }
                            }
                        } catch (Throwable unused3) {
                        }
                    }
                });
            }
        } catch (Throwable unused3) {
        }
        this.p.postDelayed(new Runnable() { // from class: chat.ola.vn.activity.OlaChatViewActivity.23
            @Override // java.lang.Runnable
            public void run() {
                OlaChatViewActivity.this.e(false);
            }
        }, 3000L);
        if (OlaApplication.b != null) {
            OlaApplication.b.a(this);
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        try {
            this.F.removeCallbacks(this.G);
            this.F = null;
            this.G = null;
            this.X = null;
        } catch (Throwable unused) {
        }
        try {
            if (this.q != null) {
                this.q.removeTextChangedListener(this);
            }
            ad();
            this.C = null;
        } catch (Throwable unused2) {
        }
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            if (adapterView == this.I) {
                if (this.C.k() == 4) {
                    chat.ola.vn.message.f fVarC = chat.ola.vn.h.x.c(i);
                    if (fVarC == null) {
                        return;
                    }
                    ad();
                    a(fVarC);
                    this.L.notifyDataSetChanged();
                    if (this.N == null) {
                        return;
                    }
                } else {
                    chat.ola.vn.message.f fVarC2 = chat.ola.vn.h.t.c(i);
                    if (fVarC2 == null) {
                        return;
                    }
                    if (fVarC2.k() == 5) {
                        try {
                            if (((u) fVarC2).a(this)) {
                                chat.ola.vn.h.t.b(fVarC2);
                            }
                        } catch (Throwable unused) {
                        }
                    } else if (fVarC2.k() != 6) {
                        if (fVarC2.k() == 7) {
                            OlaOtherPeopleListActivity.a(this);
                        } else {
                            ad();
                            a(fVarC2);
                        }
                    }
                    this.K.notifyDataSetChanged();
                    if (this.N == null) {
                        return;
                    }
                }
            } else {
                if (adapterView != this.J) {
                    return;
                }
                a(this.O.getItem(i));
                if (this.N == null) {
                    return;
                }
            }
            W();
        } catch (Throwable unused2) {
        }
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.cameraImageButton) {
                an();
                return true;
            }
            if (id != R.id.chatMessageTextContentView && id != R.id.chatRssViewLayout && id != R.id.imgMeYoutubeThumbnail1) {
                if (id == R.id.likeButton) {
                    a("(Y)", 0, false);
                    Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.zoom_icon_animation);
                    animationLoadAnimation.setDuration(150L);
                    this.v.startAnimation(animationLoadAnimation);
                    return true;
                }
                if (id == R.id.localPhotoImageButton) {
                    ap();
                    return true;
                }
                if (id == R.id.quickReplyImageButton) {
                    OlaQuickReplyComposerActivity.a(this);
                    return true;
                }
                switch (id) {
                    case R.id.mediaImageView1 /* 2131297096 */:
                    case R.id.mediaImageView2 /* 2131297097 */:
                    case R.id.mediaImageView3 /* 2131297098 */:
                    case R.id.mediaImageView4 /* 2131297099 */:
                    case R.id.mediaImageView5 /* 2131297100 */:
                        break;
                    default:
                        return false;
                }
            }
            try {
                return b((chat.ola.vn.message.d) view.getTag());
            } catch (Throwable unused) {
                return true;
            }
        } catch (Throwable unused2) {
            return false;
        }
    }

    public void onMessageItemButtonClick(View view) {
        try {
            Object tag = view.getTag();
            switch (view.getId()) {
                case R.id.bookmarkImageButton /* 2131296402 */:
                    chat.ola.vn.message.d dVar = (chat.ola.vn.message.d) view.getTag();
                    OlaApplication.b.d(this.C.j(), this.C.k(), dVar.p());
                    dVar.x = false;
                    this.o.notifyDataSetChanged();
                    break;
                case R.id.btnMakeFriend /* 2131296479 */:
                    if (((chat.ola.vn.message.d) view.getTag()) != null) {
                        OlaApplication.b.b(chat.ola.vn.util.m.j(this.C.j()), (String) null);
                    }
                    break;
                case R.id.messageLocationThumbnail /* 2131297108 */:
                    chat.ola.vn.message.d dVar2 = (chat.ola.vn.message.d) tag;
                    k kVar = (k) dVar2;
                    String strI = dVar2.d() == 1 ? dVar2.i() : chat.ola.vn.h.a();
                    chat.ola.vn.util.b.a(this, kVar.C(), kVar.a(), "@" + strI);
                    break;
                case R.id.messageSenderTextview /* 2131297109 */:
                    a((chat.ola.vn.message.d) view.getTag());
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        try {
            Bundle extras = intent.getExtras();
            String string = extras.getString("_conv_id");
            short s = extras.getShort("_conv_type");
            if (chat.ola.vn.util.m.a(string)) {
                return;
            }
            e = string;
            f = s;
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
        try {
            this.X.b();
        } catch (Throwable unused) {
        }
        try {
            chat.ola.vn.h.t.b(this);
            this.q.removeTextChangedListener(this);
            ad();
        } catch (Throwable unused2) {
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        if (i == 103) {
            if (iArr[0] == 0) {
                f(false);
                this.ae = 3;
                if (this.M.a()) {
                    return;
                }
                j(false);
                return;
            }
            return;
        }
        if (i == 101) {
            if (chat.ola.vn.n.b.b(this)) {
                at();
                return;
            } else {
                chat.ola.vn.i.i.a(this, R.string.dialog_title_inform, R.string.message_require_location_permission);
                return;
            }
        }
        if (i == 105 && iArr[0] == 0) {
            ao();
        }
    }

    @Override // android.app.Activity
    protected void onRestoreInstanceState(Bundle bundle) {
        super.onRestoreInstanceState(bundle);
        if (bundle != null) {
            String string = bundle.getString("_conv_id");
            if (chat.ola.vn.util.m.a(string)) {
                finish();
            } else {
                this.C = chat.ola.vn.h.t.b(string, bundle.getShort("_conv_type"), true);
            }
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        if (bundle != null) {
            if (this.C != null) {
                bundle.putString("_conv_id", this.C.j());
                bundle.putShort("_conv_type", this.C.k());
            }
            try {
                Parcelable parcelableOnSaveInstanceState = this.p.onSaveInstanceState();
                if (parcelableOnSaveInstanceState != null) {
                    bundle.putParcelable("BUNDLE_LIST_VIEW_PARCELABLE", parcelableOnSaveInstanceState);
                }
            } catch (Throwable unused) {
            }
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        CharSequence charSequenceB;
        try {
            if (this.C != null) {
                if (i + i2 >= i3) {
                    this.C.D = -1;
                } else {
                    this.C.D = i;
                }
            }
            this.am = i;
            this.an = i2;
            this.ao = i3;
            if (this.o != null) {
                if (i2 + i >= this.o.getCount()) {
                    g(false);
                }
                if (i < 0 || this.k == i) {
                    return;
                }
                this.k = i;
                this.l = this.k + 1;
                this.l = Math.min(this.l, this.o.getCount() - 1);
                this.j = this.k - 1;
                this.j = Math.max(this.j, 0);
                chat.ola.vn.message.d dVarA = this.o.getItem(this.j);
                chat.ola.vn.message.d dVarA2 = this.o.getItem(this.k);
                chat.ola.vn.message.d dVarA3 = this.o.getItem(this.l);
                if (dVarA.e() != 4) {
                    if (dVarA.e() != 4) {
                        charSequenceB = com.mg.ola.common.d.i.b(dVarA.m(), chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a());
                    } else if (dVarA3.e() == 4) {
                        return;
                    } else {
                        charSequenceB = com.mg.ola.common.d.i.b(dVarA2.m(), chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a());
                    }
                    o(charSequenceB.toString());
                }
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i) {
        if (i != 0) {
            return;
        }
        try {
            if (this.ao - (this.am + this.an) > 10) {
                if (this.ad.getVisibility() == 8) {
                    this.ad.startAnimation(this.S);
                    this.ad.setVisibility(0);
                }
            } else if (this.ad.getVisibility() == 0) {
                this.ad.startAnimation(this.T);
                this.ad.setVisibility(8);
            }
        } catch (Throwable unused) {
        }
        try {
            View childAt = this.p.getChildAt(0);
            this.C.E = childAt == null ? 0 : childAt.getTop();
            if (this.C.D >= 0) {
                this.p.setTranscriptMode(1);
            } else {
                this.p.setTranscriptMode(2);
            }
            if (this.p.getFirstVisiblePosition() <= 6 && this.C.Q && chat.ola.vn.h.g()) {
                String strT = this.C.T();
                if (this.C.k() == 2 && !this.C.X()) {
                    if (chat.ola.vn.util.m.a(strT, this.C.O)) {
                        return;
                    }
                    if (OlaApplication.b.h(this.C.j(), strT, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaChatViewActivity.16
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 55;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                            OlaChatViewActivity.this.e(false);
                            OlaChatViewActivity.this.S();
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                            OlaChatViewActivity.this.e(false);
                            OlaChatViewActivity.this.S();
                        }
                    }))) {
                        e(true);
                        this.C.O = strT;
                        this.C.Q = true;
                        return;
                    }
                    e(false);
                    S();
                }
                if (chat.ola.vn.util.m.b(strT, "null") || chat.ola.vn.util.m.a(strT, this.C.O)) {
                    return;
                }
                if (OlaApplication.b.i(this.C.j(), strT, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaChatViewActivity.17
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 55;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        OlaChatViewActivity.this.e(false);
                        OlaChatViewActivity.this.S();
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        OlaChatViewActivity.this.e(false);
                        OlaChatViewActivity.this.S();
                    }
                }))) {
                    e(true);
                    this.C.O = strT;
                    this.C.Q = true;
                    return;
                }
                e(false);
                S();
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // android.text.TextWatcher
    public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        if (i3 <= 0 || this.C == null || OlaApplication.b == null || System.currentTimeMillis() - this.H < 1500) {
            return;
        }
        this.H = System.currentTimeMillis();
        if (this.C.k() == 2) {
            OlaApplication.b.f(this.C.j());
        } else {
            OlaApplication.b.g(this.C.j());
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:14:0x0022, code lost:
    
        if (r2.ae == 0) goto L20;
     */
    /* JADX WARN: Code restructure failed: missing block: B:19:0x002d, code lost:
    
        if (r2.ae == 0) goto L20;
     */
    /* JADX WARN: Code restructure failed: missing block: B:20:0x002f, code lost:
    
        f(false);
     */
    /* JADX WARN: Code restructure failed: missing block: B:21:0x0032, code lost:
    
        return false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:22:0x0033, code lost:
    
        r2.ae = 0;
        j(false);
     */
    @Override // android.view.View.OnTouchListener
    @android.annotation.SuppressLint({"ClickableViewAccessibility"})
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean onTouch(android.view.View r3, android.view.MotionEvent r4) {
        /*
            r2 = this;
            int r3 = r3.getId()
            r0 = 2131297043(0x7f090313, float:1.821202E38)
            r1 = 0
            if (r3 == r0) goto L25
            r0 = 2131297185(0x7f0903a1, float:1.8212308E38)
            if (r3 == r0) goto L1a
            r4 = 2131297636(0x7f090564, float:1.8213223E38)
            if (r3 == r4) goto L15
            return r1
        L15:
            r3 = 1
            r2.h(r3)
            return r1
        L1a:
            int r3 = r4.getAction()
            if (r3 != 0) goto L38
            int r3 = r2.ae
            if (r3 != 0) goto L33
            goto L2f
        L25:
            int r3 = r4.getAction()
            if (r3 != 0) goto L38
            int r3 = r2.ae
            if (r3 != 0) goto L33
        L2f:
            r2.f(r1)
            return r1
        L33:
            r2.ae = r1
            r2.j(r1)
        L38:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaChatViewActivity.onTouch(android.view.View, android.view.MotionEvent):boolean");
    }

    /* JADX WARN: Failed to find 'out' block for switch in B:5:0x001a. Please report as an issue. */
    /* JADX WARN: Removed duplicated region for block: B:10:0x004a  */
    /* JADX WARN: Removed duplicated region for block: B:9:0x0045  */
    @Override // chat.ola.vn.c
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected android.app.Dialog v() {
        /*
            r7 = this;
            java.util.ArrayList r0 = new java.util.ArrayList
            r0.<init>()
            chat.ola.vn.message.f r1 = r7.C
            short r1 = r1.k()
            r2 = 4
            if (r1 == r2) goto L98
            r2 = 2131691039(0x7f0f061f, float:1.9011139E38)
            r3 = 2131690583(0x7f0f0457, float:1.9010214E38)
            r4 = 2131690980(0x7f0f05e4, float:1.9011019E38)
            r5 = 2131690669(0x7f0f04ad, float:1.9010388E38)
            switch(r1) {
                case 0: goto L57;
                case 1: goto L4f;
                case 2: goto L1f;
                default: goto L1d;
            }
        L1d:
            goto La0
        L1f:
            r1 = 2131690793(0x7f0f0529, float:1.901064E38)
            java.lang.String r1 = r7.getString(r1)
            r0.add(r1)
            r1 = 2131690958(0x7f0f05ce, float:1.9010974E38)
            java.lang.String r1 = r7.getString(r1)
            r0.add(r1)
            java.lang.String r1 = r7.getString(r4)
            r0.add(r1)
            java.lang.String r1 = r7.getString(r5)
            r0.add(r1)
            boolean r1 = r7.ab
            if (r1 == 0) goto L4a
        L45:
            java.lang.String r1 = r7.getString(r3)
            goto L53
        L4a:
            java.lang.String r1 = r7.getString(r2)
            goto L53
        L4f:
            java.lang.String r1 = r7.getString(r5)
        L53:
            r0.add(r1)
            goto La0
        L57:
            chat.ola.vn.message.g r1 = chat.ola.vn.h.t
            chat.ola.vn.message.f r6 = r7.C
            java.lang.String r6 = r6.j()
            boolean r1 = r1.c(r6)
            if (r1 != 0) goto L6f
            r6 = 2131690832(0x7f0f0550, float:1.9010719E38)
            java.lang.String r6 = r7.getString(r6)
            r0.add(r6)
        L6f:
            java.lang.String r4 = r7.getString(r4)
            r0.add(r4)
            java.lang.String r4 = r7.getString(r5)
            r0.add(r4)
            r4 = 2131690642(0x7f0f0492, float:1.9010333E38)
            java.lang.String r4 = r7.getString(r4)
            r0.add(r4)
            if (r1 == 0) goto L93
            r1 = 2131690554(0x7f0f043a, float:1.9010155E38)
            java.lang.String r1 = r7.getString(r1)
            r0.add(r1)
        L93:
            boolean r1 = r7.ab
            if (r1 == 0) goto L4a
            goto L45
        L98:
            r1 = 2131690956(0x7f0f05cc, float:1.901097E38)
            java.lang.String r1 = r7.getString(r1)
            goto L53
        La0:
            chat.ola.vn.i.m r1 = new chat.ola.vn.i.m
            r1.<init>(r7)
            r1.a(r0)
            chat.ola.vn.activity.OlaChatViewActivity$19 r2 = new chat.ola.vn.activity.OlaChatViewActivity$19
            r2.<init>()
            r1.a(r2)
            r1.show()
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaChatViewActivity.v():android.app.Dialog");
    }

    @Override // chat.ola.vn.c
    public FrameLayout z() {
        return this.t;
    }
}
