package com.facebook.accountkit.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.SmsMessage;
import com.facebook.accountkit.Tracker;
import com.facebook.accountkit.internal.Utility;
import com.google.android.gms.auth.api.phone.SmsRetriever;
import com.google.android.gms.common.api.Status;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes.dex */
public abstract class SmsTracker extends Tracker {
    private static final Pattern ACCOUNT_KIT_PATTERN = Pattern.compile("(\\d{6})(?=.*\\bAccount Kit\\b)(?=.*\\bFacebook\\b)");
    public static final String AK_SMS_INTENT = "com.facebook.accountkit.SMS_RECIEVED";
    public static final int AK_SMS_INTENT_REQUEST_CODE = 42;
    static final String SMS_INTENT = "android.provider.Telephony.SMS_RECEIVED";

    public SmsTracker() {
        startTracking();
    }

    static boolean canTrackSms(Context context, AccountKitConfiguration accountKitConfiguration) {
        if (accountKitConfiguration.isReceiveSMSEnabled()) {
            return Utility.hasGooglePlayServices(context) || Utility.hasReceiveSmsPermissions(context);
        }
        return false;
    }

    static String getCodeFromString(String str) {
        Matcher matcher = ACCOUNT_KIT_PATTERN.matcher(str);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    protected abstract void confirmationCodeReceived(String str);

    @Override // com.facebook.accountkit.Tracker
    protected List<String> getActionsStateChanged() {
        return Arrays.asList(SMS_INTENT, AK_SMS_INTENT, SmsRetriever.SMS_RETRIEVED_ACTION);
    }

    @Override // com.facebook.accountkit.Tracker
    protected boolean isLocal() {
        return false;
    }

    @Override // com.facebook.accountkit.Tracker
    protected void onReceive(Intent intent) {
        String string;
        String codeFromString;
        if (SmsRetriever.SMS_RETRIEVED_ACTION.equals(intent.getAction())) {
            Bundle extras = intent.getExtras();
            Status status = (Status) extras.get(SmsRetriever.EXTRA_STATUS);
            string = (status == null || status.getStatusCode() != 0) ? null : (String) extras.get(SmsRetriever.EXTRA_SMS_MESSAGE);
        } else {
            Object[] objArr = (Object[]) intent.getSerializableExtra("pdus");
            StringBuilder sb = new StringBuilder();
            for (Object obj : objArr) {
                sb.append(SmsMessage.createFromPdu((byte[]) obj).getDisplayMessageBody());
            }
            string = sb.toString();
        }
        if (string == null || (codeFromString = getCodeFromString(string)) == null) {
            return;
        }
        confirmationCodeReceived(codeFromString);
    }
}
