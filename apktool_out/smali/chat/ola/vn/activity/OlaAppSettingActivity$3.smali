.class Lchat/ola/vn/activity/OlaAppSettingActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/i/j$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaAppSettingActivity;->C()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaAppSettingActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaAppSettingActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$3;->a:Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 5

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->f(Landroid/content/Context;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/facebook/login/LoginManager;->getInstance()Lcom/facebook/login/LoginManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/login/LoginManager;->logOut()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->l()V

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->b()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const v1, 0x7f0f02ac

    const-wide/16 v2, 0xbb8

    new-instance v4, Lchat/ola/vn/activity/OlaAppSettingActivity$3$1;

    invoke-direct {v4, p0}, Lchat/ola/vn/activity/OlaAppSettingActivity$3$1;-><init>(Lchat/ola/vn/activity/OlaAppSettingActivity$3;)V

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IJLjava/lang/Runnable;)Lchat/ola/vn/i/c;

    return-void

    :cond_1
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->l()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/c;->b(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method
