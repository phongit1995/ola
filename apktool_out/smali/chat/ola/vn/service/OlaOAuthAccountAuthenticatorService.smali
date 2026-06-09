.class public Lchat/ola/vn/service/OlaOAuthAccountAuthenticatorService;
.super Landroid/app/Service;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    new-instance p1, Lchat/ola/vn/a/a;

    invoke-direct {p1, p0}, Lchat/ola/vn/a/a;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1}, Lchat/ola/vn/a/a;->getIBinder()Landroid/os/IBinder;

    move-result-object p1

    return-object p1
.end method
