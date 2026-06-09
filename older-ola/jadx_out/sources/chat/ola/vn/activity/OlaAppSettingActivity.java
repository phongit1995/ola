package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.AbsListView;
import android.widget.ExpandableListView;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.c.f;
import chat.ola.vn.c.x;
import chat.ola.vn.entry.a.a;
import chat.ola.vn.entry.a.b;
import chat.ola.vn.entry.a.c;
import chat.ola.vn.entry.a.d;
import chat.ola.vn.entry.a.e;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.i.j;
import chat.ola.vn.i.n;
import chat.ola.vn.lock.OlaPasscodeSettingActivity;
import chat.ola.vn.util.m;
import com.facebook.AccessToken;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.login.LoginManager;
import com.facebook.share.widget.LikeView;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class OlaAppSettingActivity extends c implements View.OnClickListener, ExpandableListView.OnChildClickListener, c.a {
    private ArrayList<b> e;
    private chat.ola.vn.b.b f;
    private ExpandableListView g;
    private LikeView h;
    private int i = 0;

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        try {
            if (this.e == null) {
                this.e = new ArrayList<>();
            } else {
                this.e.clear();
            }
            b bVar = new b(R.string.title_general_setting);
            bVar.a(new d((short) 63, getString(R.string.title_chat_rintone_notification), getString(R.string.sum_chat_rintone_notification), R.array.entry_ringtone_mode, R.array.values_ringtone_mode, ((int) x.n) + "").a((c.a) this));
            bVar.a(new d((short) 66, getString(R.string.title_ringtone_sound), getString(R.string.sum_ringtone_sound), R.array.entry_ringtone_sound, R.array.values_ringtone_sound, x.c()).a((c.a) this));
            bVar.a(new d((short) 64, getString(R.string.title_chat_vibrate_notification), getString(R.string.sum_chat_vibrate_notification), R.array.entry_vibration_mode, R.array.values_vibration_mode, ((int) x.o) + "").a((c.a) this));
            bVar.a(new e((short) 65, getString(R.string.setting_led_notification_title), getString(R.string.setting_led_notification_summary), Boolean.valueOf(x.q)).a((c.a) this));
            String strL = chat.ola.vn.e.a().l();
            int i = m.b(strL, "vi") ? 1 : m.b(strL, "en") ? 2 : 0;
            bVar.a(new d((short) 100, getString(R.string.title_language_setting), getString(R.string.sum_language_setting), R.array.entry_language_setting, R.array.values_language_setting, i + "").a((c.a) this));
            bVar.a(new a((short) 45, getString(R.string.title_passcode), getString(R.string.message_passcode_to_open_ola), "").a((c.a) this));
            this.e.add(bVar);
            b bVar2 = new b(R.string.title_display_setting);
            bVar2.a(new e((short) 67, getString(R.string.setting_new_me_notification_enable_title), getString(R.string.setting_new_me_notification_enable_summary), Boolean.valueOf(x.h)).a((c.a) this));
            if (x.m > 3) {
                x.m = (byte) 2;
            }
            bVar2.a(new d((short) 59, getString(R.string.setting_general_show_avatar_title), getString(R.string.setting_general_show_avatar_summary), R.array.entry_ovatar_style, R.array.values_ovatar_style, ((int) x.m) + "").a((c.a) this));
            String str = AppEventsConstants.EVENT_PARAM_VALUE_NO;
            try {
                byte[] bArrC = chat.ola.vn.h.b.c(h.a());
                if (bArrC != null) {
                    if (bArrC.length > 0) {
                        str = "1";
                    }
                }
            } catch (Throwable unused) {
            }
            bVar2.a(new d((short) 93, getString(R.string.settings_ola_app_wallpaper_message), null, R.array.setting_ola_app_wallpaper_entry, R.array.setting_ola_app_wallpaper_value, str).a((c.a) this));
            bVar2.a(new e((short) 110, getString(R.string.setting_general_choice_web_browser_mode_title), getString(R.string.setting_general_choice_web_browser_mode_summary), Boolean.valueOf(x.x)).a((c.a) this));
            bVar2.a(new d((short) 101, getString(R.string.setting_general_play_video_mode_title), getString(R.string.setting_general_play_video_mode_summary), R.array.entry_play_video_mode, R.array.values_play_video_mode, ((int) x.p) + "").a((c.a) this));
            bVar2.a(new e((short) 91, getString(R.string.setting_typing_suggestion_enable_title), getString(R.string.setting_typing_suggestion_enable_summary), Boolean.valueOf(x.r)).a((c.a) this));
            this.e.add(bVar2);
            b bVar3 = new b(R.string.title_chat_setting);
            if (x.k > 2) {
                x.k = (byte) 0;
            }
            bVar3.a(new d((short) 56, getString(R.string.message_show_popup_message), null, R.array.setting_popup_message_entry, R.array.setting_popup_message_value, ((int) x.k) + "").a((c.a) this));
            bVar3.a(new e((short) 112, getString(R.string.setting_quick_reply_enable_title), getString(R.string.setting_quick_reply_enable_summary), Boolean.valueOf(x.y)).a((c.a) this));
            bVar3.a(new d((short) 86, getString(R.string.setting_message_appearance_animation_title), getString(R.string.setting_message_appearance_animation_summary), R.array.entry_message_appearance_animation, R.array.values_message_appearance_animation, ((int) x.l) + "").a((c.a) this));
            this.e.add(bVar3);
            b bVar4 = new b(R.string.title_rss_setting);
            bVar4.a(new e((short) 104, getString(R.string.setting_rss_save_history_title), null, Boolean.valueOf(x.t)).a((c.a) this));
            bVar4.a(new a((short) 87, getString(R.string.setting_rss_font_size_title), getString(R.string.setting_rss_font_size_summary), c(x.i) + "").a((c.a) this));
            this.e.add(bVar4);
            b bVar5 = new b(R.string.title_ola_info);
            PackageInfo packageInfo = getPackageManager().getPackageInfo(getPackageName(), 0);
            String str2 = "" + packageInfo.versionCode;
            String str3 = packageInfo.versionName;
            bVar5.a(new a((short) 19, getString(R.string.title_ola_rating), getString(R.string.message_ratting_app_content), "").a((c.a) this));
            bVar5.a(new a((short) 20, getString(R.string.title_ola_beta), getString(R.string.message_try_ola_beta_content), "").a((c.a) this));
            bVar5.a(new a((short) 92, getString(R.string.setting_version_name) + ": " + str3 + "", getString(R.string.setting_version_code) + ": " + str2 + "\n" + getString(R.string.setting_protocol_code) + ": 5.10.19\n" + getString(R.string.setting_distro) + ": " + chat.ola.vn.f.a.n + "\n" + getString(R.string.setting_version_released_date) + ": " + getString(R.string.app_release_date) + "\nCopyright 2007-2016 MicroGame Corp.\n" + getString(R.string.setting_version_support_phone_number) + ":\n1900588883", "").a((c.a) this));
            bVar5.a(new a((short) 108, getString(R.string.string_logout_all), getString(R.string.message_logout_hint), "").a((c.a) this));
            this.e.add(bVar5);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void C() {
        try {
            if (chat.ola.vn.c.c() != null) {
                new j(chat.ola.vn.c.c(), true, new j.a() { // from class: chat.ola.vn.activity.OlaAppSettingActivity.3
                    @Override // chat.ola.vn.i.j.a
                    public void a() {
                        try {
                            chat.ola.vn.util.c.b.f(OlaApplication.a());
                            if (!OlaApplication.b.h()) {
                                OlaApplication.b.l();
                                chat.ola.vn.c.c().b(true);
                                return;
                            }
                            OlaApplication.b.a(false);
                            try {
                                if (AccessToken.getCurrentAccessToken() != null) {
                                    LoginManager.getInstance().logOut();
                                }
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                            h.t.l();
                            OlaApplication.c.b();
                            i.a(chat.ola.vn.c.c(), R.string.message_logout_waiting, 3000L, new Runnable() { // from class: chat.ola.vn.activity.OlaAppSettingActivity.3.1
                                @Override // java.lang.Runnable
                                public void run() {
                                    try {
                                        OlaApplication.b.l();
                                        chat.ola.vn.c.c().b(true);
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

    private void D() {
        n nVar = new n(this);
        nVar.requestWindowFeature(1);
        nVar.setContentView(R.layout.font_slide_layout);
        nVar.setCanceledOnTouchOutside(true);
        nVar.getWindow().getAttributes().width = -1;
        ((TextView) nVar.findViewById(R.id.txtMinSize)).setTextSize(12.0f);
        ((TextView) nVar.findViewById(R.id.txtMaxSize)).setTextSize(24.0f);
        SeekBar seekBar = (SeekBar) nVar.findViewById(R.id.skbFontSize);
        seekBar.setMax(10);
        seekBar.setProgress(x.i);
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() { // from class: chat.ola.vn.activity.OlaAppSettingActivity.4
            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onProgressChanged(SeekBar seekBar2, int i, boolean z) {
                x.i = i;
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStartTrackingTouch(SeekBar seekBar2) {
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStopTrackingTouch(SeekBar seekBar2) {
            }
        });
        nVar.setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.activity.OlaAppSettingActivity.5
            @Override // android.content.DialogInterface.OnDismissListener
            public void onDismiss(DialogInterface dialogInterface) {
                try {
                    OlaAppSettingActivity.this.B();
                    chat.ola.vn.e.a().b(x.i);
                    OlaAppSettingActivity.this.f.notifyDataSetChanged();
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        });
        nVar.show();
    }

    public static void a(Context context) {
        a(context, 3, 0);
    }

    private static void a(Context context, int i, int i2) {
        Intent intent = new Intent(context, (Class<?>) OlaAppSettingActivity.class);
        intent.putExtra("groupIndex", i);
        intent.putExtra("rowIndex", i2);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context) {
        a(context, 4, 0);
    }

    private int c(int i) {
        try {
            int dimensionPixelSize = getResources().getDimensionPixelSize(R.dimen.text_size_caption);
            return dimensionPixelSize + (((i * 10) * dimensionPixelSize) / 100);
        } catch (Throwable unused) {
            return 0;
        }
    }

    public static void c(Context context) {
        a(context, 0, 0);
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.entry.a.c.a
    public void a(chat.ola.vn.entry.a.c cVar, Object obj) {
        try {
            switch (cVar.a()) {
                case 19:
                    try {
                        startActivity(new Intent("android.intent.action.VIEW", Uri.parse("market://details?id=chat.ola.vn&write_review=true")));
                    } catch (Throwable th) {
                        th.printStackTrace();
                        Intent intent = new Intent("android.intent.action.VIEW");
                        intent.setData(Uri.parse("https://play.google.com/store/apps/details?id=chat.ola.vn&write_review=true"));
                        startActivity(intent);
                    }
                    this.f.notifyDataSetChanged();
                    break;
                case 20:
                    chat.ola.vn.util.b.m(this, "https://play.google.com/apps/testing/chat.ola.vn");
                    this.f.notifyDataSetChanged();
                    break;
                case 45:
                    OlaPasscodeSettingActivity.a(this);
                    this.f.notifyDataSetChanged();
                    break;
                case 56:
                    x.k = Byte.valueOf((String) obj).byteValue();
                    chat.ola.vn.h.b.d(h.a(), x.k);
                    this.f.notifyDataSetChanged();
                    break;
                case 59:
                    x.m = Byte.valueOf((String) obj).byteValue();
                    if (x.m > 3) {
                        x.m = (byte) 2;
                    }
                    chat.ola.vn.h.b.a(h.a(), x.m);
                    this.f.notifyDataSetChanged();
                    break;
                case 63:
                    x.n = Byte.valueOf((String) obj).byteValue();
                    chat.ola.vn.h.b.b(h.a(), x.n);
                    chat.ola.vn.util.c.b.b();
                    this.f.notifyDataSetChanged();
                    break;
                case 64:
                    x.o = Byte.valueOf((String) obj).byteValue();
                    chat.ola.vn.h.b.c(h.a(), x.o);
                    chat.ola.vn.util.c.b.c();
                    this.f.notifyDataSetChanged();
                    break;
                case 65:
                    x.q = ((Boolean) obj).booleanValue();
                    chat.ola.vn.h.b.d(h.a(), x.q);
                    this.f.notifyDataSetChanged();
                    break;
                case 66:
                    x.a((String) obj);
                    chat.ola.vn.util.c.b.b();
                    this.f.notifyDataSetChanged();
                    break;
                case 67:
                    x.h = ((Boolean) obj).booleanValue();
                    chat.ola.vn.h.b.b(h.a(), x.h);
                    this.f.notifyDataSetChanged();
                    break;
                case 86:
                    x.l = (byte) Integer.valueOf((String) obj).intValue();
                    this.f.notifyDataSetChanged();
                    break;
                case 87:
                    D();
                    this.f.notifyDataSetChanged();
                    break;
                case 91:
                    x.r = ((Boolean) obj).booleanValue();
                    this.f.notifyDataSetChanged();
                    break;
                case 92:
                    this.i++;
                    if (this.i >= 8) {
                        this.i = 0;
                        i.b(this, "Console", "Max: " + f.a + "ms\nAvg: " + (f.b / ((long) f.c)) + "ms\nTotal count: " + f.c).setCanceledOnTouchOutside(false);
                    }
                    this.f.notifyDataSetChanged();
                    break;
                case 93:
                    if (Integer.valueOf((String) obj).intValue() != 0) {
                        OlaCropImageActivity.a(this);
                    } else {
                        chat.ola.vn.h.b.b(h.a());
                        OlaBottomTabActivity.E();
                    }
                    this.f.notifyDataSetChanged();
                    break;
                case 95:
                    x.s = ((Boolean) obj).booleanValue();
                    this.f.notifyDataSetChanged();
                    break;
                case 100:
                    byte bByteValue = Byte.valueOf((String) obj).byteValue();
                    i.a(this, R.string.dialog_title_inform, R.string.message_restart_ola_after_change_language);
                    String str = "default";
                    switch (bByteValue) {
                        case 1:
                            str = "vi";
                            break;
                        case 2:
                            str = "en";
                            break;
                    }
                    x.b(str);
                    this.f.notifyDataSetChanged();
                    break;
                case 101:
                    x.p = Byte.valueOf((String) obj).byteValue();
                    this.f.notifyDataSetChanged();
                    break;
                case 104:
                    x.t = ((Boolean) obj).booleanValue();
                    this.f.notifyDataSetChanged();
                    break;
                case 107:
                    x.u = ((Boolean) obj).booleanValue();
                    this.f.notifyDataSetChanged();
                    break;
                case 108:
                    C();
                    this.f.notifyDataSetChanged();
                    break;
                case 110:
                    x.x = ((Boolean) obj).booleanValue();
                    chat.ola.vn.h.b.e(h.a(), x.x);
                    this.f.notifyDataSetChanged();
                    break;
                case 112:
                    x.y = ((Boolean) obj).booleanValue();
                    chat.ola.vn.h.b.f(h.a(), x.y);
                    if (x.y) {
                        OlaQuickReplyComposerActivity.a(this);
                    }
                    this.f.notifyDataSetChanged();
                    break;
                default:
                    this.f.notifyDataSetChanged();
                    break;
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        finish();
    }

    @Override // android.widget.ExpandableListView.OnChildClickListener
    public boolean onChildClick(ExpandableListView expandableListView, View view, int i, int i2, long j) {
        try {
            ((chat.ola.vn.entry.a.c) this.f.getChild(i, i2)).a((Context) this);
            return true;
        } catch (Throwable unused) {
            return true;
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.olaActionBarMoreButtonImageView) {
                return;
            }
            finish();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        final int intExtra;
        super.onCreate(bundle);
        final int intExtra2 = 0;
        try {
            intExtra = getIntent().getIntExtra("groupIndex", 0);
            try {
                intExtra2 = getIntent().getIntExtra("rowIndex", 0);
            } catch (Throwable unused) {
            }
        } catch (Throwable unused2) {
            intExtra = 0;
        }
        getWindow().setBackgroundDrawable(new ColorDrawable(chat.ola.vn.f.b));
        B();
        this.f = new chat.ola.vn.b.b(this);
        this.f.a(this.e);
        setContentView(R.layout.app_config_layout);
        this.g = (ExpandableListView) findViewById(R.id.lvAppConfigList);
        this.h = (LikeView) findViewById(R.id.fbLikeView);
        this.h.setObjectIdAndType("286093228187327", LikeView.ObjectType.PAGE);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_setting);
        findViewById(R.id.olaActionBarBackViewLayout).setVisibility(4);
        ImageView imageView = (ImageView) findViewById(R.id.olaActionBarMoreButtonImageView);
        imageView.setImageResource(R.drawable.ic_action_quit);
        imageView.setOnClickListener(this);
        View view = new View(this);
        view.setLayoutParams(new AbsListView.LayoutParams(-1, getResources().getDimensionPixelSize(R.dimen.metric_16dp)));
        this.g.addFooterView(view);
        this.g.setAdapter(this.f);
        this.g.setOnChildClickListener(this);
        this.g.setOnGroupClickListener(new ExpandableListView.OnGroupClickListener() { // from class: chat.ola.vn.activity.OlaAppSettingActivity.1
            @Override // android.widget.ExpandableListView.OnGroupClickListener
            public boolean onGroupClick(ExpandableListView expandableListView, View view2, int i, long j) {
                return expandableListView.isGroupExpanded(i);
            }
        });
        this.g.post(new Runnable() { // from class: chat.ola.vn.activity.OlaAppSettingActivity.2
            @Override // java.lang.Runnable
            public void run() {
                int groupCount = OlaAppSettingActivity.this.f.getGroupCount();
                for (int i = 0; i < groupCount; i++) {
                    OlaAppSettingActivity.this.g.expandGroup(i);
                }
                if (intExtra2 > 0) {
                    OlaAppSettingActivity.this.g.setSelectedChild(intExtra, intExtra2, true);
                } else {
                    OlaAppSettingActivity.this.g.setSelectedGroup(intExtra);
                }
            }
        });
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        x.h();
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
        x.h();
    }
}
