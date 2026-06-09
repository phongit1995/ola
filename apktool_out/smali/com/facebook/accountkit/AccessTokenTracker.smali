.class public abstract Lcom/facebook/accountkit/AccessTokenTracker;
.super Lcom/facebook/accountkit/Tracker;


# static fields
.field public static final ACTION_CURRENT_ACCESS_TOKEN_CHANGED:Ljava/lang/String; = "com.facebook.accountkit.sdk.ACTION_CURRENT_ACCESS_TOKEN_CHANGED"

.field public static final EXTRA_NEW_ACCESS_TOKEN:Ljava/lang/String; = "com.facebook.accountkit.sdk.EXTRA_NEW_ACCESS_TOKEN"

.field public static final EXTRA_OLD_ACCESS_TOKEN:Ljava/lang/String; = "com.facebook.accountkit.sdk.EXTRA_OLD_ACCESS_TOKEN"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/Tracker;-><init>()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/AccessTokenTracker;->startTracking()V

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

    const-string v0, "com.facebook.accountkit.sdk.ACTION_CURRENT_ACCESS_TOKEN_CHANGED"

    invoke-static {v0}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method protected abstract onCurrentAccessTokenChanged(Lcom/facebook/accountkit/AccessToken;Lcom/facebook/accountkit/AccessToken;)V
.end method

.method protected onReceive(Landroid/content/Intent;)V
    .locals 2

    const-string v0, "com.facebook.accountkit.sdk.EXTRA_OLD_ACCESS_TOKEN"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/AccessToken;

    const-string v1, "com.facebook.accountkit.sdk.EXTRA_NEW_ACCESS_TOKEN"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/AccessToken;

    invoke-virtual {p0, v0, p1}, Lcom/facebook/accountkit/AccessTokenTracker;->onCurrentAccessTokenChanged(Lcom/facebook/accountkit/AccessToken;Lcom/facebook/accountkit/AccessToken;)V

    return-void
.end method
