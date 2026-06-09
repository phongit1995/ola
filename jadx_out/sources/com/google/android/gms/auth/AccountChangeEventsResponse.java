package com.google.android.gms.auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AccountChangeEventsResponseCreator")
public class AccountChangeEventsResponse extends AbstractSafeParcelable {
    public static final Parcelable.Creator<AccountChangeEventsResponse> CREATOR = new zzf();

    @SafeParcelable.VersionField(id = 1)
    private final int zzh;

    @SafeParcelable.Field(id = 2)
    private final List<AccountChangeEvent> zzo;

    @SafeParcelable.Constructor
    AccountChangeEventsResponse(@SafeParcelable.Param(id = 1) int i, @SafeParcelable.Param(id = 2) List<AccountChangeEvent> list) {
        this.zzh = i;
        this.zzo = (List) Preconditions.checkNotNull(list);
    }

    public AccountChangeEventsResponse(List<AccountChangeEvent> list) {
        this.zzh = 1;
        this.zzo = (List) Preconditions.checkNotNull(list);
    }

    public List<AccountChangeEvent> getEvents() {
        return this.zzo;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzh);
        SafeParcelWriter.writeTypedList(parcel, 2, this.zzo, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
