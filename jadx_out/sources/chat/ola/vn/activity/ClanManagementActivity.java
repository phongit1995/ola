package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaCropImageActivity;
import chat.ola.vn.c;
import chat.ola.vn.entity.b;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.i.p;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ClanManagementActivity extends c implements View.OnClickListener, OlaCropImageActivity.a {
    private static b e;
    private TextView f;
    private TextView g;
    private TextView h;
    private TextView i;
    private TextView j;

    private void J() {
        setContentView(R.layout.clan_manager_layout);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.clanManagerViewLayout).setOnClickListener(this);
        findViewById(R.id.clanAssistantViewLayout).setOnClickListener(this);
        findViewById(R.id.clanSupervisorViewLayout).setOnClickListener(this);
        findViewById(R.id.clanPolicyViewLayout).setOnClickListener(this);
        this.j = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        this.f = (TextView) findViewById(R.id.clanManagerTextView);
        this.g = (TextView) findViewById(R.id.clanAssistantTextView);
        this.h = (TextView) findViewById(R.id.clanSupervisorTextView);
        this.i = (TextView) findViewById(R.id.clanPolicyTextView);
        findViewById(R.id.verifyMemberButton).setOnClickListener(this);
        findViewById(R.id.unverifyMemberButton).setOnClickListener(this);
    }

    private void K() {
        try {
            if (e != null) {
                L();
                M();
            } else {
                this.f.setText(R.string.string_unavaliable);
                this.g.setText(R.string.string_unavaliable);
                this.h.setText(R.string.string_unavaliable);
                this.i.setText(R.string.string_unavaliable);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void L() {
        TextView textView;
        String str;
        TextView textView2;
        String str2;
        TextView textView3;
        String str3;
        try {
            if (m.a(e.a)) {
                this.j.setText(R.string.string_manage_clan);
            } else {
                this.j.setText("#" + e.a);
            }
            if (m.a(e.b)) {
                textView = this.g;
                str = "";
            } else {
                textView = this.f;
                str = e.b;
            }
            textView.setText(str);
            if (m.a(e.c)) {
                textView2 = this.g;
                str2 = "";
            } else {
                textView2 = this.g;
                str2 = e.c;
            }
            textView2.setText(str2);
            if (m.a(e.d)) {
                textView3 = this.h;
                str3 = "";
            } else {
                textView3 = this.h;
                str3 = e.d;
            }
            textView3.setText(str3);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void M() {
        this.i.setText(m.a(this, e.j));
    }

    private void N() {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(getString(R.string.message_clan_privacy_free_post));
        arrayList.add(getString(R.string.message_clan_privacy_free_join));
        arrayList.add(getString(R.string.message_clan_privacy_verified_post));
        arrayList.add(getString(R.string.message_clan_privacy_verified_view_and_post));
        arrayList.add(getString(R.string.message_clan_privacy_close));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.activity.ClanManagementActivity.7
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (m.b(ClanManagementActivity.this.getString(R.string.message_clan_privacy_free_post), str)) {
                        ClanManagementActivity.e.j = (short) 0;
                    } else if (m.b(ClanManagementActivity.this.getString(R.string.message_clan_privacy_free_join), str)) {
                        ClanManagementActivity.e.j = (short) 1;
                    } else if (m.b(ClanManagementActivity.this.getString(R.string.message_clan_privacy_verified_post), str)) {
                        ClanManagementActivity.e.j = (short) 2;
                    } else if (m.b(ClanManagementActivity.this.getString(R.string.message_clan_privacy_verified_view_and_post), str)) {
                        ClanManagementActivity.e.j = (short) 4;
                    } else if (m.b(ClanManagementActivity.this.getString(R.string.message_clan_privacy_close), str)) {
                        ClanManagementActivity.e.j = (short) 3;
                    }
                    OlaApplication.b.m(ClanManagementActivity.e.a, ClanManagementActivity.e.j);
                    ClanManagementActivity.this.M();
                } catch (Throwable unused) {
                }
            }
        });
        int i = 0;
        switch (e.j) {
            case 1:
                i = 1;
                break;
            case 2:
                i = 2;
                break;
            case 3:
                i = 4;
                break;
            case 4:
                i = 3;
                break;
        }
        mVar.a(i);
        mVar.show();
    }

    public static void a(Context context, b bVar) {
        if (bVar == null) {
            return;
        }
        try {
            e = bVar;
            context.startActivity(new Intent(context, (Class<?>) ClanManagementActivity.class));
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    protected void B() {
        try {
            if (m.a(e.a)) {
                return;
            }
            i.a(this, "", 0, R.string.string_verify_clan_member, R.string.general_hint_nick, R.string.string_verify, R.string.string_cancel, null, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.ClanManagementActivity.3
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    if (i == 0) {
                        String strA = ((p) dialogInterface).a();
                        OlaApplication.b.i(strA, ClanManagementActivity.e.a);
                        j.b(ClanManagementActivity.this, R.string.message_clan_verified_format, "'@" + strA + "\"", "\"#" + ClanManagementActivity.e.a + "\"");
                    }
                    dialogInterface.dismiss();
                }
            }, new p.a() { // from class: chat.ola.vn.activity.ClanManagementActivity.4
                @Override // chat.ola.vn.i.p.a
                public boolean a(String str) {
                    return !m.a(str);
                }
            });
        } catch (Throwable unused) {
        }
    }

    protected void C() {
        try {
            i.a(this, "", 0, R.string.string_unverify_clan_member, R.string.general_hint_nick, R.string.string_unvetify, R.string.string_cancel, null, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.ClanManagementActivity.5
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    if (i == 0) {
                        String strA = ((p) dialogInterface).a();
                        OlaApplication.b.j(strA, ClanManagementActivity.e.a);
                        j.b(ClanManagementActivity.this, R.string.message_clan_unverified_format, "'@" + strA + "\"", "\"#" + ClanManagementActivity.e.a + "\"");
                    }
                    dialogInterface.dismiss();
                }
            }, new p.a() { // from class: chat.ola.vn.activity.ClanManagementActivity.6
                @Override // chat.ola.vn.i.p.a
                public boolean a(String str) {
                    return !m.a(str);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void D() {
        K();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void E() {
        K();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void F() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void G() {
    }

    @Override // chat.ola.vn.c
    protected void a() {
        K();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void b_() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void f(String str) {
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        p pVarA;
        String str;
        try {
            switch (view.getId()) {
                case R.id.clanAssistantViewLayout /* 2131296619 */:
                    pVarA = i.a(this, null, R.drawable.ic_clan_role_vice_leader, R.string.string_clan_assistant, R.string.general_hint_nick, R.string.string_ok, R.string.string_cancel, 32, h.t.b(), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.ClanManagementActivity.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                try {
                                    String strJ = m.j(((p) dialogInterface).a());
                                    if (m.a(strJ)) {
                                        i.a(ClanManagementActivity.this, ClanManagementActivity.this.getString(R.string.dialog_title_confirm), ClanManagementActivity.this.getString(R.string.message_deprive_clan_assistant, new Object[]{"@" + ClanManagementActivity.e.c}), ClanManagementActivity.this.getString(R.string.string_yes), ClanManagementActivity.this.getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.ClanManagementActivity.1.1
                                            @Override // android.content.DialogInterface.OnClickListener
                                            public void onClick(DialogInterface dialogInterface2, int i2) {
                                                if (i2 == 0) {
                                                    try {
                                                        ClanManagementActivity.e.c = null;
                                                        OlaApplication.b.e(ClanManagementActivity.e.a, ClanManagementActivity.e.c);
                                                        ClanManagementActivity.this.L();
                                                    } catch (Throwable unused) {
                                                        return;
                                                    }
                                                }
                                                dialogInterface2.dismiss();
                                            }
                                        });
                                    } else {
                                        ClanManagementActivity.e.c = strJ;
                                        OlaApplication.b.e(ClanManagementActivity.e.a, ClanManagementActivity.e.c);
                                        ClanManagementActivity.this.L();
                                    }
                                } catch (Throwable unused) {
                                }
                            }
                            try {
                                dialogInterface.dismiss();
                            } catch (Throwable unused2) {
                            }
                        }
                    }, null);
                    str = e.c;
                    break;
                case R.id.clanPolicyViewLayout /* 2131296626 */:
                    N();
                    return;
                case R.id.clanSupervisorViewLayout /* 2131296628 */:
                    pVarA = i.a(this, null, R.drawable.ic_clan_role_supporter, R.string.string_clan_supervisor, R.string.general_hint_nick, R.string.string_ok, R.string.string_cancel, 32, h.t.b(), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.ClanManagementActivity.2
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            if (i == 0) {
                                try {
                                    String strJ = m.j(((p) dialogInterface).a());
                                    if (m.a(strJ)) {
                                        i.a(ClanManagementActivity.this, ClanManagementActivity.this.getString(R.string.dialog_title_confirm), ClanManagementActivity.this.getString(R.string.message_deprive_clan_supervisor, new Object[]{"@" + ClanManagementActivity.e.d}), ClanManagementActivity.this.getString(R.string.string_yes), ClanManagementActivity.this.getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.ClanManagementActivity.2.1
                                            @Override // android.content.DialogInterface.OnClickListener
                                            public void onClick(DialogInterface dialogInterface2, int i2) {
                                                if (i2 == 0) {
                                                    try {
                                                        ClanManagementActivity.e.d = null;
                                                        OlaApplication.b.f(ClanManagementActivity.e.a, ClanManagementActivity.e.d);
                                                        ClanManagementActivity.this.L();
                                                    } catch (Throwable unused) {
                                                        return;
                                                    }
                                                }
                                                dialogInterface2.dismiss();
                                            }
                                        });
                                    } else {
                                        ClanManagementActivity.e.d = m.j(strJ);
                                        OlaApplication.b.f(ClanManagementActivity.e.a, ClanManagementActivity.e.d);
                                        ClanManagementActivity.this.L();
                                    }
                                } catch (Throwable unused) {
                                }
                            }
                            try {
                                dialogInterface.dismiss();
                            } catch (Throwable unused2) {
                            }
                        }
                    }, null);
                    str = e.d;
                    break;
                case R.id.olaActionBarBackViewLayout /* 2131297180 */:
                    finish();
                    return;
                case R.id.unverifyMemberButton /* 2131297726 */:
                    if (e != null) {
                        C();
                        return;
                    }
                    return;
                case R.id.verifyMemberButton /* 2131297758 */:
                    if (e != null) {
                        B();
                        return;
                    }
                    return;
                default:
                    return;
            }
            pVarA.e(str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        J();
        K();
    }
}
