.class public final Lcom/google/firebase/auth/api/internal/zzcn;
.super Ljava/lang/Object;


# static fields
.field private static final CLIENT_KEY:Lcom/google/android/gms/common/api/Api$ClientKey;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/Api$ClientKey<",
            "Lcom/google/firebase/auth/api/internal/zzcc;",
            ">;"
        }
    .end annotation
.end field

.field private static final zzhm:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/Api$AbstractClientBuilder<",
            "Lcom/google/firebase/auth/api/internal/zzcc;",
            "Lcom/google/firebase/auth/api/internal/zzcp;",
            ">;"
        }
    .end annotation
.end field

.field public static final zzhn:Lcom/google/android/gms/common/api/Api;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/Api<",
            "Lcom/google/firebase/auth/api/internal/zzcp;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/google/android/gms/common/api/Api$ClientKey;

    invoke-direct {v0}, Lcom/google/android/gms/common/api/Api$ClientKey;-><init>()V

    sput-object v0, Lcom/google/firebase/auth/api/internal/zzcn;->CLIENT_KEY:Lcom/google/android/gms/common/api/Api$ClientKey;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzco;

    invoke-direct {v0}, Lcom/google/firebase/auth/api/internal/zzco;-><init>()V

    sput-object v0, Lcom/google/firebase/auth/api/internal/zzcn;->zzhm:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;

    new-instance v0, Lcom/google/android/gms/common/api/Api;

    const-string v1, "InternalFirebaseAuth.FIREBASE_AUTH_API"

    sget-object v2, Lcom/google/firebase/auth/api/internal/zzcn;->zzhm:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;

    sget-object v3, Lcom/google/firebase/auth/api/internal/zzcn;->CLIENT_KEY:Lcom/google/android/gms/common/api/Api$ClientKey;

    invoke-direct {v0, v1, v2, v3}, Lcom/google/android/gms/common/api/Api;-><init>(Ljava/lang/String;Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;Lcom/google/android/gms/common/api/Api$ClientKey;)V

    sput-object v0, Lcom/google/firebase/auth/api/internal/zzcn;->zzhn:Lcom/google/android/gms/common/api/Api;

    return-void
.end method

.method public static zza(Landroid/content/Context;Lcom/google/firebase/auth/api/internal/zzcp;)Lcom/google/firebase/auth/api/internal/zzao;
    .locals 1

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzao;

    invoke-direct {v0, p0, p1}, Lcom/google/firebase/auth/api/internal/zzao;-><init>(Landroid/content/Context;Lcom/google/firebase/auth/api/internal/zzcp;)V

    return-object v0
.end method
