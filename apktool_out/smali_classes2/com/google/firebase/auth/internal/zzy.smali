.class public final Lcom/google/firebase/auth/internal/zzy;
.super Ljava/lang/Object;


# static fields
.field private static final zzdx:Lcom/google/android/gms/common/logging/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/google/android/gms/common/logging/Logger;

    const-string v1, "GetTokenResultFactory"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/common/logging/Logger;-><init>(Ljava/lang/String;[Ljava/lang/String;)V

    sput-object v0, Lcom/google/firebase/auth/internal/zzy;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    return-void
.end method

.method public static zzag(Ljava/lang/String;)Lcom/google/firebase/auth/GetTokenResult;
    .locals 4

    :try_start_0
    invoke-static {p0}, Lcom/google/firebase/auth/internal/zzz;->zzah(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0
    :try_end_0
    .catch Lcom/google/android/gms/internal/firebase_auth/zzv; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    sget-object v1, Lcom/google/firebase/auth/internal/zzy;->zzdx:Lcom/google/android/gms/common/logging/Logger;

    const-string v2, "Error parsing token claims"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v0, v3}, Lcom/google/android/gms/common/logging/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    sget-object v0, Ljava/util/Collections;->EMPTY_MAP:Ljava/util/Map;

    :goto_0
    new-instance v1, Lcom/google/firebase/auth/GetTokenResult;

    invoke-direct {v1, p0, v0}, Lcom/google/firebase/auth/GetTokenResult;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    return-object v1
.end method
