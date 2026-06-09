package chat.ola.vn.note;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Point;
import android.net.Uri;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Display;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.b.q;
import chat.ola.vn.c;
import chat.ola.vn.c.x;
import chat.ola.vn.contactpicker.OlaContactPickerActivity;
import chat.ola.vn.entity.w;
import chat.ola.vn.message.f;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;
import chat.ola.vn.view.OlaTypingSuggestedText;
import chat.ola.vn.view.d;
import chat.ola.vn.view.e;
import chat.ola.vn.view.g;
import chat.ola.vn.view.h;
import chat.ola.vn.view.i;
import chat.ola.vn.view.j;
import com.mg.ola.common.widget.OlaTextView;
import com.mg.ola.common.widget.SoftKeyLinearLayout;
import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaNoteComposerActivity extends c implements TextWatcher, View.OnClickListener, View.OnLongClickListener, View.OnTouchListener, OlaContactPickerActivity.b, OlaQuickTypingSuggestedText.b, e.a, g.e, h.b, i.e, j.a, com.mg.ola.common.widget.a.a {
    private static String A;
    private static String B;
    public static a e;
    private int C;
    private Animation h;
    private Animation i;
    private View j;
    private SoftKeyLinearLayout k;
    private OlaTypingSuggestedText l;
    private EditText m;
    private TextView n;
    private ImageButton o;
    private ImageButton p;
    private ImageButton q;
    private ImageButton r;
    private FrameLayout s;
    private File z;
    private int f = 0;
    private int g = 0;
    private h t = null;
    private i u = null;
    private d v = null;
    private g w = null;
    private j x = null;
    private d y = null;
    private boolean D = false;
    private int E = 0;

    private void B() {
        this.j = findViewById(R.id.meComposerGlobalLayout);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.meContentScrollView).setOnTouchListener(this);
        this.n = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.n.setOnClickListener(this);
        this.n.setText(R.string.string_post);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_edit_note);
        this.m = (EditText) findViewById(R.id.noteTitleEditText);
        this.l = (OlaTypingSuggestedText) findViewById(R.id.meContentEditText);
        q qVar = new q(this);
        qVar.a(chat.ola.vn.g.a());
        this.l.setAdapter(qVar);
        this.l.setPopupMaxHeight(getResources().getDimensionPixelSize(R.dimen.general_list_item_height_small) * 5);
        this.l.setAllowedSuggestion(x.r);
        this.l.addTextChangedListener(this);
        this.l.setOnSuggestionSelectListener(this);
        this.k = (SoftKeyLinearLayout) findViewById(R.id.softKeyResizableViewLayout);
        this.k.setOnSoftKeyboardListener(this);
        View viewFindViewById = findViewById(R.id.vLinearContentEditNote);
        this.E = (chat.ola.vn.e.c - viewFindViewById.getPaddingLeft()) - viewFindViewById.getPaddingRight();
        D();
        C();
    }

    private void C() {
        int length = 0;
        try {
            this.D = false;
            if (m.a(B) && m.a(A) && e != null && e.c == 0) {
                A = e.a;
            }
            String str = "";
            if (!m.a(A)) {
                A = A.trim();
                str = A + " ";
                length = str.length();
            }
            if (!m.a(B)) {
                B = B.trim();
                str = str + B + " ";
            }
            if (str.length() > 0) {
                this.l.setText(n(str));
                this.l.setSelection(length, str.length());
            }
        } catch (Throwable unused) {
        }
    }

    private void D() {
        this.s = (FrameLayout) findViewById(R.id.chatAttachmentFrameLayout);
        findViewById(R.id.quickReplyImageButton).setVisibility(8);
        this.o = (ImageButton) findViewById(R.id.chatTextSmileyImageButton);
        this.o.setOnClickListener(this);
        this.p = (ImageButton) findViewById(R.id.cameraImageButton);
        this.p.setOnClickListener(this);
        this.p.setOnLongClickListener(this);
        this.q = (ImageButton) findViewById(R.id.kulImageButton);
        this.q.setOnClickListener(this);
        this.r = (ImageButton) findViewById(R.id.localPhotoImageButton);
        this.r.setOnClickListener(this);
        ImageButton imageButton = (ImageButton) findViewById(R.id.voiceImageButton);
        imageButton.setImageResource(R.drawable.ic_tag_people);
        imageButton.setOnClickListener(this);
        findViewById(R.id.moreImageButton).setVisibility(8);
    }

    private void E() {
        try {
            Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
            this.z = new File(chat.ola.vn.d.a(System.currentTimeMillis()));
            if (this.z.exists()) {
                this.z.delete();
            }
            intent.putExtra("output", Uri.fromFile(this.z));
            startActivityForResult(intent, 2);
        } catch (Throwable unused) {
        }
    }

    @SuppressLint({"InlinedApi"})
    private void F() {
        if (com.mg.ola.common.d.g.h()) {
            Intent intent = new Intent();
            intent.setType("image/*");
            intent.putExtra("android.intent.extra.ALLOW_MULTIPLE", true);
            intent.setAction("android.intent.action.GET_CONTENT");
            startActivityForResult(Intent.createChooser(intent, getString(R.string.string_select_photo)), 3);
        }
    }

    private a G() {
        e = N();
        return e;
    }

    private void H() {
        try {
            e = N();
            if (e != null) {
                e.c = (byte) 1;
                e.b();
                chat.ola.vn.util.j.d(this, R.string.message_publish_note_background_notify);
            }
            this.D = true;
            finish();
        } catch (Throwable unused) {
        }
    }

    private a N() {
        String string = this.l.getText().toString();
        e = new a();
        e.c = (byte) 0;
        e.a = string;
        e.b = this.m.getText().toString();
        return e;
    }

    private void O() {
        try {
            String string = this.l.getText().toString();
            int selectionStart = this.l.getSelectionStart() >= 0 ? this.l.getSelectionStart() : 0;
            this.l.setText(n(string));
            this.l.setSelection(selectionStart);
        } catch (Throwable unused) {
        }
    }

    private void P() {
        ImageButton imageButton;
        this.o.setSelected(false);
        this.p.setSelected(false);
        this.q.setSelected(false);
        this.r.setSelected(false);
        switch (this.g) {
            case 0:
                this.o.setSelected(false);
                return;
            case 1:
                imageButton = this.o;
                break;
            case 2:
                imageButton = this.p;
                break;
            case 3:
                imageButton = this.q;
                break;
            case 4:
                imageButton = this.r;
                break;
            case 5:
            case 6:
                return;
            default:
                return;
        }
        imageButton.setSelected(true);
    }

    private void Q() {
        if (this.f == 0) {
            this.f = this.j.getHeight() - OlaChatViewActivity.g;
        }
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.note.OlaNoteComposerActivity.3
            @Override // java.lang.Runnable
            public void run() {
                if (OlaNoteComposerActivity.this.j.getLayoutParams().height == -1 || OlaNoteComposerActivity.this.j.getLayoutParams().height != OlaNoteComposerActivity.this.f) {
                    ViewGroup.LayoutParams layoutParams = OlaNoteComposerActivity.this.j.getLayoutParams();
                    layoutParams.height = OlaNoteComposerActivity.this.f;
                    OlaNoteComposerActivity.this.j.setLayoutParams(layoutParams);
                }
            }
        });
    }

    private void R() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.note.OlaNoteComposerActivity.4
            @Override // java.lang.Runnable
            public void run() {
                if (OlaNoteComposerActivity.this.j.getLayoutParams().height != -1) {
                    ViewGroup.LayoutParams layoutParams = OlaNoteComposerActivity.this.j.getLayoutParams();
                    layoutParams.height = -1;
                    OlaNoteComposerActivity.this.j.setLayoutParams(layoutParams);
                }
            }
        });
    }

    @TargetApi(13)
    private void S() {
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

    private boolean T() {
        try {
            switch (this.g) {
                case 2:
                    try {
                        if (((e) this.v).c()) {
                            ((e) this.v).e();
                            return true;
                        }
                    } catch (Throwable unused) {
                        break;
                    }
                case 1:
                case 3:
                case 4:
                case 5:
                    this.g = 0;
                    d(false);
                    return true;
                default:
                    return false;
            }
        } catch (Throwable unused2) {
            return false;
        }
    }

    public static void a(Context context) {
        a(context, (String) null, (String) null, (List<String>) null, (List<String>) null, 0L, false);
    }

    private static void a(Context context, String str, String str2, List<String> list, List<String> list2, long j, boolean z) {
        if (m.a(str)) {
            str = null;
        }
        if (m.a(str2)) {
            str2 = null;
        }
        A = str;
        B = str2;
        Intent intent = new Intent(context, (Class<?>) OlaNoteComposerActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_bottom_in, R.anim.push_top_out);
        } catch (Throwable unused) {
        }
    }

    @TargetApi(12)
    private void c(final boolean z) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.note.OlaNoteComposerActivity.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        if (z) {
                            OlaNoteComposerActivity.this.l.requestFocus();
                        }
                        o.a(OlaNoteComposerActivity.this, OlaNoteComposerActivity.this.l, z);
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    private void d(boolean z) {
        d dVar;
        try {
            P();
            boolean z2 = true;
            switch (this.g) {
                case 0:
                    this.v = null;
                    this.s.removeAllViews();
                    e(false);
                    if (!z) {
                        R();
                    } else {
                        Q();
                    }
                    break;
                case 1:
                    this.v = null;
                    e(true);
                    Q();
                    if (this.t == null) {
                        this.t = new h(this);
                        this.t.setOlaSmileyListener(this);
                    }
                    try {
                        if (this.y == null || this.y != this.t) {
                            this.s.removeAllViews();
                            this.s.addView(this.t);
                            this.y = this.t;
                        }
                    } catch (Throwable unused) {
                    }
                    break;
                case 2:
                    e(true);
                    Q();
                    if (com.mg.ola.common.d.g.f()) {
                        if (this.v == null) {
                            this.v = new e(this);
                            ((e) this.v).b();
                            ((e) this.v).setOlaCameraListener(this);
                        }
                        if (this.y == null || this.y != this.v) {
                            this.s.removeAllViews();
                            this.s.addView(this.v);
                            dVar = this.v;
                            this.y = dVar;
                        }
                    }
                    z2 = false;
                    break;
                case 3:
                    this.v = null;
                    e(true);
                    Q();
                    if (this.u == null) {
                        this.u = new i(this);
                        this.u.setOnStickerClickedListener(this);
                    }
                    if (this.y == null || this.y != this.u) {
                        this.s.removeAllViews();
                        this.s.addView(this.u);
                        dVar = this.u;
                        this.y = dVar;
                    }
                    z2 = false;
                    break;
                case 4:
                    this.v = null;
                    e(true);
                    Q();
                    if (this.w == null) {
                        this.w = new g(this);
                        this.w.setAllowVideo(false);
                        this.w.setSendButtonText(getString(R.string.string_add));
                        this.w.setOlaPhotoListener(this);
                    }
                    if (this.y == null || this.y != this.w) {
                        this.s.removeAllViews();
                        this.s.addView(this.w);
                        dVar = this.w;
                        this.y = dVar;
                    }
                    z2 = false;
                    break;
                case 5:
                    this.v = null;
                    e(true);
                    Q();
                    if (this.x == null) {
                        this.x = new j(this);
                        this.x.setOnVoiceRecordListener(this);
                    }
                    if (this.y == null || this.y != this.x) {
                        this.s.removeAllViews();
                        this.s.addView(this.x);
                        dVar = this.x;
                        this.y = dVar;
                    }
                    z2 = false;
                    break;
                case 6:
                    z2 = false;
                    break;
                default:
                    z2 = false;
                    break;
            }
            if (z2) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.note.OlaNoteComposerActivity.2
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            if (OlaNoteComposerActivity.this.m.isFocused()) {
                                return;
                            }
                            OlaNoteComposerActivity.this.l.requestFocus();
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
            ViewGroup.LayoutParams layoutParams = this.s.getLayoutParams();
            if (layoutParams.height != OlaChatViewActivity.g) {
                layoutParams.height = OlaChatViewActivity.g;
                this.s.setLayoutParams(layoutParams);
            }
            this.s.setVisibility(0);
            return;
        }
        this.s.setVisibility(8);
        try {
            this.s.removeAllViews();
            if (this.y != null) {
                this.y.a();
            }
            this.y = null;
        } catch (Throwable unused) {
        }
    }

    private void m(String str) {
        try {
            String string = this.l.getText().toString();
            int selectionStart = this.l.getSelectionStart() >= 0 ? this.l.getSelectionStart() : 0;
            StringBuilder sb = new StringBuilder(string);
            sb.insert(selectionStart, str);
            this.l.setText(n(sb.toString()));
            this.l.setSelection(selectionStart + str.length());
        } catch (Throwable unused) {
            this.l.append(str);
        }
    }

    private CharSequence n(String str) {
        try {
            int i = this.E;
            int i2 = this.E;
            return chat.ola.vn.util.i.b(chat.ola.vn.util.i.a(chat.ola.vn.util.i.a(str, (OlaTextView.b) null), i, i2), i, i2);
        } catch (Throwable unused) {
            return str;
        }
    }

    private void o(String str) {
        try {
            try {
                this.l.removeTextChangedListener(this);
                String strEncode = URLEncoder.encode(str, "UTF-8");
                int iMax = Math.max(this.l.getSelectionStart(), 0);
                int iMax2 = Math.max(this.l.getSelectionEnd(), 0);
                Editable text = this.l.getText();
                String str2 = "file://" + strEncode;
                text.delete(Math.min(iMax, iMax2), Math.max(iMax, iMax2));
                try {
                    if (text.toString().length() > 0 && text.charAt(text.length() - 1) != '\n') {
                        text.insert(iMax, "\n");
                        iMax++;
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                text.insert(iMax, str2);
                text.insert(iMax + str2.length(), "\n");
            } finally {
                O();
                this.l.addTextChangedListener(this);
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    private void p(String str) {
        try {
            try {
                this.l.removeTextChangedListener(this);
                int iMax = Math.max(this.l.getSelectionStart(), 0);
                int iMax2 = Math.max(this.l.getSelectionEnd(), 0);
                Editable text = this.l.getText();
                String str2 = "##" + str + "#\n";
                text.delete(Math.min(iMax, iMax2), Math.max(iMax, iMax2));
                try {
                    if (text.toString().length() > 0 && text.charAt(text.length() - 1) != '\n') {
                        text.insert(iMax, "\n");
                        iMax++;
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
                text.insert(iMax, str2);
                text.insert(iMax + str2.length(), "\n");
            } finally {
                O();
                this.l.addTextChangedListener(this);
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    @Override // chat.ola.vn.view.e.a
    public boolean I() {
        E();
        this.g = 0;
        d(false);
        return true;
    }

    @Override // chat.ola.vn.view.e.a
    public boolean J() {
        try {
            ViewGroup.LayoutParams layoutParams = this.s.getLayoutParams();
            layoutParams.height = -1;
            this.s.setLayoutParams(layoutParams);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.view.e.a
    public boolean K() {
        try {
            ViewGroup.LayoutParams layoutParams = this.s.getLayoutParams();
            if (layoutParams.height == OlaChatViewActivity.g) {
                return true;
            }
            layoutParams.height = OlaChatViewActivity.g;
            this.s.setLayoutParams(layoutParams);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.view.h.b
    public void L() {
        try {
            String string = this.l.getText().toString();
            int selectionStart = this.l.getSelectionStart() >= 0 ? this.l.getSelectionStart() : 0;
            StringBuilder sb = new StringBuilder(string);
            if (selectionStart > 0) {
                selectionStart--;
            }
            sb.replace(selectionStart, selectionStart + 1, "");
            this.l.setText(sb.toString());
            this.l.setSelection(selectionStart);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void M() {
    }

    @Override // chat.ola.vn.c
    protected void a() {
        try {
            this.C = getResources().getConfiguration().orientation;
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.i.e
    public void a(w wVar) {
        if (m.a(wVar.a())) {
            return;
        }
        j(wVar.a());
    }

    @Override // com.mg.ola.common.widget.a.a
    public void a(boolean z, int i) {
        if (z) {
            this.g = 0;
            S();
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
            o(str);
        } catch (Throwable unused) {
        }
    }

    @Override // android.text.TextWatcher
    public void afterTextChanged(Editable editable) {
    }

    @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
    public void b_(String str) {
        try {
            String string = this.l.getText().toString();
            int selectionStart = this.l.getSelectionStart() >= 0 ? this.l.getSelectionStart() : 0;
            this.l.setText(n(new StringBuilder(string).toString()));
            this.l.setSelection(selectionStart);
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
                T();
            }
            Iterator<String> it2 = list.iterator();
            while (it2.hasNext()) {
                p(it2.next());
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void e(List<String> list) {
    }

    @Override // chat.ola.vn.view.g.e
    public void f(List<String> list) {
        try {
            if (list.size() > 0) {
                T();
            }
            Iterator<String> it2 = list.iterator();
            while (it2.hasNext()) {
                o(it2.next());
            }
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
    }

    @Override // chat.ola.vn.view.g.e
    public void h(String str) {
        try {
            o(str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.e.a
    public void h(String str, short s) {
        try {
            o(str);
        } catch (Throwable unused) {
        }
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
    }

    @Override // chat.ola.vn.view.g.e
    public void j(String str) {
        try {
            p(str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.view.g.e
    public void k(String str) {
    }

    @Override // chat.ola.vn.view.j.a
    public void l(String str) {
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        String[] stringArrayExtra;
        try {
            if (i == 2) {
                if (i2 == -1 && this.z != null && this.z.exists()) {
                    File file = new File(chat.ola.vn.d.a(this.z.length()));
                    com.mg.ola.common.d.c.a(this.z, file, true);
                    this.z.delete();
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
        this.z = null;
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (T()) {
            return;
        }
        super.onBackPressed();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.cameraImageButton /* 2131296579 */:
                    if (!com.mg.ola.common.d.g.f()) {
                        E();
                        return;
                    }
                    c(false);
                    this.g = 2;
                    if (this.k.a()) {
                        return;
                    }
                    break;
                    break;
                case R.id.chatTextSmileyImageButton /* 2131296604 */:
                    c(false);
                    this.g = 1;
                    if (this.k.a()) {
                        return;
                    }
                    break;
                case R.id.infoImageButton /* 2131296950 */:
                case R.id.moreImageButton /* 2131297120 */:
                case R.id.postToViewLayout /* 2131297249 */:
                case R.id.stickerImageView /* 2131297436 */:
                    return;
                case R.id.kulImageButton /* 2131296968 */:
                    c(false);
                    this.g = 3;
                    if (this.k.a()) {
                        return;
                    }
                    break;
                case R.id.localPhotoImageButton /* 2131297040 */:
                    c(false);
                    this.g = 4;
                    if (this.k.a()) {
                        return;
                    }
                    break;
                case R.id.olaActionBarBackViewLayout /* 2131297180 */:
                    onBackPressed();
                    return;
                case R.id.olaActionBarButtonTextView /* 2131297182 */:
                    H();
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
        if (this.C != configuration.orientation) {
            this.C = configuration.orientation;
            try {
                if (this.g == 2 && com.mg.ola.common.d.g.f()) {
                    if (((e) this.v).c()) {
                        ((e) this.v).e();
                    }
                    this.g = 0;
                    d(false);
                }
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_note_composer_layout);
        this.h = AnimationUtils.loadAnimation(this, R.anim.fade_in);
        this.h.setDuration(300L);
        this.i = AnimationUtils.loadAnimation(this, R.anim.fade_out);
        this.i.setDuration(300L);
        B();
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.cameraImageButton) {
                E();
                return true;
            }
            if (id != R.id.localPhotoImageButton) {
                return false;
            }
            F();
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
        try {
            if (!this.D) {
                G();
            }
        } catch (Throwable unused) {
        }
        try {
            x.j = chat.ola.vn.e.a().f();
        } catch (Throwable unused2) {
        }
    }

    @Override // android.text.TextWatcher
    public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        if (i3 > 5) {
            try {
                String string = charSequence.toString();
                this.l.removeTextChangedListener(this);
                int selectionStart = this.l.getSelectionStart() >= 0 ? this.l.getSelectionStart() : 0;
                this.l.setText(n(string));
                int length = selectionStart + i3;
                try {
                    if (length > string.length()) {
                        length = string.length();
                    }
                    this.l.setSelection(length);
                } catch (Throwable unused) {
                }
                this.l.addTextChangedListener(this);
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
            com.mg.ola.common.widget.SoftKeyLinearLayout r3 = r2.k
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
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.note.OlaNoteComposerActivity.onTouch(android.view.View, android.view.MotionEvent):boolean");
    }
}
