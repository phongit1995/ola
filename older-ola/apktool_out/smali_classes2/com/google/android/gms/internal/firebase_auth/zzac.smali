.class public final Lcom/google/android/gms/internal/firebase_auth/zzac;
.super Ljava/lang/Object;


# instance fields
.field private message:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static zzj(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzac;
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzac;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzac;-><init>()V

    iput-object p0, v0, Lcom/google/android/gms/internal/firebase_auth/zzac;->message:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public final getErrorMessage()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzac;->message:Ljava/lang/String;

    return-object v0
.end method
