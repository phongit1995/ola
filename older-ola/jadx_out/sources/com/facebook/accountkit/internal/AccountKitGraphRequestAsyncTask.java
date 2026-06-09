package com.facebook.accountkit.internal;

import android.os.AsyncTask;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.util.Log;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.internal.AccountKitGraphRequest;
import java.net.HttpURLConnection;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
final class AccountKitGraphRequestAsyncTask extends AsyncTask<Void, Void, AccountKitGraphResponse> {
    private static final int BACKOFF_INTERVAL_SEC = 5;
    private static final int MAX_NUM_RETRIES = 4;
    private static final String TAG = AccountKitGraphRequestAsyncTask.class.getCanonicalName();
    private static volatile AccountKitGraphRequestAsyncTask currentAsyncTask;
    private final AccountKitGraphRequest.Callback callback;
    private final HttpURLConnection connection;
    private Exception exception;
    private final int numRetries;
    private final AccountKitGraphRequest request;

    AccountKitGraphRequestAsyncTask(AccountKitGraphRequest accountKitGraphRequest, AccountKitGraphRequest.Callback callback) {
        this(null, accountKitGraphRequest, callback, 0);
    }

    private AccountKitGraphRequestAsyncTask(HttpURLConnection httpURLConnection, AccountKitGraphRequest accountKitGraphRequest, AccountKitGraphRequest.Callback callback, int i) {
        this.connection = httpURLConnection;
        this.request = accountKitGraphRequest;
        this.callback = callback;
        this.numRetries = i;
    }

    static AccountKitGraphRequestAsyncTask cancelCurrentAsyncTask() {
        AccountKitGraphRequestAsyncTask accountKitGraphRequestAsyncTask = currentAsyncTask;
        if (accountKitGraphRequestAsyncTask != null) {
            accountKitGraphRequestAsyncTask.cancel(true);
        }
        return accountKitGraphRequestAsyncTask;
    }

    static AccountKitGraphRequestAsyncTask getCurrentAsyncTask() {
        return currentAsyncTask;
    }

    static void setCurrentAsyncTask(AccountKitGraphRequestAsyncTask accountKitGraphRequestAsyncTask) {
        currentAsyncTask = accountKitGraphRequestAsyncTask;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    public AccountKitGraphResponse doInBackground(Void... voidArr) {
        try {
            return this.connection == null ? this.request.executeAndWait() : AccountKitGraphRequest.executeConnectionAndWait(this.connection, this.request);
        } catch (Exception e) {
            this.exception = e;
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    public void onPostExecute(AccountKitGraphResponse accountKitGraphResponse) {
        super.onPostExecute(accountKitGraphResponse);
        if (accountKitGraphResponse != null && accountKitGraphResponse.getError() != null && accountKitGraphResponse.getError().getException().getError().getErrorType() == AccountKitError.Type.NETWORK_CONNECTION_ERROR && accountKitGraphResponse.getError().getException().getError().getDetailErrorCode() != 101 && this.numRetries < 4) {
            new Handler(AccountKitController.getApplicationContext().getMainLooper()).post(new Runnable() { // from class: com.facebook.accountkit.internal.AccountKitGraphRequestAsyncTask.1
                @Override // java.lang.Runnable
                public void run() {
                    final AccountKitGraphRequestAsyncTask accountKitGraphRequestAsyncTask = new AccountKitGraphRequestAsyncTask(null, AccountKitGraphRequestAsyncTask.this.request, AccountKitGraphRequestAsyncTask.this.callback, AccountKitGraphRequestAsyncTask.this.numRetries + 1);
                    Utility.getBackgroundExecutor().schedule(new Runnable() { // from class: com.facebook.accountkit.internal.AccountKitGraphRequestAsyncTask.1.1
                        @Override // java.lang.Runnable
                        public void run() {
                            if (AccountKitGraphRequestAsyncTask.this.isCancelled() || accountKitGraphRequestAsyncTask.isCancelled()) {
                                return;
                            }
                            accountKitGraphRequestAsyncTask.executeOnExecutor(Utility.getThreadPoolExecutor(), new Void[0]);
                        }
                    }, r0 * 5, TimeUnit.SECONDS);
                    if (AccountKitGraphRequestAsyncTask.this.request.isLoginRequest()) {
                        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(accountKitGraphRequestAsyncTask);
                    }
                }
            });
            return;
        }
        if (this.callback != null) {
            this.callback.onCompleted(accountKitGraphResponse);
        }
        if (this.exception != null) {
            Log.d(TAG, String.format("onPostExecute: exception encountered during request: %s", this.exception.getMessage()));
        }
    }

    @Override // android.os.AsyncTask
    protected void onPreExecute() {
        super.onPreExecute();
        if (this.request.getCallbackHandler() == null) {
            this.request.setCallbackHandler(Thread.currentThread() instanceof HandlerThread ? new Handler() : new Handler(Looper.getMainLooper()));
        }
    }

    public String toString() {
        return "{AccountKitGraphRequestAsyncTask:  connection: " + this.connection + ", request: " + this.request + "}";
    }
}
