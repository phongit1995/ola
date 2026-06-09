.class final Lcom/google/firebase/auth/internal/zzu;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/tasks/OnFailureListener;


# instance fields
.field private final synthetic zzln:Lcom/google/firebase/auth/internal/zzt;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/internal/zzt;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/internal/zzu;->zzln:Lcom/google/firebase/auth/internal/zzt;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onFailure(Ljava/lang/Exception;)V
    .locals 2
    .param p1    # Ljava/lang/Exception;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    instance-of p1, p1, Lcom/google/firebase/FirebaseNetworkException;

    if-eqz p1, :cond_0

    invoke-static {}, Lcom/google/firebase/auth/internal/zzs;->zzbk()Lcom/google/android/gms/common/logging/Logger;

    move-result-object p1

    const-string v0, "Failure to refresh token; scheduling refresh after failure"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/common/logging/Logger;->v(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/google/firebase/auth/internal/zzu;->zzln:Lcom/google/firebase/auth/internal/zzt;

    iget-object p1, p1, Lcom/google/firebase/auth/internal/zzt;->zzlm:Lcom/google/firebase/auth/internal/zzs;

    invoke-virtual {p1}, Lcom/google/firebase/auth/internal/zzs;->zzbj()V

    :cond_0
    return-void
.end method
