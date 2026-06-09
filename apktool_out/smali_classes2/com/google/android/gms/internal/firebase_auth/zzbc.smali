.class public final Lcom/google/android/gms/internal/firebase_auth/zzbc;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzcg;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzcg<",
        "Lcom/google/android/gms/internal/firebase_auth/zzbc;",
        "Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;",
        ">;"
    }
.end annotation


# instance fields
.field private zzaf:Ljava/lang/String;

.field private zzah:Ljava/lang/String;

.field private zzai:Ljava/lang/String;

.field private zzaj:J

.field private zzbh:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getIdToken()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbc;->zzaf:Ljava/lang/String;

    return-object v0
.end method

.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgt;)Lcom/google/firebase/auth/api/internal/zzcg;
    .locals 2

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;->zzaf:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbc;->zzaf:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;->zzbh:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbc;->zzbh:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;->zzah:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbc;->zzah:Ljava/lang/String;

    iget-object v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;->zzai:Ljava/lang/String;

    invoke-static {v0}, Lcom/google/android/gms/common/util/Strings;->emptyToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbc;->zzai:Ljava/lang/String;

    iget-wide v0, p1, Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;->zzaj:J

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbc;->zzaj:J

    return-object p0
.end method

.method public final zzag()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;",
            ">;"
        }
    .end annotation

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzf;

    return-object v0
.end method

.method public final zzap()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbc;->zzai:Ljava/lang/String;

    return-object v0
.end method

.method public final zzaq()J
    .locals 2

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbc;->zzaj:J

    return-wide v0
.end method
