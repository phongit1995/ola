.class public interface abstract Lcom/facebook/accountkit/AccountKitUpdateResult;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/AccountKitUpdateResult$UpdateResult;
    }
.end annotation


# static fields
.field public static final RESULT_KEY:Ljava/lang/String; = "account_kit_update_result"


# virtual methods
.method public abstract getError()Lcom/facebook/accountkit/AccountKitError;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getFinalAuthorizationState()Ljava/lang/String;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract wasCancelled()Z
.end method
