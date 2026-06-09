.class public final Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;
.super Lcom/google/android/gms/internal/firebase_auth/zzgn;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/internal/firebase_auth/zzg;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "zzc"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/firebase_auth/zzgn<",
        "Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;",
        ">;"
    }
.end annotation


# instance fields
.field public zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

.field private zzw:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzw:Ljava/lang/String;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzu;->zzd()[Lcom/google/android/gms/internal/firebase_auth/zzu;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzya:I

    return-void
.end method


# virtual methods
.method public final synthetic zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;)Lcom/google/android/gms/internal/firebase_auth/zzgt;
    .locals 4

    :cond_0
    :goto_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    move-result v0

    if-eqz v0, :cond_6

    const/16 v1, 0xa

    if-eq v0, v1, :cond_5

    const/16 v1, 0x12

    if-eq v0, v1, :cond_1

    invoke-super {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :cond_1
    invoke-static {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgw;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgk;I)I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    const/4 v2, 0x0

    if-nez v1, :cond_2

    const/4 v1, 0x0

    goto :goto_1

    :cond_2
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    array-length v1, v1

    :goto_1
    add-int/2addr v0, v1

    new-array v0, v0, [Lcom/google/android/gms/internal/firebase_auth/zzu;

    if-eqz v1, :cond_3

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    invoke-static {v3, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :cond_3
    :goto_2
    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_4

    new-instance v2, Lcom/google/android/gms/internal/firebase_auth/zzu;

    invoke-direct {v2}, Lcom/google/android/gms/internal/firebase_auth/zzu;-><init>()V

    aput-object v2, v0, v1

    aget-object v2, v0, v1

    invoke-virtual {p1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgt;)V

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzcc()I

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_4
    new-instance v2, Lcom/google/android/gms/internal/firebase_auth/zzu;

    invoke-direct {v2}, Lcom/google/android/gms/internal/firebase_auth/zzu;-><init>()V

    aput-object v2, v0, v1

    aget-object v1, v0, v1

    invoke-virtual {p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzgt;)V

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    goto :goto_0

    :cond_5
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzgk;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzw:Ljava/lang/String;

    goto :goto_0

    :cond_6
    return-object p0
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V
    .locals 3

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzw:Ljava/lang/String;

    const/4 v1, 0x1

    invoke-virtual {p1, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILjava/lang/String;)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    array-length v0, v0

    if-lez v0, :cond_1

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    aget-object v1, v1, v0

    if-eqz v1, :cond_0

    const/4 v2, 0x2

    invoke-virtual {p1, v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zza(ILcom/google/android/gms/internal/firebase_auth/zzgt;)V

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    invoke-super {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zza(Lcom/google/android/gms/internal/firebase_auth/zzgl;)V

    return-void
.end method

.method protected final zzb()I
    .locals 4

    invoke-super {p0}, Lcom/google/android/gms/internal/firebase_auth/zzgn;->zzb()I

    move-result v0

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzw:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-static {v2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    array-length v1, v1

    if-lez v1, :cond_1

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    array-length v2, v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzg$zzc;->zzan:[Lcom/google/android/gms/internal/firebase_auth/zzu;

    aget-object v2, v2, v1

    if-eqz v2, :cond_0

    const/4 v3, 0x2

    invoke-static {v3, v2}, Lcom/google/android/gms/internal/firebase_auth/zzgl;->zzb(ILcom/google/android/gms/internal/firebase_auth/zzgt;)I

    move-result v2

    add-int/2addr v0, v2

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return v0
.end method
