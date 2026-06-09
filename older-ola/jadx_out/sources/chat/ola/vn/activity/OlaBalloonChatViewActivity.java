package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.graphics.Rect;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.widget.helper.ItemTouchHelper;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Display;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.animation.DecelerateInterpolator;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.o;
import chat.ola.vn.b.r;
import chat.ola.vn.balloon.b;
import chat.ola.vn.c;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.contactpicker.OlaContactPickerActivity;
import chat.ola.vn.entity.ab;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entity.w;
import chat.ola.vn.message.OlaOtherPeopleListActivity;
import chat.ola.vn.message.aa;
import chat.ola.vn.message.k;
import chat.ola.vn.message.p;
import chat.ola.vn.message.u;
import chat.ola.vn.n.b;
import chat.ola.vn.p.f;
import chat.ola.vn.tradingvip.OlaTraddingVipActivity;
import chat.ola.vn.transferken.OlaTransferKenActivity;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.d;
import chat.ola.vn.view.e;
import chat.ola.vn.view.f;
import chat.ola.vn.view.g;
import chat.ola.vn.view.h;
import chat.ola.vn.view.i;
import chat.ola.vn.view.j;
import com.mg.ola.common.widget.SoftKeyLinearLayout;
import com.mg.ola.common.widget.a.a;
import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
public class OlaBalloonChatViewActivity extends c implements TextWatcher, View.OnClickListener, View.OnLongClickListener, View.OnTouchListener, AbsListView.OnScrollListener, AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener, OlaContactPickerActivity.b, f, e.a, f.a, g.e, h.b, i.e, j.a, a {
    private static Animation N = null;
    private static Animation O = null;
    public static Bitmap f = null;
    public static Bitmap g = null;
    private static int i = -1;
    private static int j = -1;
    private OlaCachedImageView A;
    private TextView B;
    private View C;
    private OlaCachedImageView D;
    private TextView E;
    private chat.ola.vn.message.f F;
    private o G;
    private r H;
    private View K;
    private com.mg.ola.a.a.b.c L;
    private Button Q;
    private ImageButton R;
    private FrameLayout S;
    private ImageButton aa;
    private ImageButton ab;
    private ImageButton ac;
    private ImageButton ad;
    private ImageButton ae;
    private ImageButton af;
    private ImageButton ag;
    private View ah;
    private chat.ola.vn.i.c ak;
    private File am;
    protected FrameLayout h;
    private SoftKeyLinearLayout k;
    private ListView l;
    private EditText m;
    private TextView n;
    private TextView o;
    private View p;
    private View q;
    private View r;
    private OlaCachedImageView s;
    private View t;
    private OlaCachedImageView u;
    private TextView v;
    private View w;
    private OlaCachedImageView x;
    private TextView y;
    private View z;
    protected boolean e = true;
    private long I = 0;
    private String J = null;
    private int M = 150;
    private boolean P = false;
    private h T = null;
    private i U = null;
    private d V = null;
    private g W = null;
    private j X = null;
    private chat.ola.vn.view.f Y = null;
    private d Z = null;
    private int ai = 0;
    private int aj = 0;
    private boolean al = false;

    public static boolean E() {
        try {
            return m.a(b_.getClass().getName(), OlaBalloonChatViewActivity.class.getName());
        } catch (Throwable unused) {
            return false;
        }
    }

    public static void F() {
        try {
            if (E()) {
                b_.finish();
            }
        } catch (Throwable unused) {
        }
    }

    private void R() {
        setContentView(R.layout.balloon_chat_view_layout);
        this.h = (FrameLayout) findViewById(R.id.chatDrawerLayout);
        this.k = (SoftKeyLinearLayout) findViewById(R.id.softKeyResizableViewLayout);
        this.k.setOnSoftKeyboardListener(this);
        this.K = findViewById(R.id.ballonChatViewContent);
        this.n = (TextView) findViewById(R.id.txtActionTitle);
        this.o = (TextView) findViewById(R.id.txtActionSubTitle);
        findViewById(R.id.linearActionBar).setOnClickListener(this);
        this.l = (ListView) findViewById(R.id.lvBubbleList);
        this.l.setOnItemClickListener(this);
        this.l.setTranscriptMode(2);
        this.l.setSelector(new ColorDrawable(0));
        this.l.setOnItemLongClickListener(this);
        this.l.setOnScrollListener(this);
        this.l.setOnTouchListener(this);
        this.l.setBackgroundColor(chat.ola.vn.f.g);
        findViewById(R.id.txtTypingLinear).setVisibility(8);
        View view = new View(this);
        view.setLayoutParams(new AbsListView.LayoutParams(2, getResources().getDimensionPixelSize(R.dimen.general_list_item_height_small)));
        this.l.addFooterView(view);
        this.m = (EditText) findViewById(R.id.chatMessageEditText);
        this.m.setOnTouchListener(this);
        this.m.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.12
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i2, KeyEvent keyEvent) {
                if (keyEvent != null && (keyEvent.getKeyCode() == 66 || i2 == 4)) {
                    OlaBalloonChatViewActivity.this.a(OlaBalloonChatViewActivity.this.m.getText().toString(), 0, true);
                }
                return false;
            }
        });
        this.m.setOnKeyListener(new View.OnKeyListener() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.22
            @Override // android.view.View.OnKeyListener
            public boolean onKey(View view2, int i2, KeyEvent keyEvent) {
                if (i2 != 66) {
                    return false;
                }
                OlaBalloonChatViewActivity.this.a(OlaBalloonChatViewActivity.this.m.getText().toString(), 0, true);
                return true;
            }
        });
        this.m.addTextChangedListener(this);
        this.m.setOnTouchListener(this);
        this.Q = (Button) findViewById(R.id.sendTextView);
        this.Q.setText(getString(R.string.string_send).toUpperCase(Locale.US));
        this.Q.setOnClickListener(this);
        this.R = (ImageButton) findViewById(R.id.likeButton);
        this.R.setOnClickListener(this);
        this.R.setOnLongClickListener(this);
        this.q = findViewById(R.id.avatarListViewLayout);
        this.r = findViewById(R.id.conversationListBalloon);
        this.r.setOnClickListener(this);
        this.s = (OlaCachedImageView) this.r.findViewById(R.id.chattingRoundOvatar);
        this.s.a(b.a(this, BitmapFactory.decodeResource(getResources(), R.drawable.balloon_conversation_list), false, true), null);
        this.t = findViewById(R.id.conversationBalloon1);
        this.t.setOnClickListener(this);
        this.u = (OlaCachedImageView) this.t.findViewById(R.id.chattingRoundOvatar);
        this.v = (TextView) this.t.findViewById(R.id.txtChatNotify);
        this.w = findViewById(R.id.conversationBalloon2);
        this.w.setOnClickListener(this);
        this.x = (OlaCachedImageView) this.w.findViewById(R.id.chattingRoundOvatar);
        this.y = (TextView) this.w.findViewById(R.id.txtChatNotify);
        this.z = findViewById(R.id.conversationBalloon3);
        this.z.setOnClickListener(this);
        this.A = (OlaCachedImageView) this.z.findViewById(R.id.chattingRoundOvatar);
        this.B = (TextView) this.z.findViewById(R.id.txtChatNotify);
        this.C = findViewById(R.id.conversationBalloon4);
        this.C.setOnClickListener(this);
        this.D = (OlaCachedImageView) this.C.findViewById(R.id.chattingRoundOvatar);
        this.E = (TextView) this.C.findViewById(R.id.txtChatNotify);
        S();
    }

    private void S() {
        this.p = findViewById(R.id.chatInputAndAttachmentViewLayout);
        this.ah = findViewById(R.id.chatTextInputLayout);
        this.S = (FrameLayout) findViewById(R.id.chatAttachmentFrameLayout);
        this.aa = (ImageButton) findViewById(R.id.quickReplyImageButton);
        this.aa.setOnClickListener(this);
        if (x.y) {
            this.aa.setVisibility(0);
        } else {
            this.aa.setVisibility(8);
        }
        this.ab = (ImageButton) findViewById(R.id.chatTextSmileyImageButton);
        this.ab.setOnClickListener(this);
        this.ac = (ImageButton) findViewById(R.id.cameraImageButton);
        this.ac.setOnClickListener(this);
        this.ac.setOnLongClickListener(this);
        if (com.mg.ola.common.d.g.f()) {
            this.ac.setVisibility(0);
        } else {
            this.ac.setVisibility(8);
        }
        this.ad = (ImageButton) findViewById(R.id.kulImageButton);
        this.ad.setOnClickListener(this);
        this.ae = (ImageButton) findViewById(R.id.localPhotoImageButton);
        this.ae.setOnClickListener(this);
        this.af = (ImageButton) findViewById(R.id.voiceImageButton);
        this.af.setOnClickListener(this);
        this.ag = (ImageButton) findViewById(R.id.moreImageButton);
        this.ag.setOnClickListener(this);
    }

    private int T() {
        if (this.r.isSelected()) {
            return 0;
        }
        if (this.t.isSelected()) {
            return 1;
        }
        if (this.w.isSelected()) {
            return 2;
        }
        if (this.z.isSelected()) {
            return 3;
        }
        return this.C.isSelected() ? 4 : -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void U() {
        Intent intent = getIntent();
        if (intent != null) {
            String stringExtra = intent.getStringExtra("_conv_id");
            short shortExtra = intent.getShortExtra("_conv_type", (short) 0);
            if (m.a(stringExtra)) {
                finish();
                return;
            }
            this.F = chat.ola.vn.h.t.b(stringExtra, shortExtra, true);
            OlaApplication.c.f();
            a(this.F);
        }
    }

    private boolean V() {
        if (this.F.D < 0) {
            d(false);
            return false;
        }
        this.l.setTranscriptMode(1);
        try {
            this.l.setSelectionFromTop(this.F.D, this.F.E);
            return true;
        } catch (Throwable unused) {
            this.l.setSelection(this.F.D);
            return true;
        }
    }

    private View W() {
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void X() {
        try {
            this.K.setVisibility(0);
            if (this.L != null) {
                this.L.b();
            }
            int dimensionPixelSize = getResources().getDimensionPixelSize(R.dimen.head_notify_icon_size);
            View viewW = W();
            Rect rect = new Rect(0, 0, 0, 0);
            if (viewW != null) {
                viewW.getGlobalVisibleRect(rect);
            }
            Rect rect2 = new Rect(0, dimensionPixelSize, chat.ola.vn.e.c, chat.ola.vn.e.d);
            int i2 = -n.a(this);
            rect.offset(0, i2);
            rect2.offset(0, i2);
            float fWidth = rect.width() / rect2.width();
            com.mg.ola.a.a.c.b.b(this.K, 0.0f);
            com.mg.ola.a.a.c.b.c(this.K, 0.0f);
            com.mg.ola.a.a.b.c cVar = new com.mg.ola.a.a.b.c();
            com.mg.ola.a.a.b.j jVarA = com.mg.ola.a.a.b.j.a(this.K, "translationX", rect.left, rect2.left);
            com.mg.ola.a.a.b.j jVarA2 = com.mg.ola.a.a.b.j.a(this.K, "scaleX", fWidth, 1.0f);
            cVar.a(jVarA2).a(com.mg.ola.a.a.b.j.a(this.K, "scaleY", fWidth, 1.0f)).a(jVarA).a(com.mg.ola.a.a.b.j.a(this.K, "alpha", 0.0f, 1.0f)).a(com.mg.ola.a.a.b.j.a(this.q, "alpha", 0.3f, 1.0f));
            cVar.a(this.M);
            cVar.a(new DecelerateInterpolator());
            cVar.a(new com.mg.ola.a.a.b.b() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.26
                @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
                public void a(com.mg.ola.a.a.b.a aVar) {
                    OlaBalloonChatViewActivity.this.L = null;
                    if (OlaBalloonChatViewActivity.this.e) {
                        OlaBalloonChatViewActivity.this.U();
                        OlaBalloonChatViewActivity.this.e = false;
                    }
                }

                @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
                public void b(com.mg.ola.a.a.b.a aVar) {
                    OlaBalloonChatViewActivity.this.L = null;
                    if (OlaBalloonChatViewActivity.this.e) {
                        OlaBalloonChatViewActivity.this.U();
                        OlaBalloonChatViewActivity.this.e = false;
                    }
                }
            });
            cVar.a();
            this.L = cVar;
        } catch (Throwable unused) {
            try {
                this.L = null;
                if (this.e) {
                    U();
                    this.e = false;
                }
            } catch (Throwable unused2) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void Y() {
        super.finish();
        if (OlaApplication.c != null) {
            OlaApplication.c.c();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void Z() {
        aa();
        ab();
    }

    public static Bitmap a(Context context) {
        if (f == null) {
            f = BitmapFactory.decodeResource(context.getResources(), R.drawable.ic_chatgroup_vip);
            f = b.a(context, f, false, false);
        }
        return f;
    }

    public static void a(Context context, String str, short s) {
        try {
            Intent intent = new Intent(context, (Class<?>) OlaBalloonChatViewActivity.class);
            intent.setFlags(402718720);
            intent.putExtra("_conv_id", str);
            intent.putExtra("_conv_type", s);
            context.startActivity(intent);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(chat.ola.vn.message.f fVar, String str, int i2, String str2) {
        try {
            if ((m.a(str) && i2 == 0) || fVar == null) {
                return;
            }
            fVar.B = false;
            if (m.b(str, chat.ola.vn.f.c.b)) {
                str = chat.ola.vn.f.c.a;
            }
            chat.ola.vn.message.d dVarAc = ac();
            dVarAc.f(str);
            dVarAc.b((short) i2);
            dVarAc.h(str2);
            short sK = fVar.k();
            if (sK == 0) {
                if (OlaApplication.b != null) {
                    OlaApplication.b.a(dVarAc.j(), dVarAc.k(), dVarAc.p(), dVarAc.o());
                }
            } else if (sK == 2) {
                if (OlaApplication.b != null) {
                    OlaApplication.b.c(dVarAc.j(), dVarAc.k(), dVarAc.p(), dVarAc.o());
                }
            } else {
                if (sK != 4) {
                    return;
                }
                OlaApplication.b.a(Long.parseLong(dVarAc.j()), dVarAc.k(), dVarAc.o());
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(CharSequence charSequence) {
        this.m.removeTextChangedListener(this);
        this.m.setText(charSequence);
        this.m.setSelection(this.m.length());
        this.m.addTextChangedListener(this);
        b(charSequence);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(String str, final int i2, boolean z) {
        if ((m.a(str) && i2 == 0) || this.F == null) {
            return;
        }
        this.F.d(true);
        if (m.b(str, chat.ola.vn.f.c.b)) {
            str = chat.ola.vn.f.c.a;
        }
        final String str2 = str;
        chat.ola.vn.message.d dVarAc = ac();
        this.F.B = false;
        this.F.H = System.currentTimeMillis();
        dVarAc.f(str2);
        dVarAc.b((short) i2);
        final String strJ = this.F.j();
        final short sK = this.F.k();
        final chat.ola.vn.message.d dVarA = chat.ola.vn.message.e.a(dVarAc, (byte) 2);
        Runnable runnable = new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.6
            private void a() {
                dVarA.b((byte) 4);
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.6.1
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
                        OlaApplication.b.a(Long.parseLong(strJ), dVarA.k(), dVarA.o());
                        dVarA.b((byte) 2);
                        return;
                    }
                    switch (s) {
                        case 0:
                            OlaApplication.b.a(dVarA.j(), str2, dVarA.p(), (short) i2);
                            break;
                        case 1:
                            dVarA.b((byte) 2);
                            OlaApplication.b.a(dVarA.j(), str2, dVarA.p(), (short) i2);
                            return;
                        case 2:
                            OlaApplication.b.c(dVarA.j(), str2, dVarA.p(), (short) i2);
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
        this.F.a(dVarA);
        if (z) {
            a("");
        }
        d(true);
    }

    private void aa() {
        TextView textView;
        View view;
        List<chat.ola.vn.balloon.e> listF = OlaApplication.c.f();
        if (listF == null || listF.size() <= 0) {
            this.t.setVisibility(8);
            this.w.setVisibility(8);
            this.z.setVisibility(8);
            this.C.setVisibility(8);
            return;
        }
        this.t.setVisibility(8);
        this.w.setVisibility(8);
        this.z.setVisibility(8);
        this.C.setVisibility(8);
        int size = listF.size();
        for (int i2 = 0; i2 < 4 && i2 < size; i2++) {
            chat.ola.vn.balloon.e eVar = listF.get(i2);
            OlaCachedImageView olaCachedImageView = null;
            switch (i2) {
                case 0:
                    this.t.setVisibility(0);
                    olaCachedImageView = this.u;
                    textView = this.v;
                    break;
                case 1:
                    this.w.setVisibility(0);
                    olaCachedImageView = this.x;
                    textView = this.y;
                    break;
                case 2:
                    this.z.setVisibility(0);
                    olaCachedImageView = this.A;
                    textView = this.B;
                    break;
                case 3:
                    this.C.setVisibility(0);
                    olaCachedImageView = this.D;
                    textView = this.E;
                    break;
                default:
                    textView = null;
                    break;
            }
            if (olaCachedImageView != null) {
                if (eVar.getContact().k() == 2) {
                    String strO = eVar.getContact().o();
                    if (!m.a(strO)) {
                        t.a().a(strO, olaCachedImageView, a((Context) this), ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION);
                    } else if (!olaCachedImageView.a(eVar.s.j())) {
                        olaCachedImageView.a(a((Context) this), eVar.s.j());
                    }
                } else {
                    t.a().a(eVar.getContact().j(), olaCachedImageView, b((Context) this));
                }
            }
            if (textView != null) {
                int iZ = eVar.getContact().z();
                if (iZ > 0) {
                    textView.setVisibility(0);
                    textView.setText(iZ > 9 ? "9+" : "" + iZ);
                } else {
                    textView.setVisibility(8);
                }
            }
            if (eVar.getContact().equals(this.F) && T() != 0) {
                this.r.setSelected(false);
                this.t.setSelected(false);
                this.w.setSelected(false);
                this.z.setSelected(false);
                this.C.setSelected(false);
                switch (i2) {
                    case 0:
                        view = this.t;
                        view.setSelected(true);
                        break;
                    case 1:
                        view = this.w;
                        view.setSelected(true);
                        break;
                    case 2:
                        view = this.z;
                        view.setSelected(true);
                        break;
                    case 3:
                        view = this.C;
                        view.setSelected(true);
                        break;
                }
            }
        }
    }

    private void ab() {
        TextView textView;
        String strA;
        String str;
        StringBuilder sb;
        String string;
        this.o.setVisibility(0);
        short sK = this.F.k();
        if (sK != 4) {
            switch (sK) {
                case 0:
                case 1:
                    if (m.a(this.F.p())) {
                        this.o.setVisibility(8);
                        this.o.setText("");
                    } else {
                        this.o.setText(R.string.string_in_phone_book);
                        this.o.setVisibility(0);
                    }
                    this.n.setText(this.F.L().toString());
                    try {
                        if (this.F.k() != 0) {
                            this.o.setText(this.F.d());
                            if (this.o.getVisibility() != 0) {
                                this.o.setVisibility(0);
                            }
                        } else if (this.F.K == null || System.currentTimeMillis() - this.F.L >= 300000) {
                            this.F.L = System.currentTimeMillis();
                            final chat.ola.vn.message.f fVar = this.F;
                            OlaApplication.b.b(this.F.j(), new chat.ola.vn.p.d() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.28
                                @Override // chat.ola.vn.p.d
                                public void a(int i2) {
                                    try {
                                        OlaBalloonChatViewActivity.this.F.K = -1L;
                                    } catch (Throwable unused) {
                                    }
                                }

                                @Override // chat.ola.vn.p.d
                                public void a(ag agVar) {
                                    StringBuilder sb2;
                                    String string2;
                                    fVar.K = -1L;
                                    if (agVar.n != 0) {
                                        try {
                                            fVar.K = Long.valueOf(System.currentTimeMillis() - agVar.n);
                                            if (fVar.equals(OlaBalloonChatViewActivity.this.F)) {
                                                String string3 = "";
                                                switch (OlaBalloonChatViewActivity.this.F.h()) {
                                                    case 0:
                                                        sb2 = new StringBuilder();
                                                        sb2.append(" ");
                                                        string2 = OlaBalloonChatViewActivity.this.getString(R.string.string_on_mobile);
                                                        sb2.append(string2);
                                                        string3 = sb2.toString();
                                                        break;
                                                    case 1:
                                                    case 2:
                                                        sb2 = new StringBuilder();
                                                        sb2.append(" ");
                                                        string2 = OlaBalloonChatViewActivity.this.getString(R.string.string_on_web);
                                                        sb2.append(string2);
                                                        string3 = sb2.toString();
                                                        break;
                                                    case 3:
                                                        sb2 = new StringBuilder();
                                                        sb2.append(" ");
                                                        string2 = OlaBalloonChatViewActivity.this.getString(R.string.string_on_apple);
                                                        sb2.append(string2);
                                                        string3 = sb2.toString();
                                                        break;
                                                    case 4:
                                                        sb2 = new StringBuilder();
                                                        sb2.append(" ");
                                                        string2 = OlaBalloonChatViewActivity.this.getString(R.string.string_on_android);
                                                        sb2.append(string2);
                                                        string3 = sb2.toString();
                                                        break;
                                                    case 5:
                                                        sb2 = new StringBuilder();
                                                        sb2.append(" ");
                                                        string2 = OlaBalloonChatViewActivity.this.getString(R.string.string_on_windows_phone);
                                                        sb2.append(string2);
                                                        string3 = sb2.toString();
                                                        break;
                                                }
                                                if (OlaBalloonChatViewActivity.this.o.getVisibility() != 0) {
                                                    OlaBalloonChatViewActivity.this.o.setVisibility(0);
                                                }
                                                OlaBalloonChatViewActivity.this.o.setText(OlaBalloonChatViewActivity.this.getString(R.string.string_active) + " " + com.mg.ola.common.d.i.a(System.currentTimeMillis() - OlaBalloonChatViewActivity.this.F.K.longValue(), chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a(), chat.ola.vn.b.d().b()) + string3);
                                            }
                                        } catch (Throwable unused) {
                                        }
                                    }
                                }
                            });
                        } else if (this.F.K != null && this.F.K.longValue() >= 0) {
                            String string2 = "";
                            switch (this.F.h()) {
                                case 0:
                                    sb = new StringBuilder();
                                    sb.append(" ");
                                    string = getString(R.string.string_on_mobile);
                                    sb.append(string);
                                    string2 = sb.toString();
                                    break;
                                case 1:
                                case 2:
                                    sb = new StringBuilder();
                                    sb.append(" ");
                                    string = getString(R.string.string_on_web);
                                    sb.append(string);
                                    string2 = sb.toString();
                                    break;
                                case 3:
                                    sb = new StringBuilder();
                                    sb.append(" ");
                                    string = getString(R.string.string_on_apple);
                                    sb.append(string);
                                    string2 = sb.toString();
                                    break;
                                case 4:
                                    sb = new StringBuilder();
                                    sb.append(" ");
                                    string = getString(R.string.string_on_android);
                                    sb.append(string);
                                    string2 = sb.toString();
                                    break;
                                case 5:
                                    sb = new StringBuilder();
                                    sb.append(" ");
                                    string = getString(R.string.string_on_windows_phone);
                                    sb.append(string);
                                    string2 = sb.toString();
                                    break;
                            }
                            if (this.o.getVisibility() != 0) {
                                this.o.setVisibility(0);
                            }
                            this.o.setText(getString(R.string.string_active) + " " + com.mg.ola.common.d.i.a(System.currentTimeMillis() - this.F.K.longValue(), chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a(), chat.ola.vn.b.d().b()) + string2);
                        }
                    } catch (Throwable unused) {
                    }
                    try {
                        if (this.F.T == null) {
                            OlaApplication.b.x(this.F.j(), this.F.k());
                            return;
                        }
                        return;
                    } catch (Throwable unused2) {
                        return;
                    }
                case 2:
                    this.n.setText(this.F.L().toString());
                    List<chat.ola.vn.message.f> listF = this.F.F();
                    if (listF == null || listF.size() == 0) {
                        this.o.setText(OlaApplication.a(R.string.string_chat_group));
                        if (this.o.getVisibility() != 0) {
                            this.o.setVisibility(0);
                        }
                        OlaApplication.b.g(this.F.j(), (short) 0);
                        return;
                    }
                    this.o.setText(listF.size() + " " + OlaApplication.a(R.string.string_members).toLowerCase(Locale.US));
                    if (this.o.getVisibility() == 0) {
                        return;
                    }
                    break;
                default:
                    return;
            }
        } else {
            this.n.setText(this.F.b());
            List<chat.ola.vn.message.f> listI = chat.ola.vn.h.x.i();
            int size = listI.size();
            if (listI == null || size == 0) {
                textView = this.o;
                strA = OlaApplication.a(R.string.string_chat_in_room);
            } else {
                textView = this.o;
                StringBuilder sb2 = new StringBuilder();
                if (size >= 200) {
                    str = "200+";
                } else {
                    str = "" + size;
                }
                sb2.append(str);
                sb2.append(" ");
                sb2.append(OlaApplication.a(R.string.string_broadcasting_members).toLowerCase(Locale.US));
                strA = sb2.toString();
            }
            textView.setText(strA);
            if (this.o.getVisibility() == 0) {
                return;
            }
        }
        this.o.setVisibility(0);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public chat.ola.vn.message.d ac() {
        if (this.F == null) {
            return null;
        }
        chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
        dVar.d(chat.ola.vn.h.a());
        dVar.e(this.F.j());
        dVar.c(this.F.k());
        dVar.a(chat.ola.vn.h.H);
        dVar.a(System.currentTimeMillis());
        return dVar;
    }

    @TargetApi(13)
    private void ad() {
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

    private void ae() {
        ImageButton imageButton;
        ImageButton imageButton2;
        ImageButton imageButton3 = this.ab;
        int i2 = R.drawable.btn_chat_text_selector;
        imageButton3.setImageResource(R.drawable.btn_chat_text_selector);
        this.ab.setSelected(false);
        this.ac.setSelected(false);
        this.ad.setSelected(false);
        this.ae.setSelected(false);
        this.af.setSelected(false);
        this.ag.setSelected(false);
        switch (this.aj) {
            case 0:
                imageButton = this.ab;
                i2 = R.drawable.btn_smiley_selector;
                imageButton.setImageResource(i2);
                this.ab.setSelected(false);
                break;
            case 1:
                imageButton = this.ab;
                imageButton.setImageResource(i2);
                this.ab.setSelected(false);
                break;
            case 2:
                imageButton2 = this.ac;
                imageButton2.setSelected(true);
                break;
            case 3:
                imageButton2 = this.ad;
                imageButton2.setSelected(true);
                break;
            case 4:
                imageButton2 = this.ae;
                imageButton2.setSelected(true);
                break;
            case 5:
                imageButton2 = this.af;
                imageButton2.setSelected(true);
                break;
            case 6:
                imageButton2 = this.ag;
                imageButton2.setSelected(true);
                break;
        }
    }

    private void af() {
        if (this.ai == 0) {
            this.ai = this.K.getHeight() - OlaChatViewActivity.g;
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.16
            @Override // java.lang.Runnable
            public void run() {
                if (OlaBalloonChatViewActivity.this.K.getLayoutParams().height == -1 || OlaBalloonChatViewActivity.this.K.getLayoutParams().height != OlaBalloonChatViewActivity.this.ai) {
                    ViewGroup.LayoutParams layoutParams = OlaBalloonChatViewActivity.this.K.getLayoutParams();
                    layoutParams.height = OlaBalloonChatViewActivity.this.ai;
                    OlaBalloonChatViewActivity.this.K.setLayoutParams(layoutParams);
                }
            }
        });
    }

    private void ag() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.17
            @Override // java.lang.Runnable
            public void run() {
                if (OlaBalloonChatViewActivity.this.K.getLayoutParams().height != -1) {
                    ViewGroup.LayoutParams layoutParams = OlaBalloonChatViewActivity.this.K.getLayoutParams();
                    layoutParams.height = -1;
                    OlaBalloonChatViewActivity.this.K.setLayoutParams(layoutParams);
                }
            }
        });
    }

    private void ah() {
        try {
            if (Build.VERSION.SDK_INT < 23 || checkSelfPermission("android.permission.CAMERA") == 0) {
                ai();
            } else {
                requestPermissions(new String[]{"android.permission.CAMERA"}, 105);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void ai() {
        Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
        this.am = new File(chat.ola.vn.d.a(System.currentTimeMillis()));
        if (this.am.exists()) {
            this.am.delete();
        }
        intent.putExtra("output", Uri.fromFile(this.am));
        startActivityForResult(intent, 2);
    }

    private void aj() {
        if (this.ak == null) {
            this.ak = new chat.ola.vn.i.c(this);
            this.ak.a(R.string.message_getting_location);
        }
        try {
            if (chat.ola.vn.n.c.a().a(180000L) != null) {
                b(chat.ola.vn.message.e.a(ac(), (byte) 2, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c()));
                if (this.F.k() == 2) {
                    OlaApplication.b.b(this.F.j(), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c());
                    return;
                } else {
                    OlaApplication.b.a(this.F.j(), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c());
                    return;
                }
            }
        } catch (Throwable unused) {
        }
        this.ak.a(30000L, null);
        chat.ola.vn.n.b.b(this, 15000L, new b.InterfaceC0042b() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.20
            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void a(double d, double d2, float f2) {
                OlaBalloonChatViewActivity.this.ak.a();
                try {
                    if (d == 0.0d || d2 == 0.0d) {
                        try {
                            OlaBalloonChatViewActivity.this.ak.a();
                        } catch (Throwable unused2) {
                        }
                        chat.ola.vn.i.i.a(OlaBalloonChatViewActivity.this, R.string.dialog_title_inform, R.string.message_map_loading_gps_fail);
                        return;
                    }
                    OlaBalloonChatViewActivity.this.ak.a();
                    OlaBalloonChatViewActivity.this.ak.dismiss();
                    OlaBalloonChatViewActivity.this.b(chat.ola.vn.message.e.a(OlaBalloonChatViewActivity.this.ac(), (byte) 2, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c()));
                    if (OlaBalloonChatViewActivity.this.F.k() == 2) {
                        OlaApplication.b.b(OlaBalloonChatViewActivity.this.F.j(), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c());
                    } else {
                        OlaApplication.b.a(OlaBalloonChatViewActivity.this.F.j(), chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c());
                    }
                } catch (Throwable unused3) {
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void j_() {
                try {
                    OlaBalloonChatViewActivity.this.ak.a();
                    chat.ola.vn.i.i.a(OlaBalloonChatViewActivity.this, R.string.dialog_title_fail, R.string.message_not_yet_get_location);
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void k_() {
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void l_() {
                OlaBalloonChatViewActivity.this.ak.a();
                chat.ola.vn.i.i.a(c.c(), R.string.message_location_provider_gps_unavailable_title, R.string.message_location_provider_unavailable, R.string.string_turn_on_gps, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.20.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i2) {
                        if (i2 == 0) {
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

    private boolean ak() {
        try {
            final List<String> listB = OlaQuickReplyComposerActivity.B();
            if (listB == null || listB.size() <= 0) {
                return false;
            }
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
            mVar.setCanceledOnTouchOutside(true);
            mVar.a(listB);
            mVar.setTitle(R.string.string_quick_reply);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.21
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i2, long j2) {
                    try {
                        OlaBalloonChatViewActivity.this.a((String) listB.get(i2), 0, false);
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

    public static Bitmap b(Context context) {
        if (g == null) {
            g = BitmapFactory.decodeResource(context.getResources(), R.drawable.ic_contact_photo);
            g = chat.ola.vn.balloon.b.a(context, g);
        }
        return g;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(chat.ola.vn.message.d dVar) {
        if (dVar != null) {
            this.F.a(dVar);
            this.F.d(true);
        }
        d(true);
    }

    private void b(CharSequence charSequence) {
        if (this.al) {
            this.al = false;
            return;
        }
        if (charSequence != null) {
            try {
                if (charSequence.length() != 0) {
                    this.R.setVisibility(8);
                    this.Q.setVisibility(0);
                    return;
                }
            } catch (Throwable unused) {
                this.R.setVisibility(0);
                this.Q.setVisibility(8);
                return;
            }
        }
        this.R.setVisibility(0);
        this.Q.setVisibility(8);
    }

    private void d(int i2) {
        chat.ola.vn.message.f fVar;
        View view = null;
        try {
            fVar = OlaApplication.c.f().get(i2 - 1).s;
        } catch (Throwable unused) {
            fVar = null;
            i2 = 0;
        }
        this.r.setSelected(false);
        this.t.setSelected(false);
        this.w.setSelected(false);
        this.z.setSelected(false);
        this.C.setSelected(false);
        switch (i2) {
            case 0:
                this.n.setText(R.string.string_conversations);
                this.o.setVisibility(8);
                h(false);
                this.aj = 0;
                e(false);
                this.r.setSelected(true);
                try {
                    this.l.setAdapter((ListAdapter) this.H);
                    final int i3 = j;
                    final int i4 = i;
                    this.l.post(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.23
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                try {
                                    if (i3 >= 0) {
                                        OlaBalloonChatViewActivity.this.l.setSelectionFromTop(i3, i4);
                                    } else {
                                        OlaBalloonChatViewActivity.this.l.setSelection(0);
                                    }
                                } catch (Throwable unused2) {
                                    OlaBalloonChatViewActivity.this.l.setSelection(0);
                                }
                            } catch (Throwable unused3) {
                            }
                        }
                    });
                    return;
                } catch (Throwable unused2) {
                    return;
                }
            case 1:
                view = this.t;
                break;
            case 2:
                view = this.w;
                break;
            case 3:
                view = this.z;
                break;
            case 4:
                view = this.C;
                break;
        }
        h(fVar);
        if (view != null) {
            if (view.getVisibility() != 0) {
                view.setVisibility(0);
            }
            view.setSelected(true);
            ab();
            e(true);
            this.l.setAdapter((ListAdapter) this.G);
            final int i5 = this.F.D;
            final int i6 = this.F.E;
            this.l.post(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.24
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        if (i5 >= 0) {
                            OlaBalloonChatViewActivity.this.l.setSelectionFromTop(i5, i6);
                        } else {
                            OlaBalloonChatViewActivity.this.l.setSelection(OlaBalloonChatViewActivity.this.G.getCount());
                        }
                    } catch (Throwable unused3) {
                    }
                }
            });
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void e(boolean z) {
        View view;
        int i2;
        if (z) {
            view = this.p;
            i2 = 0;
        } else {
            view = this.p;
            i2 = 8;
        }
        view.setVisibility(i2);
    }

    private void f(final boolean z) {
        try {
            try {
                if (this.L != null) {
                    this.L.b();
                }
                com.mg.ola.a.a.c.b.b(this.K, 0.0f);
                com.mg.ola.a.a.c.b.c(this.K, 0.0f);
                Rect rect = new Rect(0, getResources().getDimensionPixelSize(R.dimen.head_notify_icon_size), chat.ola.vn.e.c, chat.ola.vn.e.d);
                Rect rect2 = new Rect();
                W().getGlobalVisibleRect(rect2);
                int i2 = -n.a(this);
                rect2.offset(0, i2);
                rect.offset(0, i2);
                float fHeight = rect2.height() / rect.height();
                com.mg.ola.a.a.b.c cVar = new com.mg.ola.a.a.b.c();
                com.mg.ola.a.a.b.j jVarA = com.mg.ola.a.a.b.j.a(this.K, "translationX", rect.left, rect2.left);
                com.mg.ola.a.a.b.j jVarA2 = com.mg.ola.a.a.b.j.a(this.K, "scaleX", fHeight);
                cVar.a(jVarA2).a(com.mg.ola.a.a.b.j.a(this.K, "scaleY", fHeight)).a(jVarA).a(com.mg.ola.a.a.b.j.a(this.K, "alpha", 1.0f, 0.0f)).a(com.mg.ola.a.a.b.j.a(this.q, "alpha", 1.0f, 0.1f));
                cVar.a(this.M);
                cVar.a(new DecelerateInterpolator());
                cVar.a(new com.mg.ola.a.a.b.b() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.27
                    @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
                    public void a(com.mg.ola.a.a.b.a aVar) {
                        OlaBalloonChatViewActivity.this.L = null;
                        OlaBalloonChatViewActivity.this.K.setVisibility(4);
                        if (z) {
                            OlaBalloonChatViewActivity.this.Y();
                        }
                    }

                    @Override // com.mg.ola.a.a.b.b, com.mg.ola.a.a.b.a.InterfaceC0079a
                    public void b(com.mg.ola.a.a.b.a aVar) {
                        OlaBalloonChatViewActivity.this.K.setVisibility(4);
                        if (z) {
                            OlaBalloonChatViewActivity.this.Y();
                        }
                    }
                });
                cVar.a();
                this.L = cVar;
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
            this.K.setVisibility(4);
            if (z) {
                Y();
            }
        }
    }

    private void g(boolean z) {
        h(false);
        if (!z) {
            Y();
        } else {
            f(true);
            this.e = true;
        }
    }

    private void h(chat.ola.vn.message.f fVar) {
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
            if (fVar.F == null && fVar.k() == 0) {
                try {
                    OlaApplication.b.p(fVar.j(), chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.3
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 48;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                            try {
                                if (m.b((String) objArr[0], OlaBalloonChatViewActivity.this.F.j())) {
                                    OlaBalloonChatViewActivity.this.F.F = true;
                                    OlaBalloonChatViewActivity.this.Z();
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }));
                } catch (Throwable unused) {
                }
            }
            this.F = fVar;
            this.G.a(this.F);
            this.G.notifyDataSetChanged();
            chat.ola.vn.h.t.t();
            this.F.a(0);
            this.F.A();
            if (chat.ola.vn.h.g() && this.F.V == 0 && !m.a(chat.ola.vn.h.a())) {
                try {
                    if (this.F.k() == 2) {
                        if (OlaApplication.b.h(this.F.j(), null, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.4
                            @Override // chat.ola.vn.entry.c.e
                            public short a() {
                                return (short) 55;
                            }

                            @Override // chat.ola.vn.entry.c.e
                            public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                            }

                            @Override // chat.ola.vn.entry.c.e
                            public void a(Object... objArr) {
                            }
                        }))) {
                            this.F.V = (byte) 1;
                            this.F.O = null;
                            this.F.Q = true;
                        }
                    } else if (this.F.k() != 0) {
                        this.F.V = (byte) 2;
                        this.F.O = null;
                        this.F.Q = false;
                    } else if (OlaApplication.b.i(this.F.j(), null, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.5
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 55;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                        }
                    }))) {
                        this.F.V = (byte) 1;
                        this.F.O = null;
                        this.F.Q = true;
                    }
                } catch (Throwable unused2) {
                }
            }
            Z();
            short sK = this.F.k();
            if (sK == 0) {
                editText = this.m;
                string = getString(R.string.string_write_a_message_to) + " " + this.F.j();
            } else if (sK == 2) {
                editText = this.m;
                string = getString(R.string.string_write_a_message_group, new Object[]{this.F.L()});
            } else if (sK != 4) {
                this.m.setHint(R.string.string_write_a_message);
                return;
            } else {
                editText = this.m;
                string = getString(R.string.string_write_a_message_room, new Object[]{this.F.b()});
            }
            editText.setHint(string);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @TargetApi(12)
    private void h(final boolean z) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.14
                @Override // java.lang.Runnable
                public void run() {
                    if (z) {
                        OlaBalloonChatViewActivity.this.m.requestFocus();
                    }
                    chat.ola.vn.util.o.a(OlaBalloonChatViewActivity.this, OlaBalloonChatViewActivity.this.m, z);
                }
            });
        } catch (Throwable unused) {
        }
    }

    private void i(boolean z) {
        if (z) {
            ViewGroup.LayoutParams layoutParams = this.S.getLayoutParams();
            if (layoutParams.height != OlaChatViewActivity.g) {
                layoutParams.height = OlaChatViewActivity.g;
                this.S.setLayoutParams(layoutParams);
            }
            this.S.setVisibility(0);
            return;
        }
        this.S.setVisibility(8);
        try {
            this.S.removeAllViews();
            if (this.Z != null) {
                this.Z.a();
            }
            this.Z = null;
        } catch (Throwable unused) {
        }
    }

    private void j(boolean z) {
        boolean z2;
        d dVar;
        try {
            ae();
            boolean z3 = true;
            switch (this.aj) {
                case 0:
                    this.V = null;
                    if (this.ah.getVisibility() == 0) {
                        z3 = false;
                    }
                    this.ah.setVisibility(0);
                    this.S.removeAllViews();
                    i(false);
                    if (z) {
                        af();
                    } else {
                        ag();
                    }
                    z2 = z3;
                    break;
                case 1:
                    this.V = null;
                    z2 = this.ah.getVisibility() != 0;
                    this.ah.setVisibility(0);
                    i(true);
                    af();
                    if (this.T == null) {
                        this.T = new h(this);
                        this.T.setOlaSmileyListener(this);
                    }
                    try {
                        if (this.Z == null || this.Z != this.T) {
                            this.S.removeAllViews();
                            this.S.addView(this.T);
                            this.Z = this.T;
                        }
                    } catch (Throwable unused) {
                    }
                    break;
                case 2:
                    this.ah.setVisibility(8);
                    i(true);
                    af();
                    if (com.mg.ola.common.d.g.f()) {
                        if (this.V == null) {
                            this.V = new e(this);
                            ((e) this.V).setOlaCameraListener(this);
                        }
                        if (this.Z == null || this.Z != this.V) {
                            this.S.removeAllViews();
                            this.S.addView(this.V);
                            dVar = this.V;
                            this.Z = dVar;
                        }
                    }
                    z2 = false;
                    break;
                case 3:
                    this.V = null;
                    this.ah.setVisibility(8);
                    i(true);
                    af();
                    if (this.U == null) {
                        this.U = new i(this);
                        this.U.setOnStickerClickedListener(this);
                    }
                    if (this.Z == null || this.Z != this.U) {
                        this.S.removeAllViews();
                        this.S.addView(this.U);
                        dVar = this.U;
                        this.Z = dVar;
                    }
                    z2 = false;
                    break;
                case 4:
                    this.V = null;
                    this.ah.setVisibility(8);
                    i(true);
                    af();
                    if (this.W == null) {
                        this.W = new g(this);
                        this.W.setAllowVideo(false);
                        this.W.setOlaPhotoListener(this);
                    }
                    if (this.Z == null || this.Z != this.W) {
                        this.S.removeAllViews();
                        this.S.addView(this.W);
                        dVar = this.W;
                        this.Z = dVar;
                    }
                    z2 = false;
                    break;
                case 5:
                    this.V = null;
                    this.ah.setVisibility(8);
                    i(true);
                    af();
                    if (this.X == null) {
                        this.X = new j(this);
                        this.X.setOnVoiceRecordListener(this);
                    }
                    if (this.Z == null || this.Z != this.X) {
                        this.S.removeAllViews();
                        this.S.addView(this.X);
                        dVar = this.X;
                        this.Z = dVar;
                    }
                    z2 = false;
                    break;
                case 6:
                    this.V = null;
                    this.ah.setVisibility(8);
                    i(true);
                    af();
                    if (this.Y == null) {
                        this.Y = new chat.ola.vn.view.f(this);
                        this.Y.setOnMoreActionClickedListener(this);
                    }
                    if (this.Y != null) {
                        if (this.F.k() == 2) {
                            this.Y.setTransferKenButtonVisibility(false);
                            this.Y.setTradingVipButtonVisibility(false);
                            this.Y.setSendVipDayButtonVisibility(false);
                        } else {
                            this.Y.setTransferKenButtonVisibility(true);
                            this.Y.setTradingVipButtonVisibility(true);
                            this.Y.setSendVipDayButtonVisibility(true);
                        }
                    }
                    if (this.Z == null || this.Z != this.Y) {
                        this.S.removeAllViews();
                        this.S.addView(this.Y);
                        dVar = this.Y;
                        this.Z = dVar;
                    }
                    z2 = false;
                    break;
                default:
                    z2 = false;
                    break;
            }
            if (z2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.15
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            OlaBalloonChatViewActivity.this.m.requestFocus();
                        } catch (Throwable unused2) {
                        }
                    }
                });
            }
        } catch (Throwable unused2) {
        }
    }

    private void m(final String str) {
        try {
            if (this.F == null || OlaApplication.b == null) {
                return;
            }
            final aa aaVarA = chat.ola.vn.message.e.a(ac(), (byte) 2, str);
            b(aaVarA);
            final chat.ola.vn.message.f fVar = this.F;
            Runnable runnable = new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.7
                @Override // java.lang.Runnable
                public void run() {
                    aaVarA.b((byte) 4);
                    chat.ola.vn.u.b.a().a(str, "mp3", null, new chat.ola.vn.u.o() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.7.1
                        @Override // chat.ola.vn.u.o
                        public void a(int i2, int i3) {
                            try {
                                aaVarA.d(str, i2, i3);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(chat.ola.vn.entity.i iVar) {
                            try {
                                aaVarA.b(str, iVar.d());
                                if (fVar.k() == 4) {
                                    aaVarA.b((byte) 2);
                                }
                                short sK = fVar.k();
                                if (sK == 0) {
                                    OlaApplication.b.c(fVar.j(), iVar.d(), aaVarA.p());
                                    return;
                                }
                                if (sK == 2) {
                                    OlaApplication.b.d(fVar.j(), iVar.d(), aaVarA.p());
                                    return;
                                }
                                if (sK != 4) {
                                    return;
                                }
                                OlaBalloonChatViewActivity.this.a(fVar, "##" + iVar.d() + "#", 0, aaVarA.p());
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(String str2) {
                            try {
                                aaVarA.p(str2);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(String str2, int i2) {
                            try {
                                aaVarA.l(OlaBalloonChatViewActivity.this.getString(R.string.message_fail_too_large_image_size));
                                aaVarA.b((byte) 5);
                                aaVarA.q(str2);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(String str2, int i2, String str3) {
                            try {
                                aaVarA.l(OlaBalloonChatViewActivity.this.getString(R.string.message_fail_too_large_file_size));
                                aaVarA.b((byte) 5);
                                aaVarA.q(str2);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(String str2, String str3) {
                            try {
                                aaVarA.l(OlaBalloonChatViewActivity.this.getString(R.string.message_fail_unsupported_format));
                                aaVarA.b((byte) 5);
                                aaVarA.q(str2);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void b(String str2, String str3) {
                            try {
                                aaVarA.l(str3);
                                aaVarA.b((byte) 5);
                                aaVarA.q(str2);
                            } catch (Throwable unused) {
                            }
                        }
                    });
                }
            };
            aaVarA.a(runnable);
            runnable.run();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void n(String str) {
        try {
            String string = this.m.getText().toString();
            int selectionStart = this.m.getSelectionStart() >= 0 ? this.m.getSelectionStart() : 0;
            StringBuilder sb = new StringBuilder(string);
            sb.insert(selectionStart, str);
            this.m.setText(o(sb.toString()));
            this.m.setSelection(selectionStart + str.length());
        } catch (Throwable unused) {
            this.m.append(str);
        }
    }

    private CharSequence o(String str) {
        return chat.ola.vn.util.i.c(str);
    }

    @Override // chat.ola.vn.p.f
    public void C() {
        chat.ola.vn.message.f fVarD;
        if (this.F == null || (fVarD = chat.ola.vn.h.t.d(this.F.j(), this.F.k())) == null) {
            return;
        }
        h(fVarD);
    }

    public void G() {
    }

    @Override // chat.ola.vn.p.f
    public boolean H() {
        return true;
    }

    @Override // chat.ola.vn.view.e.a
    public boolean I() {
        ah();
        this.aj = 0;
        j(false);
        return true;
    }

    @Override // chat.ola.vn.view.e.a
    public boolean J() {
        try {
            ViewGroup.LayoutParams layoutParams = this.S.getLayoutParams();
            layoutParams.height = -1;
            this.S.setLayoutParams(layoutParams);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.view.e.a
    public boolean K() {
        try {
            ViewGroup.LayoutParams layoutParams = this.S.getLayoutParams();
            if (layoutParams.height == OlaChatViewActivity.g) {
                return true;
            }
            layoutParams.height = OlaChatViewActivity.g;
            this.S.setLayoutParams(layoutParams);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.view.h.b
    public void L() {
        try {
            String string = this.m.getText().toString();
            int selectionStart = this.m.getSelectionStart() >= 0 ? this.m.getSelectionStart() : 0;
            StringBuilder sb = new StringBuilder(string);
            if (selectionStart > 0) {
                selectionStart--;
            }
            sb.replace(selectionStart, selectionStart + 1, "");
            this.m.setText(sb.toString());
            this.m.setSelection(selectionStart);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void M() {
    }

    @Override // chat.ola.vn.view.f.a
    @SuppressLint({"NewApi"})
    public void N() {
        if (chat.ola.vn.n.b.b(this)) {
            aj();
        } else {
            chat.ola.vn.n.b.a(this, 101);
        }
    }

    @Override // chat.ola.vn.view.f.a
    public void O() {
        OlaTransferKenActivity.a(this, this.F.j());
    }

    @Override // chat.ola.vn.view.f.a
    public void P() {
        OlaTraddingVipActivity.a(this, this.F.j());
    }

    @Override // chat.ola.vn.view.f.a
    public void Q() {
        BuyVipActivity.c(this, this.F.j());
    }

    @Override // chat.ola.vn.c
    protected void a() {
        this.P = true;
        chat.ola.vn.h.t.a(this);
        this.K.setVisibility(4);
        this.K.post(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.25
            @Override // java.lang.Runnable
            public void run() {
                OlaBalloonChatViewActivity.this.X();
            }
        });
        try {
            OlaApplication.c.a();
        } catch (Throwable unused) {
        }
        V();
    }

    @Override // chat.ola.vn.view.i.e
    public void a(w wVar) {
        try {
            String strA = wVar.a();
            if (m.a(strA)) {
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
            if (m.a(dVar.i())) {
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
                    chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
                    mVar.a(arrayList);
                    mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.13
                        @Override // android.widget.AdapterView.OnItemClickListener
                        public void onItemClick(AdapterView<?> adapterView, View view, int i2, long j2) {
                            try {
                                String str = (String) arrayList.get(i2);
                                if (m.b(OlaBalloonChatViewActivity.this.getString(R.string.string_make_friend), str)) {
                                    OlaApplication.b.a(fVarE);
                                    return;
                                }
                                if (m.b(OlaBalloonChatViewActivity.this.getString(R.string.string_chat), str)) {
                                    OlaChatViewActivity.a((Context) OlaBalloonChatViewActivity.this, OlaApplication.b, fVarE.j(), (short) 0);
                                    return;
                                }
                                if (m.b(OlaBalloonChatViewActivity.this.getString(R.string.string_view_me), str)) {
                                    chat.ola.vn.me.c.a(OlaBalloonChatViewActivity.this, OlaApplication.b, fVarE.j());
                                    return;
                                }
                                if (m.b(OlaBalloonChatViewActivity.this.getString(R.string.string_block), str)) {
                                    chat.ola.vn.i.i.d(OlaBalloonChatViewActivity.this, OlaBalloonChatViewActivity.this.getString(R.string.message_block_chat_title), OlaBalloonChatViewActivity.this.getString(R.string.message_block_chat_confirm_format, new Object[]{"@" + fVarE.j()}), OlaBalloonChatViewActivity.this.getString(R.string.string_block), OlaBalloonChatViewActivity.this.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.13.1
                                        @Override // android.content.DialogInterface.OnClickListener
                                        public void onClick(DialogInterface dialogInterface, int i3) {
                                            dialogInterface.dismiss();
                                            if (i3 == 0) {
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
        if (this.G != null) {
            this.G.notifyDataSetChanged();
        }
    }

    public void a(chat.ola.vn.message.f fVar) {
        try {
            this.F = fVar;
            if (fVar == null) {
                return;
            }
            fVar.a(0);
            this.F.A();
            h(fVar);
            Z();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, int i2, String str, List<chat.ola.vn.message.d> list) {
        if (i2 > 0) {
            try {
                if (fVar.equals(this.F)) {
                    if (m.a(str)) {
                        d(false);
                        return;
                    }
                    int firstVisiblePosition = this.l.getFirstVisiblePosition() + i2;
                    if (this.G != null) {
                        this.G.notifyDataSetChanged();
                    }
                    this.l.setSelection(firstVisiblePosition);
                }
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
        if (this.F != null && m.a(this.F.y(), fVar.y())) {
            this.G.notifyDataSetChanged();
        }
        aa();
    }

    @Override // chat.ola.vn.p.f
    public void a(chat.ola.vn.message.f fVar, List<chat.ola.vn.message.d> list) {
        if (fVar.equals(this.F) && this.G != null) {
            this.G.notifyDataSetChanged();
            d(false);
        }
        aa();
    }

    @Override // com.mg.ola.common.widget.a.a
    public void a(boolean z, int i2) {
        if (z) {
            ad();
            int i3 = (chat.ola.vn.e.d - chat.ola.vn.e.e) - i2;
            if (OlaChatViewActivity.g != i3) {
                OlaChatViewActivity.g = i3;
                chat.ola.vn.e.a().c(OlaChatViewActivity.g);
            }
            this.ai = i2;
            this.aj = 0;
        } else if (OlaChatViewActivity.g == 0) {
            OlaChatViewActivity.g = getResources().getDimensionPixelSize(R.dimen.metric_240dp);
        }
        j(z);
        if (this.aj == 0) {
            i(false);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:19:0x0040  */
    /* JADX WARN: Removed duplicated region for block: B:24:0x0056  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean a(final chat.ola.vn.message.d r6, android.view.View r7) {
        /*
            r5 = this;
            java.util.ArrayList r7 = new java.util.ArrayList
            r7.<init>()
            boolean r0 = r6.w
            if (r0 != 0) goto L1f
            java.lang.Long r0 = r6.p
            if (r0 == 0) goto L1f
            long r0 = java.lang.System.currentTimeMillis()
            java.lang.Long r2 = r6.p
            long r2 = r2.longValue()
            int r4 = (r0 > r2 ? 1 : (r0 == r2 ? 0 : -1))
            if (r4 >= 0) goto L1f
            r0 = 2131690996(0x7f0f05f4, float:1.9011051E38)
            goto L26
        L1f:
            boolean r0 = r6.x
            if (r0 != 0) goto L2d
            r0 = 2131690557(0x7f0f043d, float:1.901016E38)
        L26:
            java.lang.String r0 = r5.getString(r0)
            r7.add(r0)
        L2d:
            byte r0 = r6.e()
            r1 = 1
            if (r0 == r1) goto L40
            byte r0 = r6.e()
            if (r0 == 0) goto L40
            boolean r0 = r6.x()
            if (r0 == 0) goto L4a
        L40:
            r0 = 2131690641(0x7f0f0491, float:1.9010331E38)
            java.lang.String r0 = r5.getString(r0)
            r7.add(r0)
        L4a:
            byte r0 = r6.e()
            if (r0 == r1) goto L56
            byte r0 = r6.e()
            if (r0 != 0) goto L60
        L56:
            r0 = 2131689722(0x7f0f00fa, float:1.9008467E38)
            java.lang.String r0 = r5.getString(r0)
            r7.add(r0)
        L60:
            r0 = 2131690662(0x7f0f04a6, float:1.9010374E38)
            java.lang.String r0 = r5.getString(r0)
            r7.add(r0)
            chat.ola.vn.i.m r0 = new chat.ola.vn.i.m
            r0.<init>(r5)
            r0.a(r7)
            chat.ola.vn.activity.OlaBalloonChatViewActivity$11 r2 = new chat.ola.vn.activity.OlaBalloonChatViewActivity$11
            r2.<init>()
            r0.a(r2)
            r0.show()
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaBalloonChatViewActivity.a(chat.ola.vn.message.d, android.view.View):boolean");
    }

    @Override // chat.ola.vn.p.f
    public void a_() {
        if (this.G != null) {
            this.G.notifyDataSetChanged();
        }
    }

    @Override // chat.ola.vn.view.e.a
    public void a_(final String str) {
        try {
            final p pVar = new p(new chat.ola.vn.message.d(), (byte) 2);
            pVar.e(this.F.j());
            pVar.c(this.F.k());
            ArrayList arrayList = new ArrayList(1);
            arrayList.add(ab.a(str));
            pVar.b(arrayList);
            if (pVar != null) {
                b(pVar);
            }
            final chat.ola.vn.message.f fVar = this.F;
            Runnable runnable = new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.18
                @Override // java.lang.Runnable
                public void run() {
                    pVar.b((byte) 4);
                    chat.ola.vn.u.b.a().a(str, null, new chat.ola.vn.u.o() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.18.1
                        @Override // chat.ola.vn.u.o
                        public void a(int i2, int i3) {
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(chat.ola.vn.entity.i iVar) {
                            p pVar2;
                            try {
                                try {
                                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(pVar.j(), pVar.s());
                                    if (fVarD != null && (pVar2 = (p) fVarD.o(pVar.p())) != null) {
                                        List<ab> listA = pVar2.a();
                                        if (listA != null && listA.size() > 0) {
                                            ab abVar = listA.get(0);
                                            abVar.b = (byte) 0;
                                            abVar.c = iVar.d();
                                        }
                                        pVar2.b(listA);
                                        if (fVar.k() == 4) {
                                            pVar.b((byte) 2);
                                        }
                                    }
                                } catch (Throwable th) {
                                    th.printStackTrace();
                                }
                                short sK = fVar.k();
                                if (sK == 0) {
                                    OlaApplication.b.c(fVar.j(), iVar.d(), pVar.p());
                                    return;
                                }
                                if (sK == 2) {
                                    OlaApplication.b.d(fVar.j(), iVar.d(), pVar.p());
                                    return;
                                }
                                if (sK != 4) {
                                    return;
                                }
                                OlaBalloonChatViewActivity.this.a(fVar, "##" + iVar.d() + "#", 0, pVar.p());
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(String str2) {
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(String str2, int i2) {
                            try {
                                pVar.l(OlaBalloonChatViewActivity.this.getString(R.string.message_fail_too_large_image_size));
                                pVar.b((byte) 5);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(String str2, int i2, String str3) {
                            try {
                                pVar.l(OlaBalloonChatViewActivity.this.getString(R.string.message_fail_too_large_file_size));
                                pVar.b((byte) 5);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void a(String str2, String str3) {
                            try {
                                pVar.l(OlaBalloonChatViewActivity.this.getString(R.string.message_fail_unsupported_format));
                                pVar.b((byte) 5);
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.u.o
                        public void b(String str2, String str3) {
                            try {
                                pVar.l(str3);
                                pVar.b((byte) 5);
                            } catch (Throwable unused) {
                            }
                        }
                    });
                    OlaBalloonChatViewActivity.this.G.notifyDataSetChanged();
                }
            };
            pVar.a(runnable);
            runnable.run();
        } catch (Throwable unused) {
        }
    }

    @Override // android.text.TextWatcher
    public void afterTextChanged(Editable editable) {
        b(editable);
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.p.f
    public void b(chat.ola.vn.message.f fVar, chat.ola.vn.message.d dVar) {
        this.G.notifyDataSetChanged();
    }

    @Override // chat.ola.vn.p.f
    public void b(Short sh, int i2) {
    }

    @Override // android.text.TextWatcher
    public void beforeTextChanged(CharSequence charSequence, int i2, int i3, int i4) {
    }

    @Override // chat.ola.vn.p.f
    public void c(int i2) {
    }

    @Override // chat.ola.vn.p.f
    public void c(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.p.f
    public void c(List<chat.ola.vn.message.f> list) {
    }

    @Override // chat.ola.vn.p.f
    public void c(boolean z) {
    }

    @Override // chat.ola.vn.p.f
    public void d(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.view.g.e
    public void d(List<String> list) {
        try {
            if (list.size() > 0) {
                ArrayList arrayList = new ArrayList(list);
                String str = "##" + ((String) arrayList.get(0)) + "#";
                int size = arrayList.size();
                for (int i2 = 1; i2 < size; i2++) {
                    str = str + " ##" + ((String) arrayList.get(i2)) + "#";
                }
                if (!m.a(str)) {
                    a(str, 0, false);
                }
            }
        } catch (Throwable unused) {
        }
        try {
            if (this.F != null) {
                OlaApplication.c.c(this.F);
            }
        } catch (Throwable unused2) {
        }
    }

    public void d(final boolean z) {
        try {
            this.F.D = -1;
            this.F.E = 0;
        } catch (Throwable unused) {
        }
        this.l.post(new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.2
            @Override // java.lang.Runnable
            public void run() {
                try {
                    OlaBalloonChatViewActivity.this.l.setTranscriptMode(2);
                    if (z) {
                        OlaBalloonChatViewActivity.this.l.smoothScrollToPosition(OlaBalloonChatViewActivity.this.G.getCount());
                    } else {
                        OlaBalloonChatViewActivity.this.l.setSelection(OlaBalloonChatViewActivity.this.G.getCount());
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.p.f
    public void e(chat.ola.vn.message.f fVar) {
    }

    @Override // chat.ola.vn.view.g.e
    public void e(List<String> list) {
    }

    @Override // chat.ola.vn.c
    protected boolean e() {
        return false;
    }

    @Override // chat.ola.vn.p.f
    public void f(chat.ola.vn.message.f fVar) {
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
                pVar.e(this.F.j());
                pVar.c(this.F.k());
                pVar.b((byte) 4);
                final ArrayList arrayList2 = new ArrayList(arrayList);
                pVar.b(arrayList2);
                if (pVar != null) {
                    b(pVar);
                }
                final chat.ola.vn.message.f fVar = this.F;
                Runnable runnable = new Runnable() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.19
                    @Override // java.lang.Runnable
                    public void run() {
                        for (final ab abVar : arrayList2) {
                            chat.ola.vn.u.b.a().a(abVar.c, null, new chat.ola.vn.u.o() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.19.1
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
                                public void a(int i2, int i3) {
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
                                            if (m.a(str)) {
                                                str = "##" + next.c + "#";
                                            } else {
                                                str = str + " ##" + next.c + "#";
                                            }
                                        }
                                        if (z) {
                                            OlaBalloonChatViewActivity.this.a(fVar, str, 0, pVar.p());
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
                                public void a(String str, int i2) {
                                    a();
                                }

                                @Override // chat.ola.vn.u.o
                                public void a(String str, int i2, String str2) {
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
        try {
            if (this.F != null) {
                OlaApplication.c.c(this.F);
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        g(true);
    }

    @Override // chat.ola.vn.view.h.b
    public void g(String str) {
        n(str + " ");
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void g(String str, short s) {
        try {
            if (this.F.k() == s && m.b(str, this.F.j())) {
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
            return fVar.equals(this.F);
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
        chat.ola.vn.message.t tVarA;
        try {
            byte[] bArrA = com.mg.ola.common.d.c.a(new File(str));
            if (bArrA == null || bArrA.length <= 0 || bArrA.length >= 512000 || this.F == null || (tVarA = chat.ola.vn.message.e.a(chat.ola.vn.h.a(), this.F.j(), this.F.k(), chat.ola.vn.h.H, (byte) 2)) == null) {
                return;
            }
            tVarA.b((byte) 1);
            tVarA.a(str, s);
            b(tVarA);
            short sK = this.F.k();
            if (sK == 0) {
                OlaApplication.b.a(this.F.j(), bArrA, s);
            } else {
                if (sK != 2) {
                    return;
                }
                OlaApplication.b.b(this.F.j(), bArrA, s);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.contactpicker.OlaContactPickerActivity.b
    public void h(List<chat.ola.vn.message.f> list) {
        if (list == null || list.size() <= 0) {
            return;
        }
        String[] strArr = new String[list.size()];
        for (int i2 = 0; i2 < strArr.length; i2++) {
            strArr[i2] = list.get(i2).j();
        }
        OlaApplication.b.a(this.F.j(), strArr);
    }

    @Override // chat.ola.vn.view.g.e
    public void i(String str) {
    }

    @Override // chat.ola.vn.p.f
    public String i_() {
        if (this.J == null) {
            this.J = "chat.ola.vn.activity.BalloonChatViewActivity" + System.currentTimeMillis();
        }
        return this.J;
    }

    @Override // chat.ola.vn.view.g.e
    public void j(String str) {
        if (this.F.k() == 0 || this.F.k() == 2 || this.F.k() == 4) {
            p pVar = new p(new chat.ola.vn.message.d(), (byte) 2);
            pVar.e(this.F.j());
            pVar.c(this.F.k());
            ArrayList arrayList = new ArrayList(1);
            arrayList.add(ab.b(str));
            pVar.b(arrayList);
            if (pVar != null) {
                b(pVar);
            }
            if (this.F.k() == 0) {
                OlaApplication.b.c(this.F.j(), str, pVar.p());
                return;
            }
            if (this.F.k() == 2) {
                OlaApplication.b.d(this.F.j(), str, pVar.p());
                return;
            }
            if (this.F.k() == 4) {
                a(this.F, "##" + str + "#", 0, pVar.p());
                pVar.b((byte) 2);
            }
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void k(String str) {
        if (this.F.k() == 0 || this.F.k() == 2 || this.F.k() == 4) {
            p pVar = new p(new chat.ola.vn.message.d(), (byte) 2);
            pVar.e(this.F.j());
            pVar.c(this.F.k());
            ArrayList arrayList = new ArrayList(1);
            arrayList.add(ab.c(str));
            pVar.b(arrayList);
            if (pVar != null) {
                b(pVar);
            }
            if (this.F.k() == 0) {
                OlaApplication.b.c(this.F.j(), str, pVar.p());
                return;
            }
            if (this.F.k() == 2) {
                OlaApplication.b.d(this.F.j(), str, pVar.p());
                return;
            }
            if (this.F.k() == 4) {
                a(this.F, "##" + str + "#", 0, pVar.p());
                pVar.b((byte) 2);
            }
        }
    }

    @Override // chat.ola.vn.view.j.a
    public void l(String str) {
        try {
            m(str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        switch (this.aj) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
                this.aj = 0;
                j(false);
                break;
            default:
                finish();
                break;
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            switch (id) {
                case R.id.conversationBalloon1 /* 2131296707 */:
                    if (T() != 1) {
                        d(1);
                    } else {
                        finish();
                    }
                    break;
                case R.id.conversationBalloon2 /* 2131296708 */:
                    if (T() != 2) {
                        d(2);
                    } else {
                        finish();
                    }
                    break;
                case R.id.conversationBalloon3 /* 2131296709 */:
                    if (T() != 3) {
                        d(3);
                    } else {
                        finish();
                    }
                    break;
                case R.id.conversationBalloon4 /* 2131296710 */:
                    if (T() != 4) {
                        d(4);
                    } else {
                        finish();
                    }
                    break;
                default:
                    try {
                        switch (id) {
                            case R.id.cameraImageButton /* 2131296579 */:
                                if (!com.mg.ola.common.d.g.f()) {
                                    chat.ola.vn.util.j.d(this, R.string.message_this_feature_is_not_supported_on_your_device);
                                } else {
                                    h(false);
                                    this.aj = 2;
                                    if (!this.k.a()) {
                                    }
                                }
                                break;
                            case R.id.chatTextSmileyImageButton /* 2131296604 */:
                                if (this.aj != 0) {
                                    h(true);
                                    this.aj = 0;
                                } else {
                                    h(false);
                                    this.aj = 1;
                                    if (!this.k.a()) {
                                    }
                                }
                                break;
                            case R.id.chattingRoundOvatar /* 2131296606 */:
                                finish();
                                break;
                            case R.id.conversationListBalloon /* 2131296712 */:
                                if (T() != 0) {
                                    d(0);
                                } else {
                                    finish();
                                }
                                break;
                            case R.id.kulImageButton /* 2131296968 */:
                                h(false);
                                this.aj = 3;
                                if (!this.k.a()) {
                                }
                                break;
                            case R.id.likeButton /* 2131296979 */:
                                a("(y)", 0, false);
                                Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.zoom_icon_animation);
                                animationLoadAnimation.setDuration(150L);
                                this.R.startAnimation(animationLoadAnimation);
                                break;
                            case R.id.linearActionBar /* 2131296986 */:
                                if (this.F != null) {
                                    OlaChatViewActivity.a(this, OlaApplication.b, this.F);
                                    g(false);
                                }
                                break;
                            case R.id.localPhotoImageButton /* 2131297040 */:
                                h(false);
                                this.aj = 4;
                                if (!this.k.a()) {
                                }
                                break;
                            case R.id.moreImageButton /* 2131297120 */:
                                String string = this.m.getText().toString();
                                if (!m.a(string)) {
                                    a(string, 0, true);
                                } else {
                                    h(false);
                                    this.aj = 6;
                                    if (!this.k.a()) {
                                    }
                                }
                                break;
                            case R.id.quickReplyImageButton /* 2131297275 */:
                                ak();
                                break;
                            case R.id.sendTextView /* 2131297382 */:
                                this.al = true;
                                a(this.m.getText().toString(), 0, true);
                                Animation animationLoadAnimation2 = AnimationUtils.loadAnimation(this, R.anim.disappear_animation);
                                animationLoadAnimation2.setDuration(200L);
                                animationLoadAnimation2.setAnimationListener(new Animation.AnimationListener() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.8
                                    @Override // android.view.animation.Animation.AnimationListener
                                    public void onAnimationEnd(Animation animation) {
                                        try {
                                            OlaBalloonChatViewActivity.this.Q.setVisibility(8);
                                            Animation animationLoadAnimation3 = AnimationUtils.loadAnimation(OlaBalloonChatViewActivity.this, R.anim.appear_animation);
                                            animationLoadAnimation3.setDuration(200L);
                                            OlaBalloonChatViewActivity.this.R.startAnimation(animationLoadAnimation3);
                                            OlaBalloonChatViewActivity.this.R.setVisibility(0);
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
                                this.Q.startAnimation(animationLoadAnimation2);
                                break;
                            case R.id.voiceImageButton /* 2131297792 */:
                                h(false);
                                this.aj = 5;
                                if (this.k.a()) {
                                }
                                break;
                        }
                        j(false);
                    } catch (Throwable unused) {
                        return;
                    }
                    break;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    @TargetApi(14)
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Window window = getWindow();
        if (com.mg.ola.common.d.g.f()) {
            window.setDimAmount(0.5f);
        }
        window.addFlags(2);
        window.setBackgroundDrawable(null);
        if (N == null) {
            N = AnimationUtils.loadAnimation(this, R.anim.slide_in_from_bottom);
            N.setDuration(100L);
        }
        if (O == null) {
            O = AnimationUtils.loadAnimation(this, R.anim.slide_out_to_bottom);
            O.setDuration(100L);
        }
        R();
        this.H = new r(this);
        this.G = new o(this, null);
        this.G.a(new View.OnClickListener() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                OlaBalloonChatViewActivity.this.onMessageItemButtonClick(view);
            }
        });
        this.l.setAdapter((ListAdapter) this.G);
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i2, long j2) {
        try {
            if (T() == 0) {
                chat.ola.vn.message.f fVarA = this.H.getItem(i2);
                if (fVarA.k() == 5) {
                    if (((u) fVarA).a(this)) {
                        chat.ola.vn.h.t.b(fVarA);
                        return;
                    }
                    return;
                }
                if (fVarA.k() == 6) {
                    return;
                }
                if (fVarA.k() == 7) {
                    OlaOtherPeopleListActivity.a(this);
                    return;
                }
                List<chat.ola.vn.balloon.e> listF = OlaApplication.c.f();
                if (listF == null || listF.size() <= 0) {
                    return;
                }
                int size = listF.size();
                for (int i3 = 0; i3 < 4 && i3 < size; i3++) {
                    if (fVarA.equals(listF.get(i3).s)) {
                        d(i3 + 1);
                        return;
                    }
                }
                if (size >= 4) {
                    listF.remove(size - 1);
                }
                chat.ola.vn.balloon.e eVar = new chat.ola.vn.balloon.e(OlaApplication.c);
                eVar.setBalloonTerminator(OlaApplication.c.a);
                eVar.b.x = eVar.getWindowWidth() - eVar.getBalloonWidth();
                eVar.b.y = (eVar.getWindowHeight() / 3) - ((eVar.getBalloonHeight() / 2) + (new Random().nextInt(60) - 30));
                eVar.setBackupX(eVar.b.x);
                eVar.setBackupY(eVar.b.y);
                eVar.setVisibility(0);
                fVarA.a((Long) null);
                eVar.setContact(fVarA);
                listF.add(0, eVar);
                d(1);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AdapterView.OnItemLongClickListener
    public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i2, long j2) {
        try {
            if (view.getTag() == null || !(view.getTag() instanceof chat.ola.vn.entry.b.b)) {
                return a((chat.ola.vn.message.d) this.l.getItemAtPosition(i2), view);
            }
            return a((chat.ola.vn.message.d) this.l.getItemAtPosition(i2), ((chat.ola.vn.entry.b.b) view.getTag()).b());
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.cameraImageButton) {
                ah();
                return true;
            }
            if (id != R.id.likeButton) {
                return false;
            }
            a("(Y)", 0, false);
            try {
                Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.zoom_icon_animation);
                animationLoadAnimation.setDuration(150L);
                this.R.startAnimation(animationLoadAnimation);
                return true;
            } catch (Throwable unused) {
                return false;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void onMessageItemButtonClick(View view) {
        try {
            Object tag = view.getTag();
            switch (view.getId()) {
                case R.id.bookmarkImageButton /* 2131296402 */:
                    chat.ola.vn.message.d dVar = (chat.ola.vn.message.d) view.getTag();
                    OlaApplication.b.d(this.F.j(), this.F.k(), dVar.p());
                    dVar.x = false;
                    this.G.notifyDataSetChanged();
                    break;
                case R.id.btnMakeFriend /* 2131296479 */:
                    chat.ola.vn.message.d dVar2 = (chat.ola.vn.message.d) view.getTag();
                    if (dVar2 != null) {
                        OlaApplication.b.d(m.j(dVar2.i()));
                    }
                    break;
                case R.id.imgMeYoutubeThumbnail1 /* 2131296917 */:
                case R.id.meYouTubeInfo /* 2131297086 */:
                    chat.ola.vn.message.d dVar3 = (chat.ola.vn.message.d) tag;
                    if (!m.a(dVar3.v())) {
                        chat.ola.vn.util.b.a(this, dVar3.c());
                    } else if (!m.a(dVar3.c())) {
                        chat.ola.vn.util.b.a(this, dVar3.c(), view);
                    }
                    break;
                case R.id.messageLocationThumbnail /* 2131297108 */:
                    chat.ola.vn.message.d dVar4 = (chat.ola.vn.message.d) tag;
                    k kVar = (k) dVar4;
                    startActivityForResult(new Intent("android.intent.action.VIEW", Uri.parse("geo:" + kVar.C() + "," + kVar.a() + "?q=" + kVar.C() + "," + kVar.a() + "(@" + (dVar4.d() == 1 ? dVar4.i() : chat.ola.vn.h.a()) + ")")), 0);
                    break;
                case R.id.messageSenderTextview /* 2131297109 */:
                    a((chat.ola.vn.message.d) view.getTag());
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
        try {
            f(this.P);
            chat.ola.vn.h.t.b(this);
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i2, String[] strArr, int[] iArr) {
        if (i2 != 103) {
            if (i2 == 101 && iArr[0] == 0) {
                aj();
                return;
            }
            return;
        }
        if (iArr[0] == 0) {
            h(false);
            this.aj = 4;
            if (this.k.a()) {
                return;
            }
            j(false);
        }
    }

    @Override // android.app.Activity
    protected void onRestoreInstanceState(Bundle bundle) {
        super.onRestoreInstanceState(bundle);
        if (bundle != null) {
            String string = bundle.getString("_conv_id");
            short s = bundle.getShort("_conv_type");
            if (m.a(string)) {
                return;
            }
            this.F = chat.ola.vn.h.t.b(string, s, true);
            OlaApplication.c.f();
            a(this.F);
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        if (bundle != null) {
            try {
                bundle.putString("_conv_id", this.F.j());
                bundle.putShort("_conv_type", this.F.k());
            } catch (Throwable unused) {
            }
        }
        super.onSaveInstanceState(bundle);
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScroll(AbsListView absListView, int i2, int i3, int i4) {
        try {
            int iT = T();
            int top = 0;
            if (iT == 0) {
                View childAt = absListView.getChildAt(0);
                if (childAt != null) {
                    top = childAt.getTop();
                }
                i = top;
                j = i2;
                return;
            }
            if (iT <= 0 || this.F == null) {
                return;
            }
            if (i3 + i2 >= i4) {
                this.F.D = -1;
                this.F.E = -1;
                return;
            }
            this.F.D = i2;
            View childAt2 = absListView.getChildAt(0);
            chat.ola.vn.message.f fVar = this.F;
            if (childAt2 != null) {
                top = childAt2.getTop();
            }
            fVar.E = top;
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.AbsListView.OnScrollListener
    public void onScrollStateChanged(AbsListView absListView, int i2) {
        if (i2 != 0) {
            return;
        }
        try {
            if (T() <= 0) {
                return;
            }
            int top = 0;
            View childAt = this.l.getChildAt(0);
            chat.ola.vn.message.f fVar = this.F;
            if (childAt != null) {
                top = childAt.getTop();
            }
            fVar.E = top;
            if (this.F.D >= 0) {
                this.l.setTranscriptMode(1);
            } else {
                this.l.setTranscriptMode(2);
            }
            if (this.l.getFirstVisiblePosition() <= 2 && this.F.Q && chat.ola.vn.h.g()) {
                String strT = this.F.T();
                if (this.F.k() == 2) {
                    if (m.a(strT, this.F.O) || !OlaApplication.b.h(this.F.j(), strT, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.9
                        @Override // chat.ola.vn.entry.c.e
                        public short a() {
                            return (short) 55;
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(int i3, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        }

                        @Override // chat.ola.vn.entry.c.e
                        public void a(Object... objArr) {
                        }
                    }))) {
                        return;
                    } else {
                        this.F.O = strT;
                    }
                } else if (m.b(strT, "null") || m.a(strT, this.F.O) || !OlaApplication.b.i(this.F.j(), strT, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaBalloonChatViewActivity.10
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 55;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i3, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                    }
                }))) {
                    return;
                } else {
                    this.F.O = strT;
                }
                this.F.Q = true;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.text.TextWatcher
    public void onTextChanged(CharSequence charSequence, int i2, int i3, int i4) {
        if (i4 <= 0 || this.F == null || OlaApplication.b == null || System.currentTimeMillis() - this.I < 1500) {
            return;
        }
        this.I = System.currentTimeMillis();
        if (this.F.k() == 2) {
            OlaApplication.b.f(this.F.j());
        } else {
            OlaApplication.b.g(this.F.j());
        }
    }

    @Override // android.view.View.OnTouchListener
    @SuppressLint({"ClickableViewAccessibility"})
    public boolean onTouch(View view, MotionEvent motionEvent) {
        int id = view.getId();
        if (id == R.id.lvBubbleList) {
            h(false);
            return false;
        }
        if (id != R.id.txtNewMessage) {
            return false;
        }
        d(true);
        return false;
    }

    @Override // chat.ola.vn.c
    public FrameLayout z() {
        return this.h;
    }
}
