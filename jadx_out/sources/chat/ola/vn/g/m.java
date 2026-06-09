package chat.ola.vn.g;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.OlaCropImageActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.activity.OlaPhoneVerificationActivity;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.i.j;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import com.facebook.AccessToken;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.login.LoginManager;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class m extends h implements View.OnClickListener {
    public ImageView e;
    public ImageView f;
    public TextView g;
    private View h;
    private Button i;
    private TextView j;
    private TextView k;

    public m(View view) {
        super(view);
        this.e = (ImageView) view.findViewById(R.id.vipIconImageView);
        this.f = (ImageView) view.findViewById(R.id.statusImageView);
        this.g = (TextView) view.findViewById(R.id.statusMessageTextView);
        this.e.setOnClickListener(this);
        this.f.setOnClickListener(this);
        this.g.setOnClickListener(this);
        try {
            this.h = view.findViewById(R.id.warningLayout);
            this.i = (Button) view.findViewById(R.id.warningButton);
            this.j = (TextView) view.findViewById(R.id.warningLine1TextView);
            this.k = (TextView) view.findViewById(R.id.warningLine2TextView);
            this.h.setOnClickListener(this);
        } catch (Throwable unused) {
        }
    }

    private void a(final Context context, View view) {
        int i;
        final ArrayList arrayList = new ArrayList();
        try {
            if (chat.ola.vn.h.H > 0) {
                if (chat.ola.vn.h.K <= 3) {
                    i = R.string.string_buy_vip_day;
                }
                arrayList.add(context.getString(R.string.string_change_ovatar));
                arrayList.add(context.getString(R.string.string_logout));
                arrayList.add(context.getString(R.string.string_logout_all));
                chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
                mVar.a(arrayList);
                mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.g.m.2
                    @Override // android.widget.AdapterView.OnItemClickListener
                    public void onItemClick(AdapterView<?> adapterView, View view2, int i2, long j) {
                        m mVar2;
                        boolean z;
                        try {
                            String str = (String) arrayList.get(i2);
                            if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_change_ovatar))) {
                                OlaCropImageActivity.c(context);
                                return;
                            }
                            if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_buy_vip))) {
                                BuyVipActivity.a(context);
                                return;
                            }
                            if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_buy_vip_day))) {
                                BuyVipActivity.b(context);
                                return;
                            }
                            if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_logout))) {
                                mVar2 = m.this;
                                z = false;
                            } else {
                                if (!chat.ola.vn.util.m.b(str, context.getString(R.string.string_logout_all))) {
                                    return;
                                }
                                mVar2 = m.this;
                                z = true;
                            }
                            mVar2.c(z);
                        } catch (Throwable unused) {
                        }
                    }
                });
                mVar.show();
                return;
            }
            i = R.string.string_buy_vip;
            chat.ola.vn.i.m mVar2 = new chat.ola.vn.i.m(context);
            mVar2.a(arrayList);
            mVar2.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.g.m.2
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view2, int i2, long j) {
                    m mVar22;
                    boolean z;
                    try {
                        String str = (String) arrayList.get(i2);
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_change_ovatar))) {
                            OlaCropImageActivity.c(context);
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_buy_vip))) {
                            BuyVipActivity.a(context);
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_buy_vip_day))) {
                            BuyVipActivity.b(context);
                            return;
                        }
                        if (chat.ola.vn.util.m.b(str, context.getString(R.string.string_logout))) {
                            mVar22 = m.this;
                            z = false;
                        } else {
                            if (!chat.ola.vn.util.m.b(str, context.getString(R.string.string_logout_all))) {
                                return;
                            }
                            mVar22 = m.this;
                            z = true;
                        }
                        mVar22.c(z);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar2.show();
            return;
        } catch (Throwable unused) {
            return;
        }
        arrayList.add(context.getString(i));
        arrayList.add(context.getString(R.string.string_change_ovatar));
        arrayList.add(context.getString(R.string.string_logout));
        arrayList.add(context.getString(R.string.string_logout_all));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(final boolean z) {
        try {
            if (chat.ola.vn.c.c() != null) {
                new chat.ola.vn.i.j(chat.ola.vn.c.c(), z, new j.a() { // from class: chat.ola.vn.g.m.3
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
                            chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.message_logout_waiting, 3000L, new Runnable() { // from class: chat.ola.vn.g.m.3.1
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

    @Override // chat.ola.vn.g.h
    public void b(int i) {
        try {
            this.e.setImageBitmap(chat.ola.vn.j.a().a(chat.ola.vn.h.H));
            String str = x.c;
            if (chat.ola.vn.util.m.a(str)) {
                this.g.setText((CharSequence) null);
                this.f.setVisibility(8);
            } else {
                ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) str);
                String strD = chat.ola.vn.util.i.d(str, "");
                if (arrayListB == null || arrayListB.isEmpty()) {
                    this.f.setVisibility(8);
                } else {
                    String str2 = arrayListB.get(0);
                    char cCharAt = str2.charAt(1);
                    if (cCharAt == 'P') {
                        Bitmap bitmapB = t.a().b(str2);
                        if (bitmapB != null) {
                            this.f.setImageBitmap(bitmapB);
                        } else {
                            this.f.setImageResource(R.drawable.bg_more_photo);
                            chat.ola.vn.c.f fVarG = chat.ola.vn.c.f.g(str2, 320);
                            fVarG.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.g.m.1
                                @Override // chat.ola.vn.c.g
                                public void a(chat.ola.vn.c.f fVar) {
                                    m.this.f.setImageBitmap(fVar.c());
                                }

                                @Override // chat.ola.vn.c.g
                                public void b(chat.ola.vn.c.f fVar) {
                                }
                            });
                            try {
                                new chat.ola.vn.c.e().a(fVarG);
                            } catch (Throwable unused) {
                            }
                        }
                    } else if (cCharAt == 'S') {
                        this.f.setImageResource(R.drawable.ic_media_sound);
                    } else if (cCharAt != 'V') {
                        this.f.setImageResource(R.drawable.ic_sdcard);
                    } else {
                        this.f.setImageResource(R.drawable.ic_media_video);
                    }
                    this.f.setVisibility(0);
                }
                this.g.setText(strD);
            }
        } catch (Throwable unused2) {
        }
        try {
            try {
                if (this.h != null) {
                    this.h.setVisibility(8);
                    if (chat.ola.vn.h.O.u == 0) {
                        this.h.setVisibility(0);
                        this.h.setTag(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                        this.i.setText(R.string.string_buy_vip);
                        this.j.setText(R.string.message_register_vip_account);
                        this.k.setText(R.string.message_register_vip_explaination);
                        return;
                    }
                    if (chat.ola.vn.h.O.q > 0 && chat.ola.vn.h.O.q < 3) {
                        this.h.setVisibility(0);
                        this.h.setTag("1");
                        this.i.setText(R.string.string_extend_vip);
                        this.j.setText(R.string.message_extend_vip_account);
                        this.k.setText(R.string.message_extend_vip_explaination);
                        return;
                    }
                    if (chat.ola.vn.h.O.x) {
                        return;
                    }
                    this.h.setVisibility(0);
                    this.h.setTag("2");
                    this.i.setText(R.string.string_verify);
                    this.j.setText(R.string.message_phone_number_not_validate);
                    this.k.setText(R.string.message_warning_need_verify_phone_to_protect_your_account);
                }
            } catch (Throwable unused3) {
                this.h.setVisibility(8);
            }
        } catch (Throwable unused4) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            chat.ola.vn.c cVarC = chat.ola.vn.c.c();
            switch (view.getId()) {
                case R.id.statusImageView /* 2131297429 */:
                    ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) x.c);
                    if (arrayListB != null && arrayListB.size() > 0) {
                        ArrayList arrayList = new ArrayList(arrayListB);
                        for (String str : arrayListB) {
                            if (chat.ola.vn.entity.i.i(str) == 1) {
                                arrayList.add(str);
                            }
                        }
                        if (arrayList.size() > 0) {
                            OlaImageViewerActivity.a(cVarC, view, (Bitmap) null, 0, OlaMediaEntity.a(arrayList));
                        }
                        break;
                    }
                    break;
                case R.id.statusMessageTextView /* 2131297430 */:
                    OlaMeComposerActivity.a(cVarC, x.c);
                    break;
                case R.id.vipIconImageView /* 2131297775 */:
                    a(cVarC, view);
                    break;
                case R.id.warningLayout /* 2131297797 */:
                    String str2 = (String) view.getTag();
                    if (chat.ola.vn.util.m.c(str2, AppEventsConstants.EVENT_PARAM_VALUE_NO)) {
                        BuyVipActivity.a(chat.ola.vn.c.c());
                    } else if (chat.ola.vn.util.m.c(str2, "1")) {
                        BuyVipActivity.b(chat.ola.vn.c.c());
                    } else if (chat.ola.vn.util.m.c(str2, "2")) {
                        OlaPhoneVerificationActivity.a(chat.ola.vn.c.c());
                    }
                    break;
            }
        } catch (Throwable unused) {
        }
    }
}
