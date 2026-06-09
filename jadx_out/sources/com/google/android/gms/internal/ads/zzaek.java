package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzaek implements Parcelable.Creator<zzaej> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzaej createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        long j = 0;
        long j2 = 0;
        long j3 = 0;
        long j4 = 0;
        String strCreateString = null;
        String strCreateString2 = null;
        ArrayList<String> arrayListCreateStringList = null;
        ArrayList<String> arrayListCreateStringList2 = null;
        ArrayList<String> arrayListCreateStringList3 = null;
        String strCreateString3 = null;
        String strCreateString4 = null;
        String strCreateString5 = null;
        String strCreateString6 = null;
        zzaev zzaevVar = null;
        String strCreateString7 = null;
        String strCreateString8 = null;
        zzaig zzaigVar = null;
        ArrayList<String> arrayListCreateStringList4 = null;
        ArrayList<String> arrayListCreateStringList5 = null;
        zzael zzaelVar = null;
        String strCreateString9 = null;
        ArrayList<String> arrayListCreateStringList6 = null;
        String strCreateString10 = null;
        zzaiq zzaiqVar = null;
        String strCreateString11 = null;
        Bundle bundleCreateBundle = null;
        ArrayList<String> arrayListCreateStringList7 = null;
        String strCreateString12 = null;
        int i = 0;
        int i2 = 0;
        boolean z = false;
        int i3 = 0;
        boolean z2 = false;
        boolean z3 = false;
        boolean z4 = false;
        boolean z5 = false;
        boolean z6 = false;
        boolean z7 = false;
        boolean z8 = false;
        boolean z9 = false;
        boolean z10 = false;
        boolean z11 = false;
        boolean z12 = false;
        boolean z13 = false;
        boolean z14 = false;
        boolean z15 = false;
        int i4 = 0;
        boolean z16 = false;
        boolean z17 = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                case 2:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 3:
                    strCreateString2 = SafeParcelReader.createString(parcel, header);
                    break;
                case 4:
                    arrayListCreateStringList = SafeParcelReader.createStringList(parcel, header);
                    break;
                case 5:
                    i2 = SafeParcelReader.readInt(parcel, header);
                    break;
                case 6:
                    arrayListCreateStringList2 = SafeParcelReader.createStringList(parcel, header);
                    break;
                case 7:
                    j = SafeParcelReader.readLong(parcel, header);
                    break;
                case 8:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 9:
                    j2 = SafeParcelReader.readLong(parcel, header);
                    break;
                case 10:
                    arrayListCreateStringList3 = SafeParcelReader.createStringList(parcel, header);
                    break;
                case 11:
                    j3 = SafeParcelReader.readLong(parcel, header);
                    break;
                case 12:
                    i3 = SafeParcelReader.readInt(parcel, header);
                    break;
                case 13:
                    strCreateString3 = SafeParcelReader.createString(parcel, header);
                    break;
                case 14:
                    j4 = SafeParcelReader.readLong(parcel, header);
                    break;
                case 15:
                    strCreateString4 = SafeParcelReader.createString(parcel, header);
                    break;
                case 16:
                case 17:
                case 20:
                case 27:
                case 41:
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
                case 18:
                    z2 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 19:
                    strCreateString5 = SafeParcelReader.createString(parcel, header);
                    break;
                case 21:
                    strCreateString6 = SafeParcelReader.createString(parcel, header);
                    break;
                case 22:
                    z3 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 23:
                    z4 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 24:
                    z5 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 25:
                    z6 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 26:
                    z7 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 28:
                    zzaevVar = (zzaev) SafeParcelReader.createParcelable(parcel, header, zzaev.CREATOR);
                    break;
                case 29:
                    strCreateString7 = SafeParcelReader.createString(parcel, header);
                    break;
                case 30:
                    strCreateString8 = SafeParcelReader.createString(parcel, header);
                    break;
                case 31:
                    z8 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 32:
                    z9 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 33:
                    zzaigVar = (zzaig) SafeParcelReader.createParcelable(parcel, header, zzaig.CREATOR);
                    break;
                case 34:
                    arrayListCreateStringList4 = SafeParcelReader.createStringList(parcel, header);
                    break;
                case 35:
                    arrayListCreateStringList5 = SafeParcelReader.createStringList(parcel, header);
                    break;
                case 36:
                    z10 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 37:
                    zzaelVar = (zzael) SafeParcelReader.createParcelable(parcel, header, zzael.CREATOR);
                    break;
                case 38:
                    z11 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 39:
                    strCreateString9 = SafeParcelReader.createString(parcel, header);
                    break;
                case 40:
                    arrayListCreateStringList6 = SafeParcelReader.createStringList(parcel, header);
                    break;
                case 42:
                    z12 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 43:
                    strCreateString10 = SafeParcelReader.createString(parcel, header);
                    break;
                case 44:
                    zzaiqVar = (zzaiq) SafeParcelReader.createParcelable(parcel, header, zzaiq.CREATOR);
                    break;
                case 45:
                    strCreateString11 = SafeParcelReader.createString(parcel, header);
                    break;
                case 46:
                    z13 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 47:
                    z14 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 48:
                    bundleCreateBundle = SafeParcelReader.createBundle(parcel, header);
                    break;
                case 49:
                    z15 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 50:
                    i4 = SafeParcelReader.readInt(parcel, header);
                    break;
                case 51:
                    z16 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 52:
                    arrayListCreateStringList7 = SafeParcelReader.createStringList(parcel, header);
                    break;
                case 53:
                    z17 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 54:
                    strCreateString12 = SafeParcelReader.createString(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzaej(i, strCreateString, strCreateString2, arrayListCreateStringList, i2, arrayListCreateStringList2, j, z, j2, arrayListCreateStringList3, j3, i3, strCreateString3, j4, strCreateString4, z2, strCreateString5, strCreateString6, z3, z4, z5, z6, z7, zzaevVar, strCreateString7, strCreateString8, z8, z9, zzaigVar, arrayListCreateStringList4, arrayListCreateStringList5, z10, zzaelVar, z11, strCreateString9, arrayListCreateStringList6, z12, strCreateString10, zzaiqVar, strCreateString11, z13, z14, bundleCreateBundle, z15, i4, z16, arrayListCreateStringList7, z17, strCreateString12);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzaej[] newArray(int i) {
        return new zzaej[i];
    }
}
