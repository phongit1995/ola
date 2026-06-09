.class final Lcom/google/firebase/auth/api/internal/zzai;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<O:",
        "Lcom/google/firebase/auth/api/internal/zzaj;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field public final zzgk:Lcom/google/android/gms/common/api/GoogleApi;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/GoogleApi<",
            "TO;>;"
        }
    .end annotation
.end field

.field public final zzgl:Lcom/google/android/gms/common/api/GoogleApi;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/GoogleApi<",
            "TO;>;"
        }
    .end annotation
.end field

.field public final zzgm:Lcom/google/firebase/auth/api/internal/zzan;


# direct methods
.method public constructor <init>(Lcom/google/android/gms/common/api/GoogleApi;Lcom/google/android/gms/common/api/GoogleApi;Lcom/google/firebase/auth/api/internal/zzan;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/common/api/GoogleApi<",
            "TO;>;",
            "Lcom/google/android/gms/common/api/GoogleApi<",
            "TO;>;",
            "Lcom/google/firebase/auth/api/internal/zzan;",
            ")V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzai;->zzgk:Lcom/google/android/gms/common/api/GoogleApi;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzai;->zzgl:Lcom/google/android/gms/common/api/GoogleApi;

    iput-object p3, p0, Lcom/google/firebase/auth/api/internal/zzai;->zzgm:Lcom/google/firebase/auth/api/internal/zzan;

    return-void
.end method
