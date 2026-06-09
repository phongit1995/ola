package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.app.DatePickerDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaFacebookActivity;
import chat.ola.vn.c;
import chat.ola.vn.c.x;
import chat.ola.vn.e;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entity.d;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.i.m;
import chat.ola.vn.l.b;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import com.facebook.AccessToken;
import com.google.android.gms.auth.api.credentials.CredentialsApi;
import com.mg.ola.common.d.g;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaUserProfileActivity extends c implements DatePickerDialog.OnDateSetListener, View.OnClickListener {
    private TextView e;
    private EditText f;
    private TextView g;
    private TextView h;
    private TextView i;
    private EditText j;
    private TextView k;
    private ag l;
    private ProgressDialog m;
    private Button n;
    private ScrollView p;
    private TextView r;
    private ImageView s;
    private boolean o = false;
    private chat.ola.vn.network.c q = new chat.ola.vn.network.c() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.1
        @Override // chat.ola.vn.network.c
        public void a() {
            try {
                OlaUserProfileActivity.this.o = true;
                OlaUserProfileActivity.this.B();
                x.j = (short) 16386;
                e.a().d(x.j);
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void a(String str) {
            b.b(str, h.f(), this);
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, String str2, String str3) {
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, boolean z) {
        }

        @Override // chat.ola.vn.network.c
        public void a(List<String> list) {
        }

        @Override // chat.ola.vn.network.c
        public void a(short s) {
        }

        @Override // chat.ola.vn.network.c
        public void b() {
        }

        @Override // chat.ola.vn.network.c
        public void b(String str, String str2, String str3) {
        }

        @Override // chat.ola.vn.network.c
        public void b(List<String> list) {
        }

        @Override // chat.ola.vn.network.c
        public void b(short s) {
        }

        @Override // chat.ola.vn.network.c
        public void c() {
        }

        @Override // chat.ola.vn.network.c
        public void d() {
            i.a(OlaUserProfileActivity.this, R.string.string_info, R.string.string_unlink_facebook_accout_fail);
        }
    };

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        try {
            if (this.o) {
                this.n.setVisibility(8);
                this.n.setText(R.string.string_unlink_facebook_account);
            } else {
                this.n.setVisibility(0);
                this.n.setText(getString(R.string.string_link_facebook_account));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:21:0x0098 A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:22:0x00b6 A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:25:0x00c3 A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:26:0x00e1 A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:29:0x00f0 A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:30:0x00fd A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:33:0x0115 A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:34:0x011e A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:37:0x014d  */
    /* JADX WARN: Removed duplicated region for block: B:38:0x014e A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:40:0x015e A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:41:0x016b A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:42:0x0178 A[Catch: Throwable -> 0x01b4, TryCatch #0 {Throwable -> 0x01b4, blocks: (B:2:0x0000, B:4:0x0016, B:6:0x0027, B:8:0x0040, B:10:0x0051, B:12:0x0057, B:19:0x008b, B:21:0x0098, B:23:0x00bb, B:25:0x00c3, B:27:0x00e6, B:29:0x00f0, B:31:0x010b, B:33:0x0115, B:35:0x0146, B:36:0x014a, B:43:0x0185, B:38:0x014e, B:39:0x015a, B:40:0x015e, B:41:0x016b, B:42:0x0178, B:34:0x011e, B:30:0x00fd, B:26:0x00e1, B:22:0x00b6, B:13:0x0067, B:15:0x006d, B:16:0x007d, B:17:0x007f, B:9:0x0049, B:18:0x0083), top: B:55:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:46:0x0197 A[Catch: Throwable -> 0x01b8, TryCatch #1 {Throwable -> 0x01b8, blocks: (B:44:0x0191, B:46:0x0197, B:47:0x01a3, B:49:0x01a7), top: B:57:0x0191 }] */
    /* JADX WARN: Removed duplicated region for block: B:49:0x01a7 A[Catch: Throwable -> 0x01b8, TRY_LEAVE, TryCatch #1 {Throwable -> 0x01b8, blocks: (B:44:0x0191, B:46:0x0197, B:47:0x01a3, B:49:0x01a7), top: B:57:0x0191 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void C() {
        /*
            Method dump skipped, instruction units count: 454
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaUserProfileActivity.C():void");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void D() {
        try {
            i.a(this, R.string.string_help, R.string.message_call_cse_to_support_unlock_phone_number);
        } catch (Throwable unused) {
        }
    }

    private void E() {
        i.b(this, getString(R.string.dialog_title_inform), getString(R.string.message_require_unlock_phone_number_format, new Object[]{this.l.f}), getString(R.string.string_unlock), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.6
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    OlaUserProfileActivity.this.D();
                }
                dialogInterface.dismiss();
            }
        });
    }

    private void F() {
        OlaPhoneVerificationActivity.a(this);
    }

    private void G() {
        try {
            if (this.m == null) {
                this.m = i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.general_load_form_info));
                this.m.setCancelable(true);
                this.m.setCanceledOnTouchOutside(true);
            }
            OlaApplication.b.b(h.a(), f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.8
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 9;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, d[] dVarArr) {
                    if (OlaUserProfileActivity.this != null) {
                        OlaUserProfileActivity.this.m.dismiss();
                    }
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    OlaUserProfileActivity olaUserProfileActivity;
                    if (OlaUserProfileActivity.this != null) {
                        boolean z = false;
                        OlaUserProfileActivity.this.l = (ag) objArr[0];
                        if (OlaUserProfileActivity.this.l.b == null) {
                            olaUserProfileActivity = OlaUserProfileActivity.this;
                        } else {
                            olaUserProfileActivity = OlaUserProfileActivity.this;
                            z = true;
                        }
                        olaUserProfileActivity.o = z;
                        OlaUserProfileActivity.this.C();
                        OlaUserProfileActivity.this.m.dismiss();
                    }
                }
            }));
            this.m.show();
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        Intent intent = new Intent(context, (Class<?>) OlaUserProfileActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
    }

    private void a(View view) {
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(getString(R.string.string_male));
            arrayList.add(getString(R.string.string_female));
            arrayList.add(getString(R.string.string_flexible));
            m mVar = new m(this);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.7
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j) {
                    try {
                        String str = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.a(str, OlaUserProfileActivity.this.i.getText().toString())) {
                            return;
                        }
                        if (chat.ola.vn.util.m.b(OlaUserProfileActivity.this.getString(R.string.string_male), str)) {
                            OlaUserProfileActivity.this.l.w = (byte) 1;
                        } else if (chat.ola.vn.util.m.b(OlaUserProfileActivity.this.getString(R.string.string_female), str)) {
                            OlaUserProfileActivity.this.l.w = (byte) 0;
                        } else if (chat.ola.vn.util.m.b(OlaUserProfileActivity.this.getString(R.string.string_flexible), str)) {
                            OlaUserProfileActivity.this.l.w = (byte) 2;
                        }
                        OlaUserProfileActivity.this.i.setText(str);
                        OlaUserProfileActivity.this.C();
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    private void f(String str) {
        i.a(this, getString(R.string.dialog_title_confirm), getString(R.string.message_divorce_confirmation, new Object[]{"@" + str}), getString(R.string.string_yes), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.5
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    try {
                        OlaApplication.b.v();
                        OlaUserProfileActivity.this.l.e = null;
                        OlaUserProfileActivity.this.C();
                    } catch (Throwable unused) {
                    }
                }
                try {
                    dialogInterface.dismiss();
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.c
    protected void a() {
        try {
            G();
            C();
            if (x()) {
                if (chat.ola.vn.util.m.a(h.O.f) || !h.O.x) {
                    this.p.postDelayed(new Runnable() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.9
                        @Override // java.lang.Runnable
                        public void run() {
                            OlaUserProfileActivity.this.p.scrollTo(0, OlaUserProfileActivity.this.f.getBottom());
                        }
                    }, 250L);
                }
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        EditText editText;
        try {
            switch (view.getId()) {
                case R.id.birthdayEditImageView /* 2131296397 */:
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTimeInMillis(this.l.l);
                    new DatePickerDialog(this, this, calendar.get(1), calendar.get(2), calendar.get(5)).show();
                    break;
                case R.id.btnLinkFacebookAccount /* 2131296476 */:
                    if (!this.o) {
                        if (AccessToken.getCurrentAccessToken() != null && !AccessToken.getCurrentAccessToken().isExpired()) {
                            b.a(AccessToken.getCurrentAccessToken().getToken(), this.q);
                        }
                        OlaFacebookActivity.a(this, (Bundle) null, new OlaFacebookActivity.a() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.4
                            @Override // chat.ola.vn.activity.OlaFacebookActivity.a
                            public void a() {
                                b.a(AccessToken.getCurrentAccessToken().getToken(), OlaUserProfileActivity.this.q);
                            }
                        });
                    } else {
                        i.d(this, R.string.string_info, R.string.string_confirm_unlink_facebook_accout, R.string.string_yes, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.3
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                if (i == 0) {
                                    try {
                                        b.b(h.f(), OlaUserProfileActivity.this.q);
                                    } catch (Throwable th) {
                                        th.printStackTrace();
                                        return;
                                    }
                                }
                                dialogInterface.cancel();
                            }
                        });
                    }
                    break;
                case R.id.btnSupportService /* 2131296541 */:
                    if (g.a(this) && n.b(this)) {
                        chat.ola.vn.util.b.c(this, "1900588883");
                    }
                    i.b(this);
                    break;
                case R.id.fullnameEditImageView /* 2131296828 */:
                    this.j.setEnabled(true);
                    this.j.selectAll();
                    this.j.requestFocus();
                    editText = this.j;
                    o.a((Context) this, (View) editText, true);
                    break;
                case R.id.genderEditImageView /* 2131296832 */:
                    a(view);
                    break;
                case R.id.imgAvatarPreview /* 2131296866 */:
                    OlaCropImageActivity.c(this);
                    break;
                case R.id.imgConverPreview /* 2131296881 */:
                    OlaCropImageActivity.b(this);
                    break;
                case R.id.olaActionBarMoreButtonImageView /* 2131297185 */:
                    finish();
                    break;
                case R.id.passwordViewLayout /* 2131297213 */:
                    OlaChangePasswordActivity.a(this);
                    break;
                case R.id.phoneNumberEditImageView /* 2131297217 */:
                    if (!this.l.B) {
                        this.f.setEnabled(true);
                        this.f.selectAll();
                        this.f.requestFocus();
                        editText = this.f;
                        o.a((Context) this, (View) editText, true);
                    } else {
                        E();
                    }
                    break;
                case R.id.phoneNumberViewLayout /* 2131297220 */:
                case R.id.phoneStateTextView /* 2131297221 */:
                case R.id.txtPhoneNumber /* 2131297657 */:
                    if (chat.ola.vn.util.m.a(this.l.f)) {
                        this.f.setEnabled(true);
                        this.f.selectAll();
                        this.f.requestFocus();
                        editText = this.f;
                        o.a((Context) this, (View) editText, true);
                    } else if (!this.l.x) {
                        F();
                        this.f.setEnabled(false);
                        this.f.clearFocus();
                        o.a((Context) this, (View) this.f, false);
                    }
                    break;
                case R.id.txtMarry /* 2131297603 */:
                    if (!chat.ola.vn.util.m.a(this.l.e)) {
                        f(this.l.e);
                    } else {
                        MarriageRequestComposerActivity.a(this);
                    }
                    break;
                case R.id.txtMeUserBirthday /* 2131297622 */:
                    if (this.l.l == 0) {
                        Calendar.getInstance().setTimeInMillis(this.l.l);
                        new DatePickerDialog(this, this, CredentialsApi.CREDENTIAL_PICKER_REQUEST_CODE, 5, 15).show();
                    }
                    break;
                case R.id.txtSex /* 2131297678 */:
                    if (this.l.w != -1) {
                    }
                    a(view);
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.persionnal_infomation_view_layout);
        this.e = (TextView) findViewById(R.id.txtMeUserBirthday);
        findViewById(R.id.birthdayEditImageView).setOnClickListener(this);
        this.h = (TextView) findViewById(R.id.txtMarry);
        this.h.setOnClickListener(this);
        findViewById(R.id.phoneNumberViewLayout).setOnClickListener(this);
        this.f = (EditText) findViewById(R.id.txtPhoneNumber);
        this.g = (TextView) findViewById(R.id.phoneStateTextView);
        this.g.setOnClickListener(this);
        this.s = (ImageView) findViewById(R.id.phoneNumberEditImageView);
        this.s.setOnClickListener(this);
        this.i = (TextView) findViewById(R.id.txtSex);
        findViewById(R.id.genderEditImageView).setOnClickListener(this);
        this.k = (TextView) findViewById(R.id.txtJoinOlaDate);
        this.j = (EditText) findViewById(R.id.fullnameEditText);
        this.j.setEnabled(false);
        this.j.setOnClickListener(this);
        findViewById(R.id.fullnameEditImageView).setOnClickListener(this);
        this.p = (ScrollView) findViewById(R.id.scrollView1);
        this.p.setOnTouchListener(new View.OnTouchListener() { // from class: chat.ola.vn.activity.OlaUserProfileActivity.2
            @Override // android.view.View.OnTouchListener
            @SuppressLint({"ClickableViewAccessibility"})
            public boolean onTouch(View view, MotionEvent motionEvent) {
                EditText editText;
                if (!OlaUserProfileActivity.this.j.isFocused()) {
                    if (OlaUserProfileActivity.this.f.isFocused()) {
                        o.a((Context) OlaUserProfileActivity.this, (View) OlaUserProfileActivity.this.f, false);
                        editText = OlaUserProfileActivity.this.f;
                    }
                    return false;
                }
                o.a((Context) OlaUserProfileActivity.this, (View) OlaUserProfileActivity.this.j, false);
                editText = OlaUserProfileActivity.this.j;
                editText.setEnabled(false);
                return false;
            }
        });
        this.e.setOnClickListener(this);
        this.f.setOnClickListener(this);
        this.i.setOnClickListener(this);
        findViewById(R.id.btnSupportService).setVisibility(0);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_persional_info);
        findViewById(R.id.olaActionBarBackViewLayout).setVisibility(4);
        ImageView imageView = (ImageView) findViewById(R.id.olaActionBarMoreButtonImageView);
        imageView.setVisibility(0);
        imageView.setImageResource(R.drawable.ic_action_quit);
        imageView.setOnClickListener(this);
        findViewById(R.id.passwordViewLayout).setOnClickListener(this);
        this.r = (TextView) findViewById(R.id.passwordStateTextView);
        findViewById(R.id.btnSupportService).setOnClickListener(this);
        this.n = (Button) findViewById(R.id.btnLinkFacebookAccount);
        this.n.setVisibility(0);
        this.n.setOnClickListener(this);
        B();
    }

    @Override // android.app.DatePickerDialog.OnDateSetListener
    public void onDateSet(DatePicker datePicker, int i, int i2, int i3) {
        try {
            Calendar calendar = Calendar.getInstance();
            calendar.set(5, i3);
            calendar.set(2, i2);
            calendar.set(1, i);
            long timeInMillis = calendar.getTimeInMillis();
            this.l.l = Long.valueOf(timeInMillis).longValue();
            C();
            OlaApplication.b.a((String) null, (String) null, Long.valueOf(timeInMillis), (Byte) null);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onPause() {
        String string;
        super.onPause();
        try {
            String string2 = null;
            Long lValueOf = this.l.l != 0 ? Long.valueOf(this.l.l) : null;
            Byte bValueOf = this.l.w != -1 ? Byte.valueOf(this.l.w) : null;
            try {
                string = this.j.getText().toString();
            } catch (Throwable unused) {
                string = null;
            }
            try {
                string2 = this.f.getText().toString();
            } catch (Throwable unused2) {
            }
            OlaApplication.b.a(string, string2, lValueOf, bValueOf);
        } catch (Throwable unused3) {
        }
    }
}
