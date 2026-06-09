.class public abstract Lcom/google/android/gms/internal/firebase_auth/zzbu;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;
.implements Ljava/lang/Iterable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/io/Serializable;",
        "Ljava/lang/Iterable<",
        "Ljava/lang/Byte;",
        ">;"
    }
.end annotation


# static fields
.field public static final zzmi:Lcom/google/android/gms/internal/firebase_auth/zzbu;

.field private static final zzmj:Lcom/google/android/gms/internal/firebase_auth/zzby;


# instance fields
.field private zzmk:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzcb;

    sget-object v1, Lcom/google/android/gms/internal/firebase_auth/zzdd;->EMPTY_BYTE_ARRAY:[B

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcb;-><init>([B)V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmi:Lcom/google/android/gms/internal/firebase_auth/zzbu;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzbr;->zzbu()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzcc;

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzcc;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzbv;)V

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbw;

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzbw;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzbv;)V

    :goto_0
    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmj:Lcom/google/android/gms/internal/firebase_auth/zzby;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmk:I

    return-void
.end method

.method static zza([B)Lcom/google/android/gms/internal/firebase_auth/zzbu;
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzcb;

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzcb;-><init>([B)V

    return-object v0
.end method

.method public static zzak(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzbu;
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzcb;

    sget-object v1, Lcom/google/android/gms/internal/firebase_auth/zzdd;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzcb;-><init>([B)V

    return-object v0
.end method

.method static zzb(III)I
    .locals 3

    sub-int v0, p1, p0

    or-int v1, p0, p1

    or-int/2addr v1, v0

    sub-int v2, p2, p1

    or-int/2addr v1, v2

    if-gez v1, :cond_2

    if-gez p0, :cond_0

    new-instance p1, Ljava/lang/IndexOutOfBoundsException;

    const/16 p2, 0x20

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, p2}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string p2, "Beginning index: "

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p0, " < 0"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    if-ge p1, p0, :cond_1

    new-instance p2, Ljava/lang/IndexOutOfBoundsException;

    const/16 v0, 0x42

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v0, "Beginning index larger than ending index: "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p0, ", "

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p2, p0}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw p2

    :cond_1
    new-instance p0, Ljava/lang/IndexOutOfBoundsException;

    const/16 v0, 0x25

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v0, "End index: "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, " >= "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_2
    return v0
.end method

.method public static zzb([BII)Lcom/google/android/gms/internal/firebase_auth/zzbu;
    .locals 2

    add-int v0, p1, p2

    array-length v1, p0

    invoke-static {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzb(III)I

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzcb;

    sget-object v1, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmj:Lcom/google/android/gms/internal/firebase_auth/zzby;

    invoke-interface {v1, p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzby;->zzc([BII)[B

    move-result-object p0

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzcb;-><init>([B)V

    return-object v0
.end method

.method static zzl(I)Lcom/google/android/gms/internal/firebase_auth/zzbz;
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbz;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzbz;-><init>(ILcom/google/android/gms/internal/firebase_auth/zzbv;)V

    return-object v0
.end method


# virtual methods
.method public abstract equals(Ljava/lang/Object;)Z
.end method

.method public final hashCode()I
    .locals 2

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmk:I

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->size()I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zza(III)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :cond_0
    iput v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmk:I

    :cond_1
    return v0
.end method

.method public synthetic iterator()Ljava/util/Iterator;
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbv;

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/firebase_auth/zzbv;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzbu;)V

    return-object v0
.end method

.method public abstract size()I
.end method

.method public final toString()Ljava/lang/String;
    .locals 4

    const-string v0, "<ByteString@%s size=%d>"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    aput-object v2, v1, v3

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->size()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const/4 v3, 0x1

    aput-object v2, v1, v3

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected abstract zza(III)I
.end method

.method public abstract zza(II)Lcom/google/android/gms/internal/firebase_auth/zzbu;
.end method

.method protected abstract zza(Ljava/nio/charset/Charset;)Ljava/lang/String;
.end method

.method abstract zza(Lcom/google/android/gms/internal/firebase_auth/zzbt;)V
.end method

.method public final zzbw()Ljava/lang/String;
    .locals 2

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdd;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->size()I

    move-result v1

    if-nez v1, :cond_0

    const-string v0, ""

    return-object v0

    :cond_0
    invoke-virtual {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zza(Ljava/nio/charset/Charset;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public abstract zzbx()Z
.end method

.method protected final zzby()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzbu;->zzmk:I

    return v0
.end method

.method public abstract zzk(I)B
.end method
