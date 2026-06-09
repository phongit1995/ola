.class public Lchat/ola/vn/network/h;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Lchat/ola/vn/network/g;",
        "Ljava/lang/Void;",
        "Lchat/ola/vn/network/g;",
        ">;"
    }
.end annotation


# instance fields
.field private a:J


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/network/h;->a:J

    return-void
.end method


# virtual methods
.method protected varargs a([Lchat/ola/vn/network/g;)Lchat/ola/vn/network/g;
    .locals 14

    const/4 v0, 0x0

    aget-object p1, p1, v0

    :try_start_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    sget-object v2, Lchat/ola/vn/h;->j:Ljava/util/List;

    if-eqz v2, :cond_1

    sget-object v2, Lchat/ola/vn/h;->j:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    :cond_0
    sget-object v2, Lchat/ola/vn/h;->j:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto :goto_2

    :cond_1
    :goto_0
    const/4 v2, 0x0

    :goto_1
    sget-object v3, Lchat/ola/vn/f/d;->e_:[Ljava/lang/String;

    array-length v3, v3

    if-ge v2, v3, :cond_2

    sget-object v3, Lchat/ola/vn/f/d;->e_:[Ljava/lang/String;

    aget-object v3, v3, v2

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_2
    :goto_2
    :try_start_1
    invoke-static {v1}, Ljava/util/Collections;->shuffle(Ljava/util/List;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    const-string v2, "192.168.2.7"

    invoke-interface {v1, v0, v2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const-wide/16 v4, 0x7530

    iget-object v6, p1, Lchat/ola/vn/network/g;->c:Ljava/lang/Long;

    if-eqz v6, :cond_3

    iget-object v4, p1, Lchat/ola/vn/network/g;->c:Ljava/lang/Long;

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    :cond_3
    iput-wide v2, p0, Lchat/ola/vn/network/h;->a:J

    sget v6, Lchat/ola/vn/network/OlaNetworkService;->b:I

    const/16 v7, 0x4d7

    const/4 v8, 0x1

    if-nez v6, :cond_4

    sput v7, Lchat/ola/vn/network/OlaNetworkService;->c:I

    goto :goto_4

    :cond_4
    sget v6, Lchat/ola/vn/network/OlaNetworkService;->b:I

    if-ne v6, v8, :cond_6

    sget v6, Lchat/ola/vn/network/OlaNetworkService;->c:I

    if-ne v6, v7, :cond_5

    const/16 v6, 0x50

    sput v6, Lchat/ola/vn/network/OlaNetworkService;->c:I

    goto :goto_3

    :cond_5
    sput v7, Lchat/ola/vn/network/OlaNetworkService;->c:I

    :goto_3
    const/4 v6, 0x2

    sput v6, Lchat/ola/vn/network/OlaNetworkService;->b:I

    :catch_1
    :cond_6
    :goto_4
    const/4 v6, 0x0

    :cond_7
    invoke-interface {v1, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    :try_start_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    const/4 v12, 0x0

    sub-long v12, v10, v2

    cmp-long v10, v12, v4

    if-ltz v10, :cond_8

    return-object p1

    :cond_8
    const-string v10, "OlaNetworkService"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Try with IP: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v10, Ljava/net/Socket;

    invoke-direct {v10}, Ljava/net/Socket;-><init>()V

    new-instance v11, Ljava/net/InetSocketAddress;

    sget v12, Lchat/ola/vn/network/OlaNetworkService;->c:I

    invoke-direct {v11, v9, v12}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    const/16 v12, 0x2710

    invoke-virtual {v10, v11, v12}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    invoke-virtual {v10, v8}, Ljava/net/Socket;->setKeepAlive(Z)V

    invoke-virtual {v10}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v11

    iput-object v11, p1, Lchat/ola/vn/network/g;->d:Ljava/io/InputStream;

    invoke-virtual {v10}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v11

    iput-object v11, p1, Lchat/ola/vn/network/g;->e:Ljava/io/OutputStream;

    iput-object v10, p1, Lchat/ola/vn/network/g;->f:Ljava/net/Socket;

    iput-object v9, p1, Lchat/ola/vn/network/g;->b:Ljava/lang/String;

    iput-object v9, p1, Lchat/ola/vn/network/g;->a:Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    return-object p1

    :catch_2
    move-exception v10

    :try_start_4
    const-string v11, "OlaNetworkService"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "Error on IP: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v11, v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-virtual {v10}, Ljava/lang/Throwable;->printStackTrace()V

    sput v7, Lchat/ola/vn/network/OlaNetworkService;->c:I

    add-int/lit8 v6, v6, 0x1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v9
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    if-lt v6, v9, :cond_7

    const-wide/16 v9, 0x3e8

    :try_start_5
    invoke-static {v9, v10}, Ljava/lang/Thread;->sleep(J)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_4

    :catch_3
    return-object p1
.end method

.method protected a(Lchat/ola/vn/network/g;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/network/g;->a()Lchat/ola/vn/network/i;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/network/g;->a()Lchat/ola/vn/network/i;

    move-result-object p1

    invoke-interface {p1}, Lchat/ola/vn/network/i;->f()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method protected b(Lchat/ola/vn/network/g;)V
    .locals 6

    :try_start_0
    const-string v0, "Network"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Result: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/network/g;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p1, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/network/h;->a:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0xafc8

    cmp-long v2, v4, v0

    if-lez v2, :cond_0

    return-void

    :cond_0
    iget-object v0, p1, Lchat/ola/vn/network/g;->d:Ljava/io/InputStream;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lchat/ola/vn/network/g;->e:Ljava/io/OutputStream;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/network/g;->a()Lchat/ola/vn/network/i;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/network/g;->a()Lchat/ola/vn/network/i;

    move-result-object v0

    invoke-interface {v0, p1}, Lchat/ola/vn/network/i;->a(Lchat/ola/vn/network/g;)V

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/network/g;->a()Lchat/ola/vn/network/i;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/network/g;->a()Lchat/ola/vn/network/i;

    move-result-object p1

    invoke-interface {p1}, Lchat/ola/vn/network/i;->f()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Lchat/ola/vn/network/g;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/h;->a([Lchat/ola/vn/network/g;)Lchat/ola/vn/network/g;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onCancelled(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/network/g;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/h;->a(Lchat/ola/vn/network/g;)V

    return-void
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/network/g;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/h;->b(Lchat/ola/vn/network/g;)V

    return-void
.end method
