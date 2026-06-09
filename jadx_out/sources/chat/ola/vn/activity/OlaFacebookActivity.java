package chat.ola.vn.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import chat.ola.vn.R;
import chat.ola.vn.c;
import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import com.google.android.gms.common.util.CrashUtils;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
public class OlaFacebookActivity extends c implements chat.ola.vn.f.a {
    public static String e = null;
    public static boolean f = false;
    private static CallbackManager g;
    private static b h;
    private static a i;
    private FacebookCallback<LoginResult> j = new FacebookCallback<LoginResult>() { // from class: chat.ola.vn.activity.OlaFacebookActivity.1
        @Override // com.facebook.FacebookCallback
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public void onSuccess(LoginResult loginResult) {
            OlaFacebookActivity.this.a(loginResult);
        }

        @Override // com.facebook.FacebookCallback
        public void onCancel() {
        }

        @Override // com.facebook.FacebookCallback
        public void onError(FacebookException facebookException) {
        }
    };

    public interface a {
        void a();
    }

    public interface b {
        void a();

        void b();
    }

    public static boolean B() {
        try {
            return f("publish_actions");
        } catch (Throwable unused) {
            return false;
        }
    }

    private void C() {
        if (AccessToken.getCurrentAccessToken() == null || AccessToken.getCurrentAccessToken().isExpired()) {
            LoginManager.getInstance().logInWithReadPermissions(this, Arrays.asList("email", "public_profile", "user_friends", "user_birthday"));
        }
    }

    private void D() {
        try {
            if (AccessToken.getCurrentAccessToken() == null || AccessToken.getCurrentAccessToken().isExpired()) {
                h.b();
            } else if (!B()) {
                LoginManager.getInstance().logInWithPublishPermissions(this, Arrays.asList("publish_actions"));
                return;
            } else {
                f = true;
                h.a();
            }
            finish();
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, Bundle bundle, a aVar) {
        Intent intent = new Intent(context, (Class<?>) OlaFacebookActivity.class);
        intent.addFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        i = aVar;
        h = null;
        if (bundle != null) {
            intent.putExtras(bundle);
        }
        context.startActivity(intent);
    }

    public static void a(Context context, b bVar) {
        Intent intent = new Intent(context, (Class<?>) OlaFacebookActivity.class);
        intent.addFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        i = null;
        h = bVar;
        context.startActivity(intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(LoginResult loginResult) {
        try {
            if (h != null) {
                if (B()) {
                    h.a();
                } else {
                    h.b();
                }
            }
            if (i != null) {
                i.a();
            }
            finish();
        } catch (Throwable unused) {
        }
    }

    public static boolean f(String str) {
        try {
            return AccessToken.getCurrentAccessToken().getPermissions().contains(str);
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i2, int i3, Intent intent) {
        super.onActivityResult(i2, i3, intent);
        try {
            g.onActivityResult(i2, i3, intent);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.facebook_activity_layout);
        try {
            g = CallbackManager.Factory.create();
            LoginManager.getInstance().registerCallback(g, this.j);
            if (h != null) {
                D();
            } else {
                C();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
    }
}
