.class public final Lcom/google/android/gms/internal/firebase_auth/zzaf;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdp;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdp<",
        "Lcom/google/android/gms/internal/firebase_auth/zzgz;",
        ">;"
    }
.end annotation


# instance fields
.field private zzjm:Ljava/lang/String;

.field private zzjn:Ljava/lang/String;

.field private final zzjo:Ljava/lang/String;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzaf;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object p2, Lcom/google/android/gms/internal/firebase_auth/zzae;->zzjj:Lcom/google/android/gms/internal/firebase_auth/zzae;

    invoke-virtual {p2}, Lcom/google/android/gms/internal/firebase_auth/zzae;->toString()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzaf;->zzjm:Ljava/lang/String;

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaf;->zzjn:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaf;->zzjo:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final synthetic zzao()Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzgz;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzgz;-><init>()V

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaf;->zzjm:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzgz;->zzjm:Ljava/lang/String;

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzaf;->zzjn:Ljava/lang/String;

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzgz;->zzai:Ljava/lang/String;

    const/4 v1, 0x0

    iput-object v1, v0, Lcom/google/android/gms/internal/firebase_auth/zzgz;->zzjo:Ljava/lang/String;

    return-object v0
.end method
