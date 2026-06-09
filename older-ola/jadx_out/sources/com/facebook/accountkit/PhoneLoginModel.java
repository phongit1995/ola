package com.facebook.accountkit;

import com.facebook.accountkit.ui.NotificationChannel;

/* JADX INFO: loaded from: classes.dex */
public interface PhoneLoginModel extends LoginModel {
    String getConfirmationCode();

    NotificationChannel getNotificationChannel();

    PhoneNumber getPhoneNumber();

    long getResendTime();
}
