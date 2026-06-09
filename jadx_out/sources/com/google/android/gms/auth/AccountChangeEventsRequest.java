package com.google.android.gms.auth;

import android.accounts.Account;
import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AccountChangeEventsRequestCreator")
public class AccountChangeEventsRequest extends AbstractSafeParcelable {
    public static final Parcelable.Creator<AccountChangeEventsRequest> CREATOR = new zze();

    @SafeParcelable.VersionField(id = 1)
    private final int zzh;

    @SafeParcelable.Field(id = 3)
    @Deprecated
    private String zzj;

    @SafeParcelable.Field(id = 2)
    private int zzl;

    @SafeParcelable.Field(id = 4)
    private Account zzn;

    public AccountChangeEventsRequest() {
        this.zzh = 1;
    }

    @SafeParcelable.Constructor
    AccountChangeEventsRequest(@SafeParcelable.Param(id = 1) int i, @SafeParcelable.Param(id = 2) int i2, @SafeParcelable.Param(id = 3) String str, @SafeParcelable.Param(id = 4) Account account) {
        this.zzh = i;
        this.zzl = i2;
        this.zzj = str;
        if (account != null || TextUtils.isEmpty(str)) {
            this.zzn = account;
        } else {
            this.zzn = new Account(str, "com.google");
        }
    }

    public Account getAccount() {
        return this.zzn;
    }

    @Deprecated
    public String getAccountName() {
        return this.zzj;
    }

    public int getEventIndex() {
        return this.zzl;
    }

    public AccountChangeEventsRequest setAccount(Account account) {
        this.zzn = account;
        return this;
    }

    @Deprecated
    public AccountChangeEventsRequest setAccountName(String str) {
        this.zzj = str;
        return this;
    }

    public AccountChangeEventsRequest setEventIndex(int i) {
        this.zzl = i;
        return this;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzh);
        SafeParcelWriter.writeInt(parcel, 2, this.zzl);
        SafeParcelWriter.writeString(parcel, 3, this.zzj, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzn, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
