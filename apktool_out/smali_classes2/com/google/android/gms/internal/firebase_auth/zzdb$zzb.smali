.class public final Lcom/google/android/gms/internal/firebase_auth/zzdb$zzb;
.super Lcom/google/android/gms/internal/firebase_auth/zzbp;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/internal/firebase_auth/zzdb;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "zzb"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/google/android/gms/internal/firebase_auth/zzdb<",
        "TT;*>;>",
        "Lcom/google/android/gms/internal/firebase_auth/zzbp<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private zzra:Lcom/google/android/gms/internal/firebase_auth/zzdb;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzdb;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbp;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zzb;->zzra:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    return-void
.end method


# virtual methods
.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzcd;Lcom/google/android/gms/internal/firebase_auth/zzco;)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zzb;->zzra:Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-static {v0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzdb;->zza(Lcom/google/android/gms/internal/firebase_auth/zzdb;Lcom/google/android/gms/internal/firebase_auth/zzcd;Lcom/google/android/gms/internal/firebase_auth/zzco;)Lcom/google/android/gms/internal/firebase_auth/zzdb;

    move-result-object p1

    return-object p1
.end method
