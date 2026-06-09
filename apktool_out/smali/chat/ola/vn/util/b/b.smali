.class public Lchat/ola/vn/util/b/b;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/util/b/c;

    invoke-direct {v0}, Lchat/ola/vn/util/b/c;-><init>()V

    new-instance v1, Lchat/ola/vn/util/b/b$1;

    invoke-direct {v1, p0, v0}, Lchat/ola/vn/util/b/b$1;-><init>(Landroid/content/Context;Lchat/ola/vn/util/b/c;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/util/b/a;)Lchat/ola/vn/util/b/c;

    const/4 p0, 0x1

    new-array p0, p0, [Ljava/lang/String;

    const/4 v1, 0x0

    aput-object p1, p0, v1

    invoke-virtual {v0, p0}, Lchat/ola/vn/util/b/c;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
