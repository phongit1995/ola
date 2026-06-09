.class public interface abstract Lcom/facebook/accountkit/AccountKitLoginResult;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final RESULT_KEY:Ljava/lang/String; = "account_kit_log_in_result"


# virtual methods
.method public abstract getAccessToken()Lcom/facebook/accountkit/AccessToken;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getAuthorizationCode()Ljava/lang/String;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getError()Lcom/facebook/accountkit/AccountKitError;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getFinalAuthorizationState()Ljava/lang/String;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getTokenRefreshIntervalInSeconds()J
.end method

.method public abstract wasCancelled()Z
.end method
