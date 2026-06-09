.class final Lcom/google/android/gms/internal/firebase_auth/zzfv;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/android/gms/internal/firebase_auth/zzfv$zza;,
        Lcom/google/android/gms/internal/firebase_auth/zzfv$zzb;,
        Lcom/google/android/gms/internal/firebase_auth/zzfv$zzc;,
        Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;
    }
.end annotation


# static fields
.field private static final logger:Ljava/util/logging/Logger;

.field private static final zzme:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field private static final zznf:Z

.field private static final zztj:Lsun/misc/Unsafe;

.field private static final zzvj:Z

.field private static final zzvk:Z

.field private static final zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

.field private static final zzvm:Z

.field private static final zzvn:J

.field private static final zzvo:J

.field private static final zzvp:J

.field private static final zzvq:J

.field private static final zzvr:J

.field private static final zzvs:J

.field private static final zzvt:J

.field private static final zzvu:J

.field private static final zzvv:J

.field private static final zzvw:J

.field private static final zzvx:J

.field private static final zzvy:J

.field private static final zzvz:J

.field private static final zzwa:J

.field private static final zzwb:J

.field private static final zzwc:Z


# direct methods
.method static constructor <clinit>()V
    .locals 4

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->logger:Ljava/util/logging/Logger;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzge()Lsun/misc/Unsafe;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzbr;->zzbv()Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzme:Ljava/lang/Class;

    sget-object v0, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzj(Ljava/lang/Class;)Z

    move-result v0

    sput-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvj:Z

    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzj(Ljava/lang/Class;)Z

    move-result v0

    sput-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvk:Z

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v1

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzbr;->zzbu()Z

    move-result v0

    if-eqz v0, :cond_3

    sget-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvj:Z

    if-eqz v0, :cond_2

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzb;

    sget-object v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    invoke-direct {v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzb;-><init>(Lsun/misc/Unsafe;)V

    goto :goto_0

    :cond_2
    sget-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvk:Z

    if-eqz v0, :cond_0

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzfv$zza;

    sget-object v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    invoke-direct {v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zza;-><init>(Lsun/misc/Unsafe;)V

    goto :goto_0

    :cond_3
    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzc;

    sget-object v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    invoke-direct {v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzc;-><init>(Lsun/misc/Unsafe;)V

    :goto_0
    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzgg()Z

    move-result v0

    sput-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvm:Z

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzgf()Z

    move-result v0

    sput-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zznf:Z

    const-class v0, [B

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzh(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvn:J

    const-class v0, [Z

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzh(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvo:J

    const-class v0, [Z

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzi(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvp:J

    const-class v0, [I

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzh(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvq:J

    const-class v0, [I

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzi(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvr:J

    const-class v0, [J

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzh(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvs:J

    const-class v0, [J

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzi(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvt:J

    const-class v0, [F

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzh(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvu:J

    const-class v0, [F

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzi(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvv:J

    const-class v0, [D

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzh(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvw:J

    const-class v0, [D

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzi(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvx:J

    const-class v0, [Ljava/lang/Object;

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzh(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvy:J

    const-class v0, [Ljava/lang/Object;

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzi(Ljava/lang/Class;)I

    move-result v0

    int-to-long v2, v0

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvz:J

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzgh()Ljava/lang/reflect/Field;

    move-result-object v0

    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(Ljava/lang/reflect/Field;)J

    move-result-wide v2

    sput-wide v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzwa:J

    const-class v0, Ljava/lang/String;

    const-string v2, "value"

    invoke-static {v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v2

    const-class v3, [C

    if-ne v2, v3, :cond_4

    goto :goto_1

    :cond_4
    move-object v0, v1

    :goto_1
    invoke-static {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(Ljava/lang/reflect/Field;)J

    move-result-wide v0

    sput-wide v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzwb:J

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v0

    sget-object v1, Ljava/nio/ByteOrder;->BIG_ENDIAN:Ljava/nio/ByteOrder;

    if-ne v0, v1, :cond_5

    const/4 v0, 0x1

    goto :goto_2

    :cond_5
    const/4 v0, 0x0

    :goto_2
    sput-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzwc:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static zza([BJ)B
    .locals 5

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    sget-wide v1, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvn:J

    add-long v3, v1, p1

    invoke-virtual {v0, p0, v3, v4}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzy(Ljava/lang/Object;J)B

    move-result p0

    return p0
.end method

.method private static zza(Ljava/lang/reflect/Field;)J
    .locals 2

    if-eqz p0, :cond_1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    iget-object v0, v0, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzwd:Lsun/misc/Unsafe;

    invoke-virtual {v0, p0}, Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J

    move-result-wide v0

    return-wide v0

    :cond_1
    :goto_0
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method static zza(JB)V
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zza(JB)V

    return-void
.end method

.method private static zza(Ljava/lang/Object;JB)V
    .locals 4

    const-wide/16 v0, -0x4

    and-long v2, p1, v0

    invoke-static {p0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzk(Ljava/lang/Object;J)I

    move-result v0

    long-to-int p1, p1

    xor-int/lit8 p1, p1, -0x1

    and-int/lit8 p1, p1, 0x3

    shl-int/lit8 p1, p1, 0x3

    const/16 p2, 0xff

    shl-int v1, p2, p1

    xor-int/lit8 v1, v1, -0x1

    and-int/2addr v0, v1

    and-int/2addr p2, p3

    shl-int p1, p2, p1

    or-int/2addr p1, v0

    invoke-static {p0, v2, v3, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/lang/Object;JI)V

    return-void
.end method

.method static zza(Ljava/lang/Object;JD)V
    .locals 6

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    move-object v1, p0

    move-wide v2, p1

    move-wide v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zza(Ljava/lang/Object;JD)V

    return-void
.end method

.method static zza(Ljava/lang/Object;JF)V
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zza(Ljava/lang/Object;JF)V

    return-void
.end method

.method static zza(Ljava/lang/Object;JJ)V
    .locals 6

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    move-object v1, p0

    move-wide v2, p1

    move-wide v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zza(Ljava/lang/Object;JJ)V

    return-void
.end method

.method static zza(Ljava/lang/Object;JLjava/lang/Object;)V
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    iget-object v0, v0, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzwd:Lsun/misc/Unsafe;

    invoke-virtual {v0, p0, p1, p2, p3}, Lsun/misc/Unsafe;->putObject(Ljava/lang/Object;JLjava/lang/Object;)V

    return-void
.end method

.method static zza(Ljava/lang/Object;JZ)V
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zza(Ljava/lang/Object;JZ)V

    return-void
.end method

.method static zza([BJB)V
    .locals 5

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    sget-wide v1, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvn:J

    add-long v3, v1, p1

    invoke-virtual {v0, p0, v3, v4, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zze(Ljava/lang/Object;JB)V

    return-void
.end method

.method static zza([BJJJ)V
    .locals 8

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    move-object v1, p0

    move-wide v2, p1

    move-wide v4, p3

    move-wide v6, p5

    invoke-virtual/range {v0 .. v7}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zza([BJJJ)V

    return-void
.end method

.method static zzb(Ljava/nio/ByteBuffer;)J
    .locals 3

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    sget-wide v1, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzwa:J

    invoke-virtual {v0, p0, v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzl(Ljava/lang/Object;J)J

    move-result-wide v0

    return-wide v0
.end method

.method private static zzb(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/reflect/Field;"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static zzb(Ljava/lang/Object;JB)V
    .locals 4

    const-wide/16 v0, -0x4

    and-long v2, p1, v0

    invoke-static {p0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzk(Ljava/lang/Object;J)I

    move-result v0

    long-to-int p1, p1

    and-int/lit8 p1, p1, 0x3

    shl-int/lit8 p1, p1, 0x3

    const/16 p2, 0xff

    shl-int v1, p2, p1

    xor-int/lit8 v1, v1, -0x1

    and-int/2addr v0, v1

    and-int/2addr p2, p3

    shl-int p1, p2, p1

    or-int/2addr p1, v0

    invoke-static {p0, v2, v3, p1}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/lang/Object;JI)V

    return-void
.end method

.method static zzb(Ljava/lang/Object;JI)V
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzb(Ljava/lang/Object;JI)V

    return-void
.end method

.method private static zzb(Ljava/lang/Object;JZ)V
    .locals 0

    int-to-byte p3, p3

    invoke-static {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(Ljava/lang/Object;JB)V

    return-void
.end method

.method static synthetic zzc(Ljava/lang/Object;JB)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zza(Ljava/lang/Object;JB)V

    return-void
.end method

.method private static zzc(Ljava/lang/Object;JZ)V
    .locals 0

    int-to-byte p3, p3

    invoke-static {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/lang/Object;JB)V

    return-void
.end method

.method static synthetic zzd(Ljava/lang/Object;JB)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/lang/Object;JB)V

    return-void
.end method

.method static synthetic zzd(Ljava/lang/Object;JZ)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/lang/Object;JZ)V

    return-void
.end method

.method static synthetic zzdd()Z
    .locals 1

    sget-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzwc:Z

    return v0
.end method

.method static synthetic zze(Ljava/lang/Object;JZ)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzc(Ljava/lang/Object;JZ)V

    return-void
.end method

.method static zzgc()Z
    .locals 1

    sget-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zznf:Z

    return v0
.end method

.method static zzgd()Z
    .locals 1

    sget-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvm:Z

    return v0
.end method

.method static zzge()Lsun/misc/Unsafe;
    .locals 1

    :try_start_0
    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzfw;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzfw;-><init>()V

    invoke-static {v0}, Ljava/security/AccessController;->doPrivileged(Ljava/security/PrivilegedExceptionAction;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lsun/misc/Unsafe;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private static zzgf()Z
    .locals 8

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v2, "objectFieldOffset"

    const/4 v3, 0x1

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, Ljava/lang/reflect/Field;

    aput-object v5, v4, v1

    invoke-virtual {v0, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "arrayBaseOffset"

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, Ljava/lang/Class;

    aput-object v5, v4, v1

    invoke-virtual {v0, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "arrayIndexScale"

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, Ljava/lang/Class;

    aput-object v5, v4, v1

    invoke-virtual {v0, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getInt"

    const/4 v4, 0x2

    new-array v5, v4, [Ljava/lang/Class;

    const-class v6, Ljava/lang/Object;

    aput-object v6, v5, v1

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v3

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putInt"

    const/4 v5, 0x3

    new-array v6, v5, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v4

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getLong"

    new-array v6, v4, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putLong"

    new-array v6, v5, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v4

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getObject"

    new-array v6, v4, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putObject"

    new-array v6, v5, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v4

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzbr;->zzbu()Z

    move-result v2

    if-eqz v2, :cond_1

    return v3

    :cond_1
    const-string v2, "getByte"

    new-array v6, v4, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putByte"

    new-array v6, v5, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    sget-object v7, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v4

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getBoolean"

    new-array v6, v4, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putBoolean"

    new-array v6, v5, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v4

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getFloat"

    new-array v6, v4, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putFloat"

    new-array v6, v5, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    sget-object v7, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v4

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getDouble"

    new-array v6, v4, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putDouble"

    new-array v5, v5, [Ljava/lang/Class;

    const-class v6, Ljava/lang/Object;

    aput-object v6, v5, v1

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v3

    sget-object v6, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v4

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v3

    :catch_0
    move-exception v0

    sget-object v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->logger:Ljava/util/logging/Logger;

    sget-object v3, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v4, "com.google.protobuf.UnsafeUtil"

    const-string v5, "supportsUnsafeArrayOperations"

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    add-int/lit8 v6, v6, 0x47

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7, v6}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v6, "platform method missing - proto runtime falling back to safer methods: "

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v3, v4, v5, v0}, Ljava/util/logging/Logger;->logp(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return v1
.end method

.method private static zzgg()Z
    .locals 8

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zztj:Lsun/misc/Unsafe;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v2, "objectFieldOffset"

    const/4 v3, 0x1

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, Ljava/lang/reflect/Field;

    aput-object v5, v4, v1

    invoke-virtual {v0, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getLong"

    const/4 v4, 0x2

    new-array v5, v4, [Ljava/lang/Class;

    const-class v6, Ljava/lang/Object;

    aput-object v6, v5, v1

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v3

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzgh()Ljava/lang/reflect/Field;

    move-result-object v2

    if-nez v2, :cond_1

    return v1

    :cond_1
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzbr;->zzbu()Z

    move-result v2

    if-eqz v2, :cond_2

    return v3

    :cond_2
    const-string v2, "getByte"

    new-array v5, v3, [Ljava/lang/Class;

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v1

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putByte"

    new-array v5, v4, [Ljava/lang/Class;

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v1

    sget-object v6, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v3

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getInt"

    new-array v5, v3, [Ljava/lang/Class;

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v1

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putInt"

    new-array v5, v4, [Ljava/lang/Class;

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v1

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v3

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "getLong"

    new-array v5, v3, [Ljava/lang/Class;

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v1

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "putLong"

    new-array v5, v4, [Ljava/lang/Class;

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v1

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v3

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "copyMemory"

    const/4 v5, 0x3

    new-array v6, v5, [Ljava/lang/Class;

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v4

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "copyMemory"

    const/4 v6, 0x5

    new-array v6, v6, [Ljava/lang/Class;

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v6, v3

    const-class v7, Ljava/lang/Object;

    aput-object v7, v6, v4

    sget-object v4, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v4, v6, v5

    const/4 v4, 0x4

    sget-object v5, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v5, v6, v4

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v3

    :catch_0
    move-exception v0

    sget-object v2, Lcom/google/android/gms/internal/firebase_auth/zzfv;->logger:Ljava/util/logging/Logger;

    sget-object v3, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v4, "com.google.protobuf.UnsafeUtil"

    const-string v5, "supportsUnsafeByteBufferOperations"

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    add-int/lit8 v6, v6, 0x47

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7, v6}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v6, "platform method missing - proto runtime falling back to safer methods: "

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v3, v4, v5, v0}, Ljava/util/logging/Logger;->logp(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return v1
.end method

.method private static zzgh()Ljava/lang/reflect/Field;
    .locals 3

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzbr;->zzbu()Z

    move-result v0

    if-eqz v0, :cond_0

    const-class v0, Ljava/nio/Buffer;

    const-string v1, "effectiveDirectAddress"

    invoke-static {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    const-class v0, Ljava/nio/Buffer;

    const-string v1, "address"

    invoke-static {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzb(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v1

    sget-object v2, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    if-ne v1, v2, :cond_1

    return-object v0

    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method static synthetic zzgi()J
    .locals 2

    sget-wide v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvn:J

    return-wide v0
.end method

.method private static zzh(Ljava/lang/Class;)I
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)I"
        }
    .end annotation

    sget-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zznf:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    iget-object v0, v0, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzwd:Lsun/misc/Unsafe;

    invoke-virtual {v0, p0}, Lsun/misc/Unsafe;->arrayBaseOffset(Ljava/lang/Class;)I

    move-result p0

    return p0

    :cond_0
    const/4 p0, -0x1

    return p0
.end method

.method private static zzi(Ljava/lang/Class;)I
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)I"
        }
    .end annotation

    sget-boolean v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zznf:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    iget-object v0, v0, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzwd:Lsun/misc/Unsafe;

    invoke-virtual {v0, p0}, Lsun/misc/Unsafe;->arrayIndexScale(Ljava/lang/Class;)I

    move-result p0

    return p0

    :cond_0
    const/4 p0, -0x1

    return p0
.end method

.method private static zzj(Ljava/lang/Class;)Z
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)Z"
        }
    .end annotation

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzbr;->zzbu()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzme:Ljava/lang/Class;

    const-string v2, "peekLong"

    const/4 v3, 0x2

    new-array v4, v3, [Ljava/lang/Class;

    aput-object p0, v4, v1

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const/4 v6, 0x1

    aput-object v5, v4, v6

    invoke-virtual {v0, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "pokeLong"

    const/4 v4, 0x3

    new-array v5, v4, [Ljava/lang/Class;

    aput-object p0, v5, v1

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v3

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "pokeInt"

    new-array v5, v4, [Ljava/lang/Class;

    aput-object p0, v5, v1

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v3

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "peekInt"

    new-array v5, v3, [Ljava/lang/Class;

    aput-object p0, v5, v1

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "pokeByte"

    new-array v5, v3, [Ljava/lang/Class;

    aput-object p0, v5, v1

    sget-object v7, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "peekByte"

    new-array v5, v6, [Ljava/lang/Class;

    aput-object p0, v5, v1

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "pokeByteArray"

    const/4 v5, 0x4

    new-array v7, v5, [Ljava/lang/Class;

    aput-object p0, v7, v1

    const-class v8, [B

    aput-object v8, v7, v6

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v8, v7, v3

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v8, v7, v4

    invoke-virtual {v0, v2, v7}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    const-string v2, "peekByteArray"

    new-array v5, v5, [Ljava/lang/Class;

    aput-object p0, v5, v1

    const-class p0, [B

    aput-object p0, v5, v6

    sget-object p0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object p0, v5, v3

    sget-object p0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object p0, v5, v4

    invoke-virtual {v0, v2, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v6

    :catch_0
    return v1
.end method

.method static zzk(Ljava/lang/Object;J)I
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzk(Ljava/lang/Object;J)I

    move-result p0

    return p0
.end method

.method static zzl(Ljava/lang/Object;J)J
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzl(Ljava/lang/Object;J)J

    move-result-wide p0

    return-wide p0
.end method

.method static zzm(Ljava/lang/Object;J)Z
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzm(Ljava/lang/Object;J)Z

    move-result p0

    return p0
.end method

.method static zzn(Ljava/lang/Object;J)F
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzn(Ljava/lang/Object;J)F

    move-result p0

    return p0
.end method

.method static zzo(Ljava/lang/Object;J)D
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    invoke-virtual {v0, p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzo(Ljava/lang/Object;J)D

    move-result-wide p0

    return-wide p0
.end method

.method static zzp(Ljava/lang/Object;J)Ljava/lang/Object;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzvl:Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;

    iget-object v0, v0, Lcom/google/android/gms/internal/firebase_auth/zzfv$zzd;->zzwd:Lsun/misc/Unsafe;

    invoke-virtual {v0, p0, p1, p2}, Lsun/misc/Unsafe;->getObject(Ljava/lang/Object;J)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private static zzq(Ljava/lang/Object;J)B
    .locals 4

    const-wide/16 v0, -0x4

    and-long v2, p1, v0

    invoke-static {p0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzk(Ljava/lang/Object;J)I

    move-result p0

    const-wide/16 v0, -0x1

    xor-long v2, p1, v0

    const-wide/16 p1, 0x3

    and-long v0, v2, p1

    const/4 p1, 0x3

    shl-long p1, v0, p1

    long-to-int p1, p1

    ushr-int/2addr p0, p1

    int-to-byte p0, p0

    return p0
.end method

.method private static zzr(Ljava/lang/Object;J)B
    .locals 4

    const-wide/16 v0, -0x4

    and-long v2, p1, v0

    invoke-static {p0, v2, v3}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzk(Ljava/lang/Object;J)I

    move-result p0

    const-wide/16 v0, 0x3

    and-long v2, p1, v0

    const/4 p1, 0x3

    shl-long p1, v2, p1

    long-to-int p1, p1

    ushr-int/2addr p0, p1

    int-to-byte p0, p0

    return p0
.end method

.method private static zzs(Ljava/lang/Object;J)Z
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzq(Ljava/lang/Object;J)B

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method private static zzt(Ljava/lang/Object;J)Z
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzr(Ljava/lang/Object;J)B

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method static synthetic zzu(Ljava/lang/Object;J)B
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzq(Ljava/lang/Object;J)B

    move-result p0

    return p0
.end method

.method static synthetic zzv(Ljava/lang/Object;J)B
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzr(Ljava/lang/Object;J)B

    move-result p0

    return p0
.end method

.method static synthetic zzw(Ljava/lang/Object;J)Z
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzs(Ljava/lang/Object;J)Z

    move-result p0

    return p0
.end method

.method static synthetic zzx(Ljava/lang/Object;J)Z
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzfv;->zzt(Ljava/lang/Object;J)Z

    move-result p0

    return p0
.end method
