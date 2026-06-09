.class public abstract Lcom/google/android/gms/internal/firebase_auth/zzgn;
.super Lcom/google/android/gms/internal/firebase_auth/zzgt;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<M:",
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "TM;>;>",
        "Lcom/google/android/gms/internal/firebase_auth/zzgt;"
    }
.end annotation


# instance fields
.field protected zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgt;-><init>()V

    return-void
.end method


# virtual methods
.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgt;->zzgn()Lcom/google/android/gms/internal/firebase_auth/zzgt;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzgn;

    invoke-static {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgr;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgn;Lcom/google/android/gms/internal/firebase_auth/zzgn;)V

    return-object v0
.end method

.method public zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 2

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzgp;->size()I

    move-result v1

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    invoke-virtual {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgp;->zzbc(I)Lcom/google/android/gms/internal/firebase_auth/zzgq;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgq;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method protected final zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)Z
    .locals 3

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->getPosition()I

    move-result v0

    invoke-virtual {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzn(I)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    ushr-int/lit8 v1, p2, 0x3

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->getPosition()I

    move-result v2

    sub-int/2addr v2, v0

    invoke-virtual {p1, v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzr(II)[B

    move-result-object p1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzgv;

    invoke-direct {v0, p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgv;-><init>(I[B)V

    const/4 p1, 0x0

    iget-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    if-nez p2, :cond_1

    new-instance p2, Lcom/google/android/gms/internal/firebase_auth/zzgp;

    invoke-direct {p2}, Lcom/google/android/gms/internal/firebase_auth/zzgp;-><init>()V

    iput-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    invoke-virtual {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgp;->zzbb(I)Lcom/google/android/gms/internal/firebase_auth/zzgq;

    move-result-object p1

    :goto_0
    if-nez p1, :cond_2

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzgq;

    invoke-direct {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgq;-><init>()V

    iget-object p2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    invoke-virtual {p2, v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgp;->zza(ILcom/google/android/gms/internal/firebase_auth/zzgq;)V

    :cond_2
    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgq;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgv;)V

    const/4 p1, 0x1

    return p1
.end method

.method protected zzb()I
    .locals 3

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    invoke-virtual {v2}, Lcom/google/android/gms/internal/firebase_auth/zzgp;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzxr:Lcom/google/android/gms/internal/firebase_auth/zzgp;

    invoke-virtual {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgp;->zzbc(I)Lcom/google/android/gms/internal/firebase_auth/zzgq;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/android/gms/internal/firebase_auth/zzgq;->zzb()I

    move-result v2

    add-int/2addr v0, v2

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :cond_1
    return v0
.end method

.method public final synthetic zzgn()Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 1

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgt;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzgn;

    return-object v0
.end method
