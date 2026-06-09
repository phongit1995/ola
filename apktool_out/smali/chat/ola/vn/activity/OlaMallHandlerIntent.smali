.class public Lchat/ola/vn/activity/OlaMallHandlerIntent;
.super Lchat/ola/vn/c;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaMallHandlerIntent;->getIntent()Landroid/content/Intent;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaMallHandlerIntent;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    const-string v0, "android.intent.action.VIEW"

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaMallHandlerIntent;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    :try_start_0
    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->g(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x0

    :try_start_1
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-static {p0, v0}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v1

    :try_start_2
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {p0, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaMallHandlerIntent;->finish()V

    throw p1

    :catch_1
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaMallHandlerIntent;->finish()V

    :cond_2
    return-void
.end method
