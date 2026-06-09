package chat.ola.vn.activity;

import android.accounts.Account;
import android.accounts.AccountAuthenticatorActivity;
import android.accounts.AccountManager;
import android.app.Dialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.i.i;
import chat.ola.vn.util.http.a;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class OlaOAuthenLoginActivity extends AccountAuthenticatorActivity implements View.OnClickListener {
    private EditText a;
    private EditText b;
    private Dialog c;

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Type inference failed for: r2v0, types: [chat.ola.vn.activity.OlaOAuthenLoginActivity$3] */
    public void a() {
        if (this.c != null) {
            return;
        }
        this.c = i.a(this, R.string.message_connection_login_watting, 60000L, new Runnable() { // from class: chat.ola.vn.activity.OlaOAuthenLoginActivity.2
            @Override // java.lang.Runnable
            public void run() {
                try {
                    OlaOAuthenLoginActivity.this.c.dismiss();
                } catch (Throwable unused) {
                }
                OlaOAuthenLoginActivity.this.c = null;
            }
        });
        final String string = this.a.getText().toString();
        final String string2 = this.b.getText().toString();
        new AsyncTask<Void, Void, Intent>() { // from class: chat.ola.vn.activity.OlaOAuthenLoginActivity.3
            /* JADX INFO: Access modifiers changed from: protected */
            @Override // android.os.AsyncTask
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public Intent doInBackground(Void... voidArr) {
                return a.a(string, string2);
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // android.os.AsyncTask
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public void onPostExecute(Intent intent) {
                OlaOAuthenLoginActivity.this.a(intent);
            }
        }.execute(new Void[0]);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(Intent intent) {
        String str;
        String strValueOf;
        try {
            this.c.dismiss();
        } catch (Throwable unused) {
        }
        try {
            this.c = null;
            if (intent != null) {
                int intExtra = intent.getIntExtra("_result", 1);
                if (intExtra == 1) {
                    String stringExtra = intent.getStringExtra("authAccount");
                    String stringExtra2 = intent.getStringExtra("_pass");
                    String stringExtra3 = intent.getStringExtra("authtoken");
                    Account account = new Account(stringExtra, intent.getStringExtra("accountType"));
                    AccountManager accountManager = AccountManager.get(this);
                    long longExtra = intent.getLongExtra("_time", 0L);
                    if (getIntent().getBooleanExtra("ARG_IS_ADDING_NEW_ACCOUNT", false)) {
                        String string = getString(R.string.token_type);
                        accountManager.addAccountExplicitly(account, stringExtra2, null);
                        accountManager.setAuthToken(account, string, stringExtra3);
                        str = "_time";
                        strValueOf = String.valueOf(longExtra);
                    } else {
                        accountManager.setAuthToken(account, getString(R.string.token_type), stringExtra3);
                        accountManager.setPassword(account, stringExtra2);
                        str = "_time";
                        strValueOf = String.valueOf(longExtra);
                    }
                    accountManager.setUserData(account, str, strValueOf);
                    setAccountAuthenticatorResult(intent.getExtras());
                    setResult(-1, intent);
                    finish();
                    return;
                }
                if (intExtra == 33) {
                    i.a(this, R.string.dialog_title_fail, R.string.message_connection_lost_network_title);
                    return;
                }
                String stringExtra4 = intent.getStringExtra("_byte_data");
                if (!m.a(stringExtra4)) {
                    i.b(this, getString(R.string.dialog_title_fail), stringExtra4);
                    return;
                }
            }
            i.a(this, R.string.dialog_title_fail, R.string.message_fail_username_or_password);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i2 != -1 || intent == null) {
            return;
        }
        String stringExtra = intent.getStringExtra("_username");
        String stringExtra2 = intent.getStringExtra("_pass");
        this.a.setText(stringExtra);
        this.b.setText(stringExtra2);
        a();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.btnActionClose) {
                finish();
            } else if (id == R.id.btnLogin) {
                a();
            } else {
                if (id != R.id.btnRegister) {
                    return;
                }
                startActivityForResult(new Intent(this, (Class<?>) OlaOAuthenRegisterHtmlActivity.class), 0);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.accounts.AccountAuthenticatorActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.activity_ola_oauthen_login);
        this.a = (EditText) findViewById(R.id.txtUserName);
        this.a.setOnClickListener(this);
        this.b = (EditText) findViewById(R.id.txtPassword);
        this.b.setOnClickListener(this);
        this.b.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.OlaOAuthenLoginActivity.1
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (i != R.id.btnLogin && i != 0) {
                    return false;
                }
                OlaOAuthenLoginActivity.this.a();
                return true;
            }
        });
        findViewById(R.id.btnLogin).setOnClickListener(this);
        findViewById(R.id.btnRegister).setOnClickListener(this);
        findViewById(R.id.btnActionClose).setOnClickListener(this);
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        super.onCreateOptionsMenu(menu);
        getMenuInflater().inflate(R.menu.ola_oauthen_login, menu);
        return true;
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        if (menuItem.getItemId() != 16908332) {
            return super.onOptionsItemSelected(menuItem);
        }
        NavUtils.navigateUpFromSameTask(this);
        return true;
    }
}
