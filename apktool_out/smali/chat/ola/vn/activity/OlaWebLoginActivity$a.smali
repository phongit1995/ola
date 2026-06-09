.class Lchat/ola/vn/activity/OlaWebLoginActivity$a;
.super Lchat/ola/vn/util/http/WebAppInterfaceImp;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaWebLoginActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaWebLoginActivity;


# direct methods
.method public constructor <init>(Lchat/ola/vn/activity/OlaWebLoginActivity;Landroid/content/Context;Landroid/webkit/WebView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaWebLoginActivity$a;->a:Lchat/ola/vn/activity/OlaWebLoginActivity;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/util/http/WebAppInterfaceImp;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V

    return-void
.end method


# virtual methods
.method public onSignInComplete(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;)V
    .locals 10
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->onSignInComplete(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->i()Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    :cond_0
    move-wide v7, v0

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p3}, Lchat/ola/vn/network/OlaNetworkService;->t()Lchat/ola/vn/network/e;

    move-result-object v2

    const/4 v4, 0x0

    const/4 v6, 0x0

    const/4 v9, 0x0

    move-object v3, p1

    move-object v5, p2

    invoke-virtual/range {v2 .. v9}, Lchat/ola/vn/network/e;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JS)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaWebLoginActivity$a;->a:Lchat/ola/vn/activity/OlaWebLoginActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaWebLoginActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
