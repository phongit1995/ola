.class final Lcom/google/firebase/auth/api/internal/zzak;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzan;


# annotations
.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation


# instance fields
.field private final zzgo:I

.field private final zzgp:I

.field private final zzgq:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private final zzgr:Z


# direct methods
.method public constructor <init>(IILjava/util/Map;Z)V
    .locals 0
    .param p3    # Ljava/util/Map;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;Z)V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgo:I

    iput p2, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgp:I

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Map;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgq:Ljava/util/Map;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgr:Z

    return-void
.end method


# virtual methods
.method public final zzd(Lcom/google/firebase/auth/api/internal/zzam;)Z
    .locals 4

    iget-boolean v0, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgr:Z

    const/4 v1, 0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget v0, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgp:I

    iget v2, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgo:I

    const/4 v3, 0x0

    if-gt v0, v2, :cond_1

    return v3

    :cond_1
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgq:Ljava/util/Map;

    invoke-virtual {p1}, Lcom/google/firebase/auth/api/internal/zzam;->zzz()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    if-nez p1, :cond_2

    return v3

    :cond_2
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iget v2, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgo:I

    if-le v0, v2, :cond_3

    iget v0, p0, Lcom/google/firebase/auth/api/internal/zzak;->zzgp:I

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    if-lt v0, p1, :cond_3

    return v1

    :cond_3
    return v3
.end method
