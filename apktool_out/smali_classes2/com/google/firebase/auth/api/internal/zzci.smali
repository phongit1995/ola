.class public abstract Lcom/google/firebase/auth/api/internal/zzci;
.super Lcom/google/android/gms/internal/firebase_auth/zzb;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzch;


# direct methods
.method public constructor <init>()V
    .locals 1

    const-string v0, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzb;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method protected final dispatchTransaction(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 0

    packed-switch p1, :pswitch_data_0

    const/4 p1, 0x0

    return p1

    :pswitch_0
    invoke-virtual {p0}, Lcom/google/firebase/auth/api/internal/zzci;->zzae()V

    goto/16 :goto_0

    :pswitch_1
    sget-object p1, Lcom/google/android/gms/common/api/Status;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/common/api/Status;

    sget-object p3, Lcom/google/firebase/auth/PhoneAuthCredential;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p2

    check-cast p2, Lcom/google/firebase/auth/PhoneAuthCredential;

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/auth/api/internal/zzci;->zza(Lcom/google/android/gms/common/api/Status;Lcom/google/firebase/auth/PhoneAuthCredential;)V

    goto/16 :goto_0

    :pswitch_2
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzci;->zzf(Ljava/lang/String;)V

    goto :goto_0

    :pswitch_3
    sget-object p1, Lcom/google/firebase/auth/PhoneAuthCredential;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/PhoneAuthCredential;

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzci;->onVerificationCompleted(Lcom/google/firebase/auth/PhoneAuthCredential;)V

    goto :goto_0

    :pswitch_4
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzci;->zze(Ljava/lang/String;)V

    goto :goto_0

    :pswitch_5
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzci;->zzd(Ljava/lang/String;)V

    goto :goto_0

    :pswitch_6
    invoke-virtual {p0}, Lcom/google/firebase/auth/api/internal/zzci;->zzad()V

    goto :goto_0

    :pswitch_7
    invoke-virtual {p0}, Lcom/google/firebase/auth/api/internal/zzci;->zzac()V

    goto :goto_0

    :pswitch_8
    sget-object p1, Lcom/google/android/gms/common/api/Status;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/common/api/Status;

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzci;->onFailure(Lcom/google/android/gms/common/api/Status;)V

    goto :goto_0

    :pswitch_9
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzav;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzav;

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzci;->zza(Lcom/google/android/gms/internal/firebase_auth/zzav;)V

    goto :goto_0

    :pswitch_a
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzx;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzx;

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzci;->zza(Lcom/google/android/gms/internal/firebase_auth/zzx;)V

    goto :goto_0

    :pswitch_b
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzao;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzao;

    sget-object p3, Lcom/google/android/gms/internal/firebase_auth/zzaj;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p2

    check-cast p2, Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/auth/api/internal/zzci;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;)V

    goto :goto_0

    :pswitch_c
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzao;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzci;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzao;)V

    :goto_0
    const/4 p1, 0x1

    return p1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
