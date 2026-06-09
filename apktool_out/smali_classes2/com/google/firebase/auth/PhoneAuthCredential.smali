.class public Lcom/google/firebase/auth/PhoneAuthCredential;
.super Lcom/google/firebase/auth/AuthCredential;

# interfaces
.implements Ljava/lang/Cloneable;


# annotations
.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "PhoneAuthCredentialCreator"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/firebase/auth/PhoneAuthCredential;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private zzbd:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getPhoneNumber"
        id = 0x4
    .end annotation
.end field

.field private zzcf:Z
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getAutoCreate"
        id = 0x5
    .end annotation
.end field

.field private zzey:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getSessionInfo"
        id = 0x1
    .end annotation
.end field

.field private zzez:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getSmsCode"
        id = 0x2
    .end annotation
.end field

.field private zzfa:Z
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getHasVerificationProof"
        id = 0x3
    .end annotation
.end field

.field private zzfb:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getTemporaryProof"
        id = 0x6
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/firebase/auth/zzv;

    invoke-direct {v0}, Lcom/google/firebase/auth/zzv;-><init>()V

    sput-object v0, Lcom/google/firebase/auth/PhoneAuthCredential;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;ZLjava/lang/String;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .param p3    # Z
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x3
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x4
        .end annotation
    .end param
    .param p5    # Z
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x5
        .end annotation
    .end param
    .param p6    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x6
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    invoke-direct {p0}, Lcom/google/firebase/auth/AuthCredential;-><init>()V

    if-eqz p3, :cond_0

    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-static {p6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    :cond_2
    const/4 v0, 0x1

    goto :goto_0

    :cond_3
    const/4 v0, 0x0

    :goto_0
    const-string v1, "Cannot create PhoneAuthCredential without either verificationProof, sessionInfo, ortemprary proof."

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkArgument(ZLjava/lang/Object;)V

    iput-object p1, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzey:Ljava/lang/String;

    iput-object p2, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzez:Ljava/lang/String;

    iput-boolean p3, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzfa:Z

    iput-object p4, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzbd:Ljava/lang/String;

    iput-boolean p5, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzcf:Z

    iput-object p6, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzfb:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public synthetic clone()Ljava/lang/Object;
    .locals 8

    new-instance v7, Lcom/google/firebase/auth/PhoneAuthCredential;

    iget-object v1, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzey:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/google/firebase/auth/PhoneAuthCredential;->getSmsCode()Ljava/lang/String;

    move-result-object v2

    iget-boolean v3, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzfa:Z

    iget-object v4, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzbd:Ljava/lang/String;

    iget-boolean v5, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzcf:Z

    iget-object v6, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzfb:Ljava/lang/String;

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lcom/google/firebase/auth/PhoneAuthCredential;-><init>(Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;ZLjava/lang/String;)V

    return-object v7
.end method

.method public getProvider()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    const-string v0, "phone"

    return-object v0
.end method

.method public getSignInMethod()Ljava/lang/String;
    .locals 1

    const-string v0, "phone"

    return-object v0
.end method

.method public getSmsCode()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzez:Ljava/lang/String;

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 3

    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result p2

    iget-object v0, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzey:Ljava/lang/String;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {p1, v2, v0, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    invoke-virtual {p0}, Lcom/google/firebase/auth/PhoneAuthCredential;->getSmsCode()Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x2

    invoke-static {p1, v2, v0, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-boolean v0, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzfa:Z

    const/4 v2, 0x3

    invoke-static {p1, v2, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBoolean(Landroid/os/Parcel;IZ)V

    iget-object v0, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzbd:Ljava/lang/String;

    const/4 v2, 0x4

    invoke-static {p1, v2, v0, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-boolean v0, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzcf:Z

    const/4 v2, 0x5

    invoke-static {p1, v2, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBoolean(Landroid/os/Parcel;IZ)V

    iget-object v0, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzfb:Ljava/lang/String;

    const/4 v2, 0x6

    invoke-static {p1, v2, v0, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    invoke-static {p1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final zza(Z)Lcom/google/firebase/auth/PhoneAuthCredential;
    .locals 0

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/google/firebase/auth/PhoneAuthCredential;->zzcf:Z

    return-object p0
.end method
