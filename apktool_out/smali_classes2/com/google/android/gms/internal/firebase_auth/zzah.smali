.class public final Lcom/google/android/gms/internal/firebase_auth/zzah;
.super Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzcg;


# annotations
.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "GetAccountInfoResponseCreator"
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
        "Lcom/google/android/gms/internal/firebase_auth/zzah;",
        "Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;",
        ">;"
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/internal/firebase_auth/zzah;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private zzjp:Lcom/google/android/gms/internal/firebase_auth/zzal;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getUserList"
        id = 0x2
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzai;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzai;-><init>()V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzah;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    return-void
.end method

.method constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzal;)V
    .locals 0
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzal;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    if-nez p1, :cond_0

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzal;

    invoke-direct {p1}, Lcom/google/android/gms/internal/firebase_auth/zzal;-><init>()V

    goto :goto_0

    :cond_0
    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzal;->zza(Lcom/google/android/gms/internal/firebase_auth/zzal;)Lcom/google/android/gms/internal/firebase_auth/zzal;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzah;->zzjp:Lcom/google/android/gms/internal/firebase_auth/zzal;

    return-void
.end method


# virtual methods
.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 4

    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzah;->zzjp:Lcom/google/android/gms/internal/firebase_auth/zzal;

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {p1, v2, v1, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgt;)Lcom/google/firebase/auth/api/internal/zzcg;
    .locals 1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    :goto_0
    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzah;->zzjp:Lcom/google/android/gms/internal/firebase_auth/zzal;

    return-object p0

    :cond_0
    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzal;->zza(Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;)Lcom/google/android/gms/internal/firebase_auth/zzal;

    move-result-object p1

    goto :goto_0

    return-object p0
.end method

.method public final zzag()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;",
            ">;"
        }
    .end annotation

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;

    return-object v0
.end method

.method public final zzas()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/google/android/gms/internal/firebase_auth/zzaj;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzah;->zzjp:Lcom/google/android/gms/internal/firebase_auth/zzal;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzal;->zzas()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
