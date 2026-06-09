.class Lchat/ola/vn/u/m$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/u/m;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/u/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/u/m;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    if-nez v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v1}, Lchat/ola/vn/u/p;->a()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->f:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    new-instance v2, Ljava/io/FileInputStream;

    new-instance v3, Ljava/io/File;

    iget-object v4, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v4, v4, Lchat/ola/vn/u/m;->f:Ljava/lang/String;

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    :goto_0
    iput-object v2, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    new-instance v2, Ljava/io/FileInputStream;

    new-instance v3, Ljava/io/File;

    iget-object v4, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v4, v4, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v1}, Lchat/ola/vn/u/p;->b()[B

    move-result-object v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    new-instance v2, Ljava/io/ByteArrayInputStream;

    iget-object v3, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v3, v3, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v3}, Lchat/ola/vn/u/p;->b()[B

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    goto :goto_0

    :cond_2
    :goto_1
    const/4 v1, 0x0

    const/4 v2, 0x0

    :cond_3
    :goto_2
    iget-object v3, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-boolean v3, v3, Lchat/ola/vn/u/m;->k:Z

    if-nez v3, :cond_5

    iget-object v3, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget v3, v3, Lchat/ola/vn/u/m;->g:I

    new-array v3, v3, [B

    iget-object v4, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v4, v4, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    iget-object v5, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget v5, v5, Lchat/ola/vn/u/m;->g:I

    invoke-virtual {v4, v3, v1, v5}, Ljava/io/InputStream;->read([BII)I

    move-result v4

    if-gez v4, :cond_4

    goto :goto_3

    :cond_4
    if-lez v4, :cond_3

    new-instance v5, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v5}, Ljava/io/ByteArrayOutputStream;-><init>()V

    invoke-virtual {v5, v3, v1, v4}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v5, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v5, v5, Lchat/ola/vn/u/m;->b:Ljava/lang/String;

    invoke-static {v4, v5, v2, v3}, Lchat/ola/vn/u/m;->a(Lchat/ola/vn/u/m;Ljava/lang/String;I[B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_5
    :goto_3
    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    :goto_4
    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iput-object v0, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    return-void

    :catchall_0
    move-exception v1

    goto :goto_5

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    invoke-static {v1}, Lchat/ola/vn/u/m;->b(Lchat/ola/vn/u/m;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_6

    :goto_5
    :try_start_3
    iget-object v2, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v2, v2, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    iget-object v2, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iput-object v0, v2, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    throw v1

    :catch_2
    :goto_6
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/u/m$5;->a:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_4

    :catch_3
    return-void
.end method
