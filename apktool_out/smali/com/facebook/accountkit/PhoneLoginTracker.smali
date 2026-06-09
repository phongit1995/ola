.class public abstract Lcom/facebook/accountkit/PhoneLoginTracker;
.super Lcom/facebook/accountkit/Tracker;


# static fields
.field public static final ACTION_PHONE_LOGIN_STATE_CHANGED:Ljava/lang/String; = "com.facebook.accountkit.sdk.ACTION_PHONE_LOGIN_STATE_CHANGED"


# instance fields
.field private code:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/Tracker;-><init>()V

    return-void
.end method


# virtual methods
.method protected getActionsStateChanged()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const-string v0, "com.facebook.accountkit.sdk.ACTION_PHONE_LOGIN_STATE_CHANGED"

    invoke-static {v0}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/PhoneLoginTracker;->code:Ljava/lang/String;

    return-object v0
.end method

.method protected abstract onAccountVerified(Lcom/facebook/accountkit/PhoneLoginModel;)V
.end method

.method protected abstract onCancel(Lcom/facebook/accountkit/PhoneLoginModel;)V
.end method

.method protected abstract onError(Lcom/facebook/accountkit/AccountKitException;)V
.end method

.method protected onReceive(Landroid/content/Intent;)V
    .locals 3

    const-string v0, "com.facebook.accountkit.sdk.EXTRA_LOGIN_MODEL"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/PhoneLoginModel;

    const-string v1, "com.facebook.accountkit.sdk.EXTRA_LOGIN_STATUS"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getSerializableExtra(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object v1

    check-cast v1, Lcom/facebook/accountkit/internal/LoginStatus;

    if-eqz v0, :cond_1

    if-nez v1, :cond_0

    return-void

    :cond_0
    sget-object v2, Lcom/facebook/accountkit/PhoneLoginTracker$1;->$SwitchMap$com$facebook$accountkit$internal$LoginStatus:[I

    invoke-virtual {v1}, Lcom/facebook/accountkit/internal/LoginStatus;->ordinal()I

    move-result v1

    aget v1, v2, v1

    packed-switch v1, :pswitch_data_0

    return-void

    :pswitch_0
    const-string v0, "com.facebook.accountkit.sdk.EXTRA_LOGIN_ERROR"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/AccountKitError;

    if-eqz p1, :cond_1

    const-string v0, ""

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/PhoneLoginTracker;->setCode(Ljava/lang/String;)V

    new-instance v0, Lcom/facebook/accountkit/AccountKitException;

    invoke-direct {v0, p1}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError;)V

    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/PhoneLoginTracker;->onError(Lcom/facebook/accountkit/AccountKitException;)V

    return-void

    :pswitch_1
    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/PhoneLoginTracker;->onCancel(Lcom/facebook/accountkit/PhoneLoginModel;)V

    return-void

    :pswitch_2
    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/PhoneLoginTracker;->onSuccess(Lcom/facebook/accountkit/PhoneLoginModel;)V

    return-void

    :pswitch_3
    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/PhoneLoginTracker;->onAccountVerified(Lcom/facebook/accountkit/PhoneLoginModel;)V

    return-void

    :pswitch_4
    invoke-virtual {p0, v0}, Lcom/facebook/accountkit/PhoneLoginTracker;->onStarted(Lcom/facebook/accountkit/PhoneLoginModel;)V

    :cond_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected abstract onStarted(Lcom/facebook/accountkit/PhoneLoginModel;)V
.end method

.method protected abstract onSuccess(Lcom/facebook/accountkit/PhoneLoginModel;)V
.end method

.method public setCode(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/PhoneLoginTracker;->code:Ljava/lang/String;

    return-void
.end method
