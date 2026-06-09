.class Lchat/ola/vn/u/m$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/u/m;->a(Ljava/util/List;Ljava/lang/Integer;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Ljava/lang/Integer;

.field final synthetic c:Lchat/ola/vn/u/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/u/m;Ljava/util/List;Ljava/lang/Integer;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iput-object p2, p0, Lchat/ola/vn/u/m$6;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/u/m$6;->b:Ljava/lang/Integer;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 13

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    if-nez v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v1}, Lchat/ola/vn/u/p;->a()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->f:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    new-instance v2, Ljava/io/FileInputStream;

    new-instance v3, Ljava/io/File;

    iget-object v4, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v4, v4, Lchat/ola/vn/u/m;->f:Ljava/lang/String;

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    :goto_0
    iput-object v2, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    new-instance v2, Ljava/io/FileInputStream;

    new-instance v3, Ljava/io/File;

    iget-object v4, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v4, v4, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v1}, Lchat/ola/vn/u/p;->b()[B

    move-result-object v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    new-instance v2, Ljava/io/ByteArrayInputStream;

    iget-object v3, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v3, v3, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v3}, Lchat/ola/vn/u/p;->b()[B

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    goto :goto_0

    :cond_2
    :goto_1
    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/u/m$6;->a:Ljava/util/List;

    iget-object v4, p0, Lchat/ola/vn/u/m$6;->b:Ljava/lang/Integer;

    move-object v6, v2

    const/4 v5, 0x0

    move-object v2, v0

    :cond_3
    :goto_2
    iget-object v7, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-boolean v7, v7, Lchat/ola/vn/u/m;->k:Z

    if-nez v7, :cond_a

    const/4 v7, 0x1

    if-eqz v3, :cond_4

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_4

    invoke-interface {v3, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_7

    move-object v3, v0

    goto :goto_3

    :cond_4
    if-eqz v4, :cond_5

    move-object v2, v4

    const/4 v5, 0x1

    move-object v4, v0

    goto :goto_3

    :cond_5
    if-nez v2, :cond_6

    goto :goto_4

    :cond_6
    if-eqz v5, :cond_a

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    add-int/2addr v2, v7

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    :cond_7
    :goto_3
    iget-object v8, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget v8, v8, Lchat/ola/vn/u/m;->g:I

    new-array v8, v8, [B

    iget-object v9, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget v9, v9, Lchat/ola/vn/u/m;->g:I

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v10

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v11

    sub-int/2addr v10, v11

    mul-int v9, v9, v10

    if-lez v9, :cond_8

    iget-object v10, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v10, v10, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    int-to-long v11, v9

    invoke-virtual {v10, v11, v12}, Ljava/io/InputStream;->skip(J)J

    :cond_8
    iget-object v9, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v9, v9, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    iget-object v10, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget v10, v10, Lchat/ola/vn/u/m;->g:I

    invoke-virtual {v9, v8, v1, v10}, Ljava/io/InputStream;->read([BII)I

    move-result v9

    if-gez v9, :cond_9

    goto :goto_4

    :cond_9
    if-lez v9, :cond_3

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v6

    add-int/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    new-instance v7, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v7}, Ljava/io/ByteArrayOutputStream;-><init>()V

    invoke-virtual {v7, v8, v1, v9}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v7

    iget-object v8, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v9, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v9, v9, Lchat/ola/vn/u/m;->b:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v10

    invoke-static {v8, v9, v10, v7}, Lchat/ola/vn/u/m;->a(Lchat/ola/vn/u/m;Ljava/lang/String;I[B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_2

    :cond_a
    :goto_4
    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    :goto_5
    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iput-object v0, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    return-void

    :catchall_0
    move-exception v1

    goto :goto_6

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    invoke-static {v1}, Lchat/ola/vn/u/m;->b(Lchat/ola/vn/u/m;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_7

    :goto_6
    :try_start_3
    iget-object v2, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v2, v2, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    iget-object v2, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iput-object v0, v2, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    throw v1

    :catch_2
    :goto_7
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/u/m$6;->c:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->j:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_5

    :catch_3
    return-void
.end method
