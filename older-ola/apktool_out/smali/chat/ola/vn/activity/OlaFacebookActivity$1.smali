.class Lchat/ola/vn/activity/OlaFacebookActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/FacebookCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaFacebookActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/facebook/FacebookCallback<",
        "Lcom/facebook/login/LoginResult;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaFacebookActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaFacebookActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaFacebookActivity$1;->a:Lchat/ola/vn/activity/OlaFacebookActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/facebook/login/LoginResult;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaFacebookActivity$1;->a:Lchat/ola/vn/activity/OlaFacebookActivity;

    invoke-static {v0, p1}, Lchat/ola/vn/activity/OlaFacebookActivity;->a(Lchat/ola/vn/activity/OlaFacebookActivity;Lcom/facebook/login/LoginResult;)V

    return-void
.end method

.method public onCancel()V
    .locals 0

    return-void
.end method

.method public onError(Lcom/facebook/FacebookException;)V
    .locals 0

    return-void
.end method

.method public synthetic onSuccess(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lcom/facebook/login/LoginResult;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaFacebookActivity$1;->a(Lcom/facebook/login/LoginResult;)V

    return-void
.end method
