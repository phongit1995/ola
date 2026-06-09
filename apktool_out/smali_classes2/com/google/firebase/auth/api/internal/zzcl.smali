.class public abstract Lcom/google/firebase/auth/api/internal/zzcl;
.super Lcom/google/android/gms/internal/firebase_auth/zzb;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzck;


# direct methods
.method public constructor <init>()V
    .locals 1

    const-string v0, "com.google.firebase.auth.api.internal.IFirebaseAuthService"

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzb;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method protected final dispatchTransaction(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 3

    const/4 p4, 0x0

    packed-switch p1, :pswitch_data_0

    const/4 p1, 0x0

    return p1

    :pswitch_0
    sget-object p1, Lcom/google/firebase/auth/EmailAuthCredential;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/EmailAuthCredential;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_1

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_0

    :cond_1
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_0
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Lcom/google/firebase/auth/EmailAuthCredential;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_1
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/google/firebase/auth/ActionCodeSettings;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/auth/ActionCodeSettings;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_2

    goto :goto_1

    :cond_2
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_3

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_1

    :cond_3
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_1
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzc(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_2
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_4

    goto :goto_2

    :cond_4
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_5

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_2

    :cond_5
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_2
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzk(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_3
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/google/firebase/auth/ActionCodeSettings;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/auth/ActionCodeSettings;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_6

    goto :goto_3

    :cond_6
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_7

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_3

    :cond_7
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_3
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzb(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_4
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/google/firebase/auth/ActionCodeSettings;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/auth/ActionCodeSettings;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_8

    goto :goto_4

    :cond_8
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_9

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_4

    :cond_9
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_4
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_5
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/google/firebase/auth/PhoneAuthCredential;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/auth/PhoneAuthCredential;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_a

    goto :goto_5

    :cond_a
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_b

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_5

    :cond_b
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_5
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Ljava/lang/String;Lcom/google/firebase/auth/PhoneAuthCredential;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_6
    sget-object p1, Lcom/google/firebase/auth/PhoneAuthCredential;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/PhoneAuthCredential;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_c

    goto :goto_6

    :cond_c
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_d

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_6

    :cond_d
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_6
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Lcom/google/firebase/auth/PhoneAuthCredential;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_7
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzax;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzax;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_e

    goto :goto_7

    :cond_e
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_f

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_7

    :cond_f
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_7
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Lcom/google/android/gms/internal/firebase_auth/zzax;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_8
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_10

    goto :goto_8

    :cond_10
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_11

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_8

    :cond_11
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_8
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzf(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_9
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_12

    goto :goto_9

    :cond_12
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_13

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_9

    :cond_13
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_9
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzj(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_a
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_14

    goto :goto_a

    :cond_14
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_15

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_a

    :cond_15
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_a
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzi(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_b
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_16

    goto :goto_b

    :cond_16
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_17

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_b

    :cond_17
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_b
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzh(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_c
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_18

    goto :goto_c

    :cond_18
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_19

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_c

    :cond_19
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_c
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzg(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_d
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p1

    if-nez p1, :cond_1a

    goto :goto_d

    :cond_1a
    const-string p2, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p1, p2}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p2

    instance-of p4, p2, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz p4, :cond_1b

    move-object p4, p2

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_d

    :cond_1b
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p1}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_d
    invoke-virtual {p0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_e
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_1c

    goto :goto_e

    :cond_1c
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_1d

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_e

    :cond_1d
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_e
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzf(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_f
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_1e

    goto :goto_f

    :cond_1e
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_1f

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_f

    :cond_1f
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_f
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zze(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_10
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_20

    goto :goto_10

    :cond_20
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_21

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_10

    :cond_21
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_10
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zze(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_11
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzbf;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzbf;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_22

    goto :goto_11

    :cond_22
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_23

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_11

    :cond_23
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_11
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Ljava/lang/String;Lcom/google/android/gms/internal/firebase_auth/zzbf;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_12
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_24

    goto :goto_12

    :cond_24
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v2, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v2, :cond_25

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_12

    :cond_25
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_12
    invoke-virtual {p0, p1, v0, v1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_13
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_26

    goto :goto_13

    :cond_26
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_27

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_13

    :cond_27
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_13
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzd(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_14
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_28

    goto :goto_14

    :cond_28
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_29

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_14

    :cond_29
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_14
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzc(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_15
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_2a

    goto :goto_15

    :cond_2a
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_2b

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_15

    :cond_2b
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_15
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzd(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_16
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_2c

    goto :goto_16

    :cond_2c
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_2d

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_16

    :cond_2d
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_16
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzc(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_17
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_2e

    goto :goto_17

    :cond_2e
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_2f

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_17

    :cond_2f
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_17
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzb(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_18
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_30

    goto :goto_18

    :cond_30
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_31

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_18

    :cond_31
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_18
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto/16 :goto_1d

    :pswitch_19
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/google/firebase/auth/UserProfileChangeRequest;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/auth/UserProfileChangeRequest;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_32

    goto :goto_19

    :cond_32
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v1, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v1, :cond_33

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_19

    :cond_33
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_19
    invoke-virtual {p0, p1, v0, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Ljava/lang/String;Lcom/google/firebase/auth/UserProfileChangeRequest;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto :goto_1d

    :pswitch_1a
    sget-object p1, Lcom/google/android/gms/internal/firebase_auth/zzbf;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzc;->zza(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzbf;

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_34

    goto :goto_1a

    :cond_34
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_35

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_1a

    :cond_35
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_1a
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbf;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto :goto_1d

    :pswitch_1b
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_36

    goto :goto_1b

    :cond_36
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_37

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_1b

    :cond_37
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_1b
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zzb(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    goto :goto_1d

    :pswitch_1c
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    if-nez p2, :cond_38

    goto :goto_1c

    :cond_38
    const-string p4, "com.google.firebase.auth.api.internal.IFirebaseAuthCallbacks"

    invoke-interface {p2, p4}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object p4

    instance-of v0, p4, Lcom/google/firebase/auth/api/internal/zzch;

    if-eqz v0, :cond_39

    check-cast p4, Lcom/google/firebase/auth/api/internal/zzch;

    goto :goto_1c

    :cond_39
    new-instance p4, Lcom/google/firebase/auth/api/internal/zzcj;

    invoke-direct {p4, p2}, Lcom/google/firebase/auth/api/internal/zzcj;-><init>(Landroid/os/IBinder;)V

    :goto_1c
    invoke-virtual {p0, p1, p4}, Lcom/google/firebase/auth/api/internal/zzcl;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    :goto_1d
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 p1, 0x1

    return p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1c
        :pswitch_1b
        :pswitch_1a
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
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
