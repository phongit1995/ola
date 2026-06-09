.class final Lcom/google/firebase/auth/internal/zzac;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/common/api/internal/BackgroundDetector$BackgroundStateChangeListener;


# instance fields
.field private final synthetic zzlx:Lcom/google/firebase/auth/internal/zzab;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/internal/zzab;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/internal/zzac;->zzlx:Lcom/google/firebase/auth/internal/zzab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onBackgroundStateChanged(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/google/firebase/auth/internal/zzac;->zzlx:Lcom/google/firebase/auth/internal/zzab;

    const/4 v0, 0x1

    invoke-static {p1, v0}, Lcom/google/firebase/auth/internal/zzab;->zza(Lcom/google/firebase/auth/internal/zzab;Z)Z

    iget-object p1, p0, Lcom/google/firebase/auth/internal/zzac;->zzlx:Lcom/google/firebase/auth/internal/zzab;

    invoke-virtual {p1}, Lcom/google/firebase/auth/internal/zzab;->cancel()V

    return-void

    :cond_0
    iget-object p1, p0, Lcom/google/firebase/auth/internal/zzac;->zzlx:Lcom/google/firebase/auth/internal/zzab;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/google/firebase/auth/internal/zzab;->zza(Lcom/google/firebase/auth/internal/zzab;Z)Z

    iget-object p1, p0, Lcom/google/firebase/auth/internal/zzac;->zzlx:Lcom/google/firebase/auth/internal/zzab;

    invoke-static {p1}, Lcom/google/firebase/auth/internal/zzab;->zzb(Lcom/google/firebase/auth/internal/zzab;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/google/firebase/auth/internal/zzac;->zzlx:Lcom/google/firebase/auth/internal/zzab;

    invoke-static {p1}, Lcom/google/firebase/auth/internal/zzab;->zzc(Lcom/google/firebase/auth/internal/zzab;)Lcom/google/firebase/auth/internal/zzs;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/firebase/auth/internal/zzs;->zzbi()V

    :cond_1
    return-void
.end method
