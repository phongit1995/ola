.class public final Lcom/google/android/gms/internal/firebase_auth/zzz;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdp;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdp<",
        "Lcom/google/android/gms/internal/firebase_auth/zzi;",
        ">;"
    }
.end annotation


# instance fields
.field private zzaf:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzz;->zzaf:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final synthetic zzao()Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzi;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzi;-><init>()V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzz;->zzaf:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzi;->zzaf:Ljava/lang/String;

    return-object v0
.end method
