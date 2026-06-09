package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.l;
import chat.ola.vn.c;
import chat.ola.vn.entity.n;
import chat.ola.vn.h;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.message.f;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class OlaBirthdayCheerActivity extends c implements View.OnClickListener {
    private ListView e = null;
    private l f = null;
    private View g;

    private class a extends n {
        private a() {
        }

        @Override // chat.ola.vn.entity.n
        public boolean a(Context context) {
            OlaBirthdayCheerActivity.c(context);
            return true;
        }
    }

    private void B() {
        this.e = (ListView) findViewById(R.id.birthdayListView);
        this.g = findViewById(R.id.olaActionBarBackViewLayout);
        this.g.setOnClickListener(this);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_today_birthdays);
    }

    private void C() {
        try {
            if (this.f == null) {
                this.f = new l(this);
                this.f.a(this);
                this.e.setAdapter((ListAdapter) this.f);
            }
            this.f.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        Intent intent = new Intent(context, (Class<?>) OlaBirthdayCheerActivity.class);
        intent.addFlags(131072);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void c(Context context) {
        try {
            a(context);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        C();
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
        try {
            int id = view.getId();
            if (id == R.id.birthdayContactViewLayout) {
                chat.ola.vn.me.c.a(this, OlaApplication.b, ((f) view.getTag()).j(), new a());
                return;
            }
            if (id == R.id.happyBirthdayMessageEditText) {
                OlaMeComposerActivity.a(this, "@" + ((f) view.getTag()).j(), (String) null);
                return;
            }
            if (id != R.id.kissImageView) {
                if (id != R.id.olaActionBarBackViewLayout) {
                    return;
                }
                onBackPressed();
                return;
            }
            f fVar = (f) view.getTag();
            if (m.b(fVar.j(), h.a())) {
                return;
            }
            OlaApplication.b.i(fVar.j());
            Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.zoom_icon_animation);
            animationLoadAnimation.setDuration(150L);
            view.startAnimation(animationLoadAnimation);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_birthday_cheer_layout);
        B();
    }
}
