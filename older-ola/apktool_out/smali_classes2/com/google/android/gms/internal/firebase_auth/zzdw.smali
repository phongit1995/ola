.class final Lcom/google/android/gms/internal/firebase_auth/zzdw;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/internal/firebase_auth/zzew;


# static fields
.field private static final zzsz:Lcom/google/android/gms/internal/firebase_auth/zzeg;


# instance fields
.field private final zzsy:Lcom/google/android/gms/internal/firebase_auth/zzeg;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzdx;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzdx;-><init>()V

    sput-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdw;->zzsz:Lcom/google/android/gms/internal/firebase_auth/zzeg;

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzdy;

    const/4 v1, 0x2

    new-array v1, v1, [Lcom/google/android/gms/internal/firebase_auth/zzeg;

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzda;->zzdy()Lcom/google/android/gms/internal/firebase_auth/zzda;

    move-result-object v2

    const/4 v3, 0x0

    aput-object v2, v1, v3

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdw;->zzes()Lcom/google/android/gms/internal/firebase_auth/zzeg;

    move-result-object v2

    const/4 v3, 0x1

    aput-object v2, v1, v3

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzdy;-><init>([Lcom/google/android/gms/internal/firebase_auth/zzeg;)V

    invoke-direct {p0, v0}, Lcom/google/android/gms/internal/firebase_auth/zzdw;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzeg;)V

    return-void
.end method

.method private constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzeg;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "messageInfoFactory"

    invoke-static {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzdd;->zza(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzeg;

    iput-object p1, p0, Lcom/google/android/gms/internal/firebase_auth/zzdw;->zzsy:Lcom/google/android/gms/internal/firebase_auth/zzeg;

    return-void
.end method

.method private static zza(Lcom/google/android/gms/internal/firebase_auth/zzef;)Z
    .locals 1

    invoke-interface {p0}, Lcom/google/android/gms/internal/firebase_auth/zzef;->zzez()I

    move-result p0

    sget v0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zze;->zzrm:I

    if-ne p0, v0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method private static zzes()Lcom/google/android/gms/internal/firebase_auth/zzeg;
    .locals 4

    :try_start_0
    const-string v0, "com.google.protobuf.DescriptorMessageInfoFactory"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "getInstance"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/internal/firebase_auth/zzeg;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    sget-object v0, Lcom/google/android/gms/internal/firebase_auth/zzdw;->zzsz:Lcom/google/android/gms/internal/firebase_auth/zzeg;

    return-object v0
.end method


# virtual methods
.method public final zze(Ljava/lang/Class;)Lcom/google/android/gms/internal/firebase_auth/zzev;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Lcom/google/android/gms/internal/firebase_auth/zzev<",
            "TT;>;"
        }
    .end annotation

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zzg(Ljava/lang/Class;)V

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdw;->zzsy:Lcom/google/android/gms/internal/firebase_auth/zzeg;

    invoke-interface {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzeg;->zzc(Ljava/lang/Class;)Lcom/google/android/gms/internal/firebase_auth/zzef;

    move-result-object v2

    invoke-interface {v2}, Lcom/google/android/gms/internal/firebase_auth/zzef;->zzfa()Z

    move-result v0

    if-eqz v0, :cond_1

    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zzfl()Lcom/google/android/gms/internal/firebase_auth/zzfp;

    move-result-object p1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzcr;->zzdn()Lcom/google/android/gms/internal/firebase_auth/zzcp;

    move-result-object v0

    invoke-interface {v2}, Lcom/google/android/gms/internal/firebase_auth/zzef;->zzfb()Lcom/google/android/gms/internal/firebase_auth/zzeh;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzem;->zza(Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzeh;)Lcom/google/android/gms/internal/firebase_auth/zzem;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zzfj()Lcom/google/android/gms/internal/firebase_auth/zzfp;

    move-result-object p1

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzcr;->zzdo()Lcom/google/android/gms/internal/firebase_auth/zzcp;

    move-result-object v0

    invoke-interface {v2}, Lcom/google/android/gms/internal/firebase_auth/zzef;->zzfb()Lcom/google/android/gms/internal/firebase_auth/zzeh;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzem;->zza(Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzeh;)Lcom/google/android/gms/internal/firebase_auth/zzem;

    move-result-object p1

    return-object p1

    :cond_1
    const-class v0, Lcom/google/android/gms/internal/firebase_auth/zzdb;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {v2}, Lcom/google/android/gms/internal/firebase_auth/zzdw;->zza(Lcom/google/android/gms/internal/firebase_auth/zzef;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzeq;->zzfe()Lcom/google/android/gms/internal/firebase_auth/zzeo;

    move-result-object v3

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdr;->zzer()Lcom/google/android/gms/internal/firebase_auth/zzdr;

    move-result-object v4

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zzfl()Lcom/google/android/gms/internal/firebase_auth/zzfp;

    move-result-object v5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzcr;->zzdn()Lcom/google/android/gms/internal/firebase_auth/zzcp;

    move-result-object v6

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzee;->zzex()Lcom/google/android/gms/internal/firebase_auth/zzec;

    move-result-object v7

    move-object v1, p1

    invoke-static/range {v1 .. v7}, Lcom/google/android/gms/internal/firebase_auth/zzel;->zza(Ljava/lang/Class;Lcom/google/android/gms/internal/firebase_auth/zzef;Lcom/google/android/gms/internal/firebase_auth/zzeo;Lcom/google/android/gms/internal/firebase_auth/zzdr;Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzec;)Lcom/google/android/gms/internal/firebase_auth/zzel;

    move-result-object p1

    return-object p1

    :cond_2
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzeq;->zzfe()Lcom/google/android/gms/internal/firebase_auth/zzeo;

    move-result-object v3

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdr;->zzer()Lcom/google/android/gms/internal/firebase_auth/zzdr;

    move-result-object v4

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zzfl()Lcom/google/android/gms/internal/firebase_auth/zzfp;

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzee;->zzex()Lcom/google/android/gms/internal/firebase_auth/zzec;

    move-result-object v7

    move-object v1, p1

    invoke-static/range {v1 .. v7}, Lcom/google/android/gms/internal/firebase_auth/zzel;->zza(Ljava/lang/Class;Lcom/google/android/gms/internal/firebase_auth/zzef;Lcom/google/android/gms/internal/firebase_auth/zzeo;Lcom/google/android/gms/internal/firebase_auth/zzdr;Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzec;)Lcom/google/android/gms/internal/firebase_auth/zzel;

    move-result-object p1

    return-object p1

    :cond_3
    invoke-static {v2}, Lcom/google/android/gms/internal/firebase_auth/zzdw;->zza(Lcom/google/android/gms/internal/firebase_auth/zzef;)Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzeq;->zzfd()Lcom/google/android/gms/internal/firebase_auth/zzeo;

    move-result-object v3

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdr;->zzeq()Lcom/google/android/gms/internal/firebase_auth/zzdr;

    move-result-object v4

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zzfj()Lcom/google/android/gms/internal/firebase_auth/zzfp;

    move-result-object v5

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzcr;->zzdo()Lcom/google/android/gms/internal/firebase_auth/zzcp;

    move-result-object v6

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzee;->zzew()Lcom/google/android/gms/internal/firebase_auth/zzec;

    move-result-object v7

    move-object v1, p1

    invoke-static/range {v1 .. v7}, Lcom/google/android/gms/internal/firebase_auth/zzel;->zza(Ljava/lang/Class;Lcom/google/android/gms/internal/firebase_auth/zzef;Lcom/google/android/gms/internal/firebase_auth/zzeo;Lcom/google/android/gms/internal/firebase_auth/zzdr;Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzec;)Lcom/google/android/gms/internal/firebase_auth/zzel;

    move-result-object p1

    return-object p1

    :cond_4
    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzeq;->zzfd()Lcom/google/android/gms/internal/firebase_auth/zzeo;

    move-result-object v3

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzdr;->zzeq()Lcom/google/android/gms/internal/firebase_auth/zzdr;

    move-result-object v4

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzex;->zzfk()Lcom/google/android/gms/internal/firebase_auth/zzfp;

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzee;->zzew()Lcom/google/android/gms/internal/firebase_auth/zzec;

    move-result-object v7

    move-object v1, p1

    invoke-static/range {v1 .. v7}, Lcom/google/android/gms/internal/firebase_auth/zzel;->zza(Ljava/lang/Class;Lcom/google/android/gms/internal/firebase_auth/zzef;Lcom/google/android/gms/internal/firebase_auth/zzeo;Lcom/google/android/gms/internal/firebase_auth/zzdr;Lcom/google/android/gms/internal/firebase_auth/zzfp;Lcom/google/android/gms/internal/firebase_auth/zzcp;Lcom/google/android/gms/internal/firebase_auth/zzec;)Lcom/google/android/gms/internal/firebase_auth/zzel;

    move-result-object p1

    return-object p1
.end method
