.class public interface abstract Lcom/facebook/accountkit/PhoneUpdateModel;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# virtual methods
.method public abstract getConfirmationCode()Ljava/lang/String;
.end method

.method public abstract getError()Lcom/facebook/accountkit/AccountKitError;
.end method

.method public abstract getFinalUpdateState()Ljava/lang/String;
.end method

.method public abstract getInitialUpdateState()Ljava/lang/String;
.end method

.method public abstract getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;
.end method

.method public abstract getPrivacyPolicy()Ljava/lang/String;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getResendTime()J
.end method

.method public abstract getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;
.end method

.method public abstract getTermsOfService()Ljava/lang/String;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end method

.method public abstract getUpdateRequestCode()Ljava/lang/String;
.end method
