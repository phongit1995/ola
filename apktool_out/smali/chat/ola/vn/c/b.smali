.class public abstract Lchat/ola/vn/c/b;
.super Ljava/lang/Object;


# instance fields
.field protected a:Ljava/io/File;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract a(Ljava/lang/String;)Lchat/ola/vn/c/a;
.end method

.method public abstract a(Ljava/lang/String;Lchat/ola/vn/c/a;)Lchat/ola/vn/c/a;
.end method

.method public abstract a()V
.end method

.method protected final a(Lchat/ola/vn/c/a;)V
    .locals 1

    :try_start_0
    new-instance v0, Lchat/ola/vn/c/b$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/c/b$1;-><init>(Lchat/ola/vn/c/b;Lchat/ola/vn/c/a;)V

    const/4 p1, 0x0

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/b$1;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public abstract b(Ljava/lang/String;)Lchat/ola/vn/c/a;
.end method

.method protected final b(Lchat/ola/vn/c/a;)V
    .locals 3

    :try_start_0
    iget-boolean v0, p1, Lchat/ola/vn/c/a;->d:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/c/b;->a:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v1

    const-string v2, ".best"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v0

    iget-object p1, p1, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    invoke-direct {v1, v0, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    return-void

    :cond_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/c/b;->a:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v1

    iget-object p1, p1, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->delete()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected final c(Ljava/lang/String;)Lchat/ola/vn/c/a;
    .locals 5

    :try_start_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/c/b;->a:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v1

    const-string v2, ".best"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v0

    invoke-direct {v1, v0, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v0, :cond_0

    :try_start_1
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v1, Lchat/ola/vn/c/a;

    invoke-direct {v1}, Lchat/ola/vn/c/a;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, v1, Lchat/ola/vn/c/a;->c:J

    iput-object v0, v1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    iput-object p1, v1, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    iput-boolean v2, v1, Lchat/ola/vn/c/a;->d:Z

    iput-boolean v2, v1, Lchat/ola/vn/c/a;->e:Z

    invoke-virtual {p0, p1, v1}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;Lchat/ola/vn/c/a;)Lchat/ola/vn/c/a;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-object v1

    :catch_0
    :cond_0
    :try_start_2
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/c/b;->a:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v1, Lchat/ola/vn/c/a;

    invoke-direct {v1}, Lchat/ola/vn/c/a;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, v1, Lchat/ola/vn/c/a;->c:J

    iput-object v0, v1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    iput-object p1, v1, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, v1, Lchat/ola/vn/c/a;->d:Z

    iput-boolean v2, v1, Lchat/ola/vn/c/a;->e:Z

    invoke-virtual {p0, p1, v1}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;Lchat/ola/vn/c/a;)Lchat/ola/vn/c/a;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-object v1

    :catch_1
    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method
