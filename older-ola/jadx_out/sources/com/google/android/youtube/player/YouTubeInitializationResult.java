package com.google.android.youtube.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.ActivityNotFoundException;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import com.google.android.youtube.player.internal.ac;
import com.google.android.youtube.player.internal.m;
import com.google.android.youtube.player.internal.z;

/* JADX INFO: loaded from: classes2.dex */
public enum YouTubeInitializationResult {
    SUCCESS,
    INTERNAL_ERROR,
    UNKNOWN_ERROR,
    SERVICE_MISSING,
    SERVICE_VERSION_UPDATE_REQUIRED,
    SERVICE_DISABLED,
    SERVICE_INVALID,
    ERROR_CONNECTING_TO_SERVICE,
    CLIENT_LIBRARY_UPDATE_REQUIRED,
    NETWORK_ERROR,
    DEVELOPER_KEY_INVALID,
    INVALID_APPLICATION_SIGNATURE;

    private static final class a implements DialogInterface.OnClickListener {
        private final Activity a;
        private final Intent b;
        private final int c;

        public a(Activity activity, Intent intent, int i) {
            this.a = (Activity) ac.a(activity, "activity cannot be null");
            this.b = (Intent) ac.a(intent, "intent cannot be null");
            this.c = ((Integer) ac.a(Integer.valueOf(i), "requestCode cannot be null")).intValue();
        }

        @Override // android.content.DialogInterface.OnClickListener
        public final void onClick(DialogInterface dialogInterface, int i) {
            try {
                this.a.startActivityForResult(this.b, this.c);
                dialogInterface.dismiss();
            } catch (ActivityNotFoundException e) {
                Log.e("YouTubeAndroidPlayerAPI", String.format("Can't perform resolution for YouTubeInitalizationError", e));
            }
        }
    }

    public final Dialog getErrorDialog(Activity activity, int i) {
        return getErrorDialog(activity, i, null);
    }

    public final Dialog getErrorDialog(Activity activity, int i, DialogInterface.OnCancelListener onCancelListener) {
        Intent intentB;
        AlertDialog.Builder message;
        String str;
        AlertDialog.Builder builder = new AlertDialog.Builder(activity);
        if (onCancelListener != null) {
            builder.setOnCancelListener(onCancelListener);
        }
        switch (this) {
            case SERVICE_MISSING:
            case SERVICE_VERSION_UPDATE_REQUIRED:
                intentB = z.b(z.a(activity));
                break;
            case SERVICE_DISABLED:
                intentB = z.a(z.a(activity));
                break;
            default:
                intentB = null;
                break;
        }
        a aVar = new a(activity, intentB, i);
        m mVar = new m(activity);
        switch (this) {
            case SERVICE_MISSING:
                message = builder.setTitle(mVar.b).setMessage(mVar.c);
                str = mVar.d;
                break;
            case SERVICE_DISABLED:
                message = builder.setTitle(mVar.e).setMessage(mVar.f);
                str = mVar.g;
                break;
            case SERVICE_VERSION_UPDATE_REQUIRED:
                message = builder.setTitle(mVar.h).setMessage(mVar.i);
                str = mVar.j;
                break;
            default:
                throw new IllegalArgumentException("Unexpected errorReason: " + name());
        }
        return message.setPositiveButton(str, aVar).create();
    }

    public final boolean isUserRecoverableError() {
        switch (this) {
            case SERVICE_MISSING:
            case SERVICE_DISABLED:
            case SERVICE_VERSION_UPDATE_REQUIRED:
                return true;
            default:
                return false;
        }
    }
}
