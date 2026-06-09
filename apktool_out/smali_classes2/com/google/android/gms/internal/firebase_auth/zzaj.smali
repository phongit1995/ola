.class public final Lcom/google/android/gms/internal/firebase_auth/zzaj;
.super Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;


# annotations
.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "GetAccountInfoUserCreator"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Reserved;
    value = {
        0x1
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/internal/firebase_auth/zzaj;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private zzad:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getLocalId"
        id = 0x2
    .end annotation
.end field

.field private zzah:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getEmail"
        id = 0x3
    .end annotation
.end field

.field private zzak:Z
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "isNewUser"
        id = 0xc
    .end annotation
.end field

.field private zzbd:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getPhoneNumber"
        id = 0x9
    .end annotation
.end field

.field private zzbh:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getDisplayName"
        id = 0x5
    .end annotation
.end field

.field private zzbi:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getPassword"
        id = 0x8
    .end annotation
.end field

.field private zzbr:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getPhotoUrl"
        id = 0x6
    .end annotation
.end field

.field private zzjq:Z
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "isEmailVerified"
        id = 0x4
    .end annotation
.end field

.field private zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getProviderInfoList"
        id = 0x7
    .end annotation
.end field

.field private zzjs:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getCreationTimestamp"
        id = 0xa
    .end annotation
.end field

.field private zzjt:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getLastSignInTimestamp"
        id = 0xb
    .end annotation
.end field

.field private zzju:Lcom/google/firebase/auth/zzd;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getDefaultOAuthCredential"
        id = 0xd
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzak;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzak;-><init>()V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzas;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzas;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Lcom/google/android/gms/internal/firebase_auth/zzas;Ljava/lang/String;Ljava/lang/String;JJZLcom/google/firebase/auth/zzd;)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x3
        .end annotation
    .end param
    .param p3    # Z
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x4
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x5
        .end annotation
    .end param
    .param p5    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x6
        .end annotation
    .end param
    .param p6    # Lcom/google/android/gms/internal/firebase_auth/zzas;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x7
        .end annotation
    .end param
    .param p7    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x8
        .end annotation
    .end param
    .param p8    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x9
        .end annotation
    .end param
    .param p9    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xa
        .end annotation
    .end param
    .param p11    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xb
        .end annotation
    .end param
    .param p13    # Z
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xc
        .end annotation
    .end param
    .param p14    # Lcom/google/firebase/auth/zzd;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xd
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzad:Ljava/lang/String;

    iput-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzah:Ljava/lang/String;

    iput-boolean p3, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjq:Z

    iput-object p4, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbh:Ljava/lang/String;

    iput-object p5, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbr:Ljava/lang/String;

    if-nez p6, :cond_0

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzas;

    invoke-direct {p1}, Lcom/google/android/gms/internal/firebase_auth/zzas;-><init>()V

    goto :goto_0

    :cond_0
    invoke-static {p6}, Lcom/google/android/gms/internal/firebase_auth/zzas;->zza(Lcom/google/android/gms/internal/firebase_auth/zzas;)Lcom/google/android/gms/internal/firebase_auth/zzas;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    iput-object p7, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbi:Ljava/lang/String;

    iput-object p8, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbd:Ljava/lang/String;

    iput-wide p9, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjs:J

    iput-wide p11, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjt:J

    iput-boolean p13, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzak:Z

    iput-object p14, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzju:Lcom/google/firebase/auth/zzd;

    return-void
.end method


# virtual methods
.method public final getCreationTimestamp()J
    .locals 2

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjs:J

    return-wide v0
.end method

.method public final getDisplayName()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbh:Ljava/lang/String;

    return-object v0
.end method

.method public final getEmail()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzah:Ljava/lang/String;

    return-object v0
.end method

.method public final getLastSignInTimestamp()J
    .locals 2

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjt:J

    return-wide v0
.end method

.method public final getLocalId()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzad:Ljava/lang/String;

    return-object v0
.end method

.method public final getPhoneNumber()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbd:Ljava/lang/String;

    return-object v0
.end method

.method public final getPhotoUri()Landroid/net/Uri;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbr:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbr:Ljava/lang/String;

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public final isEmailVerified()Z
    .locals 1

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjq:Z

    return v0
.end method

.method public final isNewUser()Z
    .locals 1

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzak:Z

    return v0
.end method

.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 5

    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzad:Ljava/lang/String;

    const/4 v2, 0x0

    const/4 v3, 0x2

    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzah:Ljava/lang/String;

    const/4 v3, 0x3

    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjq:Z

    const/4 v3, 0x4

    invoke-static {p1, v3, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBoolean(Landroid/os/Parcel;IZ)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbh:Ljava/lang/String;

    const/4 v3, 0x5

    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbr:Ljava/lang/String;

    const/4 v3, 0x6

    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    const/4 v3, 0x7

    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbi:Ljava/lang/String;

    const/16 v3, 0x8

    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbd:Ljava/lang/String;

    const/16 v3, 0x9

    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjs:J

    const/16 v1, 0xa

    invoke-static {p1, v1, v3, v4}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjt:J

    const/16 v1, 0xb

    invoke-static {p1, v1, v3, v4}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    iget-boolean v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzak:Z

    const/16 v3, 0xc

    invoke-static {p1, v3, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBoolean(Landroid/os/Parcel;IZ)V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzju:Lcom/google/firebase/auth/zzd;

    const/16 v3, 0xd

    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final zzat()Ljava/util/List;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/google/android/gms/internal/firebase_auth/zzaq;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzas;->zzat()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public final zzau()Lcom/google/android/gms/internal/firebase_auth/zzas;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    return-object v0
.end method

.method public final zzav()Lcom/google/firebase/auth/zzd;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzju:Lcom/google/firebase/auth/zzd;

    return-object v0
.end method

.method public final zzb(Lcom/google/firebase/auth/zzd;)Lcom/google/android/gms/internal/firebase_auth/zzaj;
    .locals 0
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzju:Lcom/google/firebase/auth/zzd;

    return-object p0
.end method

.method public final zzb(Ljava/util/List;)Lcom/google/android/gms/internal/firebase_auth/zzaj;
    .locals 1
    .param p1    # Ljava/util/List;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/google/android/gms/internal/firebase_auth/zzaq;",
            ">;)",
            "Lcom/google/android/gms/internal/firebase_auth/zzaj;"
        }
    .end annotation

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzas;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzas;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzjr:Lcom/google/android/gms/internal/firebase_auth/zzas;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzas;->zzat()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-object p0
.end method

.method public final zzc(Z)Lcom/google/android/gms/internal/firebase_auth/zzaj;
    .locals 0

    iput-boolean p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzak:Z

    return-object p0
.end method

.method public final zzl(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzah:Ljava/lang/String;

    return-object p0
.end method

.method public final zzm(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbh:Ljava/lang/String;

    return-object p0
.end method

.method public final zzn(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbr:Ljava/lang/String;

    return-object p0
.end method

.method public final zzo(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzbi:Ljava/lang/String;

    return-object p0
.end method
