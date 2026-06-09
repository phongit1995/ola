.class final Lcom/google/android/gms/internal/firebase_auth/zzci$zze;
.super Lcom/google/android/gms/internal/firebase_auth/zzci;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/internal/firebase_auth/zzci;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "zze"
.end annotation


# instance fields
.field private final zznj:Ljava/nio/ByteBuffer;

.field private final zznk:Ljava/nio/ByteBuffer;

.field private final zznl:J

.field private final zznm:J

.field private final zznn:J

.field private final zzno:J

.field private zznp:J


# direct methods
.method constructor <init>(Ljava/nio/ByteBuffer;)V
    .locals 6

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzcj;)V

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznj:Ljava/nio/ByteBuffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    sget-object v1, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznk:Ljava/nio/ByteBuffer;

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznl:J

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznl:J

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v2

    int-to-long v2, v2

    add-long v4, v0, v2

    iput-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznm:J

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznl:J

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->limit()I

    move-result p1

    int-to-long v2, p1

    add-long v4, v0, v2

    iput-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    const-wide/16 v2, 0xa

    sub-long v4, v0, v2

    iput-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zzno:J

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznm:J

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    return-void
.end method

.method private final zzj(J)V
    .locals 5

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznk:Ljava/nio/ByteBuffer;

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznl:J

    sub-long v3, p1, v1

    long-to-int p1, v3

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    return-void
.end method


# virtual methods
.method public final flush()V
    .locals 7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznj:Ljava/nio/ByteBuffer;

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznl:J

    sub-long v5, v1, v3

    long-to-int v1, v5

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    return-void
.end method

.method public final write([BII)V
    .locals 11

    if-eqz p1, :cond_1

    if-ltz p2, :cond_1

    if-ltz p3, :cond_1

    array-length v0, p1

    sub-int/2addr v0, p3

    if-lt v0, p2, :cond_1

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    int-to-long v9, p3

    sub-long v2, v0, v9

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    cmp-long v4, v2, v0

    if-gez v4, :cond_0

    goto :goto_0

    :cond_0
    int-to-long v3, p2

    iget-wide v5, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    move-object v2, p1

    move-wide v7, v9

    invoke-static/range {v2 .. v8}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza([BJJJ)V

    iget-wide p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    add-long v0, p1, v9

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    return-void

    :cond_1
    :goto_0
    if-nez p1, :cond_2

    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "value"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_2
    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;

    const-string p2, "Pos: %d, limit: %d, len: %d"

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    aput-object v2, v0, v1

    const/4 v1, 0x1

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    aput-object v2, v0, v1

    const/4 v1, 0x2

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    aput-object p3, v0, v1

    invoke-static {p2, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public final zza(B)V
    .locals 6

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    cmp-long v4, v0, v2

    if-ltz v4, :cond_0

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;

    const-string v0, "Pos: %d, limit: %d, len: %d"

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    aput-object v3, v1, v2

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const/4 v3, 0x1

    aput-object v2, v1, v3

    const/4 v2, 0x2

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    const-wide/16 v2, 0x1

    add-long v4, v0, v2

    iput-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    invoke-static {v0, v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(JB)V

    return-void
.end method

.method public final zza(IJ)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(J)V

    return-void
.end method

.method public final zza(ILcom/google/android/gms/internal/firebase_auth/zzbu;)V
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbu;)V

    return-void
.end method

.method public final zza(ILcom/google/android/gms/internal/firebase_auth/zzeh;)V
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzeh;)V

    return-void
.end method

.method final zza(ILcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)V
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(Lcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)V

    return-void
.end method

.method public final zza(ILjava/lang/String;)V
    .locals 1

    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzal(Ljava/lang/String;)V

    return-void
.end method

.method public final zza(J)V
    .locals 12

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zzno:J

    cmp-long v4, v0, v2

    const/4 v0, 0x7

    const-wide/16 v1, 0x0

    const-wide/16 v5, -0x80

    const-wide/16 v7, 0x1

    if-gtz v4, :cond_1

    :goto_0
    and-long v3, p1, v5

    cmp-long v9, v3, v1

    if-nez v9, :cond_0

    :goto_1
    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    add-long v2, v0, v7

    iput-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    long-to-int p1, p1

    int-to-byte p1, p1

    invoke-static {v0, v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(JB)V

    return-void

    :cond_0
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    add-long v9, v3, v7

    iput-wide v9, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    long-to-int v9, p1

    and-int/lit8 v9, v9, 0x7f

    or-int/lit16 v9, v9, 0x80

    int-to-byte v9, v9

    invoke-static {v3, v4, v9}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(JB)V

    ushr-long/2addr p1, v0

    goto :goto_0

    :cond_1
    :goto_2
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v9, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    cmp-long v11, v3, v9

    if-gez v11, :cond_3

    and-long v3, p1, v5

    cmp-long v9, v3, v1

    if-nez v9, :cond_2

    goto :goto_1

    :cond_2
    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    add-long v9, v3, v7

    iput-wide v9, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    long-to-int v9, p1

    and-int/lit8 v9, v9, 0x7f

    or-int/lit16 v9, v9, 0x80

    int-to-byte v9, v9

    invoke-static {v3, v4, v9}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(JB)V

    ushr-long/2addr p1, v0

    goto :goto_2

    :cond_3
    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;

    const-string p2, "Pos: %d, limit: %d, len: %d"

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    aput-object v2, v0, v1

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    const/4 v1, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-static {p2, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzbu;)V
    .locals 1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->size()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    invoke-virtual {p1, p0}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbt;)V

    return-void
.end method

.method final zza(Lcom/google/android/gms/internal/firebase_auth/zzeh;Lcom/google/android/gms/internal/firebase_auth/zzev;)V
    .locals 3

    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzbn;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzbn;->zzbp()I

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    invoke-interface {p2, v0}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zzo(Ljava/lang/Object;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzbn;->zzg(I)V

    :cond_0
    invoke-virtual {p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zzng:Lcom/google/android/gms/internal/firebase_auth/zzck;

    invoke-interface {p2, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzev;->zza(Ljava/lang/Object;Lcom/google/android/gms/internal/firebase_auth/zzgj;)V

    return-void
.end method

.method public final zza([BII)V
    .locals 0

    invoke-virtual {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->write([BII)V

    return-void
.end method

.method public final zzal(Ljava/lang/String;)V
    .locals 10

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    mul-int/lit8 v2, v2, 0x3

    invoke-static {v2}, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zzac(I)I

    move-result v2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    invoke-static {v3}, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zzac(I)I

    move-result v3

    if-ne v3, v2, :cond_0

    iget-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznl:J

    const/4 v2, 0x0

    sub-long v8, v4, v6

    long-to-int v2, v8

    add-int/2addr v2, v3

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznk:Ljava/nio/ByteBuffer;

    invoke-virtual {v3, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznk:Ljava/nio/ByteBuffer;

    invoke-static {p1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzfx;->zza(Ljava/lang/CharSequence;Ljava/nio/ByteBuffer;)V

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznk:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    sub-int/2addr v3, v2

    invoke-virtual {p0, v3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    iget-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    int-to-long v2, v3

    add-long v6, v4, v2

    iput-wide v6, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    return-void

    :cond_0
    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzfx;->zza(Ljava/lang/CharSequence;)I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    invoke-direct {p0, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zzj(J)V

    iget-object v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznk:Ljava/nio/ByteBuffer;

    invoke-static {p1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzfx;->zza(Ljava/lang/CharSequence;Ljava/nio/ByteBuffer;)V

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    int-to-long v5, v2

    add-long v7, v3, v5

    iput-wide v7, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J
    :try_end_0
    .catch Lcom/google/android/gms/internal/firebase_auth/zzga; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;

    invoke-direct {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;-><init>(Ljava/lang/Throwable;)V

    throw v0

    :catch_1
    move-exception p1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;

    invoke-direct {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;-><init>(Ljava/lang/Throwable;)V

    throw v0

    :catch_2
    move-exception v2

    iput-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    invoke-direct {p0, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zzj(J)V

    invoke-virtual {p0, p1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(Ljava/lang/String;Lcom/google/android/gms/internal/firebase_auth/zzga;)V

    return-void
.end method

.method public final zzb(II)V
    .locals 0

    shl-int/lit8 p1, p1, 0x3

    or-int/2addr p1, p2

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    return-void
.end method

.method public final zzb(ILcom/google/android/gms/internal/firebase_auth/zzbu;)V
    .locals 3

    const/4 v0, 0x3

    const/4 v1, 0x1

    invoke-virtual {p0, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    const/4 v2, 0x2

    invoke-virtual {p0, v2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzd(II)V

    invoke-virtual {p0, v0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(ILcom/google/android/gms/internal/firebase_auth/zzbu;)V

    const/4 p1, 0x4

    invoke-virtual {p0, v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    return-void
.end method

.method public final zzb(ILcom/google/android/gms/internal/firebase_auth/zzeh;)V
    .locals 3

    const/4 v0, 0x3

    const/4 v1, 0x1

    invoke-virtual {p0, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    const/4 v2, 0x2

    invoke-virtual {p0, v2, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzd(II)V

    invoke-virtual {p0, v0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(ILcom/google/android/gms/internal/firebase_auth/zzeh;)V

    const/4 p1, 0x4

    invoke-virtual {p0, v1, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    return-void
.end method

.method public final zzb(IZ)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    int-to-byte p1, p2

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(B)V

    return-void
.end method

.method public final zzb(Lcom/google/android/gms/internal/firebase_auth/zzeh;)V
    .locals 1

    invoke-interface {p1}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzdq()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    invoke-interface {p1, p0}, Lcom/google/android/gms/internal/firebase_auth/zzeh;->zzb(Lcom/google/android/gms/internal/firebase_auth/zzci;)V

    return-void
.end method

.method public final zzc(II)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzw(I)V

    return-void
.end method

.method public final zzc(IJ)V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzc(J)V

    return-void
.end method

.method public final zzc(J)V
    .locals 7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznk:Ljava/nio/ByteBuffer;

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznl:J

    sub-long v5, v1, v3

    long-to-int v1, v5

    invoke-virtual {v0, v1, p1, p2}, Ljava/nio/ByteBuffer;->putLong(IJ)Ljava/nio/ByteBuffer;

    iget-wide p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    const-wide/16 v0, 0x8

    add-long v2, p1, v0

    iput-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    return-void
.end method

.method public final zzd(II)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    return-void
.end method

.method public final zzdc()I
    .locals 6

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    sub-long v4, v0, v2

    long-to-int v0, v4

    return v0
.end method

.method public final zze([BII)V
    .locals 0

    invoke-virtual {p0, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    const/4 p2, 0x0

    invoke-virtual {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzci;->write([BII)V

    return-void
.end method

.method public final zzf(II)V
    .locals 1

    const/4 v0, 0x5

    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzb(II)V

    invoke-virtual {p0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzz(I)V

    return-void
.end method

.method public final zzw(I)V
    .locals 2

    if-ltz p1, :cond_0

    invoke-virtual {p0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zzx(I)V

    return-void

    :cond_0
    int-to-long v0, p1

    invoke-virtual {p0, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzci;->zza(J)V

    return-void
.end method

.method public final zzx(I)V
    .locals 7

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zzno:J

    cmp-long v4, v0, v2

    const-wide/16 v0, 0x1

    if-gtz v4, :cond_1

    :goto_0
    and-int/lit8 v2, p1, -0x80

    if-nez v2, :cond_0

    :goto_1
    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    add-long v4, v2, v0

    iput-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    int-to-byte p1, p1

    invoke-static {v2, v3, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(JB)V

    return-void

    :cond_0
    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    add-long v4, v2, v0

    iput-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    and-int/lit8 v4, p1, 0x7f

    or-int/lit16 v4, v4, 0x80

    int-to-byte v4, v4

    invoke-static {v2, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(JB)V

    ushr-int/lit8 p1, p1, 0x7

    goto :goto_0

    :cond_1
    :goto_2
    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    cmp-long v6, v2, v4

    if-gez v6, :cond_3

    and-int/lit8 v2, p1, -0x80

    if-nez v2, :cond_2

    goto :goto_1

    :cond_2
    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    add-long v4, v2, v0

    iput-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    and-int/lit8 v4, p1, 0x7f

    or-int/lit16 v4, v4, 0x80

    int-to-byte v4, v4

    invoke-static {v2, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(JB)V

    ushr-int/lit8 p1, p1, 0x7

    goto :goto_2

    :cond_3
    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;

    const-string v0, "Pos: %d, limit: %d, len: %d"

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    aput-object v3, v1, v2

    iget-wide v2, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznn:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const/4 v3, 0x1

    aput-object v2, v1, v3

    const/4 v2, 0x2

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzci$zzc;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public final zzz(I)V
    .locals 7

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznk:Ljava/nio/ByteBuffer;

    iget-wide v1, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    iget-wide v3, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznl:J

    sub-long v5, v1, v3

    long-to-int v1, v5

    invoke-virtual {v0, v1, p1}, Ljava/nio/ByteBuffer;->putInt(II)Ljava/nio/ByteBuffer;

    iget-wide v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    const-wide/16 v2, 0x4

    add-long v4, v0, v2

    iput-wide v4, p0, Lcom/google/android/gms/internal/firebase_auth/zzci$zze;->zznp:J

    return-void
.end method
