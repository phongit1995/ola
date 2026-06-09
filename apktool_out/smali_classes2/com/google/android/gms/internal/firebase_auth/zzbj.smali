.class public final Lcom/google/android/gms/internal/firebase_auth/zzbj;
.super Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzcg;


# annotations
.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "VerifyCustomTokenResponseCreator"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Reserved;
    value = {
        0x1
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;",
        "Lcom/google/firebase/auth/api/internal/zzcg<",
        "Lcom/google/android/gms/internal/firebase_auth/zzbj;",
        "Lcom/google/android/gms/internal/firebase_auth/zzg$zzh;",
        ">;"
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/internal/firebase_auth/zzbj;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private zzaf:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getIdToken"
        id = 0x2
    .end annotation
.end field

.field private zzai:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getRefreshToken"
        id = 0x3
    .end annotation
.end field

.field private zzaj:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getExpiresIn"
        id = 0x4
    .end annotation
.end field

.field private zzak:Z
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "isNewUser"
        id = 0x5
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbk;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzbk;-><init>()V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;JZ)V
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
    .param p3    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x4
        .end annotation
    .end param
    .param p5    # Z
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x5
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzaf:Ljava/lang/String;

    iput-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzai:Ljava/lang/String;

    iput-wide p3, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzaj:J

    iput-boolean p5, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzak:Z

    return-void
.end method


# virtual methods
.method public final getIdToken()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzaf:Ljava/lang/String;

    return-object v0
.end method

.method public final isNewUser()Z
    .locals 1

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzak:Z

    return v0
.end method

.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 3

    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result p2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzaf:Ljava/lang/String;

    const/4 v1, 0x0

    const/4 v2, 0x2

    invoke-static {p1, v2, v0, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzai:Ljava/lang/String;

    const/4 v2, 0x3

    invoke-static {p1, v2, v0, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzaj:J

    const/4 v2, 0x4

    invoke-static {p1, v2, v0, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    iget-boolean v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzak:Z

    const/4 v1, 0x5

    invoke-static {p1, v1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBoolean(Landroid/os/Parcel;IZ)V

    invoke-static {p1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgt;)Lcom/google/firebase/auth/api/internal/zzcg;
    .locals 2

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzh;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzh;->zzaf:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzaf:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzh;->zzai:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzai:Ljava/lang/String;

    iget-wide v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzh;->zzaj:J

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzaj:J

    iget-boolean p1, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzh;->zzak:Z

    iput-boolean p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzak:Z

    return-object p0
.end method

.method public final zzag()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "Lcom/google/android/gms/internal/firebase_auth/zzg$zzh;",
            ">;"
        }
    .end annotation

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzh;

    return-object v0
.end method

.method public final zzap()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzai:Ljava/lang/String;

    return-object v0
.end method

.method public final zzaq()J
    .locals 2

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbj;->zzaj:J

    return-wide v0
.end method
