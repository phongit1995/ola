.class public abstract Lcom/google/android/gms/internal/firebase_auth/zzdb$zzc;
.super Lcom/google/android/gms/internal/firebase_auth/zzdb;

# interfaces
.implements Lcom/google/android/gms/internal/firebase_auth/zzej;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/internal/firebase_auth/zzdb;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "zzc"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<MessageType:",
        "Lcom/google/android/gms/internal/firebase_auth/zzdb$zzc<",
        "TMessageType;TBuilderType;>;BuilderType:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/google/android/gms/internal/firebase_auth/zzdb<",
        "TMessageType;TBuilderType;>;",
        "Lcom/google/android/gms/internal/firebase_auth/zzej;"
    }
.end annotation


# instance fields
.field protected zzrd:Lcom/google/android/gms/internal/firebase_auth/zzcs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/internal/firebase_auth/zzcs<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/google/android/gms/internal/firebase_auth/zzdb;-><init>()V

    invoke-static {}, Lcom/google/android/gms/internal/firebase_auth/zzcs;->zzdp()Lcom/google/android/gms/internal/firebase_auth/zzcs;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/internal/firebase_auth/zzdb$zzc;->zzrd:Lcom/google/android/gms/internal/firebase_auth/zzcs;

    return-void
.end method
