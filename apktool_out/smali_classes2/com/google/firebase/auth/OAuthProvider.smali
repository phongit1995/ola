.class public Lcom/google/firebase/auth/OAuthProvider;
.super Lcom/google/firebase/auth/zzh;


# direct methods
.method public static getCredential(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/google/firebase/auth/AuthCredential;
    .locals 0
    .param p0    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p0, p1, p2}, Lcom/google/firebase/auth/zzd;->zza(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/google/firebase/auth/zzd;

    move-result-object p0

    return-object p0
.end method
