package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.network.a.a.aj;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ac extends j implements View.OnClickListener {
    private static chat.ola.vn.entity.z k = null;
    private static String l = null;
    private static boolean m = true;
    private TextView A;
    private TextView B;
    private View C;
    private TextView D;
    protected View i;
    protected View j;
    private OlaCachedImageView n;
    private List<String> o = null;
    private OlaCachedImageView[] p;
    private TextView q;
    private TextView r;
    private View s;
    private View t;
    private TextView u;
    private OlaCachedImageView v;
    private TextView w;
    private TextView x;
    private View y;
    private Button z;

    private void f() {
        try {
            String strA = chat.ola.vn.util.o.a(chat.ola.vn.c.c());
            if (chat.ola.vn.util.m.c(strA, l)) {
                return;
            }
            l = strA;
            String strE = chat.ola.vn.util.i.e(l);
            if (!chat.ola.vn.util.m.a(strE)) {
                OlaApplication.b.a(strE, new chat.ola.vn.p.l() { // from class: chat.ola.vn.entry.b.ac.1
                    @Override // chat.ola.vn.p.l
                    public void a(chat.ola.vn.entity.u uVar) {
                        try {
                            chat.ola.vn.entity.z unused = ac.k = new chat.ola.vn.entity.z();
                            ac.k.c = uVar.c();
                            ac.k.e = null;
                            ac.k.a = "rss://" + uVar.g();
                            ac.k.f = uVar.d();
                            ac.this.a();
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // chat.ola.vn.p.l
                    public void a(short s, String str) {
                        try {
                            chat.ola.vn.entity.z unused = ac.k = null;
                            ac.this.a();
                        } catch (Throwable unused2) {
                        }
                    }
                });
                return;
            }
            String strF = chat.ola.vn.util.i.f(l);
            if (chat.ola.vn.util.m.a(strF)) {
                return;
            }
            OlaApplication.b.a(strF, new aj.a() { // from class: chat.ola.vn.entry.b.ac.2
                @Override // chat.ola.vn.network.a.a.aj.a
                public void a(chat.ola.vn.entity.z zVar) {
                    chat.ola.vn.entity.z unused = ac.k = zVar;
                    ac.this.a();
                }

                @Override // chat.ola.vn.network.a.a.aj.a
                public void a(String str) {
                    chat.ola.vn.entity.z unused = ac.k = null;
                    ac.this.a();
                }
            });
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:100:0x02b6 A[Catch: Throwable -> 0x030c, TryCatch #0 {Throwable -> 0x030c, blocks: (B:2:0x0000, B:3:0x0012, B:5:0x0019, B:6:0x0023, B:22:0x00a9, B:24:0x00ad, B:28:0x00b8, B:30:0x00d7, B:32:0x00db, B:33:0x00e0, B:40:0x0110, B:43:0x0117, B:44:0x013a, B:46:0x013f, B:58:0x0182, B:60:0x018b, B:62:0x0196, B:48:0x0144, B:50:0x014f, B:52:0x015a, B:55:0x016d, B:57:0x0178, B:63:0x019f, B:35:0x0100, B:37:0x0104, B:38:0x010a, B:64:0x01a3, B:66:0x01a7, B:68:0x01cc, B:70:0x01e0, B:72:0x01ea, B:74:0x01fd, B:75:0x0203, B:77:0x0207, B:79:0x0213, B:80:0x0215, B:69:0x01db, B:82:0x0219, B:84:0x0223, B:86:0x0253, B:87:0x0274, B:98:0x02b0, B:100:0x02b6, B:102:0x02c9, B:103:0x02d1, B:105:0x02d7, B:107:0x02ec, B:108:0x02f0, B:88:0x0278, B:90:0x0282, B:91:0x0289, B:93:0x0293, B:94:0x029a, B:96:0x02a4, B:97:0x02ab, B:109:0x02f4), top: B:116:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:108:0x02f0 A[Catch: Throwable -> 0x030c, TryCatch #0 {Throwable -> 0x030c, blocks: (B:2:0x0000, B:3:0x0012, B:5:0x0019, B:6:0x0023, B:22:0x00a9, B:24:0x00ad, B:28:0x00b8, B:30:0x00d7, B:32:0x00db, B:33:0x00e0, B:40:0x0110, B:43:0x0117, B:44:0x013a, B:46:0x013f, B:58:0x0182, B:60:0x018b, B:62:0x0196, B:48:0x0144, B:50:0x014f, B:52:0x015a, B:55:0x016d, B:57:0x0178, B:63:0x019f, B:35:0x0100, B:37:0x0104, B:38:0x010a, B:64:0x01a3, B:66:0x01a7, B:68:0x01cc, B:70:0x01e0, B:72:0x01ea, B:74:0x01fd, B:75:0x0203, B:77:0x0207, B:79:0x0213, B:80:0x0215, B:69:0x01db, B:82:0x0219, B:84:0x0223, B:86:0x0253, B:87:0x0274, B:98:0x02b0, B:100:0x02b6, B:102:0x02c9, B:103:0x02d1, B:105:0x02d7, B:107:0x02ec, B:108:0x02f0, B:88:0x0278, B:90:0x0282, B:91:0x0289, B:93:0x0293, B:94:0x029a, B:96:0x02a4, B:97:0x02ab, B:109:0x02f4), top: B:116:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:24:0x00ad A[Catch: Throwable -> 0x030c, TryCatch #0 {Throwable -> 0x030c, blocks: (B:2:0x0000, B:3:0x0012, B:5:0x0019, B:6:0x0023, B:22:0x00a9, B:24:0x00ad, B:28:0x00b8, B:30:0x00d7, B:32:0x00db, B:33:0x00e0, B:40:0x0110, B:43:0x0117, B:44:0x013a, B:46:0x013f, B:58:0x0182, B:60:0x018b, B:62:0x0196, B:48:0x0144, B:50:0x014f, B:52:0x015a, B:55:0x016d, B:57:0x0178, B:63:0x019f, B:35:0x0100, B:37:0x0104, B:38:0x010a, B:64:0x01a3, B:66:0x01a7, B:68:0x01cc, B:70:0x01e0, B:72:0x01ea, B:74:0x01fd, B:75:0x0203, B:77:0x0207, B:79:0x0213, B:80:0x0215, B:69:0x01db, B:82:0x0219, B:84:0x0223, B:86:0x0253, B:87:0x0274, B:98:0x02b0, B:100:0x02b6, B:102:0x02c9, B:103:0x02d1, B:105:0x02d7, B:107:0x02ec, B:108:0x02f0, B:88:0x0278, B:90:0x0282, B:91:0x0289, B:93:0x0293, B:94:0x029a, B:96:0x02a4, B:97:0x02ab, B:109:0x02f4), top: B:116:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:25:0x00b4  */
    /* JADX WARN: Removed duplicated region for block: B:28:0x00b8 A[Catch: Throwable -> 0x030c, TryCatch #0 {Throwable -> 0x030c, blocks: (B:2:0x0000, B:3:0x0012, B:5:0x0019, B:6:0x0023, B:22:0x00a9, B:24:0x00ad, B:28:0x00b8, B:30:0x00d7, B:32:0x00db, B:33:0x00e0, B:40:0x0110, B:43:0x0117, B:44:0x013a, B:46:0x013f, B:58:0x0182, B:60:0x018b, B:62:0x0196, B:48:0x0144, B:50:0x014f, B:52:0x015a, B:55:0x016d, B:57:0x0178, B:63:0x019f, B:35:0x0100, B:37:0x0104, B:38:0x010a, B:64:0x01a3, B:66:0x01a7, B:68:0x01cc, B:70:0x01e0, B:72:0x01ea, B:74:0x01fd, B:75:0x0203, B:77:0x0207, B:79:0x0213, B:80:0x0215, B:69:0x01db, B:82:0x0219, B:84:0x0223, B:86:0x0253, B:87:0x0274, B:98:0x02b0, B:100:0x02b6, B:102:0x02c9, B:103:0x02d1, B:105:0x02d7, B:107:0x02ec, B:108:0x02f0, B:88:0x0278, B:90:0x0282, B:91:0x0289, B:93:0x0293, B:94:0x029a, B:96:0x02a4, B:97:0x02ab, B:109:0x02f4), top: B:116:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:64:0x01a3 A[Catch: Throwable -> 0x030c, TryCatch #0 {Throwable -> 0x030c, blocks: (B:2:0x0000, B:3:0x0012, B:5:0x0019, B:6:0x0023, B:22:0x00a9, B:24:0x00ad, B:28:0x00b8, B:30:0x00d7, B:32:0x00db, B:33:0x00e0, B:40:0x0110, B:43:0x0117, B:44:0x013a, B:46:0x013f, B:58:0x0182, B:60:0x018b, B:62:0x0196, B:48:0x0144, B:50:0x014f, B:52:0x015a, B:55:0x016d, B:57:0x0178, B:63:0x019f, B:35:0x0100, B:37:0x0104, B:38:0x010a, B:64:0x01a3, B:66:0x01a7, B:68:0x01cc, B:70:0x01e0, B:72:0x01ea, B:74:0x01fd, B:75:0x0203, B:77:0x0207, B:79:0x0213, B:80:0x0215, B:69:0x01db, B:82:0x0219, B:84:0x0223, B:86:0x0253, B:87:0x0274, B:98:0x02b0, B:100:0x02b6, B:102:0x02c9, B:103:0x02d1, B:105:0x02d7, B:107:0x02ec, B:108:0x02f0, B:88:0x0278, B:90:0x0282, B:91:0x0289, B:93:0x0293, B:94:0x029a, B:96:0x02a4, B:97:0x02ab, B:109:0x02f4), top: B:116:0x0000 }] */
    @Override // chat.ola.vn.entry.b.j
    @android.annotation.TargetApi(11)
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a() {
        /*
            Method dump skipped, instruction units count: 796
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.entry.b.ac.a():void");
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(View view) {
        boolean z;
        super.a(view);
        view.setClickable(true);
        view.findViewById(R.id.olaMeHeaderView).setOnClickListener(this);
        view.findViewById(R.id.cameraImageView).setOnClickListener(this);
        view.findViewById(R.id.closeImageView).setOnClickListener(this);
        this.C = view.findViewById(R.id.phoneVerificationViewLayout);
        this.C.setOnClickListener(this);
        this.D = (TextView) view.findViewById(R.id.phoneNumberEditText);
        this.D.setOnClickListener(this);
        view.findViewById(R.id.verifyPhoneButton).setOnClickListener(this);
        view.findViewById(R.id.closePhoneVerificationImageView).setOnClickListener(this);
        this.y = view.findViewById(R.id.warningLayout);
        this.y.setOnClickListener(this);
        this.z = (Button) view.findViewById(R.id.warningButton);
        this.A = (TextView) view.findViewById(R.id.warningLine1TextView);
        this.B = (TextView) view.findViewById(R.id.warningLine2TextView);
        this.i = view.findViewById(R.id.closeViewLayout);
        this.j = view.findViewById(R.id.attachedPhotoViewLayout);
        this.r = (TextView) view.findViewById(R.id.topPostHintTextView);
        this.n = (OlaCachedImageView) view.findViewById(R.id.imgMeAvatarThumbnail);
        this.n.setOnClickListener(this);
        this.p = new OlaCachedImageView[5];
        this.p[0] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView1);
        this.p[1] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView2);
        this.p[2] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView3);
        this.p[3] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView4);
        this.p[4] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView5);
        this.q = (TextView) view.findViewById(R.id.moreMediaTextView);
        this.s = view.findViewById(R.id.theTenViewLayout);
        this.t = view.findViewById(R.id.suggestedVenueViewLayout);
        this.t.setOnClickListener(this);
        this.u = (TextView) view.findViewById(R.id.infoTopTitleTextView);
        this.u.setText(R.string.string_touch_to_check_in);
        this.v = (OlaCachedImageView) view.findViewById(R.id.infoImageView);
        this.w = (TextView) view.findViewById(R.id.infoTitleTextView);
        this.x = (TextView) view.findViewById(R.id.infoSubtitleTextView);
        view.findViewById(R.id.infoImageButton).setOnClickListener(this);
        this.o = chat.ola.vn.e.a().q();
        if (this.o == null || this.o.size() <= 0) {
            z = false;
        } else {
            ArrayList arrayList = new ArrayList(this.o.size());
            int size = this.o.size();
            z = false;
            for (int i = 0; i < size; i++) {
                try {
                    String str = this.o.get(i);
                    if (!com.mg.ola.common.d.c.a(str)) {
                        z = true;
                    } else if (!chat.ola.vn.util.m.a(chat.ola.vn.d.f(str))) {
                        arrayList.add(str);
                    }
                } catch (Throwable unused) {
                }
            }
            this.o = arrayList;
        }
        if (this.o == null || this.o.size() <= 0) {
            this.i.setVisibility(8);
            this.j.setVisibility(8);
            if (!z) {
                return;
            }
        } else {
            this.i.setVisibility(0);
            this.j.setVisibility(0);
        }
        chat.ola.vn.e.a().o();
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:45:0x0133 A[Catch: Throwable -> 0x0199, TryCatch #1 {Throwable -> 0x0199, blocks: (B:2:0x0000, B:3:0x0007, B:5:0x000b, B:7:0x0019, B:9:0x0021, B:11:0x0029, B:13:0x0031, B:15:0x0039, B:17:0x0041, B:19:0x0045, B:21:0x0051, B:22:0x0069, B:24:0x008b, B:25:0x00a3, B:27:0x00b6, B:29:0x00c6, B:31:0x00cf, B:35:0x00f5, B:34:0x00db, B:37:0x00f9, B:39:0x0107, B:41:0x0110, B:42:0x0122, B:43:0x0125, B:45:0x0133, B:55:0x017a, B:57:0x017e, B:59:0x0187, B:61:0x0192, B:46:0x0138, B:48:0x0146, B:49:0x014b, B:51:0x0159, B:53:0x0167), top: B:67:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:46:0x0138 A[Catch: Throwable -> 0x0199, TryCatch #1 {Throwable -> 0x0199, blocks: (B:2:0x0000, B:3:0x0007, B:5:0x000b, B:7:0x0019, B:9:0x0021, B:11:0x0029, B:13:0x0031, B:15:0x0039, B:17:0x0041, B:19:0x0045, B:21:0x0051, B:22:0x0069, B:24:0x008b, B:25:0x00a3, B:27:0x00b6, B:29:0x00c6, B:31:0x00cf, B:35:0x00f5, B:34:0x00db, B:37:0x00f9, B:39:0x0107, B:41:0x0110, B:42:0x0122, B:43:0x0125, B:45:0x0133, B:55:0x017a, B:57:0x017e, B:59:0x0187, B:61:0x0192, B:46:0x0138, B:48:0x0146, B:49:0x014b, B:51:0x0159, B:53:0x0167), top: B:67:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:57:0x017e A[Catch: Throwable -> 0x0199, TryCatch #1 {Throwable -> 0x0199, blocks: (B:2:0x0000, B:3:0x0007, B:5:0x000b, B:7:0x0019, B:9:0x0021, B:11:0x0029, B:13:0x0031, B:15:0x0039, B:17:0x0041, B:19:0x0045, B:21:0x0051, B:22:0x0069, B:24:0x008b, B:25:0x00a3, B:27:0x00b6, B:29:0x00c6, B:31:0x00cf, B:35:0x00f5, B:34:0x00db, B:37:0x00f9, B:39:0x0107, B:41:0x0110, B:42:0x0122, B:43:0x0125, B:45:0x0133, B:55:0x017a, B:57:0x017e, B:59:0x0187, B:61:0x0192, B:46:0x0138, B:48:0x0146, B:49:0x014b, B:51:0x0159, B:53:0x0167), top: B:67:0x0000 }] */
    /* JADX WARN: Removed duplicated region for block: B:58:0x0186  */
    /* JADX WARN: Removed duplicated region for block: B:61:0x0192 A[Catch: Throwable -> 0x0199, TRY_LEAVE, TryCatch #1 {Throwable -> 0x0199, blocks: (B:2:0x0000, B:3:0x0007, B:5:0x000b, B:7:0x0019, B:9:0x0021, B:11:0x0029, B:13:0x0031, B:15:0x0039, B:17:0x0041, B:19:0x0045, B:21:0x0051, B:22:0x0069, B:24:0x008b, B:25:0x00a3, B:27:0x00b6, B:29:0x00c6, B:31:0x00cf, B:35:0x00f5, B:34:0x00db, B:37:0x00f9, B:39:0x0107, B:41:0x0110, B:42:0x0122, B:43:0x0125, B:45:0x0133, B:55:0x017a, B:57:0x017e, B:59:0x0187, B:61:0x0192, B:46:0x0138, B:48:0x0146, B:49:0x014b, B:51:0x0159, B:53:0x0167), top: B:67:0x0000 }] */
    @Override // android.view.View.OnClickListener
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void onClick(android.view.View r4) {
        /*
            Method dump skipped, instruction units count: 456
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.entry.b.ac.onClick(android.view.View):void");
    }
}
