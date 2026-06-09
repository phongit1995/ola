.class public Lchat/ola/vn/l/b;
.super Ljava/lang/Object;


# direct methods
.method public static a(Ljava/lang/String;Lchat/ola/vn/network/c;)V
    .locals 2

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/l/e;

    invoke-direct {v0}, Lchat/ola/vn/l/e;-><init>()V

    const/4 v1, 0x2

    iput v1, v0, Lchat/ola/vn/l/e;->a:I

    iput-object p0, v0, Lchat/ola/vn/l/e;->b:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/l/e;->c:Lchat/ola/vn/network/c;

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/String;

    invoke-virtual {v0, p0}, Lchat/ola/vn/l/e;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V
    .locals 1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    new-instance v0, Lchat/ola/vn/l/d;

    invoke-direct {v0}, Lchat/ola/vn/l/d;-><init>()V

    iput-object p0, v0, Lchat/ola/vn/l/d;->c:Ljava/lang/String;

    const/4 p0, 0x2

    iput p0, v0, Lchat/ola/vn/l/d;->a:I

    iput-object p1, v0, Lchat/ola/vn/l/d;->b:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/l/d;->d:Lchat/ola/vn/network/c;

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/String;

    invoke-virtual {v0, p0}, Lchat/ola/vn/l/d;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V
    .locals 1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return-void

    :cond_2
    new-instance v0, Lchat/ola/vn/l/i;

    invoke-direct {v0}, Lchat/ola/vn/l/i;-><init>()V

    iput-object p0, v0, Lchat/ola/vn/l/i;->d:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/l/i;->a:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/l/i;->b:Ljava/lang/String;

    iput-object p3, v0, Lchat/ola/vn/l/i;->c:Ljava/lang/String;

    iput-object p4, v0, Lchat/ola/vn/l/i;->e:Lchat/ola/vn/network/c;

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/String;

    invoke-virtual {v0, p0}, Lchat/ola/vn/l/i;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Ljava/lang/String;Lchat/ola/vn/network/c;)V
    .locals 1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/l/k;

    invoke-direct {v0}, Lchat/ola/vn/l/k;-><init>()V

    iput-object p0, v0, Lchat/ola/vn/l/k;->a:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/l/k;->b:Lchat/ola/vn/network/c;

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/String;

    invoke-virtual {v0, p0}, Lchat/ola/vn/l/k;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V
    .locals 1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    new-instance v0, Lchat/ola/vn/l/g;

    invoke-direct {v0}, Lchat/ola/vn/l/g;-><init>()V

    iput-object p0, v0, Lchat/ola/vn/l/g;->b:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/l/g;->a:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/l/g;->c:Lchat/ola/vn/network/c;

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/String;

    invoke-virtual {v0, p0}, Lchat/ola/vn/l/g;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static c(Ljava/lang/String;Lchat/ola/vn/network/c;)V
    .locals 1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/l/f;

    invoke-direct {v0}, Lchat/ola/vn/l/f;-><init>()V

    iput-object p0, v0, Lchat/ola/vn/l/f;->a:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/l/f;->b:Lchat/ola/vn/network/c;

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/String;

    invoke-virtual {v0, p0}, Lchat/ola/vn/l/f;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static c(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V
    .locals 1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/l/a;

    invoke-direct {v0}, Lchat/ola/vn/l/a;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/l/a;->a:Ljava/lang/String;

    iput-object p0, v0, Lchat/ola/vn/l/a;->b:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/l/a;->c:Lchat/ola/vn/network/c;

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/String;

    invoke-virtual {v0, p0}, Lchat/ola/vn/l/a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static d(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V
    .locals 1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    new-instance v0, Lchat/ola/vn/l/h;

    invoke-direct {v0}, Lchat/ola/vn/l/h;-><init>()V

    iput-object p0, v0, Lchat/ola/vn/l/h;->b:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/l/h;->a:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/l/h;->c:Lchat/ola/vn/network/c;

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/String;

    invoke-virtual {v0, p0}, Lchat/ola/vn/l/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
