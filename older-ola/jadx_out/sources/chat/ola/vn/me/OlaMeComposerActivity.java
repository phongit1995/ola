package chat.ola.vn.me;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Point;
import android.location.Location;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Display;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.CheckBox;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.b.q;
import chat.ola.vn.b.s;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.checkin.OlaCheckInActivity;
import chat.ola.vn.checkin.OlaVenueDetailActivity;
import chat.ola.vn.cloud.OlaCloudPhotoChooserActivity;
import chat.ola.vn.cloud.OlaLocalPhotoChooserActivity;
import chat.ola.vn.contactpicker.OlaContactPickerActivity;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.ab;
import chat.ola.vn.entity.u;
import chat.ola.vn.entity.w;
import chat.ola.vn.entity.z;
import chat.ola.vn.message.f;
import chat.ola.vn.n.b;
import chat.ola.vn.network.a.a.aj;
import chat.ola.vn.network.a.a.l;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import chat.ola.vn.view.OlaTypingSuggestedText;
import chat.ola.vn.view.e;
import chat.ola.vn.view.g;
import chat.ola.vn.view.h;
import chat.ola.vn.view.i;
import chat.ola.vn.view.j;
import com.mg.ola.common.widget.OlaTextView;
import com.mg.ola.common.widget.SoftKeyLinearLayout;
import it.sephiroth.android.library.widget.HListView;
import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class OlaMeComposerActivity extends chat.ola.vn.c implements TextWatcher, View.OnClickListener, View.OnTouchListener, chat.ola.vn.checkin.b, OlaContactPickerActivity.b, b.InterfaceC0042b, l.a, OlaQuickTypingSuggestedText.b, e.a, g.e, h.b, i.e, j.a, com.mg.ola.common.widget.a.a {
    private static long E = 0;
    private static boolean F = false;
    private static boolean G = false;
    private static String H = null;
    private static String I = null;
    private static List<String> J = null;
    private static List<String> K = null;
    private static OlaVenueEntity L = null;
    private static z M = null;
    public static boolean e = false;
    private static long h;
    private OlaCachedImageView S;
    private TextView T;
    private TextView U;
    private int X;
    private View Y;
    private CheckBox Z;
    private View aa;
    private TextView ab;
    private Animation i;
    private Animation j;
    private View k;
    private SoftKeyLinearLayout l;
    private OlaTypingSuggestedText m;
    private TextView n;
    private TextView o;
    private TextView p;
    private HListView q;
    private s r;
    private OlaCachedImageView s;
    private View t;
    private chat.ola.vn.i.c u;
    private ImageButton v;
    private ImageButton w;
    private ImageButton x;
    private FrameLayout y;
    private int f = 0;
    private int g = 0;
    private h z = null;
    private i A = null;
    private j B = null;
    private chat.ola.vn.view.d C = null;
    private File D = null;
    private short N = 2;
    private w O = null;
    private OlaCheckInActionEntity P = null;
    private OlaCheckInItemEntity Q = null;
    private long R = 0;
    private long V = 0;
    private boolean W = false;

    private void C() {
        this.k = findViewById(R.id.meComposerGlobalLayout);
        this.Y = findViewById(R.id.postToViewLayout);
        this.Y.setOnClickListener(this);
        this.Z = (CheckBox) findViewById(R.id.postToMeCheckBox);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.meContentScrollView).setOnTouchListener(this);
        this.q = (HListView) findViewById(R.id.attachedPhotoListView);
        this.r = new s(this);
        this.q.setAdapter((ListAdapter) this.r);
        try {
            if (K != null) {
                Iterator<String> it2 = K.iterator();
                while (it2.hasNext()) {
                    this.r.c(it2.next());
                }
            }
        } catch (Throwable unused) {
        }
        try {
            if (J != null) {
                Iterator<String> it3 = J.iterator();
                while (it3.hasNext()) {
                    this.r.a(it3.next());
                }
            }
            this.r.notifyDataSetChanged();
        } catch (Throwable unused2) {
        }
        this.n = (TextView) findViewById(R.id.postToTextView);
        this.o = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.o.setOnClickListener(this);
        this.o.setText(R.string.string_post);
        this.p = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        this.m = (OlaTypingSuggestedText) findViewById(R.id.meContentEditText);
        q qVar = new q(this);
        qVar.a(chat.ola.vn.g.a());
        this.m.setAdapter(qVar);
        this.m.setPopupMaxHeight(getResources().getDimensionPixelSize(R.dimen.general_list_item_height_small) * 5);
        this.m.setAllowedSuggestion(x.r);
        this.m.addTextChangedListener(this);
        this.m.setOnSuggestionSelectListener(this);
        this.s = (OlaCachedImageView) findViewById(R.id.stickerImageView);
        this.s.setOnClickListener(this);
        this.l = (SoftKeyLinearLayout) findViewById(R.id.softKeyResizableViewLayout);
        this.l.setOnSoftKeyboardListener(this);
        this.t = findViewById(R.id.suggestedVenueViewLayout);
        this.t.setVisibility(8);
        this.ab = (TextView) findViewById(R.id.infoTopTitleTextView);
        this.ab.setText(R.string.string_you_are_staying_at);
        this.S = (OlaCachedImageView) findViewById(R.id.infoImageView);
        this.T = (TextView) findViewById(R.id.infoTitleTextView);
        this.U = (TextView) findViewById(R.id.infoSubtitleTextView);
        this.aa = findViewById(R.id.infoImageButton);
        this.aa.setOnClickListener(this);
        findViewById(R.id.infoViewLayout).setOnClickListener(this);
        F();
        if (D()) {
            return;
        }
        E();
    }

    private boolean D() {
        Intent intent;
        String action;
        try {
            intent = getIntent();
            action = intent.getAction();
        } catch (Throwable unused) {
        }
        if (m.b(action, "android.intent.action.SEND")) {
            E = 0L;
            if (intent.getType().contains("text")) {
                String stringExtra = intent.getStringExtra("android.intent.extra.TEXT");
                if (stringExtra != null) {
                    this.m.setText(n(stringExtra));
                    return true;
                }
            } else {
                Uri uri = (Uri) intent.getParcelableExtra("android.intent.extra.STREAM");
                if (uri != null) {
                    String strA = o.a(getContentResolver(), uri);
                    if (!m.a(strA)) {
                        ArrayList arrayList = new ArrayList();
                        arrayList.add(strA);
                        f(arrayList);
                    }
                }
            }
            return true;
        }
        if (m.b(action, "android.intent.action.SEND_MULTIPLE")) {
            E = 0L;
            ArrayList parcelableArrayListExtra = intent.getParcelableArrayListExtra("android.intent.extra.STREAM");
            if (intent.getType().contains("text")) {
                String stringExtra2 = intent.getStringExtra("android.intent.extra.TEXT");
                if (stringExtra2 != null) {
                    this.m.setText(n(stringExtra2));
                    return true;
                }
            } else if (parcelableArrayListExtra != null && !parcelableArrayListExtra.isEmpty()) {
                ArrayList arrayList2 = new ArrayList();
                int size = parcelableArrayListExtra.size();
                for (int i = 0; i < size; i++) {
                    String strA2 = o.a(getContentResolver(), (Uri) parcelableArrayListExtra.get(i));
                    if (!m.a(strA2)) {
                        arrayList2.add(strA2);
                    }
                }
                f(arrayList2);
            }
            return true;
        }
        return false;
    }

    private void E() {
        a aVarY;
        int length = 0;
        this.W = false;
        if (E == 0 && this.N != 10 && ((J == null || J.size() == 0) && ((K == null || K.size() == 0) && m.a(I) && m.a(H) && (aVarY = chat.ola.vn.h.u.y()) != null))) {
            if (System.currentTimeMillis() - aVarY.i > 300000) {
                chat.ola.vn.h.u.a((a) null);
            } else if (aVarY.k == 0) {
                chat.ola.vn.h.u.a((a) null);
                E = aVarY.h;
                this.N = aVarY.j;
                this.O = aVarY.b;
                H = aVarY.c;
                this.r.a(aVarY.a);
                this.r.notifyDataSetChanged();
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.1
                    @Override // java.lang.Runnable
                    public void run() {
                        OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                    }
                });
                M = null;
            }
        }
        String str = "";
        if (!m.a(H)) {
            str = H + " ";
            length = str.length();
        }
        if (!m.a(I)) {
            I = I.trim();
            str = str + I + " ";
        }
        if (str.length() > 0) {
            try {
                for (String str2 : chat.ola.vn.util.i.b((CharSequence) str)) {
                    if (chat.ola.vn.entity.i.i(str2) == 1) {
                        this.r.a(str2);
                    } else if (chat.ola.vn.entity.i.i(str2) == 2) {
                        this.r.b(str2);
                    }
                }
                this.r.notifyDataSetChanged();
            } catch (Throwable unused) {
            }
            try {
                String strE = chat.ola.vn.util.i.e(str);
                if (m.a(strE)) {
                    String strF = chat.ola.vn.util.i.f(str);
                    if (!m.a(strF)) {
                        OlaApplication.b.a(strF, new aj.a() { // from class: chat.ola.vn.me.OlaMeComposerActivity.16
                            @Override // chat.ola.vn.network.a.a.aj.a
                            public void a(z zVar) {
                                try {
                                    z unused2 = OlaMeComposerActivity.M = zVar;
                                    OlaMeComposerActivity.this.H();
                                } catch (Throwable unused3) {
                                }
                            }

                            @Override // chat.ola.vn.network.a.a.aj.a
                            public void a(String str3) {
                                try {
                                    z unused2 = OlaMeComposerActivity.M = null;
                                    OlaMeComposerActivity.this.H();
                                } catch (Throwable unused3) {
                                }
                            }
                        });
                    }
                } else {
                    OlaApplication.b.a(strE, new chat.ola.vn.p.l() { // from class: chat.ola.vn.me.OlaMeComposerActivity.12
                        @Override // chat.ola.vn.p.l
                        public void a(u uVar) {
                            try {
                                z unused2 = OlaMeComposerActivity.M = new z();
                                OlaMeComposerActivity.M.c = uVar.c();
                                OlaMeComposerActivity.M.e = uVar.j();
                                OlaMeComposerActivity.M.a = uVar.g();
                                OlaMeComposerActivity.M.f = uVar.d();
                                OlaMeComposerActivity.this.H();
                            } catch (Throwable unused3) {
                            }
                        }

                        @Override // chat.ola.vn.p.l
                        public void a(short s, String str3) {
                            try {
                                z unused2 = OlaMeComposerActivity.M = null;
                                OlaMeComposerActivity.this.H();
                            } catch (Throwable unused3) {
                            }
                        }
                    });
                }
            } catch (Throwable unused2) {
            }
            String strD = chat.ola.vn.util.i.d(str, "");
            this.m.setText(n(strD));
            this.m.setSelection(length, strD.length());
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void F() {
        ImageButton imageButton;
        this.y = (FrameLayout) findViewById(R.id.chatAttachmentFrameLayout);
        int i = 8;
        findViewById(R.id.quickReplyImageButton).setVisibility(8);
        this.v = (ImageButton) findViewById(R.id.chatTextSmileyImageButton);
        this.v.setOnClickListener(this);
        ImageButton imageButton2 = (ImageButton) findViewById(R.id.cameraImageButton);
        imageButton2.setImageResource(R.drawable.ic_local);
        imageButton2.setOnClickListener(this);
        this.w = (ImageButton) findViewById(R.id.kulImageButton);
        this.w.setOnClickListener(this);
        ImageButton imageButton3 = (ImageButton) findViewById(R.id.localPhotoImageButton);
        imageButton3.setImageResource(R.drawable.ic_cloud);
        imageButton3.setOnClickListener(this);
        ImageButton imageButton4 = (ImageButton) findViewById(R.id.voiceImageButton);
        imageButton4.setImageResource(R.drawable.ic_tag_people);
        imageButton4.setOnClickListener(this);
        this.x = (ImageButton) findViewById(R.id.moreImageButton);
        this.x.setImageResource(R.drawable.ic_checkin_gray);
        this.x.setOnClickListener(this);
        if (E == 0) {
            imageButton = this.x;
            i = 0;
        } else {
            imageButton = this.x;
        }
        imageButton.setVisibility(i);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void G() {
        HListView hListView;
        int i;
        if (this.r.d()) {
            hListView = this.q;
            i = 0;
        } else {
            hListView = this.q;
            i = 8;
        }
        hListView.setVisibility(i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void H() {
        TextView textView;
        String strH;
        if (M != null) {
            this.ab.setVisibility(8);
            this.aa.setVisibility(8);
            if (this.t.getVisibility() != 0) {
                this.t.startAnimation(this.i);
                this.t.setVisibility(0);
            }
            if (!m.a(M.c)) {
                this.T.setVisibility(0);
                this.T.setText(M.c);
            }
            if (!m.a(M.e)) {
                this.U.setVisibility(0);
                this.U.setText(M.e);
            }
            if (!m.a(M.f)) {
                this.S.setVisibility(0);
                if (M.f.toLowerCase(Locale.US).startsWith("http")) {
                    t.a().b(M.f, this.S);
                    return;
                } else {
                    t.a().b(M.f, this.S, 240);
                    return;
                }
            }
        } else {
            if (L == null || E != 0) {
                if (this.t.getVisibility() == 0) {
                    try {
                        this.t.startAnimation(this.j);
                    } catch (Throwable unused) {
                    }
                    this.t.setVisibility(8);
                    return;
                }
                return;
            }
            this.ab.setVisibility(0);
            this.aa.setVisibility(0);
            if (this.t.getVisibility() != 0) {
                this.t.startAnimation(this.i);
                this.t.setVisibility(0);
            }
            this.T.setText(L.c());
            this.U.setVisibility(0);
            if (this.P == null || m.a(this.P.b())) {
                if (L.i() > 100) {
                    textView = this.U;
                    strH = getString(R.string.string_check_in) + ": " + L.i();
                } else if (!m.a(L.d())) {
                    textView = this.U;
                    strH = L.d();
                } else if (!m.a(L.e())) {
                    textView = this.U;
                    strH = L.e();
                } else if (m.a(L.h())) {
                    this.U.setVisibility(8);
                } else {
                    textView = this.U;
                    strH = L.h();
                }
                textView.setText(strH);
            } else {
                String strB = this.P.b();
                if (this.Q != null && !m.a(this.Q.b())) {
                    strB = strB + " " + this.Q.b();
                }
                this.U.setText(strB);
            }
            String strF = L.f();
            if (strF != null) {
                this.S.setVisibility(0);
                if (strF.toLowerCase(Locale.US).startsWith("http")) {
                    t.a().a(strF, this.S, true);
                    return;
                } else if (chat.ola.vn.entity.i.i(strF) == 1) {
                    t.a().b(strF, this.S, 240);
                    return;
                }
            }
        }
        this.S.setVisibility(8);
    }

    private void N() {
        if (this.O == null) {
            this.s.setVisibility(8);
            return;
        }
        this.s.setVisibility(0);
        t.a().a(this.O.a(), this.s, ImageView.ScaleType.CENTER_INSIDE, (View) null, 240);
        this.s.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void O() {
        int i;
        TextView textView;
        short s = (short) (this.N & 16383);
        if ((this.N & 16384) == 16384) {
            textView = this.n;
            i = R.string.string_publishig_to_facebook;
        } else {
            i = R.string.string_indicated_visible_to_tag_people;
            switch (s) {
                case 1:
                    textView = this.n;
                    i = R.string.string_friends_only_your_friends_can_see;
                    break;
                case 2:
                    textView = this.n;
                    i = R.string.string_public_every_one_can_see;
                    break;
                case 3:
                    break;
                default:
                    switch (s) {
                        case 10:
                            textView = this.n;
                            i = R.string.string_diary_to_private_diary;
                            break;
                        case 11:
                            break;
                        default:
                            return;
                    }
                    break;
            }
            textView = this.n;
        }
        textView.setText(i);
    }

    private void P() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.string_public));
        arrayList.add(getString(R.string.string_friend));
        arrayList.add(getString(R.string.string_publishig_to_facebook));
        arrayList.add(getString(R.string.string_indicated));
        if (E == 0) {
            arrayList.add(getString(R.string.string_diary));
            arrayList.add(getString(R.string.string_box));
        }
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.me.OlaMeComposerActivity.21
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                chat.ola.vn.e eVarA;
                try {
                    String str = (String) arrayList.get(i);
                    if (m.b(str, OlaMeComposerActivity.this.getString(R.string.string_public))) {
                        OlaMeComposerActivity.this.N = (short) 2;
                        x.j = OlaMeComposerActivity.this.N;
                        eVarA = chat.ola.vn.e.a();
                    } else {
                        if (!m.b(str, OlaMeComposerActivity.this.getString(R.string.string_friend))) {
                            if (m.b(str, OlaMeComposerActivity.this.getString(R.string.string_indicated))) {
                                OlaMeComposerActivity.this.N = (short) 3;
                            } else if (m.b(str, OlaMeComposerActivity.this.getString(R.string.string_box))) {
                                OlaMeComposerActivity.this.N = (short) 11;
                            } else if (m.b(str, OlaMeComposerActivity.this.getString(R.string.string_diary)) || m.b(str, OlaMeComposerActivity.this.getString(R.string.string_diary))) {
                                OlaMeComposerActivity.this.N = (short) 10;
                            } else if (m.b(str, OlaMeComposerActivity.this.getString(R.string.string_publishig_to_facebook))) {
                                OlaMeComposerActivity.this.N = (short) (OlaMeComposerActivity.this.N | 16384);
                                x.j = OlaMeComposerActivity.this.N;
                                eVarA = chat.ola.vn.e.a();
                            }
                            OlaMeComposerActivity.this.O();
                        }
                        OlaMeComposerActivity.this.N = (short) 1;
                        x.j = OlaMeComposerActivity.this.N;
                        eVarA = chat.ola.vn.e.a();
                    }
                    eVarA.d(x.j);
                    OlaMeComposerActivity.this.O();
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void Q() {
        try {
            Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
            this.D = new File(chat.ola.vn.d.a(System.currentTimeMillis()));
            if (this.D.exists()) {
                this.D.delete();
            }
            intent.putExtra("output", Uri.fromFile(this.D));
            startActivityForResult(intent, 2);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void R() {
        if (Build.VERSION.SDK_INT < 23 || checkSelfPermission("android.permission.READ_EXTERNAL_STORAGE") == 0) {
            OlaLocalPhotoChooserActivity.a(this, this);
        } else {
            requestPermissions(new String[]{"android.permission.READ_EXTERNAL_STORAGE"}, 103);
        }
    }

    private void S() {
        OlaCloudPhotoChooserActivity.a(this, this);
    }

    private a T() {
        a aVarW = W();
        if (aVarW != null) {
            aVarW.i = System.currentTimeMillis();
            chat.ola.vn.h.u.a(aVarW);
        }
        return aVarW;
    }

    private void U() {
        this.s.startAnimation(this.j);
        this.s.setVisibility(8);
        this.O = null;
    }

    private void V() {
        try {
            a aVarT = T();
            if (aVarT != null) {
                aVarT.k = (byte) 1;
                aVarT.b();
            }
            this.W = true;
            finish();
        } catch (Throwable unused) {
        }
    }

    private a W() {
        List<ab> listA = this.r.a();
        String string = this.m.getText().toString();
        a aVar = new a();
        aVar.k = (byte) 0;
        aVar.b = this.O;
        if (listA != null) {
            aVar.a = new ArrayList(listA);
        }
        if (L != null) {
            aVar.d = L.b();
            aVar.e = L.j();
        }
        if (this.P != null) {
            aVar.f = this.P.a();
        }
        if (this.Q != null) {
            aVar.g = this.Q.a();
        }
        aVar.c = string;
        aVar.h = E;
        aVar.j = this.N;
        aVar.l = F;
        aVar.n = G;
        try {
            aVar.m = this.Z.isChecked();
        } catch (Throwable unused) {
        }
        if (E != 0 && m.a(string) && this.O == null && (listA == null || listA.size() == 0)) {
            return null;
        }
        return aVar;
    }

    private void X() {
        Location locationE = chat.ola.vn.n.c.a().e();
        if (locationE != null && (System.currentTimeMillis() - this.V <= 900000 || (locationE != null && locationE.getAccuracy() <= 50.0f))) {
            OlaCheckInActivity.a(this, this);
            return;
        }
        if (!chat.ola.vn.n.b.b(this)) {
            chat.ola.vn.n.b.a(this, 101);
            return;
        }
        if (this.u == null) {
            this.u = new chat.ola.vn.i.c(this);
            this.u.a(R.string.message_getting_location);
        }
        chat.ola.vn.n.b.b(this, 5000L, new b.InterfaceC0042b() { // from class: chat.ola.vn.me.OlaMeComposerActivity.2
            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void a(double d, double d2, float f) {
                try {
                    OlaMeComposerActivity.this.u.a();
                } catch (Throwable unused) {
                }
                try {
                    if (d == 0.0d || d2 == 0.0d) {
                        try {
                            OlaMeComposerActivity.this.u.a();
                        } catch (Throwable unused2) {
                        }
                        chat.ola.vn.i.i.a(OlaMeComposerActivity.this, R.string.dialog_title_inform, R.string.message_map_loading_gps_fail);
                    } else {
                        OlaMeComposerActivity.this.V = System.currentTimeMillis();
                        OlaCheckInActivity.a(OlaMeComposerActivity.this, OlaMeComposerActivity.this);
                    }
                } catch (Throwable unused3) {
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void j_() {
                try {
                    OlaMeComposerActivity.this.u.a();
                    chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.dialog_title_fail, R.string.message_not_yet_get_location);
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void k_() {
                try {
                    OlaMeComposerActivity.this.u.a(10000L, null);
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.n.b.InterfaceC0042b
            public void l_() {
                try {
                    OlaMeComposerActivity.this.u.a();
                    chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.message_location_provider_gps_unavailable_title, R.string.message_location_provider_unavailable, R.string.string_turn_on_gps, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.me.OlaMeComposerActivity.2.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                try {
                                    chat.ola.vn.c.c().startActivity(new Intent("android.settings.LOCATION_SOURCE_SETTINGS"));
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

    private void Y() {
        ImageButton imageButton;
        this.v.setSelected(false);
        this.w.setSelected(false);
        switch (this.g) {
            case 0:
                this.v.setSelected(false);
                return;
            case 1:
                imageButton = this.v;
                break;
            case 2:
                imageButton = this.w;
                break;
            case 3:
            case 4:
                return;
            default:
                return;
        }
        imageButton.setSelected(true);
    }

    private void Z() {
        if (this.f == 0) {
            this.f = this.k.getHeight() - OlaChatViewActivity.g;
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.4
            @Override // java.lang.Runnable
            public void run() {
                if (OlaMeComposerActivity.this.k.getLayoutParams().height == -1 || OlaMeComposerActivity.this.k.getLayoutParams().height != OlaMeComposerActivity.this.f) {
                    ViewGroup.LayoutParams layoutParams = OlaMeComposerActivity.this.k.getLayoutParams();
                    layoutParams.height = OlaMeComposerActivity.this.f;
                    OlaMeComposerActivity.this.k.setLayoutParams(layoutParams);
                }
            }
        });
    }

    public static void a(Context context) {
        a(context, (String) null, (String) null, (List<String>) null, (List<String>) null, (OlaVenueEntity) null, 0L, false);
    }

    public static void a(Context context, long j) {
        a(context, (String) null, (String) null, (String) null, j);
    }

    public static void a(Context context, OlaVenueEntity olaVenueEntity) {
        a(context, (String) null, (String) null, (List<String>) null, (List<String>) null, olaVenueEntity, 0L, false);
    }

    public static void a(Context context, String str) {
        a(context, (String) null, str, (List<String>) null, (List<String>) null, (OlaVenueEntity) null, 0L, true);
    }

    public static void a(Context context, String str, String str2) {
        a(context, str, str2, (List<String>) null, (List<String>) null, (OlaVenueEntity) null, 0L, false);
    }

    public static void a(Context context, String str, String str2, long j) {
        a(context, str, str2, (String) null, j);
    }

    public static void a(Context context, String str, String str2, String str3) {
        ArrayList arrayList;
        if (m.a(str3)) {
            arrayList = null;
        } else {
            arrayList = new ArrayList();
            arrayList.add(str3);
        }
        a(context, str, str2, (List<String>) arrayList, (List<String>) null, (OlaVenueEntity) null, 0L, false);
    }

    public static void a(Context context, String str, String str2, String str3, long j) {
        ArrayList arrayList;
        if (m.a(str3)) {
            arrayList = null;
        } else {
            arrayList = new ArrayList();
            arrayList.add(str3);
        }
        a(context, str, str2, (List<String>) arrayList, (List<String>) null, (OlaVenueEntity) null, j, false);
    }

    public static void a(Context context, String str, String str2, List<String> list) {
        a(context, str, str2, list, (List<String>) null, (OlaVenueEntity) null, 0L, false);
    }

    public static void a(Context context, String str, String str2, List<String> list, long j) {
        a(context, str, str2, list, (List<String>) null, (OlaVenueEntity) null, j, false);
    }

    private static void a(Context context, String str, String str2, List<String> list, List<String> list2, OlaVenueEntity olaVenueEntity, long j, boolean z) {
        if (m.a(str)) {
            str = null;
        }
        if (m.a(str2)) {
            str2 = null;
        }
        G = false;
        F = z;
        E = j;
        H = str;
        I = str2;
        J = list;
        K = list2;
        L = olaVenueEntity;
        Intent intent = new Intent(context, (Class<?>) OlaMeComposerActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_bottom_in, R.anim.push_top_out);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str, List<String> list) {
        a(context, (String) null, str, list, (List<String>) null, (OlaVenueEntity) null, 0L, true);
    }

    public static void a(Context context, List<String> list) {
        c(context, null, list);
    }

    private void aa() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.5
            @Override // java.lang.Runnable
            public void run() {
                if (OlaMeComposerActivity.this.k.getLayoutParams().height != -1) {
                    ViewGroup.LayoutParams layoutParams = OlaMeComposerActivity.this.k.getLayoutParams();
                    layoutParams.height = -1;
                    OlaMeComposerActivity.this.k.setLayoutParams(layoutParams);
                }
            }
        });
    }

    @TargetApi(13)
    private void ab() {
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

    private boolean ac() {
        try {
            switch (this.g) {
                case 1:
                case 2:
                case 3:
                    this.g = 0;
                    d(false);
                    return true;
                default:
                    return false;
            }
        } catch (Throwable unused) {
            return false;
        }
        return false;
    }

    public static void b(Context context) {
        x.j = (short) 10;
        a(context, (String) null, (String) null, (List<String>) null, (List<String>) null, (OlaVenueEntity) null, 0L, false);
    }

    public static void b(Context context, long j) {
        a(context, (String) null, (String) null, (String) null, j);
        G = true;
    }

    public static void b(Context context, String str) {
        a(context, (String) null, str, (List<String>) null, (List<String>) null, (OlaVenueEntity) null, 0L, false);
    }

    public static void b(Context context, String str, String str2) {
        a(context, str, (String) null, str2);
    }

    public static void b(Context context, String str, List<String> list) {
        a(context, (String) null, str, (List<String>) null, list, (OlaVenueEntity) null, 0L, true);
    }

    public static void c(Context context, String str) {
        b(context, (String) null, str);
    }

    public static void c(Context context, String str, List<String> list) {
        a(context, (String) null, str, (List<String>) null, list, (OlaVenueEntity) null, 0L, false);
    }

    @TargetApi(12)
    private void c(final boolean z) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.22
                @Override // java.lang.Runnable
                public void run() {
                    if (z) {
                        OlaMeComposerActivity.this.m.requestFocus();
                    }
                    o.a(OlaMeComposerActivity.this, OlaMeComposerActivity.this.m, z);
                }
            });
        } catch (Throwable unused) {
        }
    }

    public static void d(Context context, String str) {
        ArrayList arrayList;
        if (m.a(str)) {
            arrayList = null;
        } else {
            arrayList = new ArrayList();
            arrayList.add(str);
        }
        a(context, arrayList);
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    private void d(boolean z) {
        chat.ola.vn.view.d dVar;
        try {
            Y();
            boolean z2 = true;
            switch (this.g) {
                case 0:
                    this.y.removeAllViews();
                    e(false);
                    if (!z) {
                        aa();
                    } else {
                        Z();
                    }
                    break;
                case 1:
                    e(true);
                    Z();
                    if (this.z == null) {
                        this.z = new h(this);
                        this.z.setOlaSmileyListener(this);
                    }
                    try {
                        if (this.C == null || this.C != this.z) {
                            this.y.removeAllViews();
                            this.y.addView(this.z);
                            this.C = this.z;
                        }
                    } catch (Throwable unused) {
                    }
                    break;
                case 2:
                    e(true);
                    Z();
                    if (this.A == null) {
                        this.A = new i(this);
                        this.A.setOnStickerClickedListener(this);
                    }
                    if (this.C == null || this.C != this.A) {
                        this.y.removeAllViews();
                        this.y.addView(this.A);
                        dVar = this.A;
                        this.C = dVar;
                    }
                    z2 = false;
                    break;
                case 3:
                    e(true);
                    Z();
                    if (this.B == null) {
                        this.B = new j(this);
                        this.B.setOnVoiceRecordListener(this);
                    }
                    if (this.C == null || this.C != this.B) {
                        this.y.removeAllViews();
                        this.y.addView(this.B);
                        dVar = this.B;
                        this.C = dVar;
                    }
                    z2 = false;
                    break;
                case 4:
                    z2 = false;
                    break;
                default:
                    z2 = false;
                    break;
            }
            if (z2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.3
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            OlaMeComposerActivity.this.m.requestFocus();
                        } catch (Throwable unused2) {
                        }
                    }
                });
            }
        } catch (Throwable unused2) {
        }
    }

    private void e(boolean z) {
        if (z) {
            ViewGroup.LayoutParams layoutParams = this.y.getLayoutParams();
            if (layoutParams.height != OlaChatViewActivity.g) {
                layoutParams.height = OlaChatViewActivity.g;
                this.y.setLayoutParams(layoutParams);
            }
            this.y.setVisibility(0);
            return;
        }
        this.y.setVisibility(8);
        try {
            this.y.removeAllViews();
            if (this.C != null) {
                this.C.a();
            }
            this.C = null;
        } catch (Throwable unused) {
        }
    }

    private void m(String str) {
        try {
            String string = this.m.getText().toString();
            int selectionStart = this.m.getSelectionStart() >= 0 ? this.m.getSelectionStart() : 0;
            StringBuilder sb = new StringBuilder(string);
            sb.insert(selectionStart, str);
            this.m.setText(n(sb.toString()));
            this.m.setSelection(selectionStart + str.length());
        } catch (Throwable unused) {
            this.m.append(str);
        }
    }

    private CharSequence n(String str) {
        return chat.ola.vn.util.i.a(str, (OlaTextView.b) null);
    }

    @Override // chat.ola.vn.view.e.a
    public boolean I() {
        Q();
        this.g = 0;
        d(false);
        return true;
    }

    @Override // chat.ola.vn.view.e.a
    public boolean J() {
        try {
            ViewGroup.LayoutParams layoutParams = this.y.getLayoutParams();
            layoutParams.height = -1;
            this.y.setLayoutParams(layoutParams);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.view.e.a
    public boolean K() {
        try {
            ViewGroup.LayoutParams layoutParams = this.y.getLayoutParams();
            if (layoutParams.height == OlaChatViewActivity.g) {
                return true;
            }
            layoutParams.height = OlaChatViewActivity.g;
            this.y.setLayoutParams(layoutParams);
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

    @Override // chat.ola.vn.c
    protected void a() {
        TextView textView;
        int i;
        try {
            this.X = getResources().getConfiguration().orientation;
        } catch (Throwable unused) {
        }
        if (E != 0) {
            this.Y.setVisibility(0);
            this.Z.setVisibility(8);
            textView = this.p;
            i = R.string.string_comment_title;
        } else if (F) {
            this.Y.setVisibility(8);
            this.Z.setVisibility(0);
            textView = this.p;
            i = R.string.string_share_your_mind;
        } else if (this.N == 10) {
            this.Y.setVisibility(8);
            this.Z.setVisibility(8);
            textView = this.p;
            i = R.string.string_write_diary;
        } else {
            this.Y.setVisibility(0);
            this.Z.setVisibility(8);
            textView = this.p;
            i = R.string.string_post_me;
        }
        textView.setText(i);
        O();
        G();
        N();
        if (L == null) {
            L = chat.ola.vn.n.c.a().f();
        }
        H();
        if (L == null && System.currentTimeMillis() - this.R >= 600000) {
            Location locationE = chat.ola.vn.n.c.a().e();
            if (locationE != null && locationE.getAccuracy() <= 50.0f) {
                OlaApplication.b.a((l.a) this);
            }
            if (chat.ola.vn.n.b.b(this)) {
                chat.ola.vn.n.b.b(this, 15000L, this);
            } else if (System.currentTimeMillis() - h >= 900000) {
                h = System.currentTimeMillis();
                chat.ola.vn.n.b.a(this, 101);
            }
        }
        if (e) {
            e = false;
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.17
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.R();
                }
            }, 1000L);
        }
    }

    @Override // chat.ola.vn.n.b.InterfaceC0042b
    public void a(double d, double d2, float f) {
        this.R = System.currentTimeMillis();
        if (f <= 50.0f) {
            OlaApplication.b.a((l.a) this);
        }
    }

    @Override // chat.ola.vn.network.a.a.l.a
    public void a(int i, String str) {
    }

    @Override // chat.ola.vn.view.i.e
    public void a(w wVar) {
        this.O = wVar;
        N();
    }

    @Override // chat.ola.vn.checkin.b
    public void a(String str, OlaVenueEntity olaVenueEntity, OlaCheckInActionEntity olaCheckInActionEntity, OlaCheckInItemEntity olaCheckInItemEntity) {
        this.R = System.currentTimeMillis();
        this.P = olaCheckInActionEntity;
        this.Q = olaCheckInItemEntity;
        L = olaVenueEntity;
        L.i(str);
        H();
    }

    @Override // chat.ola.vn.network.a.a.l.a
    public void a(List<OlaVenueEntity> list) {
        try {
            OlaVenueEntity olaVenueEntity = list.get(0);
            if (chat.ola.vn.n.c.a().b(olaVenueEntity)) {
                L = null;
                H();
                return;
            }
            if (L == null) {
                L = olaVenueEntity;
                if (m.a(L.f()) || m.a(L.c())) {
                    L = null;
                }
            }
            if (olaVenueEntity != null) {
                chat.ola.vn.n.c.a().a(olaVenueEntity);
            }
            H();
        } catch (Throwable unused) {
        }
    }

    @Override // com.mg.ola.common.widget.a.a
    public void a(boolean z, int i) {
        if (z) {
            this.g = 0;
            ab();
            int i2 = (chat.ola.vn.e.d - chat.ola.vn.e.e) - i;
            if (OlaChatViewActivity.g != i2) {
                OlaChatViewActivity.g = i2;
                chat.ola.vn.e.a().c(OlaChatViewActivity.g);
            }
            this.f = i;
        } else if (OlaChatViewActivity.g == 0) {
            OlaChatViewActivity.g = getResources().getDimensionPixelSize(R.dimen.metric_240dp);
        }
        d(z);
        if (this.g == 0) {
            e(false);
        }
    }

    @Override // chat.ola.vn.view.e.a
    public void a_(String str) {
        try {
            this.r.c(str);
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.15
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // android.text.TextWatcher
    public void afterTextChanged(Editable editable) {
    }

    @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
    public void b_(String str) {
        try {
            String string = this.m.getText().toString();
            int selectionStart = this.m.getSelectionStart() >= 0 ? this.m.getSelectionStart() : 0;
            this.m.setText(n(new StringBuilder(string).toString()));
            this.m.setSelection(selectionStart);
        } catch (Throwable unused) {
        }
    }

    @Override // android.text.TextWatcher
    public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }

    @Override // chat.ola.vn.view.g.e
    public void d(List<String> list) {
        try {
            if (list.size() > 0) {
                ac();
            }
            Iterator<String> it2 = list.iterator();
            while (it2.hasNext()) {
                this.r.a(it2.next());
            }
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.10
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void e(List<String> list) {
        try {
            if (list.size() > 0) {
                ac();
            }
            Iterator<String> it2 = list.iterator();
            while (it2.hasNext()) {
                this.r.b(it2.next());
            }
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.11
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void f(List<String> list) {
        try {
            if (list.size() > 0) {
                ac();
            }
            Iterator<String> it2 = list.iterator();
            while (it2.hasNext()) {
                this.r.c(it2.next());
            }
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.13
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_top_in, R.anim.push_bottom_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.h.b
    public void g(String str) {
        m(str + " ");
    }

    @Override // chat.ola.vn.view.g.e
    public void g(List<String> list) {
        try {
            if (list.size() > 0) {
                ac();
            }
            Iterator<String> it2 = list.iterator();
            while (it2.hasNext()) {
                this.r.d(it2.next());
            }
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.14
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void h(String str) {
        try {
            this.r.c(str);
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.6
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.e.a
    public void h(String str, short s) {
        a_(str);
    }

    @Override // chat.ola.vn.contactpicker.OlaContactPickerActivity.b
    public void h(List<f> list) {
        try {
            Iterator<f> it2 = list.iterator();
            while (it2.hasNext()) {
                m(" @" + it2.next().j());
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void i(String str) {
        try {
            this.r.d(str);
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.7
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void j(String str) {
        try {
            this.r.a(str);
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.8
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.n.b.InterfaceC0042b
    public void j_() {
    }

    @Override // chat.ola.vn.view.g.e
    public void k(String str) {
        try {
            this.r.b(str);
            G();
            this.r.notifyDataSetChanged();
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.9
                @Override // java.lang.Runnable
                public void run() {
                    OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.n.b.InterfaceC0042b
    public void k_() {
    }

    @Override // chat.ola.vn.view.j.a
    public void l(String str) {
    }

    @Override // chat.ola.vn.n.b.InterfaceC0042b
    public void l_() {
    }

    @Override // chat.ola.vn.checkin.b
    public void m_() {
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        String[] stringArrayExtra;
        try {
            if (i == 2) {
                if (i2 == -1 && this.D != null && this.D.exists()) {
                    File file = new File(chat.ola.vn.d.a(this.D.length()));
                    com.mg.ola.common.d.c.a(this.D, file, true);
                    this.D.delete();
                    a_(file.getAbsolutePath());
                }
            } else if (i == 3 && i2 == -1 && (stringArrayExtra = intent.getStringArrayExtra("all_path")) != null && stringArrayExtra.length > 0) {
                ArrayList arrayList = new ArrayList(stringArrayExtra.length);
                for (String str : stringArrayExtra) {
                    arrayList.add(str);
                }
                f(arrayList);
            }
        } catch (Throwable unused) {
        }
        this.D = null;
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (ac()) {
            return;
        }
        super.onBackPressed();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        chat.ola.vn.c cVarC;
        String str;
        try {
            switch (view.getId()) {
                case R.id.cameraImageButton /* 2131296579 */:
                    R();
                    return;
                case R.id.chatTextSmileyImageButton /* 2131296604 */:
                    c(false);
                    this.g = 1;
                    if (this.l.a()) {
                        return;
                    }
                    break;
                case R.id.infoImageButton /* 2131296950 */:
                    L = null;
                    H();
                    return;
                case R.id.infoViewLayout /* 2131296955 */:
                    if (M == null || m.a(M.a)) {
                        if (L != null) {
                            OlaVenueDetailActivity.a(this, L.b());
                            return;
                        }
                        return;
                    } else {
                        if (!M.a.toLowerCase(Locale.US).startsWith("http")) {
                            chat.ola.vn.m.j.a(chat.ola.vn.c.c(), M.a);
                            return;
                        }
                        if (m.a(M.b)) {
                            cVarC = chat.ola.vn.c.c();
                            str = M.a;
                        } else {
                            cVarC = chat.ola.vn.c.c();
                            str = M.b;
                        }
                        chat.ola.vn.util.b.o(cVarC, str);
                        return;
                    }
                case R.id.kulImageButton /* 2131296968 */:
                    c(false);
                    this.g = 2;
                    if (this.l.a()) {
                        return;
                    }
                    break;
                case R.id.localPhotoImageButton /* 2131297040 */:
                    S();
                    return;
                case R.id.moreImageButton /* 2131297120 */:
                    X();
                    return;
                case R.id.olaActionBarBackViewLayout /* 2131297180 */:
                    onBackPressed();
                    return;
                case R.id.olaActionBarButtonTextView /* 2131297182 */:
                    V();
                    return;
                case R.id.postToViewLayout /* 2131297249 */:
                    P();
                    return;
                case R.id.stickerImageView /* 2131297436 */:
                    U();
                    return;
                case R.id.voiceImageButton /* 2131297792 */:
                    OlaContactPickerActivity.b(this, this);
                    return;
                default:
                    return;
            }
            d(false);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        if (this.X != configuration.orientation) {
            this.X = configuration.orientation;
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_me_composer_layout);
        this.i = AnimationUtils.loadAnimation(this, R.anim.fade_in);
        this.i.setDuration(300L);
        this.j = AnimationUtils.loadAnimation(this, R.anim.fade_out);
        this.j.setDuration(300L);
        this.N = x.j;
        C();
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
        try {
            if (!this.W) {
                T();
            }
        } catch (Throwable unused) {
        }
        try {
            x.j = chat.ola.vn.e.a().f();
        } catch (Throwable unused2) {
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        if (i == 103) {
            if (iArr[0] == 0) {
                OlaLocalPhotoChooserActivity.a(this, this);
            }
        } else if (i == 101 && iArr[0] == 0) {
            chat.ola.vn.n.b.b(this, 15000L, this);
        }
    }

    @Override // android.text.TextWatcher
    public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        if (i3 > 5) {
            try {
                charSequence.toString();
                ArrayList<String> arrayListB = chat.ola.vn.util.i.b(charSequence);
                if (arrayListB != null && arrayListB.size() > 0) {
                    String strTrim = chat.ola.vn.util.i.d(charSequence, "").trim();
                    boolean z = false;
                    for (String str : arrayListB) {
                        if (chat.ola.vn.entity.i.i(str) == 1) {
                            if (w.b(str)) {
                                this.O = new w();
                                this.O.a(str);
                            } else {
                                this.r.a(str);
                                z = true;
                            }
                        } else if (chat.ola.vn.entity.i.i(str) == 2) {
                            this.r.b(str);
                            z = true;
                        } else if (m.a(strTrim)) {
                            strTrim = "##" + str + "#";
                        } else {
                            strTrim = strTrim + " ##" + str + "#";
                        }
                    }
                    if (!m.a(strTrim)) {
                        strTrim = strTrim + " ";
                    }
                    G();
                    if (z) {
                        this.r.notifyDataSetChanged();
                        ac();
                    }
                    N();
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.me.OlaMeComposerActivity.18
                        @Override // java.lang.Runnable
                        public void run() {
                            OlaMeComposerActivity.this.q.c(OlaMeComposerActivity.this.r.getCount() - 1);
                        }
                    });
                    this.m.removeTextChangedListener(this);
                    int selectionStart = this.m.getSelectionStart() >= 0 ? this.m.getSelectionStart() : 0;
                    this.m.setText(n(strTrim));
                    int length = selectionStart + i3;
                    try {
                        if (length > strTrim.length()) {
                            length = strTrim.length();
                        }
                        this.m.setSelection(length);
                    } catch (Throwable unused) {
                    }
                    this.m.addTextChangedListener(this);
                }
                String strE = chat.ola.vn.util.i.e(charSequence);
                if (!m.a(strE)) {
                    OlaApplication.b.a(strE, new chat.ola.vn.p.l() { // from class: chat.ola.vn.me.OlaMeComposerActivity.19
                        @Override // chat.ola.vn.p.l
                        public void a(u uVar) {
                            try {
                                z unused2 = OlaMeComposerActivity.M = new z();
                                OlaMeComposerActivity.M.c = uVar.c();
                                OlaMeComposerActivity.M.e = uVar.j();
                                OlaMeComposerActivity.M.a = uVar.g();
                                OlaMeComposerActivity.M.f = uVar.d();
                                OlaMeComposerActivity.this.H();
                            } catch (Throwable unused3) {
                            }
                        }

                        @Override // chat.ola.vn.p.l
                        public void a(short s, String str2) {
                            try {
                                z unused2 = OlaMeComposerActivity.M = null;
                                OlaMeComposerActivity.this.H();
                            } catch (Throwable unused3) {
                            }
                        }
                    });
                    return;
                }
                String strF = chat.ola.vn.util.i.f(charSequence);
                if (m.a(strF)) {
                    return;
                }
                OlaApplication.b.a(strF, new aj.a() { // from class: chat.ola.vn.me.OlaMeComposerActivity.20
                    @Override // chat.ola.vn.network.a.a.aj.a
                    public void a(z zVar) {
                        try {
                            z unused2 = OlaMeComposerActivity.M = zVar;
                            OlaMeComposerActivity.this.H();
                        } catch (Throwable unused3) {
                        }
                    }

                    @Override // chat.ola.vn.network.a.a.aj.a
                    public void a(String str2) {
                        try {
                            z unused2 = OlaMeComposerActivity.M = null;
                            OlaMeComposerActivity.this.H();
                        } catch (Throwable unused3) {
                        }
                    }
                });
            } catch (Throwable unused2) {
            }
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:12:0x001e, code lost:
    
        if (r2.g == 0) goto L13;
     */
    /* JADX WARN: Code restructure failed: missing block: B:13:0x0020, code lost:
    
        c(false);
     */
    /* JADX WARN: Code restructure failed: missing block: B:14:0x0023, code lost:
    
        return false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:15:0x0024, code lost:
    
        r2.g = 0;
        d(false);
     */
    /* JADX WARN: Code restructure failed: missing block: B:16:0x0029, code lost:
    
        return false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:22:0x003a, code lost:
    
        if (r2.g == 0) goto L13;
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
            int r0 = r4.getAction()
            r1 = 0
            if (r0 != 0) goto L41
            int r3 = r3.getId()
            r0 = 2131297078(0x7f090336, float:1.821209E38)
            if (r3 == r0) goto L2a
            r0 = 2131297185(0x7f0903a1, float:1.8212308E38)
            if (r3 == r0) goto L16
            return r1
        L16:
            int r3 = r4.getAction()
            if (r3 != 0) goto L41
            int r3 = r2.g
            if (r3 != 0) goto L24
        L20:
            r2.c(r1)
            return r1
        L24:
            r2.g = r1
            r2.d(r1)
            return r1
        L2a:
            int r3 = r4.getAction()
            if (r3 != 0) goto L41
            com.mg.ola.common.widget.SoftKeyLinearLayout r3 = r2.l
            boolean r3 = r3.a()
            if (r3 == 0) goto L3d
            int r3 = r2.g
            if (r3 != 0) goto L24
            goto L20
        L3d:
            r3 = 1
            r2.c(r3)
        L41:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.me.OlaMeComposerActivity.onTouch(android.view.View, android.view.MotionEvent):boolean");
    }
}
