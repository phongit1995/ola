package chat.ola.vn.a;

import android.accounts.AbstractAccountAuthenticator;
import android.accounts.Account;
import android.accounts.AccountAuthenticatorResponse;
import android.accounts.AccountManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import chat.ola.vn.activity.OlaOAuthenLoginActivity;

/* JADX INFO: loaded from: classes.dex */
public class a extends AbstractAccountAuthenticator {
    private Context a;

    public a(Context context) {
        super(context);
        this.a = context;
    }

    @Override // android.accounts.AbstractAccountAuthenticator
    public Bundle addAccount(AccountAuthenticatorResponse accountAuthenticatorResponse, String str, String str2, String[] strArr, Bundle bundle) {
        Intent intent = new Intent(this.a, (Class<?>) OlaOAuthenLoginActivity.class);
        intent.putExtra("ARG_ACCOUNT_TYPE", str);
        intent.putExtra("ARG_AUTH_TYPE", str2);
        intent.putExtra("ARG_IS_ADDING_NEW_ACCOUNT", true);
        intent.putExtra("accountAuthenticatorResponse", accountAuthenticatorResponse);
        Bundle bundle2 = new Bundle();
        bundle2.putParcelable("intent", intent);
        return bundle2;
    }

    @Override // android.accounts.AbstractAccountAuthenticator
    public Bundle confirmCredentials(AccountAuthenticatorResponse accountAuthenticatorResponse, Account account, Bundle bundle) {
        return null;
    }

    @Override // android.accounts.AbstractAccountAuthenticator
    public Bundle editProperties(AccountAuthenticatorResponse accountAuthenticatorResponse, String str) {
        return null;
    }

    @Override // android.accounts.AbstractAccountAuthenticator
    public Bundle getAuthToken(AccountAuthenticatorResponse accountAuthenticatorResponse, Account account, String str, Bundle bundle) {
        String password;
        AccountManager accountManager = AccountManager.get(this.a);
        String strPeekAuthToken = accountManager.peekAuthToken(account, str);
        if (TextUtils.isEmpty(strPeekAuthToken) && (password = accountManager.getPassword(account)) != null) {
            try {
                Intent intentA = chat.ola.vn.util.http.a.a(account.name, password);
                if (intentA != null && intentA.getIntExtra("_result", 1) == 1) {
                    strPeekAuthToken = intentA.getStringExtra("authtoken");
                }
            } catch (Throwable unused) {
            }
        }
        if (!TextUtils.isEmpty(strPeekAuthToken)) {
            Bundle bundle2 = new Bundle();
            bundle2.putString("authAccount", account.name);
            bundle2.putString("accountType", account.type);
            bundle2.putString("authtoken", strPeekAuthToken);
            return bundle2;
        }
        Intent intent = new Intent(this.a, (Class<?>) OlaOAuthenLoginActivity.class);
        intent.putExtra("accountAuthenticatorResponse", accountAuthenticatorResponse);
        intent.putExtra("ARG_ACCOUNT_TYPE", account.type);
        intent.putExtra("ARG_AUTH_TYPE", str);
        Bundle bundle3 = new Bundle();
        bundle3.putParcelable("intent", intent);
        return bundle3;
    }

    @Override // android.accounts.AbstractAccountAuthenticator
    public String getAuthTokenLabel(String str) {
        return null;
    }

    @Override // android.accounts.AbstractAccountAuthenticator
    public Bundle hasFeatures(AccountAuthenticatorResponse accountAuthenticatorResponse, Account account, String[] strArr) {
        return null;
    }

    @Override // android.accounts.AbstractAccountAuthenticator
    public Bundle updateCredentials(AccountAuthenticatorResponse accountAuthenticatorResponse, Account account, String str, Bundle bundle) {
        return null;
    }
}
