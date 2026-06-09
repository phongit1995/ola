.class public abstract Lcom/google/android/gms/internal/firebase_auth/zzci;
.super Lcom/google/android/gms/internal/firebase_auth/zzbt;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/android/gms/internal/firebase_auth/zzci$zze;,
        Lcom/google/android/gms/internal/firebase_auth/zzci$zzd;,
        Lcom/google/android/gms/internal/firebase_auth/zzci$zzb;,
        Lcom/google/android/gms/internal/firebase_auth/zzci$zza;,
        Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;
    }
.end annotation


# static fields
.field private static final logger:Ljava/util/logging/Logger;

.field private static final zznf:Z


# instance fields
.field zzng:Lcom/google/android/gms/internal/firebase_auth/zzck;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzci;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzci;->logger:Ljava/util/logging/Logger;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzgc()Z

    move-result v0

    sput-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzci;->zznf:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbt;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzcj;)V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;-><init>()V

    return-void
.end method

.method public static zza(ILcom/google/android/gms/internal/firebase_auth/zzdo;)I
    .locals 1

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzdq()I

    move-result p1

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result v0

    add-int/2addr v0, p1

    add-int/2addr p0, v0

    return p0
.end method

.method public static zza(Lcom/google/android/gms/internal/firebase_auth/zzdo;)I
    .locals 1

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzdo;->zzdq()I

    move-result p0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result v0

    add-int/2addr v0, p0

    return v0
.end method

.method public static zza(Ljava/nio/ByteBuffer;)Lcom/google/android/gms/internal/firebase_auth/zzci;
    .locals 1

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->hasArray()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzci$zzb;

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzb;-><init>(Ljava/nio/ByteBuffer;)V

    return-object v0

    :cond_0
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->isReadOnly()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzgd()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;-><init>(Ljava/nio/ByteBuffer;)V

    return-object v0

    :cond_1
    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzci$zzd;

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzd;-><init>(Ljava/nio/ByteBuffer;)V

    return-object v0

    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "ByteBuffer is read-only"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static zzaa(I)I
    .locals 0

    shl-int/lit8 p0, p0, 0x3

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result p0

    return p0
.end method

.method public static zzab(I)I
    .locals 0

    if-ltz p0, :cond_0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result p0

    return p0

    :cond_0
    const/16 p0, 0xa

    return p0
.end method

.method public static zzac(I)I
    .locals 1

    and-int/lit8 v0, p0, -0x80

    if-nez v0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    and-int/lit16 v0, p0, -0x4000

    if-nez v0, :cond_1

    const/4 p0, 0x2

    return p0

    :cond_1
    const/high16 v0, -0x200000

    and-int/2addr v0, p0

    if-nez v0, :cond_2

    const/4 p0, 0x3

    return p0

    :cond_2
    const/high16 v0, -0x10000000

    and-int/2addr p0, v0

    if-nez p0, :cond_3

    const/4 p0, 0x4

    return p0

    :cond_3
    const/4 p0, 0x5

    return p0
.end method

.method public static zzad(I)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzah(I)I

    move-result p0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result p0

    return p0
.end method

.method public static zzae(I)I
    .locals 0

    const/4 p0, 0x4

    return p0
.end method

.method public static zzaf(I)I
    .locals 0

    const/4 p0, 0x4

    return p0
.end method

.method public static zzag(I)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzab(I)I

    move-result p0

    return p0
.end method

.method private static zzah(I)I
    .locals 1

    shl-int/lit8 v0, p0, 0x1

    shr-int/lit8 p0, p0, 0x1f

    xor-int/2addr p0, v0

    return p0
.end method

.method public static zzai(I)I
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result p0

    return p0
.end method

.method public static zzam(Ljava/lang/String;)I
    .locals 1

    :try_start_0
    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzfx;->zza(Ljava/lang/CharSequence;)I

    move-result v0
    :try_end_0
    .catch Lcom/google/android/gms/internal/firebase_auth/zzga; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdd;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    array-length v0, p0

    :goto_0
    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result p0

    add-int/2addr p0, v0

    return p0
.end method

.method public static zzb(D)I
    .locals 0

    const/16 p0, 0x8

    return p0
.end method

.method public static zzb(F)I
    .locals 0

    const/4 p0, 0x4

    return p0
.end method

.method public static zzb(ID)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    add-int/lit8 p0, p0, 0x8

    return p0
.end method

.method public static zzb(IF)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    add-int/lit8 p0, p0, 0x4

    return p0
.end method

.method public static zzb(ILcom/google/android/gms/internal/firebase_auth/zzdo;)I
    .locals 2

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result v1

    shl-int/lit8 v0, v1, 0x1

    const/4 v1, 0x2

    invoke-static {v1, p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzh(II)I

    move-result p0

    add-int/2addr v0, p0

    const/4 p0, 0x3

    invoke-static {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(ILcom/google/android/gms/internal/firebase_auth/zzdo;)I

    move-result p0

    add-int/2addr v0, p0

    return v0
.end method

.method static zzb(ILcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method public static zzb(ILjava/lang/String;)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzam(Ljava/lang/String;)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method public static zzb(Lcom/google/android/gms/internal/firebase_auth/zzbu;)I
    .locals 1

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->size()I

    move-result p0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result v0

    add-int/2addr v0, p0

    return v0
.end method

.method static zzb(Lcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)I
    .locals 2

    check-cast p0, Lcom/google/android/gms/internal/firebase_auth/zzbn;

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbn;->zzbp()I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    invoke-interface {p1, p0}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zzo(Ljava/lang/Object;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzbn;->zzg(I)V

    :cond_0
    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result p0

    add-int/2addr p0, v0

    return p0
.end method

.method public static zzb([B)Lcom/google/android/gms/internal/firebase_auth/zzci;
    .locals 3

    array-length v0, p0

    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzci$zza;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci$zza;-><init>([BII)V

    return-object v1
.end method

.method public static zzc(ILcom/google/android/gms/internal/firebase_auth/zzbu;)I
    .locals 1

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->size()I

    move-result p1

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result v0

    add-int/2addr v0, p1

    add-int/2addr p0, v0

    return p0
.end method

.method public static zzc(ILcom/google/android/gms/internal/firebase_auth/zzeh;)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzc(Lcom/google/android/gms/internal/firebase_auth/zzeh;)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method static zzc(ILcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)I
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    shl-int/lit8 p0, p0, 0x1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzbn;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbn;->zzbp()I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    invoke-interface {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zzo(Ljava/lang/Object;)I

    move-result v0

    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzbn;->zzg(I)V

    :cond_0
    add-int/2addr p0, v0

    return p0
.end method

.method public static zzc(IZ)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    add-int/lit8 p0, p0, 0x1

    return p0
.end method

.method public static zzc(Lcom/google/android/gms/internal/firebase_auth/zzeh;)I
    .locals 1

    invoke-interface {p0}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzdq()I

    move-result p0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result v0

    add-int/2addr v0, p0

    return v0
.end method

.method public static zzc([B)I
    .locals 1

    array-length p0, p0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result v0

    add-int/2addr v0, p0

    return v0
.end method

.method public static zzd(IJ)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zze(J)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method public static zzd(ILcom/google/android/gms/internal/firebase_auth/zzbu;)I
    .locals 2

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result v1

    shl-int/lit8 v0, v1, 0x1

    const/4 v1, 0x2

    invoke-static {v1, p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzh(II)I

    move-result p0

    add-int/2addr v0, p0

    const/4 p0, 0x3

    invoke-static {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzc(ILcom/google/android/gms/internal/firebase_auth/zzbu;)I

    move-result p0

    add-int/2addr v0, p0

    return v0
.end method

.method public static zzd(ILcom/google/android/gms/internal/firebase_auth/zzeh;)I
    .locals 2

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result v1

    shl-int/lit8 v0, v1, 0x1

    const/4 v1, 0x2

    invoke-static {v1, p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzh(II)I

    move-result p0

    add-int/2addr v0, p0

    const/4 p0, 0x3

    invoke-static {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzc(ILcom/google/android/gms/internal/firebase_auth/zzeh;)I

    move-result p0

    add-int/2addr v0, p0

    return v0
.end method

.method public static zzd(J)I
    .locals 0

    invoke-static {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zze(J)I

    move-result p0

    return p0
.end method

.method public static zzd(Lcom/google/android/gms/internal/firebase_auth/zzeh;)I
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-interface {p0}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzdq()I

    move-result p0

    return p0
.end method

.method static synthetic zzdd()Z
    .locals 1

    sget-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzci;->zznf:Z

    return v0
.end method

.method public static zze(IJ)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zze(J)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method public static zze(J)I
    .locals 7

    const-wide/16 v0, -0x80

    and-long v2, p0, v0

    const-wide/16 v0, 0x0

    cmp-long v4, v2, v0

    if-nez v4, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    cmp-long v2, p0, v0

    if-gez v2, :cond_1

    const/16 p0, 0xa

    return p0

    :cond_1
    const-wide v2, -0x800000000L

    and-long v4, p0, v2

    cmp-long v2, v4, v0

    if-eqz v2, :cond_2

    const/4 v2, 0x6

    const/16 v3, 0x1c

    ushr-long/2addr p0, v3

    goto :goto_0

    :cond_2
    const/4 v2, 0x2

    :goto_0
    const-wide/32 v3, -0x200000

    and-long v5, p0, v3

    cmp-long v3, v5, v0

    if-eqz v3, :cond_3

    add-int/lit8 v2, v2, 0x2

    const/16 v3, 0xe

    ushr-long/2addr p0, v3

    :cond_3
    const-wide/16 v3, -0x4000

    and-long v5, p0, v3

    cmp-long p0, v5, v0

    if-eqz p0, :cond_4

    add-int/lit8 v2, v2, 0x1

    :cond_4
    return v2
.end method

.method public static zzf(IJ)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzi(J)J

    move-result-wide p1

    invoke-static {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zze(J)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method public static zzf(J)I
    .locals 0

    invoke-static {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzi(J)J

    move-result-wide p0

    invoke-static {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zze(J)I

    move-result p0

    return p0
.end method

.method public static zzg(II)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzab(I)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method public static zzg(IJ)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    add-int/lit8 p0, p0, 0x8

    return p0
.end method

.method public static zzg(J)I
    .locals 0

    const/16 p0, 0x8

    return p0
.end method

.method public static zzg(Z)I
    .locals 0

    const/4 p0, 0x1

    return p0
.end method

.method public static zzh(II)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method public static zzh(IJ)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    add-int/lit8 p0, p0, 0x8

    return p0
.end method

.method public static zzh(J)I
    .locals 0

    const/16 p0, 0x8

    return p0
.end method

.method public static zzi(II)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzah(I)I

    move-result p1

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzac(I)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method

.method private static zzi(J)J
    .locals 4

    const/4 v0, 0x1

    shl-long v0, p0, v0

    const/16 v2, 0x3f

    shr-long/2addr p0, v2

    xor-long v2, v0, p0

    return-wide v2
.end method

.method public static zzj(II)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    add-int/lit8 p0, p0, 0x4

    return p0
.end method

.method public static zzk(II)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    add-int/lit8 p0, p0, 0x4

    return p0
.end method

.method public static zzl(II)I
    .locals 0

    invoke-static {p0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzaa(I)I

    move-result p0

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzab(I)I

    move-result p1

    add-int/2addr p0, p1

    return p0
.end method


# virtual methods
.method public abstract flush()V
.end method

.method public abstract write([BII)V
.end method

.method public abstract zza(B)V
.end method

.method public final zza(D)V
    .locals 0

    invoke-static {p1, p2}, Ljava/lang/Double;->doubleToRawLongBits(D)J

    move-result-wide p1

    invoke-virtual {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzc(J)V

    return-void
.end method

.method public final zza(F)V
    .locals 0

    invoke-static {p1}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result p1

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzz(I)V

    return-void
.end method

.method public final zza(ID)V
    .locals 0

    invoke-static {p2, p3}, Ljava/lang/Double;->doubleToRawLongBits(D)J

    move-result-wide p2

    invoke-virtual {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzc(IJ)V

    return-void
.end method

.method public final zza(IF)V
    .locals 0

    invoke-static {p2}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result p2

    invoke-virtual {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzf(II)V

    return-void
.end method

.method public abstract zza(IJ)V
.end method

.method public abstract zza(ILcom/google/android/gms/internal/firebase_auth/zzbu;)V
.end method

.method public abstract zza(ILcom/google/android/gms/internal/firebase_auth/zzeh;)V
.end method

.method abstract zza(ILcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)V
.end method

.method public abstract zza(ILjava/lang/String;)V
.end method

.method public abstract zza(J)V
.end method

.method public abstract zza(Lcom/google/android/gms/internal/firebase_auth/zzbu;)V
.end method

.method abstract zza(Lcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)V
.end method

.method final zza(Ljava/lang/String;Lcom/google/android/gms/internal/firebase_auth/zzga;)V
    .locals 6

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzci;->logger:Ljava/util/logging/Logger;

    sget-object v1, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v2, "com.google.protobuf.CodedOutputStream"

    const-string v3, "inefficientWriteStringNoTag"

    const-string v4, "Converting ill-formed UTF-16. Your Protocol Buffer will not round trip correctly!"

    move-object v5, p2

    invoke-virtual/range {v0 .. v5}, Ljava/util/logging/Logger;->logp(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    sget-object p2, Lcom/google/android/gms/internal/firebase_auth/zzdd;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, p2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    :try_start_0
    array-length p2, p1

    invoke-virtual {p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    const/4 p2, 0x0

    array-length v0, p1

    invoke-virtual {p0, p1, p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzbt;->zza([BII)V
    :try_end_0
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/google/android/gms/internal/firebase_auth/zzci$zzc; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    throw p1

    :catch_1
    move-exception p1

    new-instance p2, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;

    invoke-direct {p2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;-><init>(Ljava/lang/Throwable;)V

    throw p2
.end method

.method public abstract zzal(Ljava/lang/String;)V
.end method

.method public abstract zzb(II)V
.end method

.method public final zzb(IJ)V
    .locals 0

    invoke-static {p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzi(J)J

    move-result-wide p2

    invoke-virtual {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(IJ)V

    return-void
.end method

.method public abstract zzb(ILcom/google/android/gms/internal/firebase_auth/zzbu;)V
.end method

.method public abstract zzb(ILcom/google/android/gms/internal/firebase_auth/zzeh;)V
.end method

.method public abstract zzb(IZ)V
.end method

.method public final zzb(J)V
    .locals 0

    invoke-static {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzi(J)J

    move-result-wide p1

    invoke-virtual {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(J)V

    return-void
.end method

.method public abstract zzb(Lcom/google/android/gms/internal/firebase_auth/zzeh;)V
.end method

.method public abstract zzc(II)V
.end method

.method public abstract zzc(IJ)V
.end method

.method public abstract zzc(J)V
.end method

.method public abstract zzd(II)V
.end method

.method public abstract zzdc()I
.end method

.method public final zze(II)V
    .locals 0

    invoke-static {p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzah(I)I

    move-result p2

    invoke-virtual {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzd(II)V

    return-void
.end method

.method abstract zze([BII)V
.end method

.method public abstract zzf(II)V
.end method

.method public final zzf(Z)V
    .locals 0

    int-to-byte p1, p1

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(B)V

    return-void
.end method

.method public abstract zzw(I)V
.end method

.method public abstract zzx(I)V
.end method

.method public final zzy(I)V
    .locals 0

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzah(I)I

    move-result p1

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    return-void
.end method

.method public abstract zzz(I)V
.end method
