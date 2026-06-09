package chat.ola.vn.i;

import android.content.Context;
import android.graphics.Typeface;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.c.t;
import chat.ola.vn.cloud.OlaCloudAlbumListActivity;
import chat.ola.vn.cloud.OlaCloudPhotoListActivity;
import chat.ola.vn.view.OlaCachedImageView;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class k extends n implements View.OnClickListener {
    private OlaCachedImageView a;
    private OlaCachedImageView b;
    private TextView c;
    private TextView d;
    private TextView e;
    private TextView f;
    private String g;
    private chat.ola.vn.entity.l h;

    public k(Context context) {
        super(context);
        getWindow().setLayout(-2, -2);
        setContentView(R.layout.media_code_info_layout);
        this.j = false;
        this.a = (OlaCachedImageView) findViewById(R.id.imgOwnerConver);
        this.b = (OlaCachedImageView) findViewById(R.id.imgOwnerAvatar);
        this.f = (TextView) findViewById(R.id.txtOwnerBuddyId);
        this.c = (TextView) findViewById(R.id.txtMediaDeviceType);
        this.d = (TextView) findViewById(R.id.txtMediaAlbum);
        this.d.setTypeface(Typeface.DEFAULT_BOLD);
        this.d.setTextColor(chat.ola.vn.f.a);
        this.e = (TextView) findViewById(R.id.txtMediaCreatedDate);
        this.d.setOnClickListener(this);
        findViewById(R.id.btnMediaActionChat).setOnClickListener(this);
        findViewById(R.id.btnMediaActionMakeFriend).setOnClickListener(this);
        findViewById(R.id.btnMediaActionViewME).setOnClickListener(this);
        setCanceledOnTouchOutside(true);
    }

    private void a(String str) {
        t.a().b(str, false, this.b);
    }

    private void b(String str) {
        t.a().h(str, this.a);
    }

    public void a(String str, char c, chat.ola.vn.entity.l lVar, Long l) {
        TextView textView;
        int i;
        this.g = str;
        this.h = lVar;
        this.f.setText(str);
        switch (c) {
            case '0':
                textView = this.c;
                i = R.string.string_phone;
                textView.setText(i);
                break;
            case '1':
                textView = this.c;
                i = R.string.string_web;
                textView.setText(i);
                break;
            case '2':
                textView = this.c;
                i = R.string.string_memory;
                textView.setText(i);
                break;
            default:
                this.c.setText(R.string.string_unknown);
                break;
        }
        if (l != null) {
            this.e.setText(new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault()).format(new Date(l.longValue())));
        } else {
            this.e.setText(R.string.string_unknown);
        }
        if (lVar == null || chat.ola.vn.util.m.a(lVar.a)) {
            this.d.setText(R.string.string_view_all);
        } else {
            this.d.setText(lVar.a);
        }
        a(str);
        b(str);
        if (chat.ola.vn.h.t != null) {
            if (chat.ola.vn.h.t.e(str, (short) 0) != null) {
                findViewById(R.id.btnMediaActionMakeFriend).setVisibility(8);
            } else {
                findViewById(R.id.btnMediaActionMakeFriend).setVisibility(0);
            }
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id != R.id.txtMediaAlbum) {
            switch (id) {
                case R.id.btnMediaActionChat /* 2131296505 */:
                    OlaChatViewActivity.a(getContext(), OlaApplication.b, this.g, (short) 0);
                    break;
                case R.id.btnMediaActionMakeFriend /* 2131296506 */:
                    OlaApplication.b.d(this.g);
                    break;
                case R.id.btnMediaActionViewME /* 2131296507 */:
                    chat.ola.vn.me.c.a(getContext(), OlaApplication.b, this.g);
                    break;
            }
        } else if (this.h != null) {
            OlaCloudPhotoListActivity.a(getContext(), this.g, this.h);
        } else {
            OlaCloudPhotoListActivity.a(getContext(), this.g);
            if (chat.ola.vn.util.m.b(chat.ola.vn.h.a(), this.g)) {
                OlaCloudAlbumListActivity.a(getContext());
            } else {
                OlaCloudPhotoListActivity.a(getContext(), this.g);
            }
        }
        dismiss();
    }
}
