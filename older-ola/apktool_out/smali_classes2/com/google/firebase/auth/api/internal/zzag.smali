.class final Lcom/google/firebase/auth/api/internal/zzag;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdk;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdk<",
        "Lcom/google/android/gms/internal/firebase_auth/zzao;",
        ">;"
    }
.end annotation


# instance fields
.field private final synthetic zzgi:Lcom/google/firebase/auth/api/internal/zzdk;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzdk;)V
    .locals 0

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzag;->zzgi:Lcom/google/firebase/auth/api/internal/zzdk;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final synthetic onSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1    # Ljava/lang/Object;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzao;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzag;->zzgi:Lcom/google/firebase/auth/api/internal/zzdk;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzdk;->onSuccess(Ljava/lang/Object;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzag;->zzgi:Lcom/google/firebase/auth/api/internal/zzdk;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzdk;->zzc(Ljava/lang/String;)V

    return-void
.end method
