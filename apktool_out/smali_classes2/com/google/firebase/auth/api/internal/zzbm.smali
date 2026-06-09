.class final Lcom/google/firebase/auth/api/internal/zzbm;
.super Lcom/google/firebase/auth/api/internal/zzcy;


# annotations
.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/firebase/auth/api/internal/zzcy<",
        "Ljava/lang/Void;",
        "Lcom/google/firebase/auth/internal/zza;",
        ">;"
    }
.end annotation


# instance fields
.field private zzhc:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    const/16 v0, 0x9

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbm;->zzhc:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final zzaa()V
    .locals 3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbm;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzbm;->zzhc:Ljava/lang/String;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzbm;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2}, Lcom/google/firebase/auth/api/internal/zzck;->zzk(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zzb(Ljava/lang/Object;)V

    return-void
.end method
