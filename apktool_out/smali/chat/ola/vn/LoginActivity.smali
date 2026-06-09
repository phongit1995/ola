.class public Lchat/ola/vn/LoginActivity;
.super Lchat/ola/vn/c;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "com.ola.username"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "com.ola.token"

    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/4 p1, -0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/LoginActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lchat/ola/vn/LoginActivity;->finish()V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    return-void
.end method

.method protected onStart()V
    .locals 4

    invoke-super {p0}, Lchat/ola/vn/c;->onStart()V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/LoginActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "com.ola.relogin"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/e;->j()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/LoginActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    invoke-virtual {p0, v2, v0}, Lchat/ola/vn/LoginActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lchat/ola/vn/LoginActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
