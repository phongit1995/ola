.class final Lcom/google/firebase/auth/api/internal/zzbk;
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
.field private zzdh:Ljava/lang/String;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field

.field private zzhb:Lcom/google/firebase/auth/ActionCodeSettings;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/ActionCodeSettings;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    const/4 v0, 0x6

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    const-string v0, "token cannot be null or empty"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbk;->zzdh:Ljava/lang/String;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzbk;->zzhb:Lcom/google/firebase/auth/ActionCodeSettings;

    return-void
.end method


# virtual methods
.method public final zzaa()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbk;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzbk;->zzdh:Ljava/lang/String;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzbk;->zzhb:Lcom/google/firebase/auth/ActionCodeSettings;

    iget-object v3, p0, Lcom/google/firebase/auth/api/internal/zzbk;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2, v3}, Lcom/google/firebase/auth/api/internal/zzck;->zzb(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zzb(Ljava/lang/Object;)V

    return-void
.end method
